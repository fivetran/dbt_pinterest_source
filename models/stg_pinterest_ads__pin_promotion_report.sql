with base as (

    select *
    from {{ ref('stg_pinterest_ads__pin_promotion_report_tmp') }}

), macro as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_pinterest_ads__pin_promotion_report_tmp')),
                staging_columns=get_pin_promotion_report_columns()
            )
        }}
    from base

), fields as (

    select 
        date as date_day,
        pin_promotion_id,
        ad_group_id,
        campaign_id,
        advertiser_id,
        _fivetran_synced,
        coalesce(impression_1,0) + coalesce(impression_2,0) as impressions,
        coalesce(clickthrough_1,0) + coalesce(clickthrough_2,0) as clicks,
        spend_in_micro_dollar / 1000000.0 as spend
        {% for metric in var('pin_promotion_report_pass_through_metric') %}
        , {{ metric }}
        {% endfor %}

    from base

), surrogate_key as (

    select
        *,
        {{ dbt_utils.surrogate_key(['date_day','pin_promotion_id']) }} as report_id
    from fields

)

select *
from surrogate_key  
