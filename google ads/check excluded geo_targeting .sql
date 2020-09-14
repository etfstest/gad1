select gc.geo_targeting_included, count(*) as recs
from g_campaign_targeting_20_03_06 as gc
left join g_campaign_targeting_us_20_03_06 as usc on gc.campaign_id = usc.campaign_id
where usc.campaign_id is null 
group by gc.geo_targeting_included
order by recs desc
 