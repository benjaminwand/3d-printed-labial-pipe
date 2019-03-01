// flue pipe

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/flue45.scad>
include <OpenSCAD_support/labium45.scad>
include <OpenSCAD_support/pipe_version.scad>

// variables
outerDiameter = 16;
innerDiameter = 13;
labiumWidth = 10;
outCut = 3;
lengthFlue = 20;
outerTube = 11;
innerTube = 8;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.45;

// proportions, are most likely good like that
tubeInsert = outerTube;       // length
pipeInsert = 2*outerTube; // length
height = floorThickness
    + lengthFlue
    + labiumWidth / sqrt(2)
    + 2*tubeInsert; 
    
// calculations, don't touch in production use
ground = (lengthFlue + floorThickness)*-1;
airSupplyX = (ground + tubeInsert) / sqrt(2);
airSupplyY = - outerDiameter/2;
soundingLength = height - pipeInsert - floorThickness;
labium_polygon_points = 
    [[airSupplyY - 4*minWallThickness,0],
    [airSupplyY - 4*minWallThickness, outCut*2],
    [airSupplyY, outCut],
    [airSupplyY + 4*minWallThickness, outCut*2],
    [airSupplyY + 4*minWallThickness,0]];

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
vertical_version_number ("Schlauchpfeife");

echo(version = version());
