select geo_targeting_included, geo_targeting_excluded  --, count(*) as recs
from g_campaign_targeting_us_20_03_06
--where geo_targeting_excluded <> 'Not targeted'
-- and geo_targeted_included <> 'United States'
--group by geo_targeting_included, geo_targeting_excluded
--order by recs desc