use <rocket_fins.scad>


module 5_narrow_fins() {
    rocket_fins(nfins=5, Hcenter=40, Htip=20, shift=24,
                clearance_r=32, clearance_z=-6);
};


5_narrow_fins();
