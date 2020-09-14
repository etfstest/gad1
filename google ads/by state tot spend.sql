select substring(country_subdivision_primary from 4), sum(spend_usd)
from g_geo_spend
where country_subdivision_primary like 'US-%'
group by country_subdivision_primary
order by country_subdivision_primary