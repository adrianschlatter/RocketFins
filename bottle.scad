/*
A PET-Bottle

:author: Adrian Schlatter
*/

use <pco-1881.scad>


module bottle () {
    profile = [[0, 0],
               [26.19/2, 0],
               [46, 70],
               [46, 254],
               [0, 254]];

    translate([0, 0, 20])
        union() {
            rotate_extrude()
                polygon(points=profile);

            translate([0, 0, 254])
                sphere(r=46);

            translate([0, 0, -20])
                pco1881();
        };
};


bottle();
