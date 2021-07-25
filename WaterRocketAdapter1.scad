/*
WaterRocketAdapter Type 1
++++++++++++++++++++++++++

Connects a PCO-1881-thread bottle to a Gardena G1 nozzle. The PET bottle seals 
directly on the gasket of the Gardena nozzle. Key design aspects:

- only 1 seal
- seal is entirely commercial (no 3D-printing involved): PET-bottle on Gardena
- minimum height (using Gardena you cannot get any shorter)

:author: Adrian Schlatter
:date: 2019-04-18

*/

use <threadlib/threadlib.scad>
use <gardena.scad>
use <pco-1881.scad>
use <fins.scad>

module WaterRocketAdapter1($fn=120)
{
    tol = 0.2;
    pco1881_Rmajor = thread_specs("PCO-1881-int")[2] / 2;
    G1_Rminor = thread_specs("G1-ext")[2] / 2;
    G1_Rmajor = 33.249 / 2;
    G1_P = thread_specs("G1-int")[0];
    Rgrip = 19.5;
    Hgrip = 14;
    Rbrim = (33+0.15) / 2;
    dH = 0.5;
    
    section = [[G1_Rminor, dH], [G1_Rminor, 9.5 - G1_P / 2],
               [G1_Rmajor - tol, 9.5], [Rgrip, 9.5], [Rgrip, 9.5 + Hgrip],
               [26, 9.5 + Hgrip + 12], [23, 9.5 + Hgrip + 11],
               [Rbrim + tol, 9.5 + Hgrip], [Rbrim + tol, 15.5],
               [pco1881_Rmajor, 9.0], [pco1881_Rmajor, dH]];
    clearance = [[0, section[6][1] + 10], section[6] + [8, 10],
                 section[7] + [0.5, 0], section[3], [32, -6], [0, -6]];
    union() {
        rotate_extrude()                                    // entire body of adapter
            offset(r=-1)
                offset(delta=+1)
                    offset(r=0.2)
                        offset(delta=-0.2)
                            polygon(points=section);

        // Note on thread alignement:
        // 1. Bottle neck rotation is taken as-is
        // 2. PCO-1881 internal thread is rotated so that load-sides touch
        // 3. G1 external thread is rotated to avoid weak (thin) places in the adapter
        // 4. Gardena nozzle is rotated so that load-sides of threads touch
        
        P_G1 = thread_specs("G1-ext")[0];
        rotate([0, 0, 85])                                  // G1 threads
            translate([0, 0, dH + P_G1 / 2])
                thread("G1-ext", turns=2.4);
        P_pco = thread_specs("PCO-1881-int")[0];
        rotate([0, 0, 310])                                 // PCO-1881 threads
            translate([0, 0, dH + 3 * P_pco / 4])
                thread("PCO-1881-int", turns=1.95);
        difference() {                                      // fins
            translate([0, 0, 24])
                    fins(r=0.5, nfins=5);
            rotate_extrude()
                polygon(points=clearance);
        };
    };
};


intersection() {
    translate([-100, 0, -100])
        color("Green")
            cube([200, 200, 200]);
    rotate([0, 0, 0])
    union() {
        rotate([0, 0, 3])
        color("White")                                      // botte neck
            pco1881($fn=120);
        translate([0, 0, -2.8]) {                           // gardena nozzle
            rotate([0, 0, -65])
                color("Gray")
                    nozzle_gardena_G1();
            gasket_gardena_G1();                            // gasket
        };
        color("FireBrick")                                  // Adapter
            !WaterRocketAdapter1();
    };
};