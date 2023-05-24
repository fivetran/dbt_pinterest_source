{{ config(enabled=fivetran_utils.enabled_vars(['ad_reporting__pinterest_ads_enabled','pinterest__using_keywords'])) }}

select * 
from {{ var('keyword_report') }}
