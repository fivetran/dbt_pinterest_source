with base as (

    select *
    from {{ ref('stg_pinterest_ads__advertiser_history_tmp') }}

), fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_pinterest_ads__advertiser_history_tmp')),
                staging_columns=get_advertiser_history_columns()
            )
        }}
    from base

), surrogate_key as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['advertiser_id','updated_timestamp'] )}} as version_id
    from fields

)

select *
from surrogate_key

