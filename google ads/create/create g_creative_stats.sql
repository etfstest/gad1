drop table if exists g_creative_stats;

create table g_creative_stats (
	ad_id text,
	ad_url text,
	ad_type text,
	regions text,
	advertiser_id text,
	advertiser_name text,
	ad_campaigns_list text,
	date_range_start date,
	date_range_end date,
	num_of_days integer,
	impressions text,
	spend_usd text,
	spend_range_min_usd integer,
	spend_range_max_usd integer
);

create temp table source_format (
ad_id text,
ad_url text,
ad_type text,
regions text,
advertiser_id text,
advertiser_name text,
ad_campaigns_list text,
date_range_start date,
date_range_end date,
num_of_days integer,
impressions text,
spend_usd text,
spend_range_min_usd integer,
spend_range_max_usd integer,
spend_range_min_eur integer,
spend_range_max_eur integer,
spend_range_min_inr integer,
spend_range_max_inr integer,
spend_range_min_bgn integer,
spend_range_max_bgn integer,
spend_range_min_hrk integer,
spend_range_max_hrk integer,
spend_range_min_czk integer,
spend_range_max_czk integer,
spend_range_min_dkk integer,
spend_range_max_dkk integer,
spend_range_min_huf integer,
spend_range_max_huf integer,
spend_range_min_pln integer,
spend_range_max_pln integer,
spend_range_min_ron integer,
spend_range_max_ron integer,
spend_range_min_sek integer,
spend_range_max_sek integer,
spend_range_min_gbp integer,
spend_range_max_gbp integer
);


copy source_format
from 'C:/dg-pif/goog ad/google-political-ads-transparency-bundle 2019-09-10/google-political-ads-creative-stats.csv' 
CSV HEADER Delimiter ',' QUOTE '"' ESCAPE '"';

insert into g_creative_stats
select ad_id, ad_url, ad_type, regions, advertiser_id, advertiser_name, ad_campaigns_list, date_range_start, 
date_range_end, num_of_days, impressions, spend_usd, spend_range_min_usd, spend_range_max_usd
from source_format;

drop table source_format;

drop table if exists gc_id_mapping;

create table gc_id_mapping as
select advertiser_id, ad_id, ad_type, regions, floor(length(ad_campaigns_list)::numeric/20 + 0.5) as camp_size, unnest(string_to_array(ad_campaigns_list,',')) as campaign_id
from g_creative_stats
where regions = 'US'
order by advertiser_id;




