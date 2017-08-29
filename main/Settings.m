//移除『我的设备』，恢复为『关于手机』
代码路径：com/android/settings/device
//搜索代码 IS_GLOBAL_BUILD:Z ，该语句会在多个方法出现，选择形如下面的布尔值类型函数，并对该语句 return true
.method public static Ib(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 231
    sget-boolean v0, Lmiui/os/Build;->IS_GLOBAL_BUILD:Z

    const/4 v0, 0x1

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

//移除『关于手机』的系统更新菜单
代码位置：com/android/settings/device/MiuiDeviceInfoSettings.smali
方法：.method public onCreateOptionsMenu
return null