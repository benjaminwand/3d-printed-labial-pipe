// flue pipe

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/straight_labium.scad>
include <OpenSCAD_support/straight_flue.scad>
include <OpenSCAD_support/pipe_version.scad>

// variables
outerDiameter = 32;
innerDiameter = 28;
labiumWidth = 23.4158;
outCut = 7.0248;
totalLength = 279.6128;
outerTube = 12;
innerTube = 8;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.6;
corpus_angle = 45;

// proportions, are most likely good like that
lengthFlue = totalLength / 8;
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
height = floorThickness
    + lengthFlue
    + labiumWidth /2
    + tubeInsert; 
    
// calculations, don't touch in production use
ground = (lengthFlue + floorThickness)*-1;
airSupplyY = - outerDiameter/4 - innerDiameter/4 - minWallThickness/2;
soundingLength = height - pipeInsert - floorThickness;
labium_polygon_points = 
    [[airSupplyY - 2*minWallThickness, -outCut],
    [airSupplyY - 2*minWallThickness, outCut],
    [airSupplyY, 0],
    [airSupplyY + 2*minWallThickness, outCut],
    [airSupplyY + 2*minWallThickness, -outCut]];

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// announcing tube length
echo(str("tube needed (in mm): ", totalLength - soundingLength));

// logic
rotate([0, 45, 0])
difference(){
    union(){
        basicShape20(height, corpus_angle); 
        outer_straight_flue_20();
        vertical_version_number_20 ("0.20", corpus_angle);
    };
    union(){
        inner_straight_flue_20(); 
        airSupplySpacer();
        straight_labium_cut_20();
    };
};

echo(version = version());