//移除安全扫描完成页的资讯推荐
反编译res，在values/public.xml找到 display_antivirus_Ads 对应的id，
再在smali/com/miui中查找其对应的布尔型函数，return false

//移除应用锁中的资讯推荐
同上，display_applock_Ads

//移除安全体检（立即优化）完成页的资讯推荐
同上，preference_key_information_setting_close

/移除应用管理的资源推荐
代码路径：com/miui/appmanager
代码：am_ads_enable
//找到该代码所在的布尔型函数，return false
