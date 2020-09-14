select geo_targeting_included, count(*) as recs
from g_campaign_targeting_us_20_03_06
group by geo_targeting_included
order by recs desc