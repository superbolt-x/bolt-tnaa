{{ config (
    alias = target.database + '_googleads_ad_performance'
)}}

SELECT
account_id,
ad_id,
campaign_name,
campaign_id,
campaign_status,
campaign_type_default,
CASE WHEN campaign_name ~* 'NB' AND campaign_name !~* 'DSA' AND campaign_name !~* 'Allentown' THEN 'Unbrand - US'
    WHEN campaign_name ~* 'Allentown' THEN 'Unbrand - Allentown'
    WHEN campaign_name ~* 'Southport' THEN 'Unbrand - Southport'
    WHEN campaign_name ~* 'Brand' THEN 'Brand'
    WHEN campaign_name ~* 'Performance Max' THEN 'Performance Max'
    WHEN campaign_name ~* 'DSA' THEN 'DSA'
    ELSE 'Others'
END as campaign_type_custom,
ad_group_name,
ad_group_id,
date,
date_granularity,
spend,
impressions,
clicks,
conversions as purchases,
conversions_value as revenue,
"Unbounce Form Submission V. 2" as unbounce_leads,
"http://tnaa.com - GA4 (web) slimFormSubmitV2" as slimform_leads
FROM {{ ref('googleads_performance_by_ad') }}
