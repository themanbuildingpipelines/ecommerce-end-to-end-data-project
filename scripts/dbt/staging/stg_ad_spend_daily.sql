select
    spend_date,
    nullif(trim(channel), '') as channel,
    nullif(trim(campaign_name), '') as campaign_name,
    nullif(trim(campaign_id), '') as campaign_id,
    impressions,
    clicks,
    cost,
    nullif(trim(currency), '') as currency,
    nullif(trim(ad_platform), '') as ad_platform,
    nullif(trim(target_audience), '') as target_audience,
    nullif(trim(ad_type), '') as ad_type,
    nullif(trim(region), '') as region,
    created_at,
    updated_at,
    load_timestamp,
    source_file
from {{ source('bronze', 'bronze_ad_spend_daily') }}
where spend_date is not null
