KK_fnc_inHouse = {
	_startPosition = getPosASL player;
	_endPosition = [_startPosition select 0, _startPosition select 1, (_startPosition select 2 ) + 10];
	_intersections = lineIntersectsSurfaces [_startPosition, _endPosition, player, objNull, false, 1, "GEOM", "VIEW"];
	_isBelowRoof = !(_intersections isEqualTo []);
	if (_isBelowRoof) exitWith {true};
	_rain = rain;
	if (_rain > 0.15) exitWith {true};
	if (vehicle player isKindOf "Air") exitWith {true};
	_tempPos = getPosATL player;
	_plyrAlt = _tempPos select 2;
	if(_plyrAlt > 8) exitWith {true};
	false;
};

dodust = {
private ["_obj","_pos","_dust1","_inVehicle"];
		playsound "sandstorm";
		_velocitydust = [random 10,random 10,-1];
		_colordust = [1.0, 0.9, 0.8];
		_alphadust = 0.01+random 0.1;
		
        _obj = player;
        _pos = position _obj;
		_pos set [2,0];
 
        _dust1 = "#particlesource" createVehicleLocal _pos;
		_dust1 setParticleParams [["\A3\data_f\cl_basic",1,0,1], "", "Billboard", 1, 7+random 4, [0, 0, -6], _velocitydust, 13, 1.275, 1, 0, [4,10,20], [_colordust  + [0], _colordust + [_alphadust], _colordust  + [0]], [0.08], 1, 0, "", "", vehicle player];
		_dust1 setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
		_dust1 setParticleCircle [0.1, [0, 0, 0]];
		_dust1 setDropInterval 0.01;
 
        _this setVariable ["playerdust", floor time + 5];
 
        sleep 15;

        deleteVehicle _dust1;
    };
[] spawn {
    while {true} do {
        if(!(player call KK_fnc_inHouse)) then 
		{
        _dustchance = floor random 100;
		if(_dustchance > 70) then 
			{
			if (player getVariable ["playerdust", -1] < time) then 
				{
				player setVariable ["playerdust", floor time + 5];
				player spawn dodust;
				sleep 30;
				};
			} 
			else 
			{
			sleep 30;
			};
        };
    };
};