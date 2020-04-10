// flue pipe

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/traverse_flue.scad>
include <OpenSCAD_support/traverse_labium.scad>
include <OpenSCAD_support/pipe_version.scad>

// variables
outerDiameter = 25;
innerDiameter = 23;
labiumWidth = 16;
outCut = 6.4;
totalLength = 200;
outerTube = 8;         // air supply tube
innerTube = 6;
minWallThickness = 0.8;
floorThickness =1.5;
flueWidth = 0.3;
connector = 2;          // [0 / 1 / 2]

// proportions, are most likely good like that
lengthFlue = totalLength / 8;
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length

// calculations, don't touch in production use
ground = -(lengthFlue + floorThickness);
airSupplyX = -innerDiameter/2 - outCut;
labium_polygon_points = 
    [[0,-outerDiameter/2],
    [innerDiameter/2, -outerDiameter],
    [-outCut, -outerDiameter],
    [-outCut, 0],
    [innerDiameter/2,0]];
height = - ground
    + labiumWidth/2
    + minWallThickness
    + pipeInsert;
echo (height=height);
soundingLength = height - pipeInsert - floorThickness;

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// announcing tube length
echo(str("tube needed (in mm): ", totalLength - soundingLength));

// connector points if connector ==2
allP = [[airSupplyX, - outerDiameter/2, ground],
    [airSupplyX, - outerDiameter/2, 0],
    [-outCut, - outerDiameter/2, - labiumWidth*0.45],
    [-outCut -minWallThickness, -outCut -minWallThickness, ground]];
middlePoint = [(allP[0][0] + allP[2][0] + allP[2][0] + allP[3][0]) /4,
(allP[0][1] + allP[2][1] + allP[2][1] + allP[3][1]) /4,
(allP[0][2] + allP[2][2] + allP[2][2] + allP[3][2]) /4];

// logic
difference(){
    union(){
        basicShape21(); 
        outer_traverse_flue();
        high_cut_up_connector();
    };
    union(){
        inner_traverse_flue(); 
        airSupplySpacerTraverse(x=airSupplyX);
        labium_cut();
        airdome();
    };
};

// version number
vertical_version_number ("0.21 gedackt");

echo(version = version());