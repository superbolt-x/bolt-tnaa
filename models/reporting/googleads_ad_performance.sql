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
CASE 
    WHEN campaign_name ~* 'NB' AND campaign_name ~* 'Allied' THEN 'Unbrand - Allied'
    WHEN (campaign_name ~* 'Search - NB -') OR (campaign_name ~* 'Competitor') THEN 'Unbrand - US'
    WHEN campaign_name ~* 'Allentown' THEN 'Location - Allentown'
    WHEN campaign_name ~* 'Southport' THEN 'Location - Southport'
    WHEN campaign_name ~* 'Spokane' THEN 'Location - Spokane' 
    WHEN campaign_name ~* 'Baptist' THEN 'Location - Baptist' 
    WHEN campaign_name ~* 'Willis Knighton' THEN 'Location - Willis Knighton' 
    WHEN campaign_name ~* 'Shannon Health' THEN 'Location - Shannon Health' 
    WHEN campaign_name ~* 'AR Childrens' THEN 'Location - AR Childrens' 
    WHEN campaign_name ~* 'UofL Health' THEN 'Location - UofL Health'
    WHEN campaign_name ~* 'Puget Sound' THEN 'Location - Puget Sound'
    WHEN campaign_name ~* 'Parrish' THEN 'Location - Parrish'
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
unbounceformsubmissionv2 as unbounce_leads,
httptnaacomga4webslimformsubmitv2 as slimform_leads,
dwlead as dw_leads,
dwapp as dw_apps,
dwabs as dw_abs,
dwsubmission as dw_submissions,
dwassignment as dw_assignments
FROM {{ ref('googleads_performance_by_ad') }}
