{{ config(materialized='table') }}

with cleaned_ad_spending as (
    select
        campaign_id,
        spend_date,

        case
            when channel in ('Google', 'google ads') then 'Google Ads'
            when channel = 'facebook' then 'Facebook'
            when channel = 'Twitter' then 'X (formerly Twitter)'
            else channel
        end as marketing_channel,

        case
            when campaign_name in ('BlackFriday2024', 'black_friday', 'BLACKFRIDAY') then 'Black Friday'
            when campaign_name in ('Summer Sale 2024', 'summer-sale', 'summer_sale_2024', 'SUMMER_SALE') then 'Summer Sale'
            when campaign_name in ('awareness-campaign', 'BRAND', 'brand_awareness') then 'Brand Awareness'
            when campaign_name in ('HOLIDAY', 'holiday_sale', 'holiday-promo-2024') then 'Holiday Sale'
            when campaign_name in ('RETARGET', 'retarget_q4', 'retargeting') then 'Retargeting Campaign'
            when campaign_name in ('new_customer', 'NEW CUSTOMER', 'new-customer-2024') then 'New Customer Promo'
            else campaign_name
        end as campaign_name,

        impressions,
        clicks,

        -- Normalize cost into USD (assumes base currency is already USD unless EUR/GBP)
        case
            when currency = 'EUR' then cost * 1.17
            when currency = 'GBP' then cost * 1.35
            else cost
        end as cost_in_usd,

        currency,

        case
            when ad_platform = 'Instagram' then 'Instagram Ads'
            when ad_platform in ('Google', 'google ads') then 'Google Ads'
            when ad_platform = 'LinkedIn' then 'LinkedIn Ads'
            when ad_platform in ('Twitter', 'Twitter Ads', 'X') then 'X Ads'
            when ad_platform = 'TikTok' then 'TikTok Ads'
            when ad_platform = 'facebook' then 'Facebook Ads'
            else ad_platform
        end as ad_platform,

        target_audience,

        case
            when upper(region) in ('KENYA', 'KE') then 'Kenya'
            when upper(region) in ('FRANCE', 'FR') then 'France'
            when upper(region) in ('GERMANY', 'DE') then 'Germany'
            when upper(region) in ('UNITED KINGDOM', 'UK', 'GBR') then 'United Kingdom'
            when upper(region) in ('UNITED STATES', 'USA', 'US') then 'United States'
            when upper(region) in ('GLOBAL', 'WORLDWIDE') then 'Global'
            when upper(region) in ('ALL') then 'All'
            else 'Unknown'
        end as region,

        cast(created_at as date) as ad_creation_date,
        cast(updated_at as date) as ad_updated_date,
        load_timestamp,

        -- Data quality flags (flag them instead of dropping)
        case when spend_date < cast(created_at as date) then 1 else 0 end as dq_spend_before_creation,

        case when impressions < clicks then 1 else 0 end as dq_clicks_gt_impressions

    from {{ ref('stg_ad_spend_daily') }}
),

final as (
    select
        *,
        dense_rank() over (order by campaign_id) as campaign_day_seq
    from cleaned_ad_spending
)

select
    campaign_id,
    campaign_day_seq,
    spend_date,
    marketing_channel,
    campaign_name,
    impressions,
    clicks,
    cost_in_usd,
    currency,
    case when upper(trim(ad_platform)) = 'META' and marketing_channel = 'Facebook' then 'Facebook Ads'
    when upper(trim(ad_platform)) = 'META'and marketing_channel = 'Instagram' then 'Instagram Ads'
    else ad_platform
    end ad_platform,
    target_audience,
    region,
    ad_creation_date,
    ad_updated_date,
    load_timestamp,
    dq_spend_before_creation,
    dq_clicks_gt_impressions
from final
