private _random = allPlayers select 0;
private _trg = createTrigger ["EmptyDetector", getPos _random];
_trg attachTo [_random, [0, 0, 1] ]; 
_trg setTriggerArea [10, 10, 0, false];
_trg setTriggerActivation ["WEST", "PRESENT", false];
_trg setTriggerStatements ["{_x in thisList} count (playableUnits + switchableUnits) == (playersNumber west)", "hint 'Autos SooS'", ""];

waitUntil {triggerActivated _trg};

sleep 5;
TASK_ALPHA setTaskState "SUCCEEDED";

/*private _doof = false;
private _randomDude = allPlayers select 0;
private _range = 10;
{
    if !(_x isEqualTo _randomDude) then {
        if (_x distance _randomDude >= _range) then {
            _doof = true;
        };
    };
} forEach allPlayers;*/