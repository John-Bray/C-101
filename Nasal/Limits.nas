# Nasal script to print errors to the screen when aircraft exceed design limits:
#  - extending flaps above maximum flap extension speed(s)
#  - extending gear above maximum gear extension speed
#  - exceeding Vna
#  - exceeding structural G limits
#  - compressability onset

var checkFlaps = func(n) {

var flapsetting = n.getValue();
	if (flapsetting == 0)
		return;

	var airspeed = getprop("velocities/airspeed-kt");

	if ((flapsetting < 0.50 and airspeed > 190.0) or
		(flapsetting > 0.50 and airspeed > 150.0)) {
			screen.log.write("Flaps extended above maximum flap extension speed!");
		}
	# cause structural damage when safe speed is exceeded by 10%
	if ((flapsetting < 0.50 and airspeed > 209.0) or
		(flapsetting > 0.50 and airspeed > 165.5)) {
			screen.log.write("Flaps damaged!");
			setprop("/sim/failure-manager/controls/flight/flaps/serviceable", 0);
		}
}

var checkGear = func(n) {

	if (!n.getValue())
		return;

	if (getprop("velocities/airspeed-kt") > 190.0) {
		screen.log.write("Gear extended above maximum extension speed!");
	}
}

# ====== Structural failure load limt exceeded =======
# This only prints a message actual failure is handled
# by Systems/crash-detect.xml

var checkG = func (n) {

	if (getprop("/sim/freeze/replay-state"))
		return;

	var overG = n.getValue();

	if (overG > 0){
		if (getprop("/fdm/jsbsim/accelerations/Nz") > 0) {
			msg = "Airframe structural positive load limit exceeded!";
		}
		else {
			msg = "Airframe structural negative load limit exceeded!";
		}
		screen.log.write(msg);
	}
}

var checkCompressability = func (n) {

	if (getprop("/sim/freeze/replay-state"))
		return;

	var compressabilityStength = n.getValue();

	if (compressabilityStength > 0.0) {
		if (compressabilityStength <= 0.3) {
			msg = "Initial on set of compressability.";
		}
		else {
			if (compressabilityStength <= 0.6) {
				msg = "Moderate compressability.";
			}
			else {
				if (compressabilityStength > 0.6 ) {
					msg = "Severe compressability - structural failure possible.";
				}
			}
		}
		screen.log.write(msg);
	}
}

# Set the listeners
setlistener("fdm/jsbsim/systems/compressabilty/strength", checkCompressability);
setlistener("controls/flight/flaps", checkFlaps);
setlistener("controls/gear/gear-down", checkGear);
setlistener("fdm/jsbsim/systems/crash-detect/over-g", checkG);

# ====== VNE exceeded =======

var VnePlusTime = 0;

var checkVNE = func {

	if (getprop("/sim/freeze/replay-state"))
		return;

	if (getprop("instrumentation/airspeed-indicator/indicated-speed-kt") != nil and
		getprop("instrumentation/airspeed-indicator/indicated-speed-kt") > 450) {
		screen.log.write("Airspeed exceeds Vne!");
	}
	else {
		VnePlusTime = 0;
	}
	if (getprop("instrumentation/airspeed-indicator/indicated-speed-kt") != nil and
		getprop("instrumentation/airspeed-indicator/indicated-speed-kt") > 450) {
		# elevator fails after 2 seconds above VNE + 10%
		if (VnePlusTime == 4) {
			screen.log.write("Elevator Failure");
			setprop("/sim/failure-manager/controls/flight/elevator/serviceable", 0);
		}
		# rudder fails after 3 seconds above VNE + 10%
		if (VnePlusTime == 6) {
			screen.log.write("Rudder Failure");
			setprop("/sim/failure-manager/controls/flight/rudder/serviceable", 0);
		}
		# ailerons fails after 4 seconds above VNE + 10%
		if (VnePlusTime == 8) {
			screen.log.write("Aileron Failure");
			setprop("/sim/failure-manager/controls/flight/aileron/serviceable", 0);
		}
		# complete structural failure after 5 seconds above VNE + 10%
		if (VnePlusTime >= 10) {
			screen.log.write("Structural Failure");
			setprop("/fdm/jsbsim/systems/crash-detect/crashed", 1);
		}
		VnePlusTime = VnePlusTime + 1;
	}
	else {
		VnePlusTime = 0
	}
	settimer(checkVNE, 0.5);
}

checkVNE();