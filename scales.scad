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
    [32, -18, 20],
    [40, -66, 800],
    [30, -230, 35],
    [-8, -66, 800],
    [-2, -23, 10],
    [4, -23/2, 23]
];
scaleThickness=28;
scaleRoundness=1;

% blade();
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

            // scale causes recursion error right here
            // hence, use resize instead
            resize([0, 0, 85.50], auto=[false, false, true])
                shape(21);
            shapeX(450);
            shapeY(57);
        }
        translate([73, 103, 141])
            rotate([55, 0, -20])
                linear_extrude(height=30)
                    circle(180, $fn=500);
    }
}

module shapeX(size) {
    translate([-5, -60, -(size/2-scaleThickness/2)+0.05])
        rotate([0, 90, 0])
            linear_extrude(height=55)
                circle(d=size, $fn=500);
}

module shapeY(size) {
    translate([22, 15, -13])
        rotate([90, 0, 0])
            linear_extrude(height=150)
                circle(d=size, $fn=500);
}

module shape(size, length=117) {
    outlinePoints=[
        [0, 0, 0],
        [0, length/2, 0],
        [length/2, length/2, 0],
        [length/2, 0, 0],
        [size, 0, 0],
        [size*3/4, 0, 8],
        [size, -length/2, length*3/2],
        [size*2/3, -length, size],
        [0, -length, 0]
    ];

    translate([16, -17.5, 0])
        rotate([-90, 0, 2])
            rotate_extrude($fn=100)
                polygon(polyRound(outlinePoints, 30));
}
