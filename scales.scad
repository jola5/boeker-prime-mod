/******************
Böker Prime: Scales
******************/
include <Round-Anything/polyround.scad>
include <blade.scad>

/////////////////////////////////
echo(version=version());

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

    difference() {
        intersection() {
            linear_extrude(scaleThickness/2)
                polygon(polyRound(scalePoints, 30));

            shapeY(50);
            shapeX(500);
        }
        translate([52, 68, -33])
            rotate([41, 0, -20])
                linear_extrude(height=150)
                    circle(38, $fn=500);
        // bottom outline
        translate([16, -18, 0])
            rotate([-90, 0, 2])
                outline(30);
        // top outline
        translate([0, -18, 0])
            rotate([-90, 180, 2])
                outline(30);
    }
}

module shapeX(size) {
    translate([-5, -60, -(size/2-scaleThickness/2)+0.05])
        rotate([0, 90, 0])
            linear_extrude(height=55)
                circle(d=size, $fn=500);
}

module shapeY(size) {
    # union() {
        translate([13, -22, -size/2+scaleThickness/2-0.91])
            rotate([82, 20, 0])
                linear_extrude(height=150, scale=0.4)
                    circle(d=size, $fn=500);
        translate([-50, -22, -50])
            cube([100, 100, 100]);
    }
}

module outline(size, length=150) {
    outlinePoints=[
        [0, 0, 12],
        [20, 0, 0],
        [20, -length, 0],
        [0, -length, 0]
    ];

    intersection() {
        rotate_extrude($fn=100)
            translate([size/2, 0, 0])
                polygon(polyRound(outlinePoints, 30));
        translate([0, -size/2, -length])
            cube([size, size, length]);
    }
}