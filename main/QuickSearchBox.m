//屏蔽热点推荐
代码位置：com/android/quicksearchbox/SearchSettingsImpl.smali
方法：.method public getShowHot()Z
return false

//屏蔽首页
代码位置：com/android/quicksearchbox/xiaomi/SuggestionTabController.smali
方法：.method public isShowHomepage()Z
return false