create table g_geotargets_2020_03_03 (
	tar_criteria_id bigint,
	tar_name text,
	tar_canonical_name text,
	tar_parent_id bigint,
	tar_country_code text,
	tar_type text,
	tar_status text,
	tar_state text
);

copy g_geotargets_2020_03_03 (
	tar_criteria_id,
	tar_name,
	tar_canonical_name,
	tar_parent_id,
	tar_country_code,
	tar_type,
	tar_status
)
from 'C:/dg-pif/goog ad/data-supplementary/g_geotargets_2020_03_03.csv' 
WITH (FORMAT csv,  DELIMITER ',', NULL '', HEADER true,  QUOTE '"', ESCAPE '"', 
	  FORCE_NULL(tar_criteria_id, tar_parent_id));
	  
update g_geotargets_2020_03_03 as geo
set tar_state = ra[array_length(ra, 1) - 1]
from (
	select tar_criteria_id, regexp_split_to_array(tar_canonical_name,',')  as ra
	from g_geotargets_2020_03_03
	where tar_country_code = 'US' and tar_canonical_name <> 'United States'
) sqa
where geo.tar_criteria_id = sqa.tar_criteria_id;  

-- correct Google data coding errors
update g_geotargets_2020_03_03
set tar_state =
case tar_state
when 'French Quarter - CBD' then 'Louisiana'
when 'Great Smoky Mountains National Park' then 'Tennessee'
when 'Holly Springs' then 'North Carolina'
when 'San Francisco Bay Area' then 'California'
when 'Yellowstone National Park' then 'Wyoming'
else tar_state
end;
