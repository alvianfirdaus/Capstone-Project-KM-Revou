------------------ clean code

---- 1. create table banyak arrival

create table banyak_arrival as(
	select 
		CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month) as tanggal,
		count(*) as jumlah_arrival
	from hotel_bookings hb 
	where hb.arrival_date_year = '2017' and hb.reservation_status = "Check-Out"
	group by CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month)
	order by tanggal
)

---- 2. jalanin script python dulu

---- 3. create table banyak orang 

create table banyak_orang as(
	SELECT bodh.tanggal, DAYNAME(STR_TO_DATE(bodh.tanggal, '%Y-%M-%d')) AS nama_hari, bodh.jumlah as jumlah_orang
	FROM banyak_orang_dalam_1_hari bodh
)

---- 4. gabungan banyak orang dan banyak arrival

SELECT bo.tanggal, bo.nama_hari, ba.jumlah_arrival, bo.jumlah_orang 
FROM banyak_orang bo 
LEFT JOIN banyak_arrival ba 
ON bo.tanggal = ba.tanggal
