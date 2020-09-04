// flue pipe

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/flue45_11.scad>
include <OpenSCAD_support/labium45_11.scad>
include <OpenSCAD_support/pipe_version.scad>

// variables
outerDiameter = 60;
innerDiameter = 55;
labiumWidth = 47;
outCut = 14;
lengthFlue = 50;
outerTube = 16;
innerTube = 14;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.5;

// proportions, are most likely good like that
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
ccle = labiumWidth*0.6;
soundingLength = height - pipeInsert - floorThickness;
labium_polygon_points = 
    [[airSupplyY - 2*minWallThickness, outCut*0.5],
    [airSupplyY - 2*minWallThickness, outCut*2],
    [airSupplyY, outCut*1.5],
    [airSupplyY + 2*minWallThickness, outCut*2],
    [airSupplyY + 2*minWallThickness, outCut*0.5]];

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// logic
difference(){
    union(){
        basicShape15_12(height); 
        outer_45_flue_11();
    };
    union(){
        inner_45_flue_11(); 
        airSupplySpacer(x=airSupplyX);
        labium_cut();
    };
};


// version number
rotate([0, 0, 10])vertical_version_number ("0.15.12");

echo(version = version());