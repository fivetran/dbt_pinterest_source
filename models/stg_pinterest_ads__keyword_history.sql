ADD source_relation WHERE NEEDED + CHECK JOINS AND WINDOW FUNCTIONS! (Delete this line when done.)

{{ config(enabled=fivetran_utils.enabled_vars(['ad_reporting__pinterest_ads_enabled','pinterest__using_keywords'])) }}

with base as (

    select * 
    from {{ ref('stg_pinterest_ads__keyword_history_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_pinterest_ads__keyword_history_tmp')),
                staging_columns=get_keyword_history_columns()
            )
        }}
    
        {{ fivetran_utils.source_relation(
            union_schema_variable='pinterest_union_schemas', 
            union_database_variable='pinterest_union_databases') 
        }}

    from base
),

final as (

    select
        source_relation,
        id as keyword_id,
        value as keyword_value,
        _fivetran_id,
        _fivetran_synced,
        ad_group_id,
        advertiser_id,
        archived,
        bid,
        campaign_id,
        match_type,
        parent_type,
        row_number() over (partition by source_relation, id order by _fivetran_synced desc) = 1 as is_most_recent_record
    from fields
)

select *
from final
