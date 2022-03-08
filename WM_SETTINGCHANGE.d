import std.utf;
version(Windows) pragma(lib, "user32.lib");

import core.sys.windows.windows : SendMessageTimeoutW;
import core.sys.windows.windows : GetLastError;
import core.sys.windows.windows : ERROR_SUCCESS;
import core.sys.windows.windows : SMTO_ABORTIFHUNG;
import core.sys.windows.windows : LPARAM;
import core.sys.windows.windows : HWND_BROADCAST;
import core.sys.windows.windows : WM_SETTINGCHANGE;
import core.sys.windows.basetsd : PDWORD_PTR;

import std.stdio;


 /**
    Broadcasts a signal to update All Environment variables On Windows XP, 7, 8, 10 systems.
    Mostly used update changes to Path environment variable.
    After broadcast of this signal, reopen applications, for changes to be visible.
    
    Usage: 
        1. dmd WM_SETTINGCHANGE.d
           WM_SETTINGCHANGE.exe Environment 5000
        2. rdmd WM_SETTINGCHANGE.d Environment 5000

    Date: 07/09/2019
    License: use freely for any purpose
    
    Update: 2022-03-04
    ChangeLog: 
    * Fixed Typos
    * Added Switch Statement for Command Line Interface Arguments
    * Added Switch Statement for Policy, intl, Environment
    * Added Switch Statement for Error handling: Exit status, Error level
    * Increased window "timeout" from 1 to 1000

    Online Repository: https://github.com/vaido-world/WM_SETTINGCHANGE

    Params:
        broadcastAddress = "Policy"      When the system sends this message as a result of a change in policy settings, this parameter points to this string.
                           "intl"        When the system sends this message as a result of a change in locale settings, this parameter points to this string.
                           "Environment" To effect a change in the environment variables for the system or the user, broadcast this message with lParam set to this string

    Returns: win32 system-error-code of int type.
    See_Also:
        https://docs.microsoft.com/lt-lt/windows/win32/api/winuser/nf-winuser-sendmessagetimeouta
        https://docs.microsoft.com/en-us/windows/win32/winmsg/wm-settingchange
 */
 

 @trusted int broadcastSettingChange (string broadcastAddress="Environment", uint timeout=1000)
 {
 
 
/*__________________Check if message parameter is one of the available options.__________________*/
    switch (broadcastAddress)
    {
        case "Policy":
            break;
        
        case "intl":
            break;
        
        case "Environment":
            break;
        
        default:
            writeln("The broadcastAddress variable value, \"", broadcastAddress, "\", is incorrect.");
            writeln("Please select one of the three options.");
            writeln(" Policy");
            writeln(" intl");
            writeln(" Environment");
    
    }

__________________THE_CORE_OF_THE_PROGRAM__________________:

    void* hWnd = HWND_BROADCAST;
    uint  Msg = WM_SETTINGCHANGE;
    uint  wParam = 0;
    int   lParam = cast( LPARAM )broadcastAddress.toUTF16z;
    uint  fuFlags = SMTO_ABORTIFHUNG;
    uint  uTimeout = timeout;
    
    import core.sys.windows.winnt;
    DWORDLONG lpdwResult = 1;

    int result = SendMessageTimeoutW(
        hWnd,
        Msg,
        wParam,
        lParam,
        fuFlags,
        uTimeout,
        cast( PDWORD_PTR ) &lpdwResult // https://www.autohotkey.com/board/topic/80581-how-to-detect-a-hung-window/
    );
    


__________________INFORMATIVE_WARNINGS__________________:

    if(result == 0)
    {

        writeln("The function SendMessageTimeoutW did not even start broadcasting message.");
        
    } 
    
    if(lpdwResult != 0){ 

        writeln("WM_SETTINGCHANGE message was not processed by the top-level windows.");

    }
    

/*__________________WIN32 Error handling for SendMessageTimeoutW fuction__________________*/

    import core.sys.windows.winerror;
    
    int lastError = GetLastError();
    
    switch (lastError){
    
        case ERROR_SUCCESS:
            writeln("[", __FILE__, "] Success. Sent a WM_SETTINGCHANGE of ", broadcastAddress, ", broadcast to all top windows.");
            break;
        
        case ERROR_TIMEOUT:
            writeln("ERROR_TIMEOUT");
            writeln("Notice: Some top-windows were not notified due to timeout.");
            writeln("TIP: Increase the top-windows uTimeout of SendMessageTimeoutW. (current value: ", timeout, ")");
            break;
            
        case ERROR_INVALID_PARAMETER:
            writeln("ERROR_INVALID_PARAMETER");
            break;
            
        default:
            writeln("https://docs.microsoft.com/en-us/windows/win32/debug/system-error-codes--0-499-");
            writeln("https://docs.microsoft.com/en-us/windows/win32/debug/system-error-codes--500-999-");
            writeln("https://docs.microsoft.com/en-us/windows/win32/debug/system-error-codes--1300-1699-");
            writeln("Exit Error: ", lastError);
    
    }
        
        return lastError;


  }