/*
_xBwB_RE4Admins = {
//no RE for you lol
};

_xbwb_AlertAdmins {
	_xbwb_alert = _this select 0;

	_xbwb_code2exec = {
		if ((getPlayerUID player) in ["_SP_PLAYER_"]) then {
			#Include "XBWB_AdminFiles\KK_Console.hpp"
			//conRedTime(_xbwb_alert);
			conRedTime("XbwB");
		};
	};	

	[_xbwb_code2exec] call _xBwB_RE4Admins;
};

["Alert Alert Alert"] call _xbwb_AlertAdmins;
*/
#Include "\XBWB_AH\DLLs\KK_Console.hpp"
_msg = "xbwb jtm";
conRedTime(_msg);
