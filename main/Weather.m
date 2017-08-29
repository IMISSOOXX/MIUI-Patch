//移除主界面的广告
代码位置：com/miui/weather2/tools/ToolUtils.smali
方法：
.method public static canRequestCommercialFromDb //在个别版本出现
.method public static canRequestCommercial
.method public static canRequestCommercialInfo

//移除15天趋势预报的广告
代码位置：com/miui/weather2/structures/DailyForecastAdData.smali
方法：
.method public isAdInfosExistence()Z
.method public isAdTitleExistence()Z
.method public isLandingPageUrlExistence()Z
.method public isUseSystemBrowserExistence()Z
return false