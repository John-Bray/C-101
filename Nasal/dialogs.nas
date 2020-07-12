#############################################################################
##     CASA C-101_Aviojet for the flight simulator FlightGear 
##  Copyright (C) 2013  Pavel Cueto, Fernando Espinosa
##
##This program is free software; you can redistribute it and/or modify 
##it under the terms of the GNU General Public License as published by 
##the Free Software Foundation; either version 3 of the License, or 
##(at your option) any later version. 

##This program is distributed in the hope that it will be useful, 
##but WITHOUT ANY WARRANTY; without even the implied warranty of 
##MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
##GNU General Public License for more details. 
##
##You should have received a copy of the GNU General Public License 
##along with this program; if not, write to the Free Software 
##Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
####################################################################################
# MODEL INFO
print('');
print('MODEL INFO: CASA C-101 Aviojet');
print('');
print('Type: Two-seat military jet trainer');
print('Powerplant: 1 Garrett TFE731 turbofan. Engine thrust: 3550lbs (EB) 3700lbs (BB) 4700lbs (CC)');
print('Built by CASA (Construcciones Aeronauticas S.A.)');
print('');
print('Tipo: Jet militar para entrenamiento de vuelo y combate, 2 asientos');
print('Motor: 1 turbofan Garrett TFE731. Potencia: 3550lbs (EB) 3700lbs (BB) 4700lbs (CC)');
print('Fabricante: CASA (Construcciones Aeronauticas S.A.)');
print('');
print('Authors/Autores: Pavel Cueto y Fernando Espinosa');
print('December/Diciembre 2011');



# LIGHTS DIALOG
var dlg = gui.Dialog.new("/sim/gui/dialogs/lights/dialog","Aircraft/C-101/Dialogs/C-101-lights.xml");



# NOTA I: Cuando haya mas de 1 variable, usar
# var dialog =
# {
# lights: gui.Dialog.new("sim/gui/dialogs/lights/dialog", "Aircraft/C-101/Dialogs/C-101-lights.xml")
# };
# NOTA II
#dlg.open();
#dlg.close();