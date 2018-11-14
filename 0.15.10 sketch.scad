// flue pipe

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/flue45.scad>
include <OpenSCAD_support/labium45.scad>
include <OpenSCAD_support/pipe_version.scad>

// variables
outerDiameter = 25;
innerDiameter = 23;
labiumWidth = 16;
outCut = 4;
lengthFlue = 24;
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
    + labiumWidth / sqrt(2)
    + tubeInsert; 
    
// calculations, don't touch in production use
ground = (lengthFlue + floorThickness)*-1;
airSupplyX = (ground + tubeInsert) / sqrt(2);
airSupplyY = - outerDiameter/2;
soundingLength = height - pipeInsert - floorThickness;
labium_polygon_points = 
    [[airSupplyY - 2*minWallThickness,0],
    [airSupplyY - 2*minWallThickness, outCut*2],
    [airSupplyY, outCut],
    [airSupplyY + 2*minWallThickness, outCut*2],
    [airSupplyY + 2*minWallThickness,0]];

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// logic
difference(){
    union(){
        basicShape15(height); 
        outer_45_flue();
    };
    union(){
        inner_45_flue(); 
        airSupplySpacer(x=airSupplyX);
        labium_cut();
    };
};

// version number
vertical_version_number ("0.15.10");

echo(version = version());
