private _random = allPlayers select 0;
private _counter = 0;
private _range = 25;
while {_counter < playersNumber WEST} do 
{
	_counter = 0;
	{
		if (_x distance _random <= _range) then {
			_counter = _counter + 1;
		};
	} forEach allPlayers;
	
	sleep 2;
};


TASK_ALPHA setTaskState "SUCCEEDED";