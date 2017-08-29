//禁用日历本地化功能
代码位置：com/miui/calendar/util/LocalizationUtils.smali
方法：.method public static isLocalFeatureEnabled
return false

//移除节日详情页的内容推荐
代码位置：com/miui/calendar/card/single/custom/CustomSingleCard.smali
方法：.method public bindData
return null