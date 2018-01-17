set SDK_PATH="%ANDROID_SDK_HOME%\platform-tools"

%SDK_PATH%\adb devices
pause

%SDK_PATH%\adb install %1.apk
pause