/*
	Creator: xBwB
	Credits: 
		Jacob88 (Opensource DLLs),
		KillzoneKid (KK_CHECKP DLL),
		Lystic (SQF Snippets),
		infiSTAR (SQF Snippets),
		Harmdhast (Aide)
*/
onPlayerConnected {
    if (_uid == "") exitWith {};

	0 = [_name,_uid] spawn {
	    _name = _this select 0;
	    _uid = _this select 1;

	    _xbwb_hasBans = {
			_xbwb_name = _this select 0;
			_xbwb_uidp = _this select 1;
			_xbwb_what = _this select 2;
			_xbwb_para = _this select 3;
			"XBWB_AH\DLLs\XBWB_hasBans" callExtension format["XBWB_AH | BANS | JOUEUR %1 (%2) | %3 -> %4",_xbwb_name,_xbwb_uidp,_xbwb_what,_xbwb_para];
		};

		_xbwb_isOk = {
			_xbwb_name = _this select 0;
			_xbwb_uidp = _this select 1;
			"XBWB_AH\DLLs\XBWB_isOk" callExtension format["XBWB_AH | OK | JOUEUR %1 (%2) | Aucun bans",_xbwb_name,_xbwb_uidp];
		};

	    _xbwb_Error = {
			_xbwb_name = _this select 0;
			_xbwb_uidp = _this select 1;
			"XBWB_AH\DLLs\XBWB_Error" callExtension format["XBWB_AH | ERREUR | JOUEUR %1 (%2) | Erreur pendant la vérification des bans",_xbwb_name,_xbwb_uidp];	
		};

	    _check = {
	        {
	            _cond = _x select 1 != "0" && _x select 1 != "none";
	            if (_cond) then {
	                [_name,_uid,(_x select 0),(_x select 1)] call _xbwb_HasBans;
	            };
	            _cond
	        } count _this;
	    };

	    "XBWB_AH\DLLs\KK_CHECKP" callExtension _uid;
	    _time = time + 10;
	    private "_bans";
	    waitUntil {
	        _bans = "XBWB_AH\DLLs\KK_CHECKP" callExtension _uid;
	        _bans != "WAIT" || {_bans = "[]"; time > _time}
	    };
	    if (_bans == "[]") then {
	         [_name,_uid] call _xbwb_Error;
	    } else {
	        if ((call compile _bans) call _check == 0) then {
	            [_name,_uid] call _xbwb_isOk;
	        };
	    };
	};
};

_xbwb_AH = {
	_xbwb_var_1 = [_this, 0, nil] call BIS_fnc_param;
	[] spawn (_xbwb_var_1);
};

_xbwb_pListfnc = {
	_xbwb_plist = [];

	{
		if (isPlayer _x) then {
			_xbwb_format_plist = format["%1 (%2)",(name _x),(getPlayerUID _x)];
			_xbwb_plist = _xbwb_pList + _xbwb_format_plist;
		};
	} foreach playableUnits;

	_xbwb_plist;
};

_xbwb_Check_SwatikaHack = {
	[] spawn {
		_xbwb_cntq1 = 0;
		{
			if (_x isKindOf "AllVehicles") then
			{    
				if ((typeof _x) in ["C_Quadbike_01_F"]) then {
					_xbwb_cntq1 = _xbwb_cntq1 + 1;
				};
			};  
		} forEach vehicles; 
		sleep 6;
		_xbwb_cntq2 = 0;
		{
			if (_x isKindOf "AllVehicles") then
			{    
				if ((typeof _x) in ["C_Quadbike_01_F"]) then {
					_xbwb_cntq2 = _xbwb_cntq2 + 1;
				};
			};  
		} forEach vehicles; 
		sleep 2;
		if ((_xbwb_cntq2 - _xbwb_cntq1) > 45) then {
			_xbwb_pOnLineAlert = call _xbwb_pListfnc; // A TESTER EN MP
			"XBWB_AH\DLLs\XBWB_ALERTS" callExtension format["XBWB_AH | HACK | SWASTIKA QUAD HACK | Players Online: %1",_xbwb_pOnLineAlert];
		};
	};
	sleep 2;
};

_xbwb_Check_DesyncHack = { 
	[] spawn {
		_xbwb_cntq1 = 0;
		{
			if (_x isKindOf "AllVehicles") then
			{    
				if ((typeof _x) in ["O_Heli_Attack_02_black_F"]) then {
					_xbwb_cntq1 = _xbwb_cntq1 + 1;
				};
			};  
		} forEach vehicles; 
		sleep 6;
		_xbwb_cntq2 = 0;
		{
			if (_x isKindOf "AllVehicles") then
			{    
				if ((typeof _x) in ["O_Heli_Attack_02_black_F"]) then {
					_xbwb_cntq2 = _xbwb_cntq2 + 1;
				};
			};  
		} forEach vehicles; 
		sleep 2;
		if ((_xbwb_cntq2 - _xbwb_cntq1) > 45) then {
			"XBWB_AH\DLLs\XBWB_ALERTS" callExtension format["XBWB_AH | HACK | CRASH-SERVER HACK"];
		};
	};
	sleep 2;
};

_xbwb_Check_VehicleLocal = {
	{
		if (local _x && (vehicle player != player)) then {
			_xbwb_crew = crew _x;
			_xbwb_0 = name (_xbwb_crew select 0); 	// Driver
			_xbwb_1 = name (_xbwb_crew select 1);	// Gunner
			_xbwb_2 = name (_xbwb_crew select 4); 	// Cargo

			"XBWB_AH\DLLs\XBWB_ALERTS" callExtension format["XBWB_AH | LOCAL_VEHICLE | Pilote: %1 | Tireur: %2 | Passager: %3",_xbwb_0,_xbwb_1,_xbwb_2];
			sleep 1.2;
			deleteVehicle _x;
		};
	} forEach vehicles;
};