

EXEC sp_defaultlanguage 'sa', 'us_english'
SET DATEFORMAT ymd;


/*

create view vw_corridas as
select * from [dbo].[data-sample_data-nyctaxi-trips-2009-json_corrigido]
union
select * from [dbo].[data-sample_data-nyctaxi-trips-2010-json_corrigido]
union
select * from [dbo].[data-sample_data-nyctaxi-trips-2011-json_corrigido]
union
select * from [dbo].[data-sample_data-nyctaxi-trips-2012-json_corrigido]

*/

-- select cast(dropoff_datetime as datetime) from [dbo].[data-sample_data-nyctaxi-trips-2009-json_corrigido]


--select cast (left (dropoff_datetime, 10) as datetime) from [dbo].[data-sample_data-nyctaxi-trips-2009-json_corrigido]
drop table ano_2009
drop table ano_2010
drop table ano_2011
drop table ano_2012





select * into ano_2009 from  [dbo].[data-sample_data-nyctaxi-trips-2009-json_corrigido]
select * into ano_2010 from  [dbo].[data-sample_data-nyctaxi-trips-2010-json_corrigido]
select * into ano_2011 from  [dbo].[data-sample_data-nyctaxi-trips-2011-json_corrigido]
select * into ano_2012 from  [dbo].[data-sample_data-nyctaxi-trips-2012-json_corrigido]





UPDATE dbo.ano_2009
SET dropoff_datetime = REPLACE(dropoff_datetime, '+', '')
--WHERE ID <=4






update ano_2009 set dropoff_datetime = replace(dropoff_datetime,'+','') from ano_2009 where dropoff_datetime  like '%+%'
select  dropoff_datetime from ano_2009 where  dropoff_datetime  like '%+%'

select count(*) from ano_2012


 
alter view vw_2009 as
select 
cast(CONVERT(char(10),left (dropoff_datetime, 10),126) +' '+ substring(dropoff_datetime,12,8) as datetime) as dropoff_datetime
,cast(CONVERT(char(10),left (pickup_datetime, 10),126) +' '+ substring(pickup_datetime,12,8) as datetime) as pickup_datetime
,dropoff_datetime as dropoff_datetime_original
,pickup_datetime as pickup_datetime_original
,cast(CONVERT(char(10),left (dropoff_datetime, 10),126) as date) as dropoff_date
,cast(CONVERT(char(10),left (pickup_datetime, 10),126) as date) as pickup_date
,cast(substring(dropoff_datetime,12,8) as time) as dropoff_time
,cast(substring(pickup_datetime,12,8) as time) as pickup_time
--,cast(CONVERT(substring(pickup_datetime,12,8) as time) as pickup_time
,pickup_latitude
,pickup_longitude
,dropoff_latitude
,dropoff_longitude
,cast(fare_amount  as float) as fare_amount
,cast(passenger_count as int)  as passenger_count
,payment_type
,rate_code
,store_and_fwd_flag
,cast(surcharge  as float) as surcharge
,cast(tip_amount as float) as tip_amount
,cast(tolls_amount as float) as tolls_amount
,cast (total_amount as float) as total_amount
,cast (trip_distance as float) as trip_distance
,vendor_id
from [dbo].[ano_2009]



alter view vw_todos_anos as 
select * from vw_2009
union
select * from vw_2010
union
select * from vw_2011
union
select * from vw_2012


SELECT * FROM 
[dbo].[data-vendor_lookup-csv]

alter view vw_pay as 
select distinct payment_type, payment_lookup  from [dbo].[data-payment_lookup-csv] 



alter view vw_todos_pay as
SELECT 
a.dropoff_datetime
,a.pickup_datetime         
,a.dropoff_datetime_original                         
,a.pickup_datetime_original                          
,a.dropoff_date 
,a.pickup_date 

,dropoff_time     
,pickup_time      
,pickup_latitude                                   
,pickup_longitude                                  
,dropoff_latitude                                  
,dropoff_longitude                                 
,fare_amount                                       
,passenger_count                                   
,a.payment_type                                      
,rate_code                                         
,store_and_fwd_flag                                
,surcharge                                         
,tip_amount                                        
,total_amount                                      
,a.trip_distance                                     
,vendor_id                                         
,payment_lookup

FROM 
vw_todos_anos a inner join vw_pay b
on cast(a.payment_type as varchar) = cast(b.payment_type as varchar)


select * from  vw_todos_pay


alter view vw_todos_final as 
select 
a.*
,b.name 
,address 
,city 
,state 
,zip  
,country                                            
,contact                                            
,[current]
from vw_todos_pay a inner join [dbo].[data-vendor_lookup-csv] b
on a.vendor_id = b.vendor_id

select count(*) from vw_todos_final


--View com todas as viagens que tiveram dois passageiros no máximo
alter view vw_2_pass_max as
select trip_distance from  vw_todos_final where passenger_count  <= 2
select count(*) from vw_2_pass_max 
--vemos que foram 3319652 viagens com até dois passageiros

--Cálculo da distância média das viagens com até dois passageiros
select avg(trip_distance ) as distancia_media
FROM  vw_2_pass_max 
--a distância média foi de 2,66 (km ou milhas, a verificar no dicionário de dados)


select  * from vw_todos_final 

select sum(fare_amount) as tarifa, sum(tip_amount) as gorjeta , sum(total_amount) as total, vendor_id, name from vw_todos_final group by vendor_id, name
order by tarifa desc

-- a basear pela tarifa e levando em consideração que a gorjeta não vai para a empresa,
-- quem obterve o maior valor de corridas foi a "Creative Mobile Technologies com um total de 18606781,07
em seguida a VeriFone Inc e a Dependable Driver Service
/*
18606781,079995	718470,599999935	19549084,2799949	CMT	"Creative Mobile Technologies
17407211,319995	825853,959999968	19043433,9999966	VTS	VeriFone Inc
2503647,16	89835,5199999998	2714901,72000001	DDS	"Dependable Driver Service
43,6	0	45,6	TS	Total Solutions Co
*/


--número de corridas pagas em dinheiro agrupadas por mês
select 
 count(*) as total 
,year(dropoff_datetime) as ano
, month(dropoff_datetime) as mes
,
 CASE month(dropoff_datetime)
      WHEN 1 THEN concat(year(dropoff_datetime),'01')
	  WHEN 2 THEN concat(year(dropoff_datetime),'02')
	  WHEN 3 THEN concat(year(dropoff_datetime),'03')
	  WHEN 4 THEN concat(year(dropoff_datetime),'04')
	  WHEN 5 THEN concat(year(dropoff_datetime),'05')
	  WHEN 6 THEN concat(year(dropoff_datetime),'06')
	  WHEN 7 THEN concat(year(dropoff_datetime),'07')
	  WHEN 8 THEN concat(year(dropoff_datetime),'08')
	  WHEN 9 THEN concat(year(dropoff_datetime),'09')
	  WHEN 10 THEN concat(year(dropoff_datetime),'10')
	  WHEN 11 THEN concat(year(dropoff_datetime),'11')
	  WHEN 12 THEN concat(year(dropoff_datetime),'12')
 END as ano_mes 

from [dbo].[vw_pagas_dinheiro]

group by 
month(dropoff_datetime)
, year(dropoff_datetime)
order by ano_mes 



--total ano mes para todos os anos e todas formas de pagamento


EXEC sp_defaultlanguage 'sa', 'us_english'
SET DATEFORMAT ymd;


select 
 count(*) as total 
,year(dropoff_datetime) as ano
, month(dropoff_datetime) as mes
,
 CASE month(dropoff_datetime)
      WHEN 1 THEN concat(year(dropoff_datetime),'01')
	  WHEN 2 THEN concat(year(dropoff_datetime),'02')
	  WHEN 3 THEN concat(year(dropoff_datetime),'03')
	  WHEN 4 THEN concat(year(dropoff_datetime),'04')
	  WHEN 5 THEN concat(year(dropoff_datetime),'05')
	  WHEN 6 THEN concat(year(dropoff_datetime),'06')
	  WHEN 7 THEN concat(year(dropoff_datetime),'07')
	  WHEN 8 THEN concat(year(dropoff_datetime),'08')
	  WHEN 9 THEN concat(year(dropoff_datetime),'09')
	  WHEN 10 THEN concat(year(dropoff_datetime),'10')
	  WHEN 11 THEN concat(year(dropoff_datetime),'11')
	  WHEN 12 THEN concat(year(dropoff_datetime),'12')
 END as ano_mes 

from [dbo].[vw_todos_final]

group by 
month(dropoff_datetime)
, year(dropoff_datetime)
order by ano_mes 



-- 3. Make a histogram of the monthly distribution over 4 years of rides paid with cash;
--valor total das corridas pagas em dinheiro agrupadas por mês
select 



EXEC sp_defaultlanguage 'sa', 'us_english'
SET DATEFORMAT ymd;

select 
 convert(int,sum(convert(float,total_amount))  /1000)

, sum(total_amount)  valor_total 
,year(dropoff_datetime) as ano
, month(dropoff_datetime) as mes
,
 CASE month(dropoff_datetime)
      WHEN 1 THEN concat(year(dropoff_datetime),'01')
	  WHEN 2 THEN concat(year(dropoff_datetime),'02')
	  WHEN 3 THEN concat(year(dropoff_datetime),'03')
	  WHEN 4 THEN concat(year(dropoff_datetime),'04')
	  WHEN 5 THEN concat(year(dropoff_datetime),'05')
	  WHEN 6 THEN concat(year(dropoff_datetime),'06')
	  WHEN 7 THEN concat(year(dropoff_datetime),'07')
	  WHEN 8 THEN concat(year(dropoff_datetime),'08')
	  WHEN 9 THEN concat(year(dropoff_datetime),'09')
	  WHEN 10 THEN concat(year(dropoff_datetime),'10')
	  WHEN 11 THEN concat(year(dropoff_datetime),'11')
	  WHEN 12 THEN concat(year(dropoff_datetime),'12')
 END as ano_mes 

from [dbo].[vw_pagas_dinheiro]

group by 
month(dropoff_datetime)
, year(dropoff_datetime)
order by ano_mes 


--4. Make a time series chart computing the number of tips each day for the last 3 months of 2012.

--NUMERO DE GORJETAS (não é o valor das gorjetas) por dia nos últimos 3 meses de 2012
select year(dropoff_datetime) as ano , day(dropoff_datetime) as dia, month(dropoff_datetime) as mes, count(fare_amount)  num_gorjetas
from vw_todos_final 
where year(dropoff_datetime)='2012'
and month(dropoff_datetime) in (8,9,10)
group by day(dropoff_datetime) ,year(dropoff_datetime), month(dropoff_datetime) 
order by month(dropoff_datetime) desc


--ANO 2010 LatLong e valores
select 
pickup_datetime,pickup_latitude,pickup_longitude,dropoff_latitude, dropoff_longitude
,fare_amount                                       
,rate_code                                         
,surcharge                                         
,tip_amount                                        
,total_amount                                      
,trip_distance                                     
,payment_lookup
from vw_todos_final 
where year(dropoff_datetime)='2010'


--sabados e domingos

select * ,DATENAME(dw,dropoff_datetime) 
from vw_todos_final 
where DATENAME(dw,dropoff_datetime) in ( 'Sábado','Domingo')

--dias da semana final 2012



EXEC sp_defaultlanguage 'sa', 'us_english'
SET DATEFORMAT ymd;

select * ,DATENAME(dw,dropoff_datetime) 
from vw_todos_final 

where year(dropoff_datetime)='2012'
and  month(dropoff_datetime)in('10','11','12')





select  * , DATENAME(dw,dropoff_datetime)  from vw_todos_final 




select * from vw_todos_anos where year(pickup_datetime) = 2010