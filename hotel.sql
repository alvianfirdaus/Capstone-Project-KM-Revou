---------------------- 2015

-- mengetahui jumlah booking 2015

SELECT COUNT(hb.`index`) AS jumlah_booking
FROM hotel_bookings hb 
WHERE arrival_date_year = 2015;

-- hasil: 21.996

-- yg checkout di tahun 2015
select count(hb.hotel)
from hotel_bookings hb
where reservation_status  = 'Check-Out' and arrival_date_year = 2015;

-- result = 13,854

-- yang cancel di tahun 2015

select count(*)
from hotel_bookings hb 
where is_canceled = 1 and arrival_date_year = 2015;

-- result = 8.142

-- yang tidak cancel di tahun 2015

select count(*)
from hotel_bookings hb 
where is_canceled = 0 and arrival_date_year = 2015;

-- result = 13.854


--------------------------
-- berarti dia iscancelled = 1 lalu dipecah jadi reservation status = cancelled dan no show

select count(*)
from hotel_bookings hb 
where reservation_status = "Canceled" and arrival_date_year = 2015;

-- 7.951

select count(*)
from hotel_bookings hb 
where reservation_status = "No-show" and arrival_date_year = 2015;

-- 191




------------------------------------- 2016

-- mengetahui jumlah booking 2016

SELECT COUNT(hb.`index`) AS jumlah_booking
FROM hotel_bookings hb 
WHERE arrival_date_year = 2016;

-- hasil: 56.707

-- yg checkout di tahun 2016
select count(hb.hotel)
from hotel_bookings hb
where reservation_status  = 'Check-Out' and arrival_date_year = 2016;

-- result = 36370

-- yang cancel di tahun 2016

select count(*)
from hotel_bookings hb 
where is_canceled = 1 and arrival_date_year = 2016;

-- result = 20337

-- yang tidak cancel di tahun 2016

select count(*)
from hotel_bookings hb 
where is_canceled = 0 and arrival_date_year = 2016;

-- result = 36370


--------------------------
-- berarti dia iscancelled = 1 lalu dipecah jadi reservation status = cancelled dan no show

select count(*)
from hotel_bookings hb 
where reservation_status = "Canceled" and arrival_date_year = 2016;

-- 19669

select count(*)
from hotel_bookings hb 
where reservation_status = "No-show" and arrival_date_year = 2016;

-- 668

------------------------------------- 2017

-- mengetahui jumlah booking 2017

SELECT COUNT(hb.`index`) AS jumlah_booking
FROM hotel_bookings hb 
WHERE arrival_date_year = 2017;

-- hasil: 40687

-- yg checkout di tahun 2017
select count(hb.hotel)
from hotel_bookings hb
where reservation_status  = 'Check-Out' and arrival_date_year = 2017;

-- result = 24942

-- yang cancel di tahun 2017

select count(*)
from hotel_bookings hb 
where is_canceled = 1 and arrival_date_year = 2017;

-- result = 15745

-- yang tidak cancel di tahun 2017

select count(*)
from hotel_bookings hb 
where is_canceled = 0 and arrival_date_year = 2017;

-- result = 24942


--------------------------
-- berarti dia iscancelled = 1 lalu dipecah jadi reservation status = cancelled dan no show

select count(*)
from hotel_bookings hb 
where reservation_status = "Canceled" and arrival_date_year = 2017;

-- 15397

select count(*)
from hotel_bookings hb 
where reservation_status = "No-show" and arrival_date_year = 2017;

-- 348


------------------------------------------------------------------------- cancellation rate

rata2 cancellation = jumlah_cancel / jumlah_booking * 100%
rata2 jumlah booking di tahun 2015 = jumlah booking di tahun 2015/ jumlah booking 2015,2016,2017

-- year
SELECT
    arrival_date_year,
    count(*) as total_bookings,
    count(case when is_canceled = 1 then 1 end) as total_cancelled,
    ROUND((count(case when is_canceled = 1 then 1 end) / count(*)) * 100) AS cancellation_percentage
FROM 
    hotel_bookings hb
WHERE 
    arrival_date_year IN (2015, 2016, 2017)
GROUP BY 
    Arrival_date_year
order by cancellation_percentage desc;
  

-- month
   

SELECT
    arrival_date_year,
    arrival_date_month,
    COUNT(*) as total_bookings,
    COUNT(CASE WHEN is_canceled = 1 THEN 1 END) as jumlah_cancelled,
    ROUND((SUM(CASE WHEN is_canceled = 1 THEN 1 END) / COUNT(*)) * 100) AS cancellation_percentage
FROM 
    hotel_bookings hb 
WHERE
    arrival_date_year IN (2015, 2016, 2017)
GROUP BY 
    arrival_date_year, arrival_date_month
order by cancellation_percentage desc;

 ------------------------------
 
 select arrival_date_year, arrival_date_month, count(hb.is_canceled) as jumlah_cancelled
 from hotel_bookings hb 
 where arrival_date_year = 2015 and is_canceled = 1
 group by arrival_date_month; -- juli = 2776
 
 select count(hb.is_canceled)
 from hotel_bookings hb 
 where arrival_date_year = 2015 and arrival_date_month = "August";


-- total check out berdasarkan adults children dan babies di tahun 2015
select sum(adults) as adults, sum(children)as children, sum(babies) as babies
from hotel_bookings hb
where reservation_status  = 'Check-Out' and arrival_date_year = 2015;

-- result: adults = 24,726; children = 1,036; babies = 182

-- total adr tahun 2015 berdasarkan checkout
select sum(adr)as total_revenue
from hotel_bookings hb
where reservation_status  = 'Check-Out' and arrival_date_year = 2015;

-- result: 1,299,044.1


------------------------------
---- di tahun berapa yang punya customer paling banyak dan berdasarkan tiap tipe hotel

select hotel, arrival_date_year  as year, count(*) as jumlah_booking
from hotel_bookings hb 
where reservation_status = "Check-Out"
group by arrival_date_year , hotel
order by jumlah_booking desc;

-- City Hotel	2016	22733

select count(*)
from hotel_bookings hb 
where reservation_status = "Check-Out" and arrival_date_year = 2016 and hotel = "City Hotel";


------ hotel yg paling banyak pendapatan (pakai adr)

select hotel, sum(adr) as jumlah_pendapatan
from hotel_bookings hb 
where is_canceled = 0
group by hotel
order by jumlah_pendapatan desc;

--- City Hotel	4888423.699999736


---- berapa orang yang check out di stay_in_weekend_nights dan berapa orang yang checkout di stay_in_week_nights:

select count(stays_in_weekend_nights)
from hotel_bookings hb 
where is_canceled = 0 and arrival_date_year = 2017;

--- 24942

select count(stays_in_weekend_nights)
from hotel_bookings hb 
where is_canceled = 0 and arrival_date_year = 2016;

-- 36370

select count(stays_in_weekend_nights)
from hotel_bookings hb 
where is_canceled = 0 and arrival_date_year = 2015;

-- 13854


-------------- paling sering customer menginap berapa lama?

select hb.stays_in_weekend_nights + hb.stays_in_week_nights as jumlah_nginap
from hotel_bookings hb 
where is_canceled = 0;

select
    hb.stays_in_weekend_nights + hb.stays_in_week_nights AS jumlah_nginap,
    COUNT(*) AS frekuensi
FROM 
    hotel_bookings hb 
WHERE 
    is_canceled = 0
GROUP BY 
    jumlah_nginap
ORDER BY 
    frekuensi desc
limit 1;
-- 1	15749

select
	hb.stays_in_weekend_nights as weekend, hb.stays_in_week_nights as weekday,
    hb.stays_in_weekend_nights + hb.stays_in_week_nights AS jumlah_nginap,
    COUNT(*) AS frekuensi
FROM 
    hotel_bookings hb 
WHERE 
    is_canceled = 0 and arrival_date_year = 2017
GROUP BY 
    jumlah_nginap, weekend, weekday
ORDER BY 
    frekuensi desc;
   
-- 0	1	1	12156



--- jenis meal yg paling banyak dipesan di thn 2017? sertakan data guests (child, babies, adults)

select distinct (hb.meal) 
from hotel_bookings hb;

select meal, count(*) as frekuensi
from hotel_bookings hb 
where arrival_date_year = 2017
group by meal
order by frekuensi desc;

-- BB	30524

select count(*)
from hotel_bookings hb 
where arrival_date_year = 2017 and meal = "BB";


-- paling banyak customer berasal dari country mana di thn 2017?

select hb.country as country, count(*) as frekuensi
from hotel_bookings hb 
where arrival_date_year = 2017
group by country
order by frekuensi desc;

--- PRT	12962

----- guest datang paling banyak di bulan apa pada thn 2017? tanpa kondisi apapun 
---- bandingkan dgn guest datang paling banyak di bulan ap pd thn 2017? dgn where is_cancelled = 0 or status_reservations = 'Check-Out

select hb.arrival_date_month as bulan, count(*) as frekuensi
from hotel_bookings hb 
where arrival_date_year = 2017 
group by bulan
order by frekuensi desc;

--- bulan may dengan 6313 (ini tanpa kondisi apapun)

select hb.arrival_date_month as bulan, count(*) as frekuensi
from hotel_bookings hb 
where arrival_date_year = 2017 and is_canceled = 0
group by bulan
order by frekuensi desc;

--- bulan may dengan 3551 (dengan kondisi checkout)


------------------------  guests yg paling lama mendapat konfirmasi dari hotel 
-- kondisi 1: (select customer type, country, days_in_waiting_lists where status reservation = cancelled in 2017)

select distinct (days_in_waiting_list)
from hotel_bookings hb;

select hb.customer_type, hb.country, hb.days_in_waiting_list 
from hotel_bookings hb 
where is_canceled = 0 and arrival_date_year = 2017
order by hb.days_in_waiting_list desc;

-- Transient-Party	DEU	223

---- kondisi 2: select customer type, country, days_in_waiting_lists, status reservation  where thn 2017 
--- order by day in waiting list desc


select hb.customer_type, hb.country, hb.days_in_waiting_list, hb.reservation_status 
from hotel_bookings hb 
where arrival_date_year = 2017 
order by hb.days_in_waiting_list desc;

-- Transient-Party	DEU	223	Check-Out



----------------------------------------------- full 2017

----- di bulan berapa, yang banyak dipesan di bulan apa (yang checkout)

select hotel, arrival_date_month as month, count(*) as jumlah_booking
from hotel_bookings hb 
where reservation_status = "Check-Out" and arrival_date_year = 2017
group by arrival_date_month, hotel
order by jumlah_booking desc;

-- City Hotel	May	2339

select count(*)
from hotel_bookings hb 
where hotel = "Resort Hotel" and reservation_status = "Check-Out" and arrival_date_year = 2017
and arrival_date_month = "April";

-------- berapa banyak guest yg repeated guests (lihat kondisi seperti meal, market, waiting list)

select meal, market_segment, days_in_waiting_list,customer_type, country, count(*) as jumlah_repeated
from hotel_bookings hb 
where is_repeated_guest = 1
group by meal, market_segment, days_in_waiting_list, customer_type, country
order by jumlah_repeated desc;

select count(*) as jumlah_repeated
from hotel_bookings hb 
where is_repeated_guest = 1;

-- 3810

--- jumlah customer dalam 3 tahun

select count(*)
from hotel_bookings hb 
where is_canceled = 0;

-- 75166

select count(*) as jumlah_repeated
from hotel_bookings hb 
where is_repeated_guest = 1 and arrival_date_year = 2015;

-- 641

select count(*) as jumlah_repeated
from hotel_bookings hb 
where is_repeated_guest = 1 and arrival_date_year = 2016;

-- 1778

select count(*) as jumlah_repeated
from hotel_bookings hb 
where is_repeated_guest = 1 and arrival_date_year = 2017;

-- 1391


-- 24942


--- What market segments are frequently used by guests to book hotel room

select hb.distribution_channel, hb.customer_type, market_segment, count(*) as jumlah
from hotel_bookings hb
group by market_segment, hb.customer_type, hb.distribution_channel
order by jumlah desc;

-- TA/TO	Transient	Online TA	50995

-- TA/TO = cara delivery barang. TO = transfer out. bagaimana cara barang itu keluar.
-- TA = Travel Agent
-- direct = COD

select distinct (hb.reservation_status) 
from hotel_bookings hb;


--- saran kak bobbby

--- sisi adr: kita tau bb paling laku, kiita coba promo2. yang pesan bb itu kebanyakan weekend atau weekday
--- di bulan apa yg trennya naik

select distinct (hb.days_in_waiting_list)
from hotel_bookings hb 


--------------------------------------------------------------------------- zona suci

-- menyesuaikan tabel


select hb.arrival_date_day_of_month, hb.arrival_date_month, hb.arrival_date_year, hb.arrival_date_week_number
from hotel_bookings hb;

SELECT 
	CONCAT(
        LPAD(hb.arrival_date_day_of_month, 2, '0'), '-', 
        hb.arrival_date_month, '-',
        RIGHT(hb.arrival_date_year, 2)
    ) AS date_of_arrival,
    hb.arrival_date_week_number as minggu_ke,
    hb.stays_in_weekend_nights,
    hb.stays_in_week_nights,
    hb.reservation_status_date,
    hb.lead_time,
    DATE_SUB(
        STR_TO_DATE(
            CONCAT(
                hb.arrival_date_year, '-', 
                hb.arrival_date_month, '-', 
                LPAD(hb.arrival_date_day_of_month, 2, '0')
            ), 
            '%Y-%M-%d'
        ), 
        INTERVAL hb.lead_time DAY
    ) AS booking_date
FROM 
    hotel_bookings hb
where hb.stays_in_weekend_nights = 0 and hb.stays_in_week_nights = 0;



select distinct (concat(LPAD(hb.arrival_date_month, 3, '0')))
from hotel_bookings hb;

SELECT 
	CONCAT(
        LPAD(hb.arrival_date_day_of_month, 2, '0'), '-', 
        hb.arrival_date_month, '-',
        RIGHT(hb.arrival_date_year, 2)
    ) AS date_of_arrival,
    hb.arrival_date_week_number as minggu_ke,
    hb.stays_in_weekend_nights,
    hb.stays_in_week_nights,
    hb.reservation_status_date,
    hb.lead_time,
    DATE_SUB(
        STR_TO_DATE(
            CONCAT(
                hb.arrival_date_year, '-', 
                hb.arrival_date_month, '-', 
                LPAD(hb.arrival_date_day_of_month, 2, '0')
            ), 
            '%Y-%M-%d'
        ), 
        INTERVAL hb.lead_time DAY
    ) AS booking_date,
    hb.reservation_status,
    hb.market_segment
FROM 
    hotel_bookings hb
where hb.reservation_status = "Canceled";

--- tabel end

select 
	CONCAT(
        LPAD(hb.arrival_date_day_of_month, 2, '0'), '-', 
        hb.arrival_date_month, '-',
        RIGHT(hb.arrival_date_year, 2)
    ) AS date_of_arrival,
from hotel_bookings hb
where hb.reservation_status = "Check-Out" and arrival_date_month = "July" and arrival_date_year = "2015";


SELECT 
    CONCAT(
        LPAD(hb.arrival_date_day_of_month, 2, '0'), '-', 
        hb.arrival_date_month, '-',
        RIGHT(hb.arrival_date_year, 2)
    ) AS date_of_arrival,
    DAYNAME(
        STR_TO_DATE(
            CONCAT(
                hb.arrival_date_year, '-', 
                hb.arrival_date_month, '-',
                hb.arrival_date_day_of_month
            ),
            '%Y-%M-%d'
        )
    ) AS day_of_week
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_month = "July" AND 
    hb.arrival_date_year = "2015";
   
SELECT 
    CONCAT(
        LPAD(hb.arrival_date_day_of_month, 2, '0'), '-', 
        hb.arrival_date_month, '-',
        RIGHT(hb.arrival_date_year, 2)
    ) AS date_of_arrival,
    DAYNAME(
        STR_TO_DATE(
            CONCAT(
                hb.arrival_date_year, '-', 
                hb.arrival_date_month, '-',
                hb.arrival_date_day_of_month
            ),
            '%Y-%M-%d'
        )
    ) AS day_of_week
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_month = "January" AND 
    hb.arrival_date_year = "2017";
   
SELECT 
    DAYNAME(
        STR_TO_DATE(
            CONCAT(
                hb.arrival_date_year, '-', 
                hb.arrival_date_month, '-', 
                hb.arrival_date_day_of_month
            ),
            '%Y-%M-%d'
        )
    ) AS day_of_week,
    COUNT(*) AS count
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_month = "January" AND 
    hb.arrival_date_year = "2017"
GROUP BY 
    day_of_week;

SELECT 
    DAYNAME(
        STR_TO_DATE(
            CONCAT(
                hb.arrival_date_year, '-', 
                hb.arrival_date_month, '-', 
                hb.arrival_date_day_of_month
            ),
            '%Y-%M-%d'
        )
    ) AS day_of_week,
    COUNT(*) AS count
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_month = "January" AND 
    hb.arrival_date_year = "2017" 
GROUP BY 
    day_of_week;


   
---
SELECT 
    DAYNAME(
        STR_TO_DATE(
            CONCAT(
                hb.arrival_date_year, '-', 
                hb.arrival_date_month, '-', 
                hb.arrival_date_day_of_month
            ),
            '%Y-%M-%d'
        )
    ) AS day_of_week,
    COUNT(*) AS count
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_month = "January" AND 
    hb.arrival_date_year = "2017" AND 
    DAYNAME(
        STR_TO_DATE(
            CONCAT(
                hb.arrival_date_year, '-', 
                hb.arrival_date_month, '-', 
                hb.arrival_date_day_of_month
            ),
            '%Y-%M-%d'
        )
    ) = 'Wednesday'
GROUP BY 
    day_of_week;

--------------

select
	hb.arrival_date_week_number as minggu_ke,
    DAYNAME(
        STR_TO_DATE(
            CONCAT(
                hb.arrival_date_year, '-', 
                hb.arrival_date_month, '-', 
                hb.arrival_date_day_of_month
            ),
            '%Y-%M-%d'
        )
    ) AS day_of_week,
    COUNT(*) AS count
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" and arrival_date_year = "2017"
GROUP BY 
    minggu_ke, day_of_week
order by minggu_ke asc;


--------

SELECT 
    hb.arrival_date_week_number AS week,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2017"
GROUP BY 
    hb.arrival_date_week_number
ORDER BY 
    hb.arrival_date_week_number ASC;
 
create table sementara
as (
SELECT 
    hb.arrival_date_week_number AS week,
    hb.arrival_date_month as bulan,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2017" and 
    hb.arrival_date_month = "January"
GROUP BY 
    hb.arrival_date_week_number, bulan
ORDER BY 
    hb.arrival_date_week_number ASC);


   
   
SELECT 
    hb.arrival_date_week_number AS week,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2016"
GROUP BY 
    hb.arrival_date_week_number
ORDER BY 
    hb.arrival_date_week_number ASC;
   
SELECT 
    hb.arrival_date_week_number AS week,
    hb.arrival_date_month as bulan,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2016"
GROUP BY 
    hb.arrival_date_week_number, bulan
ORDER BY 
    hb.arrival_date_week_number ASC;

   
SELECT
    hb.arrival_date_week_number AS week,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2015"
GROUP BY 
    hb.arrival_date_week_number
ORDER BY 
    hb.arrival_date_week_number ASC;

SELECT 
    hb.arrival_date_week_number AS week,
    hb.arrival_date_month as bulan,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2015"
GROUP BY 
    hb.arrival_date_week_number, bulan
ORDER BY 
    hb.arrival_date_week_number ASC;

   
--- bikin query baru pakai union untuk semua tabel sementara berdasarkan bulan untuk menjadi 1. 

create table february
as (
SELECT 
    hb.arrival_date_week_number AS week,
    hb.arrival_date_month as bulan,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2017" and 
    hb.arrival_date_month = "February"
GROUP BY 
    hb.arrival_date_week_number, bulan
ORDER BY 
    hb.arrival_date_week_number ASC);

create table hasil_akhir
as (
SELECT 
--     hb.arrival_date_week_number AS week,
    row_number() over (partition by hb.arrival_date_month order by hb.arrival_date_week_number asc) week,
    hb.arrival_date_month as bulan,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2017"
GROUP BY 
    hb.arrival_date_week_number, bulan
ORDER BY 2, 1 asc);


-- berapa orang yang mesan

SELECT 
--     hb.arrival_date_week_number AS week,
    row_number() over (partition by hb.arrival_date_month order by hb.arrival_date_week_number asc) week,
    hb.arrival_date_month as bulan,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2017"
GROUP BY 
    hb.arrival_date_week_number, bulan
ORDER BY 2, 1 asc



-- berapa orang yang literally nginap di hari tersebut


select CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month) as tanggal, 
	DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) as hari_arrival,
	hb.stays_in_weekend_nights as lama_weekend,
	hb.stays_in_week_nights as lama_weekday,
	hb.stays_in_weekend_nights + hb.stays_in_week_nights as lama_nginap,
	hb.reservation_status_date,
	hb.arrival_date_month
from hotel_bookings hb 
where hb.reservation_status = 'Check-Out' and 
	hb.arrival_date_year = '2017' and 
	CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month) = '2017-January-1'
	and hb.stays_in_weekend_nights + hb.stays_in_week_nights > 1;


CREATE TABLE banyak_orang_dalam_1_hari (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tanggal VARCHAR(255),
    jumlah INTEGER
);

select CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month) as tanggal, 
	DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) as hari_arrival,
	hb.stays_in_weekend_nights as lama_weekend,
	hb.stays_in_week_nights as lama_weekday,
	hb.stays_in_weekend_nights + hb.stays_in_week_nights as lama_nginap,
	hb.reservation_status_date,
	hb.arrival_date_month
from hotel_bookings hb 
where hb.reservation_status = 'Check-Out' and 
	hb.arrival_date_year = '2017' and 
	CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month) = '2017-January-2'


SELECT 
    row_number() over (partition by hb.arrival_date_month order by hb.arrival_date_week_number asc) week,
    hb.arrival_date_month as bulan,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2017"
GROUP BY 
    hb.arrival_date_week_number, bulan
ORDER BY 2, 1 asc


create table hari_pengunjung
as(
	select distinct CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month) as tanggal,
		DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) as hari
	from hotel_bookings hb
	where hb.arrival_date_year = '2017'
)


-- ngeliat hasil berdasarkan tanggal

select 
from hotel_bookings hb 


SELECT 
    row_number() over (partition by hb.arrival_date_month order by hb.arrival_date_week_number asc) week,
    hb.arrival_date_month as bulan,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
    SUM(CASE WHEN DAYNAME(STR_TO_DATE(CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month), '%Y-%M-%d')) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM 
    hotel_bookings hb
WHERE 
    hb.reservation_status = "Check-Out" AND 
    hb.arrival_date_year = "2017"
GROUP BY 
    hb.arrival_date_week_number, bulan
ORDER BY 2, 1 asc


create table banyak_arrival as(
	select 
		CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month) as tanggal,
		count(*) as jumlah_arrival
	from hotel_bookings hb 
	where hb.arrival_date_year = '2017' and hb.reservation_status = "Check-Out"
	group by CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month)
	order by tanggal
)

select hp.tanggal, hp.hari, x.arrival, x.jumlah_orang_dalam_1_hari
from hari_pengunjung hp 
join (
	select ba.tanggal as tanggal, ba.jumlah_arrival as arrival, bodh.jumlah as jumlah_orang_dalam_1_hari
	from banyak_arrival ba 
	join banyak_orang_dalam_1_hari bodh on ba.tanggal = bodh.tanggal 
) as x on x.tanggal = hp.tanggal 


select ba.tanggal, hp.hari 
from banyak_arrival ba
join hari_pengunjung hp on ba.tanggal = hp.tanggal 
join banyak_orang_dalam_1_hari bodh on bodh.tanggal = ba.tanggal


create table banyak_orang as(
	SELECT bodh.tanggal, DAYNAME(STR_TO_DATE(bodh.tanggal, '%Y-%M-%d')) AS nama_hari, bodh.jumlah as jumlah_orang
	FROM banyak_orang_dalam_1_hari bodh
)

-- tabel yg dipakai: banyak_orang dan banyak_arrival


SELECT bo.tanggal, bo.nama_hari, ba.jumlah_arrival, bo.jumlah_orang 
FROM banyak_orang bo 
LEFT JOIN banyak_arrival ba 
ON bo.tanggal = ba.tanggal

select count(*)
from hotel_bookings hb 
where CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month) = '2017-January-2'
	and hb.reservation_status = "Check-Out"
group by CONCAT(hb.arrival_date_year, '-', hb.arrival_date_month, '-', hb.arrival_date_day_of_month)


