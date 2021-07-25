// Points from n0009sm.dat in the archive: http://m-selig.ae.illinois.edu/ads/archives/coord_seligFmt.tar.gz
// Not necessarily in the same order as in: http://m-selig.ae.illinois.edu/ads/coord/n0009sm.dat

n0009sm_points = [[1000,0],[995.72,0.57],[982.96,2.18],[961.94,4.6299],[933.01,7.7],[896.68,11.27],[853.55,15.22],[804.38,19.4499],[750,23.84],[691.34,28.23],[629.41,32.47],[565.26,36.38],[500,39.78],[434.74,42.4799],[370.5899,44.31],[339.28,44.84],[308.66,45.09],[278.86,45.0399],[250,44.66],[222.21,43.97],[195.6199,42.95],[170.33,41.61],[146.45,39.94],[124.08,37.95],[103.32,35.64],[84.27,33.05],[66.9899,30.23],[51.56,27.2],[38.0599,23.95],[26.53,20.3899],[17.04,16.46],[9.61,12.14],[4.28,7.67],[1.07,3.49],[0,0],[1.07,-3.49],[4.28,-7.67],[9.61,-12.14],[17.04,-16.46],[26.53,-20.39],[38.0599,-23.95],[51.56,-27.2],[66.9899,-30.23],[84.27,-33.0501],[103.32,-35.64],[124.08,-37.95],[146.45,-39.9401],[170.33,-41.61],[195.6199,-42.95],[222.21,-43.97],[250,-44.66],[278.86,-45.04],[308.66,-45.09],[339.28,-44.84],[370.5899,-44.31],[434.74,-42.48],[500,-39.78],[565.26,-36.38],[629.41,-32.47],[691.34,-28.23],[750,-23.84],[804.38,-19.45],[853.55,-15.22],[896.68,-11.27],[933.01,-7.7],[961.94,-4.63],[982.96,-2.18],[995.72,-0.57]];

module fin(L=90, Hcenter=40, Htip=20, r=0, inset=0)
// Hcenter and Htip: Length of profiles *before* rounding of edges and inset
// r: external corners are rounded to this radius (avoids unprintable thin trailing edge)
// inset: useful for negative volumes. Create a fin insed by wall-thickness and subtract
//        it from a full fin to get a hollow fin
{
    // shift points so that thickest point is ~ at x=0:
    p = [for(i = [0:len(n0009sm_points)-1]) n0009sm_points[i] + [-300, 0]];
    
    s = (Htip - 2 * inset) / (Hcenter - 2 * inset);
    rotate([0, 90, 0])  // parallel to +x-axis
        scale(0.001)
            linear_extrude(height=L*1000, scale=s)
                offset(delta=-inset*1000)    // decrease by inset (=later wall thickness)
                    offset(r=r*1000) offset(delta=-r*1000)  // rounded ext corners
                        scale(Hcenter)
                            polygon(points=p);
}

module hollowFin(L=90, Hcenter=40, Htip=20, r=0.7, d=0.5)
// Creates a hollowed-out fin with wall-thickness d
{
    s = Htip / Hcenter;
    dL = L / 10;
    s0 = 1 + (1-s) * dL/L;
    s1 = s + (1-s) * d/L;

    difference() {
        fin(L=L, Hcenter=Hcenter, Htip=Htip, r=r, inset=0);
        translate([-dL, 0, 0])  // hollowing
            fin(L=L-d+dL, Hcenter=s0*Hcenter, Htip=s1*Hcenter, r=r, inset=d);
    }
}    

module fins(L=90, Hcenter=40, Htip=20, r=0, nfins=3)
// create a set of regularily rotated fins
{
    dphi = 360 / nfins;
    for (angle=[0:dphi:360]) {
        rotate([0, 0, angle])
            fin(L, Hcenter, Htip, r=r);
    }
}

module hollowFins(L=90, Hcenter=40, Htip=20, r=0.7, d=0.5, nfins=3)
// create a set of regularily rotated hollow fins
// take care: they overlap in the center. It is assumed that you will remove
//            the central region later on.
{
    dphi = 360 / nfins;
    for (angle=[0:dphi:360]) {
        rotate([0, 0, angle])
            hollowFin(L, Hcenter, Htip, r=r, d=d);
    }
}

// DEMO

intersection() {
    color("Green")
        translate([-500, 0, -500])
            cube([1000, 1000, 1000]);
        hollowFins(r=0.7, d=0.7);
};
