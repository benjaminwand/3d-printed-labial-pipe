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
flueWidth = 3;
flueSteps = 20;  // flue seems to behave weird for some values

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


// functions for the flue polyhedron
function alpha(c) = (360 * (0.5*c-0.25) / flueSteps); //starts with 1 on unit circle
function xLowerFlue(i) = cos(alpha(i))*outerTube/2;
function yLowerFlue(i) = sin(alpha(i))*outerTube/2 + airSupplyY;
    
function xUpperInnerFlue(i) = cos(i)*(outerDiameter-flueWidth)/2;
function yUpperInnerFlue(i) = sin(i)*(outerDiameter-flueWidth)/2;
function xUpperOuterFlue(i) = cos(i)*(outerDiameter+flueWidth)/2;
function yUpperOuterFlue(i) = sin(i)*(outerDiameter+flueWidth)/2;
   

upperPoints=[
    for (i =[(270+angle*0.5) : (angle/flueSteps*-1) : (270-angle*0.5)]) 
        concat(xUpperInnerFlue(i), yUpperInnerFlue(i), 0),
    for (i =[(270-angle*0.5) : (angle/flueSteps) : (270+angle*0.5)]) 
        concat(xUpperOuterFlue(i), yUpperOuterFlue(i), 0)
];
//echo(upperPoints=upperPoints);
    


lowerPoints=[
    for (i =[1 : (2*flueSteps)]) 
        concat(xLowerFlue(i), yLowerFlue(i), ground+tubeInsert)
];
//echo(lowerPoints=lowerPoints);    


function alternating_points(i) = [
    upperPoints[i],
    lowerPoints[i]
];
    
fluePolyhedronPoints=[
    for (i=[0 : (4*flueSteps-1)]) 
        if (i%2 == 0)
            upperPoints[i/2]
        else
            lowerPoints[(i-1)/2]
];
echo(fluePolyhedronPoints=fluePolyhedronPoints);

fluePolyhedronFaces = [
    [for (i= [1 : 2 : flueSteps]) i],
    [for (i= [flueSteps : -2 : 1]) i],
    for (i= [1: (flueSteps*4)]) 
        concat(i % (flueSteps*4), (i+1) % (flueSteps*4), (i+2) % (flueSteps*4))
];
echo(fluePolyhedronFaces=fluePolyhedronFaces);

module fluePolyhedron() {polyhedron( 
    points = fluePolyhedronPoints,
    faces = fluePolyhedronFaces);
};

fluePolyhedron();
