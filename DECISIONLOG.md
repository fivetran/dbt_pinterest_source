### Why may aggregations across different grains (keywords, ad group, campaign, etc) differ?

Different grains may not always have entire coverage and map out to each other. For example, there may be some ad groups that only feature in campaigns, and not at the ad group level itself. Therefore This means that you can have ad groups sent at the campaign level and that counts towards your total spend. However, since the ad group was never sent at an individual ad group level, it will not be included.

This was a large reason for us breaking the ad reporting package into separate hierarchical end models. Because we found when we only used the ad group level, for example, we were missing data as some ad groups were not served at an ad group level, but were served at a campaign level.
