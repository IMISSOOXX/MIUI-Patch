//移除MIUI9主题商店顶部的banners推荐
代码位置：res/values/dimens.xml
//将 top_banner_height 、recommend_option_view_height的键值都改成 0.0dip
<dimen name="top_banner_height">0.0dip</dimen>
<dimen name="recommend_option_view_height">0.0dip</dimen>

//阻止点击插屏广告跳转小米应用商店引发FC，使其点击无效
代码位置：com/android/thememanager/v9/holder/ElementTextImageBannerViewHolder$1.smali
方法：.method public onClick(Landroid/view/View;)V
return null

//注：以上操作会导致主题商店的部分功能失效，谨慎使用。