# WM_SETTINGCHANGE
A win32 program to broadcast WM_SETTINGCHANGE to all the windows, written in D language.

> Broadcasts a signal to update All Environment variables On Windows XP, 7, 8, 10 systems.  
> Mostly used update changes to Path environment variable in Command Prompt.  
> After broadcast of this signal, reopen applications, for changes to be visible.  
> 
> Note:  
> Windows Command Prompt is programmed to take the new changes on the Path Variable on the launch of new instance.


The first version appeared here: https://forum.dlang.org/post/ngkhsaadchcqbdvmorot@forum.dlang.org

Simple Usage: 
1. `WM_SETTINGCHANGE.exe`  (Default: Environment 1000)
2. `rdmd WM_SETTINGCHANGE.d`  (Default: Environment 1000)

Advanced Usage:
1. `WM_SETTINGCHANGE.exe Environment 5000`  
1. `WM_SETTINGCHANGE.exe Policy 5000`  
1. `WM_SETTINGCHANGE.exe intl 5000`
3. `rdmd WM_SETTINGCHANGE.d Environment 5000`  
3. `rdmd WM_SETTINGCHANGE.d Policy 5000`  
4. `rdmd WM_SETTINGCHANGE.d intl 5000`  


Compilation (.exe):
 `rdmd compile.d`  
 
---
https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-sendmessagetimeouta  
https://docs.microsoft.com/en-us/windows/win32/winmsg/wm-settingchange  
https://docs.microsoft.com/en-us/windows/win32/debug/system-error-codes  
https://docs.microsoft.com/en-us/windows/win32/winprog/windows-data-types
