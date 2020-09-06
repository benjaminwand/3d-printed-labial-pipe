// flue pipe

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/flue45_11.scad>
include <OpenSCAD_support/labium45_11.scad>
include <OpenSCAD_support/pipe_version.scad>

// variables
outerDiameter = 50;
innerDiameter = 46;
labiumWidth = 39;
outCut = 12;
lengthFlue = 45;
outerTube = 16;
innerTube = 15;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.45;
shapeAngle = 0;     // between 0 and 30
curveHeight = 0.7;  // between 0.5 and 1

// proportions, are most likely good like that3
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
height = floorThickness
    + lengthFlue
    + labiumWidth / sqrt(2)
    + tubeInsert; 
    
// calculations, dson't touch in production use
ground = (lengthFlue + floorThickness)*-1;
airSupplyX = (ground + tubeInsert) / sqrt(2);
airSupplyY = - outerDiameter/4 - innerDiameter/4 - minWallThickness/2; 
soundingLength = height - pipeInsert - floorThickness;
labium_polygon_points = 
    [[airSupplyY - 2*minWallThickness, outCut*0.5],
    [airSupplyY - 2*minWallThickness, outCut*1.5 + 2*minWallThickness],
    [airSupplyY, outCut*1.5],
    [airSupplyY + 2*minWallThickness, outCut*1.5+2*minWallThickness],
    [airSupplyY + 2*minWallThickness, outCut*0.5]];

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// logic
difference(){
    union(){
        basicShape15_13(height); 
        outer_45_flue_11();
    };
    union(){
        inner_45_flue_11(); 
        airSupplySpacer(x=airSupplyX);
        labium_cut();
    };
};

// version number
rotate([0, 0, 10])vertical_version_number ("0.15.13");

echo(version = version());