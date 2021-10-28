/******************
Böker Prime: Scales
******************/
include <Round-Anything/polyround.scad>

/////////////////////////////////
echo(version=version());


bladePoints=[
    [-0.5, 0, 10],
    [4, 23/2, 23],
    [-0, 23, 10],
    [7, 82, 0],
    [40, 55, 100],
    [36, 0, 0],
    [36, -10, 10],
    [44, -13, 0],
    [44, -15, 5],
    [29, -15, 15],
    [29, -66, 30],
    [31.5, -112, 3],
    [13, -112, 15],
    [0, -70, 70],
    [0, -23, 10],
    [4, -23/2, 23]
];
bladeThickness=6.8;
bladeChamfer=0.5;

scalePoints=[
    [-1.5, 0, 0],
    [4, 23/2, 4],
    [8, 6, 0],
    [23, -10, 40],
    [46, -11, 4],
    [45, -16, 4],
    [30, -17, 15],
    [35, -66, 800],
    [30, -230, 35],
    [-8, -66, 800],
    [-2, -23, 10],
    [4, -23/2, 23]
];
scaleThickness=28;
scaleRoundness=1;

# blade();
scale();

module scale(showOutline=false) {
    if (showOutline) {
        # translate([0, 0, 0.3])
            polygon(getpoints(scalePoints));
    }

    minkowski() {
        linear_extrude(scaleThickness/2)
            polygon(polyRound(scalePoints, 30));
        sphere(r=10);
    }
}

module bladeOutline() {
    polygon(polyRound(bladePoints, 30));
}

module bladeSolid(thickness=bladeThickness, showOutline=false) {
    if (showOutline) {
        # translate([0, 0, 0.3])
        polygon(getpoints(bladePoints));
    }

    linear_extrude(thickness)
    bladeOutline();
}

module blade(thickness=bladeThickness, chamfer=bladeChamfer) {
    halfSolidThickness=thickness/2-chamfer;

    bladeHalf();
    mirror([0, 0, -halfSolidThickness])
        bladeHalf();

    module bladeHalf() {
        union() {
            linear_extrude(halfSolidThickness)
                bladeOutline();
            translate([0, 0, halfSolidThickness])
                linear_extrude(bladeChamfer)
                    offset(-bladeChamfer)
                        bladeOutline();
        }
    }
}
