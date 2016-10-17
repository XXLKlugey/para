private _marker = createMarker ["test", getpos arty];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [50,50];
_marker setMarkerColor "ColorRed";
_marker setMarkerBrush "FDiagonal";
_marker setMarkerText "Destroy";

/*
[] spawn {
while{not isnull arty} do 
{
	_marker setmarkerpos getpos arty; 
	sleep 0.05;
};
};
*/
