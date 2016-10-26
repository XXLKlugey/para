//----------ARTYSTATE
private _side = EAST;
private _type = "B_MBT_01_mlrs_F";

private _vehtype = [];
private _id = 1;
{
	if (side _x == _side && vehicle _x isKindOf _type) then
	{	
		_id = _id+1;
		_vehtype set [count _vehtype, _x];
	};
}forEach vehicles;

{	
	private _vehgrp = group _x;
	private _dir = direction _x;
	private _xdir = 5*sin(_dir);
	private _ydir = 5*cos(_dir);
	_x lookAt [(getPos _x select 0)+_xdir,(getPos _x select 1)+_ydir,getPos _x select 2];
	_vehgrp setCombatMode "BLUE";
	_vehgrp setBehaviour "CARELESS";
	private _pos = getPos _x findEmptyPosition[900,1200];
	_vehgrp addWaypoint [_pos, 0];	
	[_vehgrp, 0] setWaypointType "SCRIPTED";
	[_vehgrp, 0] setWaypointScript "A3\functions_f\waypoints\fn_wpArtillery.sqf";
	[_vehgrp, 0] setWaypointCombatMode "NO CHANGE";
}forEach _vehtype;
{
	if(side _x == WEST) then
	{
		waitUntil {isTouchingGround _x};
	};
}forEach allPlayers;

//----------GET TASK_ALPHA
if (playersNumber WEST > 1) then
{
	sleep 5;
	[]execVM ("task_alpha.sqf");
	waitUntil {taskState TASK_ALPHA == "SUCCEEDED"};
};

//----------GET TASK_BRAVO
sleep 5;
[]execVM ("task_bravo.sqf");
waitUntil {taskState TASK_BRAVO == "SUCCEEDED"};