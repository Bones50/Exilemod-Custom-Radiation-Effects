ppEffectDestroy ExileClientPostProcessingColorCorrections;

0 = ["ColorCorrections", 1500, [0.4, 0.4, 0,-0.2, 0, 0.2, -0.2,5, 2, 1.5, 2,-1.1, -0.05, 0.5, 0]] spawn {
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 5;
};