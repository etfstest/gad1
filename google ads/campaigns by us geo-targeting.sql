select ct.advertiser_id, ct.advertiser_name, mp.ad_id, ct.campaign_id, 
ad_type, geo_targeting_included, geo_targeting_excluded, start_date, end_date 
from g_campaign_targeting as ct
left join gc_id_mapping as mp on  ct.campaign_id = mp.campaign_id
where regions = 'US'
order by ads_list

