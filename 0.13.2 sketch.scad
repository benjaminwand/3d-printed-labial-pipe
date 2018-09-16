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

// logic
difference(){
    union(){
        basicShape(height); 
        outerCurvedLoft();
    };
    union(){
        innerCurvedLoft(); 
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