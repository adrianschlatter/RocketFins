/*
Gardena Tap Connectors
++++++++++++++++++++++

Units in this file: Millimeter.

*/

use <threadlib/threadlib.scad>

// Generic

module gasket (r0=8, r1=12.5, d=3, $fn=120) {
    /*
    Flat ring gasket
    ++++++++++++++++

    r0: Hole diameter
    r1: Outer diameter
    d: Thickness
    */
    
    color("DarkSlateGray")
        difference() {
            cylinder(h=d, r=r1);
            translate([0, 0, -d])
                cylinder(h=3*d, r=r0);
        }
};

module nozzle(type="G1", section=[[16.8, 0], [19.5, 0], [19.5, -14], [10, -14],
                                   [10, -18], [8, -22], [8, -38], [4.5, -38],
                                   [4.5, -21], [7, -17], [7, -12], [16.8, -12]], $fn=120)
{
    designator = str(type, "-int");
    P = thread_specs(designator)[0];
    turns = (section[0][1] - section[11][1] - P) / P;
    union() {
        translate([0, 0, -section[11][1]])
            rotate_extrude()
                polygon(points=section);
        translate([0, 0, P / 2])
            thread(designator, turns=turns);
    };
};

// Special Cases

module gasket_gardena_G3o4() {
    gasket();
};

module gasket_gardena_G1() {
    gasket(r0=20/2, r1=31.5/2, d=3);
};

module nozzle_gardena_G3o4 () {
    nozzle(type="G3/4", section=[[13.25, 0], [16.5, 0], [16.5, -14], [10, -14],
                                 [10, -18], [8, -21], [8, -37.7], [4.5, -37.7],
                                 [4.5, -20], [7, -17], [7, -12], [13.25, -12]]);
};

module nozzle_gardena_G1 () {
    nozzle();
};


// Demo
intersection() {
    translate([-50, 0, -50])
        color("Green")
            cube(100);
    union() {
        gasket_gardena_G3o4();
        nozzle_gardena_G3o4();
    };
};
