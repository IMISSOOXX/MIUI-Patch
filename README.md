# 关于MIUI Patch
- 它是专门用于清除MIUI系统侵入式广告，以及轻量化MIUI的MOD卡刷包。已停止开发。
## 这是一篇不需要编程基础就能学会的MIUI Patch傻瓜式适配教程
- 我们知道，MIUI国际版是没有广告的。但当你将MIUI国际版的APK提取替换到国内版时，它重新出现了广告。原因是APK本质上是一致的，只不过MIUI通过一系列的方法来判断当前系统的状态，来决定是否向你展示广告以及本地化的一些功能。
- 我们要做的就是找到这些方法，使其按照我们的设定去工作，在保留MIUI本地化功能的同时把广告给干掉。本项目会直接告诉你这些方法的具体位置以及处理方式，你只须利用 [Apktool](https://ibotpeaches.github.io/Apktool/) 对相应APK进行反编译并执行对应的修改再回编译即可。当然，如果你使用的是WIN操作系统，你还可以使用 [APKDB](https://www.idoog.cn/?cat=535) 工具。
- 如果你无须改动resources，请使用命令：
`apktool d -r *.apk` 
如果你无须改动classes，请使用命令：
`apktool d -s *.apk`
如须修改资源，你必须将 miui.apk、miuisystem.apk、framework-ext-res.apk、framework-res.apk 加载至框架，示例：
`apktool if miui.apk`
回编译时使用命令：
`apktool b -c <dir>`
- 另外，有几个专门用于投放/管理MIUI系统广告的组件，分别是 AnalyticsCore.apk、mab.apk、SystemAdSolution.apk，找到它们并delete。
### 如何读懂适配文件？
示例代码：
```
//禁用日历本地化功能
代码位置：com/miui/calendar/util/LocalizationUtils.smali
方法：.method public static isLocalFeatureEnabled
return false
```
对应的修改：
```
.method public static isLocalFeatureEnabled(Landroid/content/Context;)Z
    .locals 1

    const/4 v0, 0x0  #若是return true，此处为const/4 v0, 0x1

    return v0
.end method
```
示例代码：
```
//移除节日详情页的内容推荐
代码位置：com/miui/calendar/card/single/custom/CustomSingleCard.smali
方法：.method public bindData
return null
```
对应的修改：
```
.method public bindData(Lcom/miui/calendar/card/schema/CustomCardSchema;)V
    .locals 0

    return-void
.end method
```
示例代码：
```
//移除『我的设备』，恢复为『关于手机』
代码路径：com/android/settings/device
//搜索代码 IS_GLOBAL_BUILD:Z ，该语句会在多个方法出现，选择形如下面的布尔值类型函数，并对该语句 return true
.method public static Ib(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 231
    sget-boolean v0, Lmiui/os/Build;->IS_GLOBAL_BUILD:Z

    if-eqz v0, :cond_0

    .line 232
    const/4 v0, 0x0

    return v0

    .line 234
    :cond_0
    invoke-static {}, Lcom/android/settings/device/a;->In()Z

    move-result v0

    return v0
.end method
```
对应的修改（注意这里是对 **IS_GLOBAL_BUILD:Z** 语句return true）：
```
.method public static Ib(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 231
    sget-boolean v0, Lmiui/os/Build;->IS_GLOBAL_BUILD:Z

    const/4 v0, 0x1  #在要处理的语句后加上相应的操作就可以了！

    if-eqz v0, :cond_0

    .line 232
    const/4 v0, 0x0

    return v0

    .line 234
    :cond_0
    invoke-static {}, Lcom/android/settings/device/a;->In()Z

    move-result v0

    return v0
.end method
```
推荐使用代码编辑器 [Notepad++](https://notepad-plus-plus.org/) 执行修改。
### 如何对ROM进行deodex
你从MIUI官网下载的ROM固件默认都是odex处理过的，我们无法直接对其进行反编译，所以必须先对其deodex化。你可以使用以下工具进行操作，使用方法见原post。
1. [ASSAYYED_KITCHEN](https://forum.xda-developers.com/chef-central/android/best-android-roms-editor-assayyedkitchen-t3410545)
2. [SVADeodexerForArt](https://forum.xda-developers.com/galaxy-s5/general/tool-deodex-tool-android-l-t2972025)
### 如何破译MIUI系统的卡米限制
MIUI对系统做了保护措施，如果你篡改了系统文件，比如删除应用商店、安全中心、系统更新等组件会直接导致开机一直卡在 mi logo 无法启动，因此我们必须先除掉这个后患。
处理方法：
```
框架层/system/framework：services.jar
//移除MIUI系统保护机制
代码位置：com/miui/server/SecurityManagerService.smali
方法：.method private checkSystemSelfProtection(Z)V
return null
```
### 可删除的APK列表
| APK名称 | 备注 | 关联组件 |
|:----:|:----:|:----:|
|BasicDreams.apk|动态壁纸||
|Galaxy4.apk|同上||
|HoloSpiralWallpaper.apk|同上||
|LiveWallpapers.apk|同上||
|NoiseField.apk|同上||
|PhaseBeam.apk|同上||
|MiWallpaper.apk|小米百变壁纸|ThemeManager.apk|
|MiuiSuperMarket.apk|应用商店|ThemeManager.apk|
|GameCenter.apk|游戏中心||
|MiGameCenterSDKService.apk|小米游戏自动登录组件|GameCenter.apk|
|MiuiVideo.apk|小米视频||
|Music.apk|小米音乐||
|MusicFX.apk|均衡器|Music.apk、Settings.apk|
|PaymentService.apk|米币支付服务||
|Updater.apk|系统更新|Settings.apk|
|Browser.apk|小米浏览器||
|BookmarkProvider.apk|书签|Browser.apk|
|MiLivetalk.apk|小米电话加油包|Contacts.apk|
|VirtualSim.apk|虚拟SIM|Contacts.apk|
|PicoTts.apk|TTs文字转语音引擎，不支持中文|Settings.apk、/system/tts|
|XiaomiVip.apk|小米VIP|XiaomiAccount.apk|
|XMPass.apk|小米卡包||
|VipAccount.apk|我的小米|XiaomiAccount.apk、XiaomiVip.apk|
|VoiceAssist.apk|语音助手||
|PhotoTable.apk|照片屏幕保护程序||
|SogouInput.apk|搜狗输入法|系统唯一内置的输入法引擎|
- 你可以按需删除以上程序，对于存在关联组件的APK，你须对其关联组件作相应的处理，否则会发生FC等现象。
## 联系作者
- 酷安网 @蓝色星期五
- [![](http://rescdn.qqmail.com/zh_CN/htmledition/images/function/qm_open/ico_mailme_02.png)](http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=8JmUlZGTnJ_FlLCBgd6Tn50)
