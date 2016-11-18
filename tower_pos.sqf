// andere random_pos (nur Hügel!!!)
private _range = 5;
private _tower = "Land_TTowerBig_2_F" createVehicle getMarkerPos "respawn_west";
_tpos = [getPos _tower, 0, 1500, 10, 0, 0.065, 0] call BIS_fnc_findSafePos;
_tower setPos _tpos;

private _recdist = allPlayers select 0 getVariable ["tf_receivingDistanceMultiplicator"];
private _sendist = allPlayers select 0 getVariable ["tf_sendingDistanceMultiplicator"];


while { alive _tower } do 
{
	{
		if (_x distance2D _tower <= _range) then {
			_x setVariable ["tf_receivingDistanceMultiplicator", 10];
			_x setVariable ["tf_sendingDistanceMultiplicator", 10];
			_x commandChat "Enhanced radio signal";
		
		}
		else
		{
			_x setVariable ["tf_receivingDistanceMultiplicator", _recdist];
			_x setVariable ["tf_sendingDistanceMultiplicator", _sendist];
			//systemChat "Default radio signal";
		};
	} forEach allPlayers;
	
};