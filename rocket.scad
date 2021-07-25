/*
Water Rocket Exploded Model
+++++++++++++++++++++++++++++

:author: Adrian Schlatter
*/

use <gardena.scad>
use <bottle.scad>
use <PN1_3_narrow_fins.scad>
use <PN2_3_broad_fins.scad>
use <PN3_5_narrow_fins.scad>


  // rocket with rocket fins variant _3:
union() {
    // bottle:
    translate([0, 0, 50])
        rotate([0, 0, 3])
            color("Silver")
                bottle($fn=120);

    // rocket fins _3:
    color("Gold")
        5_narrow_fins();

    // nozzle:
    translate([0, 0, -2.8 - 20]) {
        rotate([0, 0, -65])
            color("Gray")
                nozzle_gardena_G1();
        gasket_gardena_G1();
    };

};

// rocket fins variant _1:
translate([-200, 0, 0])
    color("Gold")
        3_narrow_fins();

// rocket fins variant _2:
translate([-200, 0, +70])
    color("Gold")
        3_broad_fins();
