include <configuration.scad>;
use <j-head.scad>;

barrel_radius = 8;
barrel_height = 34;

groove_radius = 6;
groove_height = 4.6;//4.6 for fix

fan_offset = 15;
fan_angel = 15;

module hotend_fan() {
	difference() {
		union(){
    		translate([0, 0, groove_height/2])
	    			cylinder(r=17,h=groove_height, center=true);
			translate([0,0,groove_height])
				cylinder(r=17,h=groove_height, center=true);
			// half round
			//difference(){
			//	translate([0, -18, 0])
			//		cylinder(r=21, h=4);
			//	translate([21, -57.5, 10]) rotate([0,90,90])
			//		cube([12,42,40]);
			//	translate([24.9, -29, -1])
			//		cube([9.8,40,40], center=true);
			//	translate([-24.9, -29, -1])
			//		cube([9.8,40,40], center=true);
			//}
			// fan mount
			difference(){
				rotate([fan_angel,0,90]) {
					difference(){
  						translate([0, - fan_offset, 12])
    						cube([40, 5, 22], center=true);
						translate([0, - fan_offset, 35])
							rotate([90, 0, 0,]) cylinder(r=19, h=20, center=true);
						// fan mount screw
						translate([0, 10- fan_offset, 15])
						for (x = [-16, 16]) {
        						translate([x, -fan_offset, 4]) rotate([90, 0, 0]) #
          						cylinder(r=m3_radius, h=16, center=true, $fn=12);
    						}
					}
				}
				translate([0, 0, -groove_height-0.4])
				cube([100,100,10], center=true);
			}
			difference(){
				rotate([fan_angel,0,-90]) {
					difference(){
  						translate([0, - fan_offset, 12])
    						cube([40, 5, 22], center=true);
						translate([0, - fan_offset, 35])
							rotate([90, 0, 0,]) cylinder(r=19, h=20, center=true);
						// fan mount screw
						translate([0, 10- fan_offset, 15])
						for (x = [-16, 16]) {
        						translate([x, -fan_offset, 4]) rotate([90, 0, 0]) #
          						cylinder(r=m3_radius, h=16, center=true, $fn=12);
    						}
					}
				}
				translate([0, 0, -groove_height-0.4])
				cube([100,100,10], center=true);
			}
		}

		//把圆形卡位的尖角切成圆角
		difference(){
			translate([0,4,groove_height-6])
				rotate([0,0,45]) cube(size=[15,15,10]);
			translate([8.7,11,groove_height/2])
				cylinder(r=3, h=16, center=true, $fn=12);
			translate([-8.7,11,groove_height/2])
				cylinder(r=3, h=16, center=true, $fn=12);
		}

    	// Groove mount insert slot.
    	translate([0, 10, 0])
      		cube([2*groove_radius, 20, 20], center=true);
		translate([0, 10,groove_height+2.5])
			cube([2*barrel_radius+2, 20,5], center=true);
       	// Groove mount.
	    cylinder(r=groove_radius, h=200, center=true, $fn=24);
    	// J-Head barrel.
    	translate([0, 0, groove_height + 0.02])
      	cylinder(r=barrel_radius + 1, h=100, $fn=24);
		// screws holes for mounting
		for (a = [60:60:359]) {
      		rotate([0, 0, a]) translate([0, 12.5, 5]) #
        	cylinder(r=m3_radius, h=12, center=true, $fn=12);
    	}
  	}

	

  	// Hotend barrel.
  	translate([0, 0, groove_height]) %
    	cylinder(r=barrel_radius, h=barrel_height);

	// J-head barrel.
	translate([7.5,4.5,50]) rotate([0,180,90]) scale(3) % jhead(center=true);

  	// 40mm fan.
  	rotate([fan_angel,0,90]) {
  		translate([0, -7 - fan_offset, 35]) % difference() {
    		cube([40, 10, 40], center=true);
    		rotate([90, 0, 0,]) cylinder(r=19, h=20, center=true);
  		}
	}
	rotate([fan_angel,0,-90]) {
  		translate([0, -7 - fan_offset, 35]) % difference() {
    		cube([40, 10, 40], center=true);
    		rotate([90, 0, 0,]) cylinder(r=19, h=20, center=true);
  		}
	}
	
}

hotend_fan();