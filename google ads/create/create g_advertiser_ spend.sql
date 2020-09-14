drop table if exists g_advertiser_spend;

create table g_advertiser_spend (
	advertiser_id text,
	advertiser_name text,
	election_cycle text,
	week_start_date date,
	spend_usd integer
);

create temp table source_format (
	advertiser_id text,
	advertiser_name text,
	election_cycle text,
	week_start_date date,
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

copy source_format
from 'C:/dg-pif/goog ad/google-political-ads-transparency-bundle 2019-09-10/google-political-ads-advertiser-weekly-spend.csv' 
CSV HEADER Delimiter ',' QUOTE '"' ESCAPE '"';

insert into g_advertiser_spend
select advertiser_id, advertiser_name, election_cycle, week_start_date, spend_usd 
from source_format;

drop table source_format;
