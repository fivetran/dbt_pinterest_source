with base as (

    select *
    from {{ ref('stg_pinterest_ads__ad_group_history_tmp') }}
), 

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_pinterest_ads__ad_group_history_tmp')),
                staging_columns=get_ad_group_history_columns()
            )
        }}
    from base
), 

final as (

    select 
        id as ad_group_id,
        name as ad_group_name,
        status as ad_group_status,
        _fivetran_synced,
        campaign_id,
        created_time as created_at,
        end_time,
        start_time
    from fields
),

most_recent as (
    select
        *,
        row_number() over (partition by ad_group_id order by _fivetran_synced desc) = 1 as is_most_recent_record
    from final
)

select *
from most_recent
