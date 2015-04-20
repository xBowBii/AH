/*
	File: xBwB_Console.sqf
	Creator: xBwB

	Credits: 	KK (DLL)
				SandBird (SQF Snippet)
*/
_xbwb_Admins = ["76561198108361527","_SP_PLAYER_"];

_xbwb_Log = {
	private["_color","_msg"];
	_color = _this select 0;
	_msg = _this select 1;

	switch (_color) do {
	case "conBeep": {"XBWB_AH\DLLs\KK_Console" callExtension ("A");};
	case "conClear": {"XBWB_AH\DLLs\KK_Console" callExtension ("C");};
	case "conClose": {"XBWB_AH\DLLs\KK_Console" callExtension ("X");};
	case "conWhite": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#1110");};
	case "conWhiteTime": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#1111");};
	case "conRed": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#1000");};
	case "conRedTime": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#1001");};
	case "conGreen": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#0100");};
	case "conGreenTime": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#0101");};
	case "conBlue": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#0010");};
	case "conBlueTime": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#0011");};
	case "conYellow": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#1100");};
	case "conYellowTime": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#1101");};
	case "conPurple": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#1010");};
	case "conPurpleTime": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#1011");};
	case "conCyan": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#0110");};
	case "conCyanTime": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "#0111");};
	case "conFile": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "~0000");};
	case "conFileTime": {"XBWB_AH\DLLs\KK_Console" callExtension (_msg + "~0001");};
	};
};

_xbwb_BeepAlert = {
	_xbwb_NumberAlerts = _this select 0;
	for "_i" from 1 to _xbwb_NumberAlerts do {
		["conBeep","Beep"] call _xbwb_Log;
	};
};

if ((getPlayerUID player) in _xbwb_Admins) then {
	_xbwb_listofp = 0;
	{
		_xbwb_listofp = _xbwb_listofp + 1;
	} count playableUnits;

	[1] call _xbwb_BeepAlert;
	["conClear","Clear"] call _xbwb_Log;
	["conGreen","[AH] Console par KK et xBwB"] call _xbwb_Log;
	["conGreen","----------------------------------"] call _xbwb_Log;
	["conGreen",format["Vous: %1, UID: %2",(name player),(getPlayerUID player)]] call _xbwb_Log;
	["conGreen",format["Joueurs connectees: %1",_xbwb_listofp]] call _xbwb_Log;
	["conGreen","----------------------------------"] call _xbwb_Log;

	// <3

	_xbwb_CallLog = {
		_xbwb_name = _this select 0;
		_xbwb_uid = _this select 1;
		_xbwb_reason = _this select 2;

		[8] call _xbwb_BeepAlert;
		["conRedTime",format["ALERTE | %3 | Joueur: %1 (%2)",_xbwb_name,_xbwb_uid,_xbwb_reason]] call _xbwb_Log;
	};

	While {true} do {
		{
			if ((unitRecoilCoefficient _x) < 1) then {
				[name _x, getPlayerUID _x, "unitRecoilCoefficient < 1"] call _xbwb_CallLog;
			};
		} forEach playableunits;
	};
} else {
	while {1==1} do {
        onMapSingleClick '';
        onEachFrame {};
        (vehicle player) allowDamage true;
        (vehicle player) addEventHandler ["HandleDamage"];
        (vehicle player) removeAllEventHandlers "HandleDamage";
        player enableFatigue true;
        removeAllMissionEventHandlers "Draw3D";
        (vehicle player) removeAllEventHandlers "Fired";
        sleep 1;
    };	
};
