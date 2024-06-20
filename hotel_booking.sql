--- membuat tanggal arrival dan memilih hanya is_canceled = 0

-- 1. membandingkan untuk resort hotel dan is canceled 0, ada berapa orang

ALTER TABLE hotel_bookings 
ADD COLUMN `index` INT AUTO_INCREMENT PRIMARY KEY;

select 
	hb.hotel, count(hb.`index`) as jumlah
from hotel_bookings hb 
where hb.is_canceled = 0
group by hb.hotel

# untuk resort hotel yang check in ada 28938
# untuk city hotel yang check in ada 46228

## kesimpulan: kita pilih city hotel untuk dianalisis

-- 2. membuat fix table khusus untuk city hotel dan is cancelled 0

create table city_hotel_checkin as(
	select 
		hb.`index`, hb.hotel, hb.is_canceled, hb.lead_time, hb.arrival_date_year, hb.arrival_date_month, hb.arrival_date_week_number,
		hb.arrival_date_day_of_month,
		STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d') as arrival_date,
		hb.stays_in_weekend_nights, hb.stays_in_week_nights, hb.adults, hb.children, hb.babies, hb.meal, hb.country,
		hb.market_segment, hb.distribution_channel, hb.is_repeated_guest, hb.previous_cancellations, hb.previous_bookings_not_canceled,
		hb.reserved_room_type, hb.assigned_room_type, hb.booking_changes, hb.deposit_type, hb.agent, hb.company,
		hb.days_in_waiting_list, hb.customer_type, hb.adr, hb.required_car_parking_spaces, hb.total_of_special_requests,
		hb.reservation_status, hb.reservation_status_date
	from hotel_bookings hb
	where hb.hotel = 'City Hotel' and hb.is_canceled = 0
)

-- 3. kita cek per masing2 year. ada berapa jumlah data per masing2 year

select 
	sum(case when chc.arrival_date_year = 2015 then 1 else 0 end) as jumlah_2015,
	sum(case when chc.arrival_date_year = 2016 then 1 else 0 end) as jumlah_2016,
	sum(case when chc.arrival_date_year = 2017 then 1 else 0 end) as jumlah_2017
from city_hotel_checkin chc

# dari hasil diatas, kita bisa memakai tahun 2016 sebagai acuan untuk memprediksi hasil di tahun 2017.

WITH ranked_data AS (
    SELECT 
        chc.arrival_date_month AS bulan, 
        chc.arrival_date_year AS tahun,
        ROW_NUMBER() OVER (PARTITION BY chc.arrival_date_year ORDER BY chc.arrival_date_month) AS row_num
    FROM city_hotel_checkin chc
    GROUP BY chc.arrival_date_month, chc.arrival_date_year
)
SELECT 
    MAX(CASE WHEN tahun = 2015 THEN bulan END) AS '2015',
    MAX(CASE WHEN tahun = 2016 THEN bulan END) AS '2016',
    MAX(CASE WHEN tahun = 2017 THEN bulan END) AS '2017'
FROM ranked_data
GROUP BY row_num;


-- 4. kita mengambil berapa banyak arrival diliat dari per tanggal di tahun 2016 dan dimasukkan ke tabel

create table arrival_city_2016 as (
select
	chc.arrival_date, 
	DAYNAME(chc.arrival_date) as hari_arrival,
	count(*) as jumlah_arrival_per_hari
from city_hotel_checkin chc
where chc.arrival_date_year = 2016
group by chc.arrival_date
)

-- 5. dengan script python untuk mendapatkan total banyak orang di city 2016

CREATE TABLE banyak_orang_city_2016 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tanggal VARCHAR(255),
    jumlah INTEGER
);

select
	chc.arrival_date as tanggal, chc.stays_in_weekend_nights + chc.stays_in_week_nights as lama_nginap
from city_hotel_checkin chc 
where chc.arrival_date_year = 2016
order by chc.arrival_date asc

-- 6. gabungkan tabel arrival_city_2016 dengan banyak_orang_city_2016 dan buat jadi tabel rekap_city_2016

create table rekap_city_2016 as (
select
	boc.tanggal,
	dayname(boc.tanggal) as hari,
	boc.jumlah as banyak_orang, ac.jumlah_arrival_per_hari as banyak_arrival
from banyak_orang_city_2016 boc 
left join arrival_city_2016 ac on ac.arrival_date = boc.tanggal 
)

-- 7. kita juga butuh data tahun 2017 untuk prediksi kenaikan hasil di bulan september


create table arrival_city_2017 as (
select
	chc.arrival_date, 
	DAYNAME(chc.arrival_date) as hari_arrival,
	count(*) as jumlah_arrival_per_hari
from city_hotel_checkin chc
where chc.arrival_date_year = 2017
group by chc.arrival_date
)

CREATE TABLE banyak_orang_city_2017 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tanggal VARCHAR(255),
    jumlah INTEGER
);

select
	chc.arrival_date as tanggal, chc.stays_in_weekend_nights + chc.stays_in_week_nights as lama_nginap
from city_hotel_checkin chc 
where chc.arrival_date_year = 2016
order by chc.arrival_date asc

create table rekap_city_2017 as (
select
	boc.tanggal,
	dayname(boc.tanggal) as hari,
	boc.jumlah as banyak_orang, ac.jumlah_arrival_per_hari as banyak_arrival
from banyak_orang_city_2017 boc 
left join arrival_city_2017 ac on ac.arrival_date = boc.tanggal 
)


-- 8. melihat top 5 countries yang visit city hotel di september 2016


select chc.country,
	count(chc.`index`) as jumlah
from city_hotel_checkin chc 
where chc.arrival_date_year = 2016 and chc.arrival_date_month = 'September'
group by chc.country
order by jumlah desc
limit 5;


-- 9. mencari top distribution channel based on country pada september 2016

select
	chc.country, chc.distribution_channel,
	count(*) as jumlah
from city_hotel_checkin chc 
where chc.arrival_date_year = 2016 and chc.arrival_date_month = 'September'
group by chc.country, chc.distribution_channel 
order by jumlah desc
limit 5;

-- 10. mencari top meal based on country and customer type pada september 2016

select 
	chc.country, chc.customer_type, chc.meal, count(chc.`index`) as jumlah
from city_hotel_checkin chc 
where chc.arrival_date_year = 2016 and chc.arrival_date_month = 'September'
group by chc.country, chc.customer_type, chc.meal
order by jumlah desc
limit 5;