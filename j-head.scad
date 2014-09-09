module jhead(){

difference() {

union() {
    // heater block
    cube(size = [5.00,5.00,3.25]);

    // threaded top end
    translate([1.5625,2.50,3.25])
    cylinder (h = 3.50, r = 1.5625, center = false, $fn = 100);
    translate([1.5625,2.50,6.75])
    cylinder (h = 1.50, r = 1.275, center = false, $fn = 100);

    // bottom projection
    translate([1.5625,2.50,-0.50])
    cylinder (h = 0.50,r = 1.5625, center = false, $fn = 100);

    // nozzle profile
    translate([1.5626,2.50,-1.20])
    cylinder (h = 0.70, r1 = 0.25, r2 = 1.5625, center = false, $fn = 100);
  }

// heater resistor hole
translate([3.58,5.01,1.625])
rotate ([90,0,0]) cylinder (h=5.02, r = 1.17, center = false, $fn = 100);

// thermistor hole
translate([-0.01,4.30,1.625])
rotate ([90,0,90]) cylinder (h=1.70, r = 0.45, center = false, $fn = 100);



// melt chamber
translate([1.5625,2.50,-0.29])
cylinder (h = 8.55, r = 0.69, center = false, $fn = 100);

// orifice
translate([1.5625,0.250,-1.20])
cylinder (h = 1.00, r = 0.10, center = false, $fn = 100);

// internal nozzle profile
translate([1.5625,2.50,-1.00])
cylinder (h = 0.70, r1 = 0.10, r2 = 0.69,center = false, $fn = 100);
}

}

jhead();



