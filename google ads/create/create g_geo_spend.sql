drop table if exists g_geo_spend;

create table g_geo_spend (
	country_subdivision_primary text,
	country_subdivision_secondary text,
	spend_usd integer
);

create temp table junk2 (
country text,
country_subdivision_primary text,
country_subdivision_secondary text,
spend_usd integer,
spend_eur integer,
spend_inr integer,
spend_bgn integer,
spend_hrk integer,
spend_czk integer,
spend_dkk integer,
spend_huf integer,
spend_pln integer,
spend_ron integer,
spend_sek integer,
spend_gbp integer
);


copy junk2
from 'C:/dg-pif/goog ad/google-political-ads-transparency-bundle 2019-09-10/google-political-ads-geo-spend.csv' 
CSV HEADER Delimiter ',' QUOTE '"' ESCAPE '"';

insert into g_geo_spend
select country_subdivision_primary, country_subdivision_secondary, spend_usd
from junk2;

drop table junk2;
