include <configuration.scad>;

use <effector.scad>;
use <retractable.scad>;
use <extruder.scad>;
use <frame_extruder.scad>;
use <hotend_fan.scad>;


% translate([0, 0, -3]) cylinder(r=85, h=3);
translate([0, 30, 0]) union() {
  translate([-20, 0, 4]) effector();
  translate([-55, -40, 0]) rotate([0, 0, 90]) retractable();
  translate([0, -45, 20]) rotate([0,180,0]) extruder();
  translate([35, 5, 0]) rotate([0,0,45]) frame_extruder();
  translate([40,-40,0]) rotate([0,0,270]) hotend_fan();

}
