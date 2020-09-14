select advertiser_name, to_char(sum(spend_usd),'999G999G999') as spend, count(*) as recs
from g_advertiser_spend
where election_cycle like 'US-Federal%' -- and week_start_date > '2018-12-31' -- includes some India data, other is all US-Federal-2018, even for 2019 data
group by advertiser_name
order by spend desc