// andere random_pos (nur Hügel!!!)
private _range = 5;
private _tower = "Land_TTowerBig_2_F" createVehicle getMarkerPos "respawn_west";
_tpos = [getPos _tower, 0, 1500, 10, 0, 0.065, 0] call BIS_fnc_findSafePos;
_tower setPos _tpos;

while { alive _tower } do 
{
	{
		if (_x distance _tower <= _range) then {
			_x setVariable ["tf_receivingDistanceMultiplicator", 5];
			_x setVariable ["tf_sendingDistanceMultiplicator", 5];
			systemChat "Enhanced radio signal";
		
		}
		else
		{
			_x setVariable ["tf_receivingDistanceMultiplicator", 1];
			_x setVariable ["tf_sendingDistanceMultiplicator", 1];
			systemChat "Default radio signal";
		};
	} forEach allPlayers;
	
};