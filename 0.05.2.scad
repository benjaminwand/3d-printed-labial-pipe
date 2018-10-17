// flue pipe

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/straight_labium.scad>
include <OpenSCAD_support/straight_flue.scad>
include <OpenSCAD_support/pipe_version.scad>

// variables
outerDiameter = 40;
innerDiameter = 36;
labiumWidth = 30;
outCut = 8;
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
    + innerDiameter *0.4
    + labiumWidth *0.4; 
    
// calculations, don't touch in production use
labium_angle = labiumWidth * 360 / outerDiameter / PI;
ground = (lengthFlue + floorThickness)*-1;
soundingLength = height - pipeInsert - floorThickness;
airSupplyY = labium_angle > 60 ? 
    1/cos(30) * (outerDiameter*-0.5 - minWallThickness) + labiumWidth * tan(30) * 0.5 : 
    sqrt((outerDiameter+2*minWallThickness)*(outerDiameter+2*minWallThickness) 
    - labiumWidth*labiumWidth)/-2; 
labium_polygon_points = 
    [[0,0],
    [0, outCut - 2*airSupplyY],
    [airSupplyY, outCut],
    [2*airSupplyY, outCut - 2*airSupplyY],
    [2*airSupplyY,0]];
labium_plus_points = 
    [[2*airSupplyY, outCut - 2*airSupplyY],
    [2*airSupplyY + minWallThickness, outCut - 2*airSupplyY + 2*minWallThickness],
    [airSupplyY + minWallThickness, outCut + 2*minWallThickness],
    [airSupplyY, outCut]];

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// flueLength warning
if (lengthFlue < outerTube * 2)
    echo("lengthFlue is too short");

// logic
difference(){
    union(){                    // fusion plus
        basicShapeFlat(height); 
        straight_flue_fill();
        straight_labium_fill();
        outer_straight_flue();
    };
    union(){                    // fusion minus
        straight_labium_cut();
        inner_straight_flue(); 
        airSupplySpacer();
    };
};

// version number
version_number ("0.5.2");

echo(version = version());