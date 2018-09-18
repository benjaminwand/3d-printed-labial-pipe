// flue pippe. work in progress.

include <common.scad>

// variables
outerDiameter = 40;
innerDiameter = 36;
labiumWidth = 35;
outCut = 10;
lengthFlue = 40; // coordinate this with the frequency
outerTube = 16;
innerTube = 13;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.8;
flueSteps = 18;  // flue seems to behave weird for some values

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



//Polygon rund

function makeSquareBracket(a, b) = [a, b];
function makeSquareBracket1(a) = [a];
function makeSquareBracket3(a, b, c) = [a, b, c];
function alpha(c) = (360 * (0.5*c-0.25) / flueSteps); //starts with 1 on unit circle
function xLowerFlue(i) = cos(alpha(i))*(outerTube/2+minWallThickness);
function yLowerFlue(i) = sin(alpha(i))*(outerTube/2+minWallThickness) + airSupplyY;
twoFlueSteps=2*flueSteps;
polygon(points=
    [for (i =[1 : twoFlueSteps]) concat(xLowerFlue(i), yLowerFlue(i))]);
    
//Polygon Schlitz
    
function xUpperInnerFlue(i) = cos(i)*(outerDiameter/2-flueWidth/2);
function yUpperInnerFlue(i) = sin(i)*(outerDiameter/2-flueWidth/2);
function xUpperOuterFlue(i) = cos(i)*(outerDiameter/2+flueWidth/2);
function yUpperOuterFlue(i) = sin(i)*(outerDiameter/2+flueWidth/2);
polygon(points=[
    for (i =[(270-angle*0.5) : (angle/flueSteps) : (270+angle*0.5)]) 
        concat(xUpperInnerFlue(i), yUpperInnerFlue(i)),
    for (i =[(270+angle*0.5) : (angle/flueSteps*-1) : (270-angle*0.5)]) 
        concat(xUpperOuterFlue(i), yUpperOuterFlue(i))
]);
/*
upperPoints=(concat(
    for (i =[(270-angle*0.5) : (angle/flueSteps) : (270+angle*0.5)]) 
        concat(xUpperInnerFlue(i), yUpperInnerFlue(i), loftCeiling),
    for (i =[(270+angle*0.5) : (angle/flueSteps*-1) : (270-angle*0.5)]) 
        concat(xUpperOuterFlue(i), yUpperOuterFlue(i), loftCeiling)
));
echo(upperPoints);
    
lowerPoints=concat(
    for (i =[1 : twoFlueSteps]) 
        concat(xLowerFlue(i), yLowerFlue(i), ground+tubeInsert)
);

polyhedron(points=[
    for (i=[1 : (flueSteps*4)])    
        
];

*/

%outerCurvedLoft();

// logic
*difference(){
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