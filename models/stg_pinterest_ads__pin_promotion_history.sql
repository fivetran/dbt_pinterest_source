with base as (

    select *
    from {{ ref('stg_pinterest_ads__pin_promotion_history_tmp') }}

), macro as (

    select

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_pinterest_ads__pin_promotion_history_tmp')),
                staging_columns=get_pin_promotion_history_columns()
            )
        }}

    from base

), fields as (

    select
        id as pin_promotion_id,
        ad_group_id,
        created_time as created_timestamp,
        destination_url,
        {{ dbt_utils.split_part('destination_url', "'?'", 1) }} as base_url,
        {{ dbt_utils.get_url_host('destination_url') }} as url_host,
        '/' || {{ dbt_utils.get_url_path('destination_url') }} as url_path,
        {{ dbt_utils.get_url_parameter('destination_url', 'utm_source') }} as utm_source,
        {{ dbt_utils.get_url_parameter('destination_url', 'utm_medium') }} as utm_medium,
        {{ dbt_utils.get_url_parameter('destination_url', 'utm_campaign') }} as utm_campaign,
        {{ dbt_utils.get_url_parameter('destination_url', 'utm_content') }} as utm_content,
        {{ dbt_utils.get_url_parameter('destination_url', 'utm_term') }} as utm_term,
        name,
        pin_id,
        status,
        creative_type,
        _fivetran_synced
    from macro

), surrogate_key as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['pin_promotion_id','_fivetran_synced'] )}} as version_id
    from fields

)

select *
from surrogate_key
