[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
waitUntil { !isNil {player} };
waitUntil { player == player };
waitUntil {isTouchingGround player};
sleep 2;

if (playersNumber WEST > 1) then
{
	//----------CREATE TASK_ALPHA START
	TASK_ALPHA = player createSimpleTask ["Group up!"];
	TASK_ALPHA setSimpleTaskDescription ["Establish radio contact with the leader and group up at his position.","Group up!","Group up!"];
	TASK_ALPHA setTaskState "CREATED";
	["TaskAssigned",["","Group up and find the team leader!"]] call BIS_fnc_showNotification;
	// switching to init.sqf

	//----------END TASK_ALPHA
	waitUntil {taskState TASK_ALPHA == "SUCCEEDED"};
	["TaskSucceeded",["","Group up and find the team leader!"]] call BIS_fnc_showNotification;
sleep 5;
};

//----------CREATE TASK_BRAVO 
TASK_BRAVO = player createSimpleTask ["Destroy!"];
TASK_BRAVO setSimpleTaskDescription ["Destroy the occupied artilleries.","Destroy!","Destroy!"];
TASK_BRAVO setTaskState "CREATED";
["TaskAssigned",["","Destroy the occupied artilleries!"]] call BIS_fnc_showNotification;
// switching to init.sqf


//----------END TASK_BRAVO
waitUntil {taskState TASK_BRAVO == "SUCCEEDED"};
["TaskSucceeded",["","Destroy the occupied artilleries!"]] call BIS_fnc_showNotification;
sleep 5;

//----------CREATE TASK_CHARLIE
TASK_CHARLIE = player createSimpleTask ["Get out!"];
TASK_CHARLIE setSimpleTaskDescription ["Follow the marker and get out of Altis.","Get out!","Get out!"];
TASK_CHARLIE setTaskState "CREATED";
["TaskAssigned",["","Follow the marker and get out of Altis."]] call BIS_fnc_showNotification;
// switching to init.sqf


//----------END TASK_CHARLIE
waitUntil {taskState TASK_CHARLIE == "SUCCEEDED"};
["TaskSucceeded",["","Follow the marker and get out of Altis."]] call BIS_fnc_showNotification;
sleep 5;