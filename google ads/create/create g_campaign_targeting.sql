--drop table if exists g_campaign_targeting;

create table g_campaign_targeting_20_03_06 (
	campaign_id text,
	age_targeting text,
	gender_targeting text,
	geo_targeting_included text,
	geo_targeting_excluded text,
	start_date date,
	end_date date,
	ads_list text,
	advertiser_id text,
	advertiser_name text
);

copy g_campaign_targeting_20_03_06
from 'C:/dg-pif/goog ad/google-political-ads-transparency-bundle 2020-03-6/google-political-ads-campaign-targeting.csv' 
CSV HEADER Delimiter ',' QUOTE '"' ESCAPE '"';

drop table if exists g_campaign_targeting_us_20_03_06;

create table g_campaign_targeting_us_20_03_06 as
select campaign_id, age_targeting, gender_targeting, geo_targeting_included, geo_targeting_excluded, 
	start_date, end_date, ads_list, advertiser_id, advertiser_name
from g_campaign_targeting_20_03_06
left join states_pocs on geo_targeting_included = us_state
where us_state is not null -- single U.S. state
or geo_targeting_included ~ 'United States'
-- pick of targeting that includes U.S. postalcodes without attached state or U.S, 
-- but exclude with Germany because Germany also has 5-digit postal codes 
or ( geo_targeting_included ~ '(^| )\d{5}($|,)'
	and geo_targeting_included !~ 'Germany' );

drop table if exists g_ctarg_us_divs_20_03_06

create table g_ctarg_us_divs_20_03_06 as
with regions as (
	select campaign_id, geo_targeting_included, regexp_split_to_table(geo_targeting_included, ',') as rg
	from g_campaign_targeting_us_20_03_06
)
select geo_targeting_included, array_agg(tar_state) as tar_state_array
from (
	-- targeted states
	select geo_targeting_included, tar_state
	from regions
	join g_geotargets_2020_03_03 on (rg = tar_name and tar_name = tar_state )

	union

	-- targeted U.S. zip codes
	select geo_targeting_included, tar_state 
	from regions
	join g_geotargets_2020_03_03 on (rg = tar_name and tar_name ~ '^\d{5}$' and tar_country_code = 'US' )
) sqa
group by geo_targeting_included;




