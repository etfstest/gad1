select keyword, to_char(sum(spend), '999G999G999') as tot_spend
from g_top_keywords
where report_date > '2018-12-31'::date and elections = 'US-Federal'
group by keyword
order by tot_spend desc