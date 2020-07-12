# beacons ===========================================================
var beacon_switch = props.globals.getNode("controls/lighting/beacon", 1);
aircraft.light.new("sim/model/C-101/lighting/beacon-top", [0.10, 0.90], beacon_switch);