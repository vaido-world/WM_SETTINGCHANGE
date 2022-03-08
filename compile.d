//rdmd compile.d

import std.stdio;
import std.process;
void main(){
	auto dmd = execute(["dmd", "WM_SETTINGCHANGE.d", "command_line_interface.d"]);
}