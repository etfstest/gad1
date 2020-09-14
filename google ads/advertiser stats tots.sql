select advertiser_name, public_ids_list, to_char(sum(total_creatives), '999G999G999') as creatives, 
	to_char(sum(spend_usd), '999G999G999') as spend, count(*) as recs
from g_advertiser_stats
where elections = 'US-Federal'
group by advertiser_name, public_ids_list
order by spend desc