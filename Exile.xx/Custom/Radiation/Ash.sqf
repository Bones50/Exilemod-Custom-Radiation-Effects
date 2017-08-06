KK_fnc_inHouse = {
	_startPosition = getPosASL player;
	_endPosition = [_startPosition select 0, _startPosition select 1, (_startPosition select 2 ) + 10];
	_intersections = lineIntersectsSurfaces [_startPosition, _endPosition, player, objNull, false, 1, "GEOM", "VIEW"];
	_isBelowRoof = !(_intersections isEqualTo []);
	if (_isBelowRoof) exitWith {true};
	_rain = rain;
	if (_rain > 0.15) exitWith {true};
	false;
};

doash = {
private ["_obj","_pos","_ash1","_inVehicle"];
		_offsetbase = [1,-1] call BIS_fnc_selectRandom;
		_offsetx = 3*_offsetbase;
		_offsety = 3*_offsetbase;
		_ashdrop = 0.001+ random 0.1;

        _obj = player;
        _pos = position _obj;
 
        _ash1 = "#particlesource" createVehicleLocal _pos;
		_ash1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 8, 1],"","Billboard", 1, 6, [0, 0, 6], [_offsety,_offsetx, 0], 3, 1.6, 1, 0.1, [0.09], [[0, 0, 0, 1]], [0.08], 1, 0, "", "", vehicle player];
		_ash1 setParticleRandom [5, [25, 25, 5], [_offsetx, _offsety, -1], 0, 0.1, [0, 0, 0, 0.1], 1, 1];
		_ash1 setParticleCircle [0, [_offsetx, _offsety, -1]];
		_ash1 setDropInterval _ashdrop;
 
        _this setVariable ["playerash", floor time + 5];
 
        sleep 120;
 
        deleteVehicle _ash1;
    };
[] spawn {
    while {true} do {
          if(!(player call KK_fnc_inHouse)) then {
            if (player getVariable ["playerash", -1] < time) then {
                player setVariable ["playerash", floor time + 5];
                player spawn doash;
                sleep 120;
            };
        };
    };
};