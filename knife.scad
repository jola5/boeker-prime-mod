/*************************************************
Böker Prime: Complete Knfie

Böker Prime with modified scales
*************************************************/
use <blade.scad>
use <scales.scad>

/////////////////////////////////
echo(version=version());

mirror([0, 0, 1])
    halfKnife();
halfKnife();

module halfKnife() {
    blade();
    scale();
}
