# Pinterest Ads (Source)

This package models Pinterest Ads data from [Fivetran's connector](https://fivetran.com/docs/applications/pinterest-ads). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/pinterest-ads#schemainformation).

This package enriches your Fivetran data by doing the following:

* Adds descriptions to tables and columns that are synced using Fivetran
* Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
* Models staging tables, which will be used in our transform package

## Models

This package contains staging models, designed to work simultaneously with our [Pinterest Ads modeling package](https://github.com/fivetran/dbt_pinterest) and our [multi-platform Ad Reporting package](https://github.com/fivetran/dbt_ad_reporting). The staging models:

* Name columns consistently across all packages:
    * Boolean fields are prefixed with `is_` or `has_`
    * Timestamps are appended with `_at`
    * ID primary keys are prefixed with the name of the table. For example, the campaign table's ID column is renamed `campaign_id`.

## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

## Configuration
By default, this package will look for your Pinterest Ads data in the `pinterest_ads` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Pinterest Ads data is, please add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    pinterest_database: your_database_name
    pinterest_schema: your_schema_name 
```

### Passthrough Columns
This package allows for custom user defined metrics to be passed through to the `stg_pinterest_ads__pin_promotion_report` model. These custom metrics may be applied using the `pin_promotion_report_pass_through_metric` variable. To apply a passthrough metric you will set the sql required to recreate the metric as a string within the variable. This sql will then be referenced and used as a custom field during model generation. See the below example for how to passthrough new metric fields to the final staging model.

```yml
# dbt_project.yml

...
vars:
  pin_promotion_report_pass_through_metric:
    - 'coalesce(my_new_field,0) + coalesce(my_new_field,0) as new_metric'
    - 'other_new_field / 100000.0 as other_new_metric'

```

### Changing the Build Schema
By default this package will build the Pinterest Ads staging models within a schema titled (<target_schema> + `_stg_pinterest`) in your target database. If this is not where you would like your Pinterest Ads staging data to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
models:
    pinterest_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```

## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `master`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Resources:
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Learn more about Fivetran [here](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
