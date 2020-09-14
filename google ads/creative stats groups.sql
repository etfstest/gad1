select advertiser_name, sum(spend_range_max_usd), count(*) as recs
from g_creative_stats
where regions = 'US'
group by advertiser_name
order by recs desc
