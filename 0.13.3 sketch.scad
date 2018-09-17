// flue pippe. work in progress.

include <common.scad>

// variables
outerDiameter = 40;
innerDiameter = 36;
labiumWidth = 35;
outCut = 10;
lengthFlue = 40; //coordinate this with the frequency
outerTube = 16;
innerTube = 13;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.8;
flueSteps = 8; 

// proportions, are most likely good like that
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
airSupplyY = outerDiameter*-0.45;    // y position of air supply
height = 85; // die 85 ist testweise, muss die Höhe noch entscheiden

// calculations, don't touch in production use
labiumX = sin(labiumWidth * 180 / outerDiameter / PI) * outerDiameter; 
angle = labiumWidth * 360 / outerDiameter / PI;
ground = (lengthFlue + floorThickness)*-1;
flueStepWidth = labiumWidth * 180 / (outerDiameter+flueWidth) / PI / flueSteps;
soundingLength = height - pipeInsert - floorThickness;

// announcing sounding length
echo("the sounding length inside the model in mm:", soundingLength);

// flueLength warning
if (lengthFlue < outerTube * 2)
    echo("lengthFlue is too short");

module curvedFlueLoft2(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        hull(){
        	translate([0, airSupplyY, loftFloor]) cylinder(h=0.1, d=lowerDiameter, center=true);
        	translate([0, airSupplyY, (ground + tubeInsert)])cylinder(h=0.1, d=lowerDiameter, center=true);
        }
        //polyhedron (points, faces, convexity);
    };
};



//Spielplatz

function makeSquareBracket(a, b) = [a, b];
function alpha(c) = (360 * (c-0.5) / flueSteps); //starts with 1 on unit circle
function xLowerFlue(c) = cos(alpha(c))*(outerTube/2+minWallThickness);
function yLowerFlue(c) = sin(alpha(c))*(outerTube/2+minWallThickness) + airSupplyY;

polygon(points=
    [for (i =[1 : flueSteps]) makeSquareBracket(xLowerFlue(i), yLowerFlue(i))]);


// logic
%difference(){
    union(){
        basicShape(height); 
        outerCurvedLoft2();
    };
    union(){
        innerCurvedLoft2(); 
        airSupplySpacer();
    };
};


/* todo:
Labiumcut
figure out polyhedron
assembly
height
*/

echo(version=version());