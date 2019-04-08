/*
WaterRocketAdapter Type 1
++++++++++++++++++++++++++

Connects a PCO-1881-thread bottle to a Gardena G1 nozzle. The PET bottle seals 
directly on the gasket of the Gardena nozzle. Key design aspects:

- only 1 seal
- seal is entirely commercial (no 3D-printing involved): PET-bottle on Gardena
- minimum height (using Gardena you cannot get any shorter)

:author: Adrian Schlatter
:date: 2019-04-08

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
        rotate_extrude()
            polygon(points=section);
        P_G1 = thread_specs("G1-ext")[0];
        rotate([0, 0, -118])
            translate([0, 0, dH + P_G1 / 2])
                thread("G1-ext", turns=2.4);
        P_pco = thread_specs("PCO-1881-int")[0];
        rotate([0, 0, +94])
            translate([0, 0, dH])
                thread("PCO-1881-int", turns=2.4);
        difference() {
            translate([0, 0, 0])
                    fins();
            rotate_extrude()
                polygon(points=clearance);
        };
    };
};


intersection() {
    translate([-100, 0, -100])
        color("Green")
            cube([200, 200, 200]);
    union() {
        color("White")
            pco1881($fn=120);
        translate([0, 0, -2.8]) {
            rotate([0, 0, -90])
                color("Gray")
                    nozzle_gardena_G1();
            gasket_gardena_G1();
        };
        color("FireBrick")
            WaterRocketAdapter1();
    };
};