{{ config(enabled=var('ad_reporting__pinterest_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_pinterest_ads__advertiser_history_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_pinterest_ads__advertiser_history_tmp')),
                staging_columns=get_advertiser_history_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as advertiser_id,
        name as advertiser_name,
        status as advertiser_status,
        billing_profile_status,
        billing_type,
        country,
        created_time as created_at,
        currency as currency_code,
        merchant_id,
        owner_user_id,
        updated_time as updated_at,
        row_number() over (partition by id order by updated_time desc) = 1 as is_most_recent_record
    from fields
)

select *
from final
