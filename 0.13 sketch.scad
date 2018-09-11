// variables
outerDiameter = 40;
innerDiameter = 36;
labiumWidth = 35;
outCut = 10;
lengthFlue = 40;
outerTube = 14;
innerTube = 11;
minWallThickness = 1.2;
flueWidth = 0.8;

// calculations, don't touch in daily use
labiumY = sin(labiumWidth * 180 / outerDiameter / PI) * outerDiameter;
angle = labiumWidth * 360 / outerDiameter / PI;
floor = (lengthFlue + minWallThickness)*-1;
tubeInsert = outerTube + 5;

// flueLength warning
if (lengthFlue < outerTube * 2)
    echo("lengthFlue is too short");

function mundform(x) = sqrt(outerDiameter*outerDiameter/4 - x*x) * -1;

union() {
    translate([0, (outerDiameter*-0.5), floor]) cylinder (tubeInsert, d=innerTube);
    for (a = [ (labiumY*-0.5) : 0.1 : (labiumY*0.5) ])
        hull () {
        translate([a, mundform(a), 0]) cylinder (0.1, d=flueWidth, $fn = 15);
        translate ([0, (outerDiameter*-0.5), (floor + tubeInsert)]) cylinder (0.1, d=innerTube);
    };
};

/* todo:
mach union modul, mit parametern
build total flue
Grundform
Labiumcut
assembly
*/


echo(version=version());