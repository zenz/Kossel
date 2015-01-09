// Kossel Mini mount for RAMPS 1.4 at bottom location
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com> and contributors
// visit: http://www.schlotzz.com


// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;


// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major / 2 + extra_radius;
m3_wide_radius = m3_major / 2 + extra_radius + 0.2;




module ramps_mount()
{

	// define base plate
	base_plate = [102, 54, 3];
	base_plate_delta = [20, 20, 0];
	base_plate_offset = [10, 0, 0];

	// define mounting hole offsets
	base_hole_offsets = [
		[14, 2.5, 0],
		[96.7, 2.5, 0],
		[66.1, 7.6, 0],
		[66.1, 35.5, 0],
		[15.3, 50.7, 0],
		[90.2, 50.7, 0]
	];

	// define mounting plate
	mounting_plate = [3, base_plate[1] + base_plate_delta[1], 44];
	mounting_plate_offset = [base_plate[0] + base_plate_delta[0] - mounting_plate[0], 0, 0];

	// define mounting hole offsets
	mounting_hole_offsets = [
		[0, 0, 7.5],
		[0, base_plate[1], 7.5],
		[0, 0, 36.5],
		[0, base_plate[1], 36.5],
	];

	// define joint enforcement
	joint_enforcement_radius = 30;
	joint_enforcement_thickness = 3;
	joint_enforcement_offsets = [
		[base_plate[0] + base_plate_delta[0], -base_plate_delta[0] / 2, 0],
		[base_plate[0] + base_plate_delta[0], base_plate[1] + base_plate_delta[0] / 2 - joint_enforcement_thickness, 0],
	];

	// define domes
	dome_height = 3;
	dome_base_width = 6;
	dome_top_width = 4.2;

	// stepper cutout
	stepper_cutout_depth = 15;
	stepper_cutout_offset = [
		base_plate[0] + base_plate_delta[0] - joint_enforcement_radius - tan(30) * stepper_cutout_depth,
		base_plate[1] + base_plate_delta[1] / 2 - stepper_cutout_depth,
		0
	];

	difference()
	{
		
		union()
		{
			// base plate
			translate(base_plate_offset - base_plate_delta / 2)
				cube(base_plate + base_plate_delta, center = false);

			// mounting plate
			translate(base_plate_offset - base_plate_delta / 2 + mounting_plate_offset)
				cube(mounting_plate);

			// domes
			for (a = base_hole_offsets)
				translate(a + [0, 0, base_plate[2]])
					cylinder(r1 = dome_base_width / 2, r2 = dome_top_width / 2, h = dome_height, $fn = 16);
			
			// joint enforcement
			for (a = joint_enforcement_offsets)
				translate(a)
					rotate([90, 0, 180])
						intersection()
						{
							cube([joint_enforcement_radius, joint_enforcement_radius, joint_enforcement_thickness]);
							cylinder(r = joint_enforcement_radius, h = joint_enforcement_thickness, $fn = 32);
						}
		}

		// base holes
		for (a = base_hole_offsets)
			translate(a)
				cylinder(r = m3_radius, h = 50, center = true, $fn = 16);

		// mounting holes
		for (a = mounting_hole_offsets)
			translate(a + mounting_plate_offset)
				rotate([0, 90, 0])
					cylinder(r = m3_radius, h = 50, center = true, $fn = 16);

		// cutout for stepper motor
		translate(stepper_cutout_offset - [0, 0, 1])
			rotate([0, 0, 60])
				cube([stepper_cutout_depth * 2, stepper_cutout_depth * 2, base_plate[2] + 2]);
	}
	

}

ramps_mount();
