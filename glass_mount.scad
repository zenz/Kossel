include <configuration.scad>;

gMountThickness = 30;
gQuality=200;

module base_mount(){
  difference(){
	linear_extrude(height=5, center=true)
	hull()
	{
		translate([0,gMountThickness/2,0])
		polygon(points = [[gMountThickness*.75,0], [-gMountThickness*.75, 0], [0, -1]]);
		polygon(points = [[gMountThickness*.75,10], [-gMountThickness*.75,10], [gMountThickness*.75,26],[-gMountThickness*.75,26], [gMountThickness/2.3,29],[-gMountThickness/2.3,29],[gMountThickness/6,30],[-gMountThickness/6,30]]);
		circle(gMountThickness/2, $fn=gQuality);	
	}
  }
}

module screw_mount(){
	// 活动的螺丝孔
	difference(){
	  linear_extrude(height=8, center=true)
	  hull(){
		translate([0,0,0])
		circle(m3_radius,$fn=gQuality);
		translate([0,4,0])
		circle(m3_radius,$fn=gQuality);
	  }
    }
	// 活动的螺母孔
	translate([0,0,4])
	difference(){
	  linear_extrude(height=8, center=true)
	  hull(){
		translate([0,0,4])
		circle(m3_nut_radius,$fn=gQuality);
		translate([0,4,4])
		circle(m3_nut_radius,$fn=gQuality);
	  }
    }
}

module part_mount(){
	// 挡板
	difference(){
	  intersection(){
		translate([0,85,4]) cube(size=[55,10,11], center=true);
		translate([0,0,4]) cylinder(r=90,h=11,$fn=gQuality,center=true);
	  }
		translate([0,0,4]) cylinder(r=85+0.2,h=11,$fn=gQuality,center=true);
		
	}
    translate([0,70,1]) base_mount();
}

module glass_mount(){
	difference(){
		part_mount();
		translate([0-10,70+19,1.5]) # screw_mount();
		translate([0+10,70+19,1.5]) # screw_mount();
	}
}

glass_mount();