private _side = EAST;
private _type = "B_MBT_01_mlrs_F";

private _tasktype = [];
private _id = 1;
private _naming = ["st","nd","rd","th","th","th"];
private _vehtype = [];
private _spos = [];
private _task = "";
{
  _x1 = _x;
	if (side _x1 == _side && vehicle _x1 isKindOf _type) then
	{	
		{
			if (side _x == WEST) then
			{
				_task = format["TASK_BRAVO_%1", str _x1];
				_task = _x createSimpleTask [format["%1%2_ARTY", _id, _naming select _id-1],TASK_BRAVO];
				_task setSimpleTaskDescription [format["Destroy the %1%2 occupied artillery!",_id, _naming select _id-1],format["%1%2 occupied artillery", _id, _naming select _id-1],format["%1%2 Artillery", _id, _naming select _id-1]];
				_task setSimpleTaskDestination (getPos _x1);
				_tasktype set [count _tasktype, _task];
				
				private _debug = format _tasktype;
				private _debug1= str _task;
				systemChat _debug;
				systemChat _debug1;
				
			};
		}forEach allPlayers;
		
		_id = _id+1;
		_vehtype set [count _vehtype, _x];
	};
}forEach vehicles;

{	
    _x2 = _x;
	while {alive _x2} do
	{
		{
			if (!alive _x) then
			{
				private _finder = _vehtype find _x;
				private _select = _tasktype select _finder;
				_select  setTaskState "SUCCEEDED";
				
				private _debug2 = str _finder;
				systemChat _debug2;
				
			};
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
		}forEach _vehtype;

		for [{_i=1}, {_i<13}, {_i=_i+1}] do	
		{	
			sleep 2;
			{	
				if (!alive _x) then
				{
					private _finder = _vehtype find _x;
					private _select = _tasktype select _finder;
					_select  setTaskState "SUCCEEDED";
					
					private _debug2 = str _finder;
					systemChat _debug2;
					
				};
				if (canMove _x && canFire _x && (count (crew _x)) > 0) then
				{
					_x setAmmo [currentWeapon _x,_i];
					{
					if (!alive _x) then
						{
						private _finder = _vehtype find _x;
						private _select = _tasktype select _finder;
						_select  setTaskState "SUCCEEDED";
						
						private _debug2 = str _finder;
						systemChat _debug2;
						
						};
					}forEach _vehtype;
				}
				else
				{
					_vehgrp = group _x;
					_vehgrp leaveVehicle _x;
					_vehgrp setCombatMode "RED";
					_vehgrp setBehaviour "COMBAT";	
				};
			}forEach _vehtype;
		};	
		
		{
			if (!alive _x) then
			{
				private _finder = _vehtype find _x;
				private _select = _tasktype select _finder;
				_select  setTaskState "SUCCEEDED";
				
				private _debug2 = str _finder;
				systemChat _debug2;
				
			};
			if (canMove _x && canFire _x && (count (crew _x)) > 0) then
			{
				_vehgrp = group _x;
					
				private _dist = 0;
		
				while {_dist < 900} do
				{
					_spos = [getPos _x, 900, 3000, 1, 0, 0, 0] call BIS_fnc_findSafePos;
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
		}forEach _vehtype;
		
		for [{_i=0}, {_i<12}, {_i=_i+1}] do
		{
			if (alive _x) then
			{
				sleep 2;
			}
			else
			{
				private _finder = _vehtype find _x;
				private _select = _tasktype select _finder;
				_select  setTaskState "SUCCEEDED";
				
				private _debug2 = str _finder;
				systemChat _debug2;
				
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