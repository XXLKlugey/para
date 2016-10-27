//----------ARTYSTATE
private _side = EAST;
private _type = "B_MBT_01_mlrs_F";

private _vehtype = [];
private _pos = [];
private _dist = 0;
{
	if (side _x == _side && vehicle _x isKindOf _type) then
	{	
		_vehtype set [count _vehtype, _x];
	};
}forEach vehicles;

{	
	_pos = [getPos _x, 0, 1500, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	_x setPos _pos;
	private _dir = direction _x;
	private _xdir = 5*sin(_dir);
	private _ydir = 5*cos(_dir);
	_x lookAt [(getPos _x select 0)+_xdir,(getPos _x select 1)+_ydir,getPos _x select 2];
	private _vehgrp = group _x;
	_vehgrp setCombatMode "BLUE";
	_vehgrp setBehaviour "CARELESS";
	_dist = 0;
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