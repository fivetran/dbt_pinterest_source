{{ config(enabled=var('ad_reporting__pinterest_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_pinterest_ads__campaign_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_pinterest_ads__campaign_report_tmp')),
                staging_columns=get_campaign_report_columns()
            )
        }}
    from base
),

final as (
    
    select 
        {{ dbt.date_trunc('day', 'date') }} as date_day,
        campaign_id,
        campaign_name,
        campaign_status,
        ad_account_id as advertiser_id,
        coalesce(impression_1,0) + coalesce(impression_2,0) as impressions,
        coalesce(clickthrough_1,0) + coalesce(clickthrough_2,0) as clicks,
        spend_in_micro_dollar / 1000000.0 as spend

        {{ fivetran_utils.fill_pass_through_columns('pinterest__campaign_report_passthrough_metrics') }}

    from fields
)

select *
from final
