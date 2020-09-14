drop table if exists g_top_keywords;

create temp table source_form (
	election_cycle text,
	region text,
	elections text,
	report_date date,
	keyword_1 text,
	spend_usd_1 integer,
	keyword_2 text,
	spend_usd_2 integer,
	keyword_3 text,
	spend_usd_3 integer,
	keyword_4 text,
	spend_usd_4 integer,
	keyword_5 text,
	spend_usd_5 integer,
	keyword_6 text,
	spend_usd_6 integer
);

copy source_form
from 'C:/dg-pif/goog ad/google-political-ads-transparency-bundle 2019-09-10/google-political-ads-top-keywords-history.csv' 
CSV HEADER Delimiter ',' QUOTE '"' ESCAPE '"';

create table g_top_keywords as 
	select region, elections, report_date, 
	unnest(array[1,2,3,4,5,6]) as keyword_num, 
	unnest(array[keyword_1,keyword_2, keyword_3, keyword_4, keyword_5, keyword_6]) as keyword,
	unnest(array[spend_usd_1,spend_usd_2, spend_usd_3, spend_usd_4, spend_usd_5, spend_usd_6]) as spend
	from source_form;
	
drop table source_form;


