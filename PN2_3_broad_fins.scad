use <rocket_fins.scad>


module 3_broad_fins() {
    rocket_fins(nfins=3, Hcenter=60, Htip=30, shift=19,
                clearance_r=50, clearance_z=-20);
};


3_broad_fins();
