import pymysql as pymysql
from datetime import datetime, timedelta

conn = pymysql.connect(
    host="localhost",
    user="<sesuaikan>",
    passwd="<sesuaikan>",
    database="<sesuaikan>",
    cursorclass=pymysql.cursors.DictCursor
)

cursor = conn.cursor()

def awal():
    sql = """
        DELETE FROM banyak_orang_dalam_1_hari
    """

    cursor.execute(sql)

def get_query():
    sql = """
        select CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month) as tanggal, 
            DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) as hari_arrival,
            hb.stays_in_weekend_nights as lama_weekend,
            hb.stays_in_week_nights as lama_weekday,
            hb.stays_in_weekend_nights + hb.stays_in_week_nights as lama_nginap,
            hb.reservation_status_date
        from hotel_bookings hb 
        where hb.reservation_status = 'Check-Out' and 
            hb.arrival_date_year = '2017'
        order by tanggal
    """

    cursor.execute(sql)
    return cursor.fetchall()

tgl = {}

def update_tgl(tgl, tanggal, lama_nginap):
    tgl_awal = datetime.strptime(tanggal, "%Y-%B-%d")

    formatted_date = tgl_awal.strftime("%Y-%B-%d")
    parts = formatted_date.split('-')
    formatted_date = parts[0] + '-' + parts[1] + '-' + str(int(parts[2]))
    
    if lama_nginap == 0:

        tgl[formatted_date] += 1

    else:
        for i in range(lama_nginap):
            tgl_update = tgl_awal + timedelta(days=i)
            tgl_str = tgl_update.strftime("%Y-%B-%d")
            parts = tgl_str.split('-')

            tgl_str = parts[0] + '-' + parts[1] + '-' + str(int(parts[2]))
            if tgl_str in tgl:
                tgl[tgl_str] += 1
            else:
                tgl[tgl_str] = 1

def get_query_2():
    query_pertama = get_query()

    for x in query_pertama:
        update_tgl(tgl, x['tanggal'], x['lama_nginap'])

def hasil():
    get_query_2()

    for tanggal, jumlah in tgl.items():
        sql = """
            insert into banyak_orang_dalam_1_hari(tanggal, jumlah)
            values(%s, %s);
        """

        cursor.execute(sql, (tanggal, jumlah))
        conn.commit()

if __name__ == '__main__':
    awal()
    hasil()
