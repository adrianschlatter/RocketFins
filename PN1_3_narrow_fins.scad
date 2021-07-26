use <rocket_fins.scad>


module 3_narrow_fins() {
    rocket_fins(nfins=3, Hcenter=40, Htip=20, shift=24,
                clearance_r=32, clearance_z=-6);
};


3_narrow_fins();
