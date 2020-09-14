-- includes

create table g_camptargs_us_states_20_03_06_incl as
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


-- excludes

create table g_camptargs_us_states_20_03_06_excl as
with regions as (
	select campaign_id, geo_targeting_excluded, regexp_split_to_table(geo_targeting_excluded, ',') as rg
	from g_campaign_targeting_us_20_03_06
)

select geo_targeting_excluded, array_agg(tar_state) as tar_state_array
from (
	-- targeted states
	select geo_targeting_excluded, tar_state
	from regions
	join g_geotargets_2020_03_03 on (rg = tar_name and tar_name = tar_state )

	union

	-- targeted U.S. zip codes
	select geo_targeting_excluded, tar_state 
	from regions
	join g_geotargets_2020_03_03 on (rg = tar_name and tar_name ~ '^\d{5}$' and tar_country_code = 'US' )
) sqa
group by geo_targeting_excluded;

