// flue pippe. work in progress.

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/straight_labium.scad>
include <OpenSCAD_support/straight_flue.scad>

// variables
outerDiameter = 40;
innerDiameter = 36;
labiumWidth = 30;
outCut = 10;
lengthFlue = 40; // coordinate this with the frequency
outerTube = 11;
innerTube = 8;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.8;

// proportions, are most likely good like that
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
height = floorThickness
    + lengthFlue
    + outCut 
    + outerDiameter *0.5; 
    
// calculations, don't touch in production use
ground = (lengthFlue + floorThickness)*-1;
soundingLength = height - pipeInsert - floorThickness;
airSupplyY = sqrt((outerDiameter+2*minWallThickness)*(outerDiameter+2*minWallThickness) - labiumWidth*labiumWidth)/-2;
labium_polygon_points = 
    [[0,0],
    [0, outCut - 2*airSupplyY],
    [airSupplyY, outCut],
    [2*airSupplyY, outCut - 2*airSupplyY],
    [2*airSupplyY,0]];
labium_plus_points = 
    [[2*airSupplyY, outCut - 2*airSupplyY],
    [airSupplyY + minWallThickness, outCut + 2*minWallThickness],
    [airSupplyY, outCut],];

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// flueLength warning
if (lengthFlue < outerTube * 2)
    echo("lengthFlue is too short");

// logic
difference(){
    union(){
        basicShape(height); 
        straight_flue_fill();
        straight_labium_fill();
        outer_straight_flue();
    };
    union(){
        straight_labium_cut();
        inner_straight_flue(); 
        airSupplySpacer();
    };
};
  

echo(version = version());
