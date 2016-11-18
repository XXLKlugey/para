_trg = createTrigger ["EmptyDetector", [18734.689,10247.342,0]];
{
	TASK_CHARLIE setSimpleTaskDestination (getPos _trg);
}forEach allPlayers;
_trg setTriggerArea [3000, 250, 0, true];
_trg setTriggerActivation ["WEST", "PRESENT", true];
_trg setTriggerStatements ["this", "", ""];
waitUntil {triggerActivated _trg};

TASK_CHARLIE setTaskState "SUCCEEDED";