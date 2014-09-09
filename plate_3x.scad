include <configuration.scad>;

use <frame_motor.scad>;
use <frame_top.scad>;
use <carriage.scad>;
use <endstop.scad>;
use <glass_mount.scad>;

% translate([0, 0, -3]) cylinder(r=85, h=3);
union() {
  translate([-15, -55, 22.5]) frame_motor();
  translate([15, 55, 7.5]) rotate([0, 0, 180]) frame_top();
  translate([-40, 30, 0]) rotate([0, 0, -30]) carriage();
  translate([0, 0, 7.5]) endstop();
  translate([-15, -30, 7.5]) endstop();
  translate([-33, 2, 1.4]) rotate([0, 0, 240]) glass_mount();
}
