private _side = EAST;
private _type = "B_MBT_01_mlrs_F";

private _vehtype = [];
private _spos = [];
private _tasktype = [];
private _task = "";
private _naming = ["st","nd","rd","th","th","th"];
private _id = 1;
{
  _x3 = _x;
	if (side _x3 == _side && vehicle _x3 isKindOf _type) then
	{	
		{
			if (side _x == WEST) then
			{
				_task = format["TASK_BRAVO_%1", str _x3];
				_task = _x createSimpleTask [format["%1%2 artillery", _id, _naming select _id-1],TASK_BRAVO];
				_task setSimpleTaskDescription [format["Destroy the %1%2 occupied artillery!",_id, _naming select _id-1],format["%1%2 occupied artillery", _id, _naming select _id-1],format["%1%2 Artillery", _id, _naming select _id-1]];
				_task setSimpleTaskDestination (getPos _x3);
				_tasktype set [count _tasktype, _task];
			};
		}forEach allPlayers;
		
		_id = _id+1;
		_vehtype set [count _vehtype, _x];
	};
}forEach vehicles;


{	
    _x2 = _x;
	while {alive _x2 || (count (crew _x2)) > 0} do
	{
		{
			if (alive _x) then
			{
				if (canMove _x && canFire _x && (count (crew _x)) > 0) then
				{	
					private _vehgrp = group _x;
					_vehgrp setCombatMode "BLUE";
					_vehgrp setBehaviour "CARELESS";	
					deleteWaypoint [_vehgrp, 0];
					
					private _dir = direction _x;
					private _xdir = 5*sin(_dir);
					private _ydir = 5*cos(_dir);
					_x lookAt [(getPos _x select 0)+_xdir,(getPos _x select 1)+_ydir,getPos _x select 2];
				}
				else
				{
					_vehgrp = group _x;
					_vehgrp leaveVehicle _x;
					_vehgrp setCombatMode "RED";
					_vehgrp setBehaviour "COMBAT";
				};
			}
			else
			{
				private _finder = _vehtype find _x;
				private _select = _tasktype select _finder;
				_select  setTaskState "SUCCEEDED";
			};
		}forEach _vehtype;

		for [{_i=1}, {_i<13}, {_i=_i+1}] do	
		{	
			if (alive _x) then
			{
				sleep 2;
				{	
					if (canMove _x && canFire _x && (count (crew _x)) > 0) then
					{
						_x setAmmo [currentWeapon _x,_i];
						{
						if (!alive _x) then
							{
							private _finder = _vehtype find _x;
							private _select = _tasktype select _finder;
							_select  setTaskState "SUCCEEDED";
							};
						}forEach _vehtype;
					}
					else
					{
						
					};
				}forEach _vehtype;
			}
			else
			{
				private _finder = _vehtype find _x;
				private _select = _tasktype select _finder;
				_select  setTaskState "SUCCEEDED";
			};
		};	
		
		{
			if (alive _x) then
			{
				if (canMove _x && canFire _x && (count (crew _x)) > 0) then
				{
					_vehgrp = group _x;
					
					private _dist = 0;
		
					while {_dist < 800} do
					{
					_spos = [getPos _x, 800, 1600, 5, 0, 20, 0] call BIS_fnc_findSafePos;
					_dist = [getPos _x select 0, getPos _x select 1] distance2D [_spos select 0, _spos select 1];
					};
					
					_vehgrp addWaypoint [_spos, 10, 0];
					[_vehgrp, 0] setWaypointType "SCRIPTED";
					[_vehgrp, 0] setWaypointScript "A3\functions_f\waypoints\fn_wpArtillery.sqf";
					[_vehgrp, 0] setWaypointCombatMode "RED";
				}
				else
				{
					_vehgrp = group _x;
					_vehgrp leaveVehicle _x;
					_vehgrp setCombatMode "RED";
					_vehgrp setBehaviour "COMBAT";
				};
			}
			else
			{
				private _finder = _vehtype find _x;
				private _select = _tasktype select _finder;
				_select  setTaskState "SUCCEEDED";
			};
		}forEach _vehtype;
		
		_id = 0;
		
		for [{_i=0}, {_i<18}, {_i=_i+1}] do
		{
			if (alive _x) then
			{
				sleep 2;
				{
					if (!alive _x) then
					{
						private _finder = _vehtype find _x;
						private _select = _tasktype select _finder;
						_select  setTaskState "SUCCEEDED";
					};
				}forEach _vehtype;
			}
			else
			{
				private _finder = _vehtype find _x;
				private _select = _tasktype select _finder;
				_select  setTaskState "SUCCEEDED";
			};
		};	
			
	};
}forEach _vehtype;
sleep 2;
{
	_x4 = _x;
		{
			if (side _x == WEST) then
			{
				_x removeSimpleTask _x4;
			};
		}forEach allPlayers;
sleep 0.2;
}forEach _tasktype;
TASK_BRAVO setTaskState "SUCCEEDED";