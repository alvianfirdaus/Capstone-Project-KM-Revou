import pymysql as pymysql
from datetime import datetime, timedelta

conn = pymysql.connect(
    host="localhost",
    user="root",
    passwd="031202",
    database="hotel_bookings",
    cursorclass=pymysql.cursors.DictCursor
)

cursor = conn.cursor()

def awal():
    sql = """
        DELETE FROM banyak_orang_city_2016
    """

    cursor.execute(sql)

def get_query():
    sql = """
        select
            chc.arrival_date as tanggal, chc.stays_in_weekend_nights + chc.stays_in_week_nights as lama_nginap
        from city_hotel_checkin chc 
        where chc.arrival_date_year = 2016
        order by chc.arrival_date asc
    """

    cursor.execute(sql)
    return cursor.fetchall()

tgl = {}

def update_tgl(tgl, tanggal, lama_nginap):
    
    if lama_nginap == 0:

        tgl[tanggal] += 1

    else:
        for i in range(lama_nginap):
            tgl_update = tanggal + timedelta(days=i)

            if tgl_update in tgl:
                tgl[tgl_update] += 1
            else:
                tgl[tgl_update] = 1

def get_query_2():
    query_pertama = get_query()

    for x in query_pertama:
        update_tgl(tgl, x['tanggal'], x['lama_nginap'])

def hasil():
    get_query_2()

    for tanggal, jumlah in tgl.items():
        sql = """
            insert into banyak_orang_city_2016(tanggal, jumlah)
            values(%s, %s);
        """

        cursor.execute(sql, (tanggal, jumlah))
        conn.commit()

if __name__ == '__main__':
    awal()
    hasil()