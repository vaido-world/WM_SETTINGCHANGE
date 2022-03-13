import SendMessage_WM_SETTINGCHANGE;

import std.stdio;
import std.regex;
import std.string: isNumeric;
import std.conv;

int main(string[] args){

    if (args.length > 1) {
        switch (args.length){
        
            case 2:
                return broadcastSettingChange(args[1]);
                break;
                
            case 3:
                string argument2 = args[2].replaceAll(regex(r"[^0-9.]","g"), "");
                if (argument2.isNumeric){
                    return broadcastSettingChange(args[1], std.conv.to!uint(argument2));
                } else {
                    writeln("Invalid timeout value: ", args[2]," (must be uint integer)");
                }
                break;       

            default:
                goto case 3;
                break;
        }
    } else {
    
        return broadcastSettingChange();
    }

    return 1;

 }
