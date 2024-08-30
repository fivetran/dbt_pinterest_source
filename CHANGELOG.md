# dbt_pinterest_source v0.11.0

[PR #33](https://github.com/fivetran/dbt_pinterest_source/pull/33) includes the following updates:

## Feature Updates: Conversion Fields Added
- We have added the following source fields to each `stg_pinterest_ads__<entity>_report` model:
  - `total_conversions`
  - `total_conversions_quantity`
  - `total_conversions_value_in_micro_dollar`
- In the event that you were already passing the above fields in via our [passthrough columns](https://github.com/fivetran/dbt_pinterest/blob/main/README.md#passing-through-additional-metrics), the package will dynamically avoid "duplicate column" errors.

> The above new field additions are 🚨 **breaking changes** 🚨 for users who were not already bringing in conversion fields via passthrough columns.

## Under the Hood
- Created `pinterest_ads_fill_pass_through_columns` and `pinterest_ads_add_pass_through_columns` macros to ensure that the new conversion fields are backwards compatible with users who have already included them via passthrough fields.

# dbt_pinterest_source v0.10.1

[PR #31](https://github.com/fivetran/dbt_pinterest_source/pull/31) includes the following updates:
## Bug Fixes
- This package now leverages the new `pinterest_ads_extract_url_parameter()` macro for use in parsing out url parameters. This was added to create special logic for Databricks instances not supported by `dbt_utils.get_url_parameter()`.
  - This macro will be replaced with the `fivetran_utils.extract_url_parameter()` macro in the next breaking change of this package.
## Under the Hood
- Included auto-releaser GitHub Actions workflow to automate future releases.

# dbt_pinterest_source v0.10.0
[PR #28](https://github.com/fivetran/dbt_pinterest_source/pull/28) includes the following updates:

## Breaking changes
- Updated the following identifiers for consistency with the source name and compatibility with the union schema feature:

| current  | previous |
|----------|----------|
| pinterest_ads_ad_group_history_identifier | pinterest_ad_group_history_identifier |
| pinterest_ads_campaign_history_identifier | pinterest_campaign_history_identifier |
| pinterest_ads_pin_promotion_report_identifier | pinterest_pin_promotion_report_identifier |
| pinterest_ads_keyword_history_identifier | pinterest_keyword_history_identifier |
| pinterest_ads_keyword_report_identifier | pinterest_keyword_report_identifier |
| pinterest_ads_ad_group_report_identifier | pinterest_ad_group_report_identifier |
| pinterest_ads_campaign_report_identifier | pinterest_campaign_report_identifier |
| pinterest_ads_advertiser_history_identifier | pinterest_advertiser_history_identifier |
| pinterest_ads_advertiser_report_identifier | pinterest_advertiser_report_identifier |

- If you are using the previous identifier, be sure to update to the current version!

## Feature update 🎉
- Unioning capability! This adds the ability to union source data from multiple pinterest connectors. Refer to the [Union Multiple Connectors README section](https://github.com/fivetran/dbt_pinterest_source/blob/main/README.md#union-multiple-connectors) for more details.

## Under the hood 🚘
- Updated tmp models to union source data using the `fivetran_utils.union_data` macro. 
- To distinguish which source each field comes from, added `source_relation` column in each staging model and applied the `fivetran_utils.source_relation` macro.
- Updated tests to account for the new `source_relation` column.

# dbt_pinterest_source v0.9.0
# Pinterest Ads v5 Upgrade
## 🚨 Breaking Changes 🚨:
[PR #25](https://github.com/fivetran/dbt_pinterest_source/pull/25) introduces the following changes:
- Following Pinterest Ads deprecating the v4 API on June 30, 2023 in place of v5, the Pinterest Ads Fivetran connector now leverages the Pinterest v5 API. The following fields have been deprecated/introduced:

| **Model** | **Removed**  | **New**   |
|---|---|---|
|  [stg_pinterest_ads__advertiser_history](https://fivetran.github.io/dbt_pinterest_source/#!/model/model.pinterest_source.stg_pinterest_ads__advertiser_history) | `billing_profile_status`, `billing_type`, `merchant_id`, `status`  | `owner_username`, `permissions`  |
|  [stg_pinterest_ads__campaign_history](https://fivetran.github.io/dbt_pinterest_source/#!/model/model.pinterest_source.stg_pinterest_ads__campaign_history) | | `default_ad_group_budget_in_micro_currency`, `is_automated_campaign`, `is_campaign_budget_optimization`, `is_flexible_daily_budgets`  |
|  [stg_pinterest_ads__ad_group_history](https://fivetran.github.io/dbt_pinterest_source/#!/model/model.pinterest_source.stg_pinterest_ads__ad_group_history) |  | `pacing_delivery_type`, `placement_group`, `summary_status`, `advertiser_id` |
|  [stg_pinterest_ads__pin_promotion_history](https://fivetran.github.io/dbt_pinterest_source/#!/model/model.pinterest_source.stg_pinterest_ads__pin_promotion_history) |  | `advertiser_id` |


## Under the Hood:
- Following the v5 upgrade, `ad_account_id` is a net new field within `ad_group_history` and `pin_promotion_history` source tables synced via the connector. However, to keep these fields standard across the package, we have renamed them as `advertiser_id` within the respective staging models.
- Seed data were updated with new/removed fields following the v5 upgrade
# dbt_pinterest_source v0.8.0
- This was an accidental release

# dbt_pinterest_source v0.7.2
## Features
- Addition of the `pinterest__using_keywords` (default=`true`) variable that allows users to disable the relevant keyword reports in the downstream Pinterest models if they are not used. ([PR #23](https://github.com/fivetran/dbt_pinterest_source/pull/23))

## Under the Hood:
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job. ([PR #22](https://github.com/fivetran/dbt_pinterest_source/pull/22))
- Updated the pull request [templates](/.github). ([PR #22](https://github.com/fivetran/dbt_pinterest_source/pull/22))

# dbt_pinterest_source v0.7.1
## 🔧 Fixes
- Added `pin_promotion_id` to unique-combination-of-columns test for model `stg_pinterest_ads` to remedy test failures. ([#21](https://github.com/fivetran/dbt_pinterest_source/pull/21))
# dbt_pinterest_source v0.7.0

## 🚨 Breaking Changes 🚨:
[PR #19](https://github.com/fivetran/dbt_pinterest_source/pull/19) includes the following breaking changes:
- Dispatch update for dbt-utils to dbt-core cross-db macros migration. Specifically `{{ dbt_utils.<macro> }}` have been updated to `{{ dbt.<macro> }}` for the below macros:
    - `any_value`
    - `bool_or`
    - `cast_bool_to_text`
    - `concat`
    - `date_trunc`
    - `dateadd`
    - `datediff`
    - `escape_single_quotes`
    - `except`
    - `hash`
    - `intersect`
    - `last_day`
    - `length`
    - `listagg`
    - `position`
    - `replace`
    - `right`
    - `safe_cast`
    - `split_part`
    - `string_literal`
    - `type_bigint`
    - `type_float`
    - `type_int`
    - `type_numeric`
    - `type_string`
    - `type_timestamp`
    - `array_append`
    - `array_concat`
    - `array_construct`
- For `current_timestamp` and `current_timestamp_in_utc` macros, the dispatch AND the macro names have been updated to the below, respectively:
    - `dbt.current_timestamp_backcompat`
    - `dbt.current_timestamp_in_utc_backcompat`
- Dependencies on `fivetran/fivetran_utils` have been upgraded, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.

# dbt_pinterest_source v0.6.0

## 🚨 Breaking Changes 🚨
- The `pin_promotion_report_pass_through_metric` variable has been renamed to `pinterest__pin_promotion_report_passthrough_metrics`. ([#18](https://github.com/fivetran/dbt_pinterest_source/pull/18))
- The declaration of passthrough variables within your root `dbt_project.yml` has changed. To allow for more flexibility and better tracking of passthrough columns, you will now want to define passthrough metrics in the following format: ([#18](https://github.com/fivetran/dbt_pinterest_source/pull/18))
> This applies to all passthrough metrics within the `dbt_pinterest_source` package and not just the `pinterest__pin_promotion_report_passthrough_metrics` example.
```yml
vars:
  pinterest__pin_promotion_report_passthrough_metrics:
    - name: "my_field_to_include" # Required: Name of the field within the source.
      alias: "field_alias" # Optional: If you wish to alias the field within the staging model.
```
## 🎉 Feature Enhancements 🎉
PR [#18](https://github.com/fivetran/dbt_pinterest_source/pull/18) includes the following changes:
- Addition of the following staging models which pull from the source counterparts. The inclusion of the additional `_report` source tables is to generate a more accurate representation of the Pinterest Ads data. For example, not all Ad types are included within the `pin_promotion_report` table. Therefore, the addition of the further grain reports will allow for more flexibility and accurate Pinterest Ad reporting. 
  - `stg_pinterest_ads__ad_group_report`
  - `stg_pinterest_ads__advertiser_report`
  - `stg_pinterest_ads__campaign_report`
  - `stg_pinterest_ads__keyword_report`
  - `stg_pinterest_ads__advertiser_history`
  - `stg_pinterest_ads__keyword_history`

- Inclusion of additional passthrough metrics: 
  - `pinterest__ad_group_report_passthrough_metrics`
  - `pinterest__campaign_report_passthrough_metrics`
  - `pinterest__advertiser_report_passthrough_metrics`
  - `pinterest__keyword_report_passthrough_metrics`

- README updates for easier navigation and use of the package. 
- Addition of identifier variables for each of the source tables to allow for further flexibility in source table direction within the dbt project.
- Included grain uniqueness tests for each staging table. 

## Contributors
- [@bnealdefero](https://github.com/bnealdefero) ([#18](https://github.com/fivetran/dbt_pinterest_source/pull/18))

# dbt_pinterest_source v0.5.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.

# dbt_pinterest_source v0.1.0 -> v0.4.0
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!
