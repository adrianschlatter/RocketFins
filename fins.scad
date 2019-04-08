// Points from n0009sm.dat in the archive: http://m-selig.ae.illinois.edu/ads/archives/coord_seligFmt.tar.gz
// Not necessarily in the same order as in: http://m-selig.ae.illinois.edu/ads/coord/n0009sm.dat

n0009sm_points = [[1000,0],[995.72,0.57],[982.96,2.18],[961.94,4.6299],[933.01,7.7],[896.68,11.27],[853.55,15.22],[804.38,19.4499],[750,23.84],[691.34,28.23],[629.41,32.47],[565.26,36.38],[500,39.78],[434.74,42.4799],[370.5899,44.31],[339.28,44.84],[308.66,45.09],[278.86,45.0399],[250,44.66],[222.21,43.97],[195.6199,42.95],[170.33,41.61],[146.45,39.94],[124.08,37.95],[103.32,35.64],[84.27,33.05],[66.9899,30.23],[51.56,27.2],[38.0599,23.95],[26.53,20.3899],[17.04,16.46],[9.61,12.14],[4.28,7.67],[1.07,3.49],[0,0],[1.07,-3.49],[4.28,-7.67],[9.61,-12.14],[17.04,-16.46],[26.53,-20.39],[38.0599,-23.95],[51.56,-27.2],[66.9899,-30.23],[84.27,-33.0501],[103.32,-35.64],[124.08,-37.95],[146.45,-39.9401],[170.33,-41.61],[195.6199,-42.95],[222.21,-43.97],[250,-44.66],[278.86,-45.04],[308.66,-45.09],[339.28,-44.84],[370.5899,-44.31],[434.74,-42.48],[500,-39.78],[565.26,-36.38],[629.41,-32.47],[691.34,-28.23],[750,-23.84],[804.38,-19.45],[853.55,-15.22],[896.68,-11.27],[933.01,-7.7],[961.94,-4.63],[982.96,-2.18],[995.72,-0.57]];

module hollowFin (length=90, centerheight=40, outerheight=20, wall=1)
{
    ratio = outerheight / centerheight;
    wall = ratio<1 ? wall : wall / ratio;

    difference() {
        rotate([0, 90, 0])  // fin
            linear_extrude(height=length, scale=outerheight/centerheight)
                        scale(centerheight)
                            translate([-1, 0])
                                scale (0.001)
                                    polygon(points=n0009sm_points);

        rotate([0, 90, 0])  // hollow space inside fin
            linear_extrude(height=length-wall, scale=outerheight/centerheight)
                offset(r=-wall)
                            scale(centerheight)
                                translate([-1, 0])
                                    scale (0.001)
                                        polygon(points=n0009sm_points);
    };
}    

module fins (length=90, centerheight=40, outerheight=20, nfins=3, wall=1)
{
    dphi = 360 / nfins;
    for (angle=[0:dphi:360]) {
        rotate([0, 0, angle])
            hollowFin(length, centerheight, outerheight, wall);
    }
}

intersection() {
    color("Green")
        translate([-100, 0, -100])
            cube([200, 200, 200]);
    fins();
};
