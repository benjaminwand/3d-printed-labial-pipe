// flue pippe. work in progress.

include <common.scad>
include <loft.scad>

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
flueSteps = 11;  
number_of_layers = 5 ;   // .. of the flue loft

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
echo(str("the sounding length inside the model in mm: ", soundingLength));

// flueLength warning
if (lengthFlue < outerTube * 2)
    echo("lengthFlue is too short");

// inner flue loft calculations
function alpha(c) = (360 * (0.5*c-0.25) / flueSteps); //starts with 1 on unit circle
function xLowerInnerFlue(i) = cos(alpha(i))*innerTube/2;
function yLowerInnerFlue(i) = -sin(alpha(i))*innerTube/2 + airSupplyY;
    
function xUpperInnerFlue1(i) = cos(i)*(outerDiameter-flueWidth)/2;
function yUpperInnerFlue1(i) = sin(i)*(outerDiameter-flueWidth)/2;
function xUpperOuterFlue1(i) = cos(i)*(outerDiameter+flueWidth)/2;
function yUpperOuterFlue1(i) = sin(i)*(outerDiameter+flueWidth)/2;

flueloft_upper_inner_points=[
    for (i =[(270+angle*0.5) : (angle/(flueSteps-1)*-1) : (270-angle*0.5)]) 
        concat(xUpperOuterFlue1(i), yUpperOuterFlue1(i), 0.1),
    for (i =[(270-angle*0.5) : (angle/(flueSteps-1)) : (270+angle*0.5)]) 
        concat(xUpperInnerFlue1(i), yUpperInnerFlue1(i), 0.1)
];

flueloft_lower_inner_points=[
    for (i =[1 : (2*flueSteps)]) 
        concat(xLowerInnerFlue(i), yLowerInnerFlue(i), ground+tubeInsert)
];

// outer flue loft calculations
function xLowerOuterFlue(i) = cos(alpha(i))*(outerTube/2+minWallThickness);
function yLowerOuterFlue(i) = -sin(alpha(i))*(outerTube/2+minWallThickness) + airSupplyY;
    
function xUpperInnerFlue2(i) = cos(i)*((outerDiameter-flueWidth)/2-minWallThickness);
function yUpperInnerFlue2(i) = sin(i)*((outerDiameter-flueWidth)/2-minWallThickness);
function xUpperOuterFlue2(i) = cos(i)*((outerDiameter+flueWidth)/2+minWallThickness);
function yUpperOuterFlue2(i) = sin(i)*((outerDiameter+flueWidth)/2+minWallThickness);

flueloft_upper_outer_points=[
    for (i =[(270+angle*0.5) : (angle/(flueSteps-1)*-1) : (270-angle*0.5)]) 
        concat(xUpperOuterFlue2(i), yUpperOuterFlue2(i), 0),
    for (i =[(270-angle*0.5) : (angle/(flueSteps-1)) : (270+angle*0.5)]) 
        concat(xUpperInnerFlue2(i), yUpperInnerFlue2(i), 0)
];
//echo(flueloft_upper_outer_points=flueloft_upper_outer_points);

flueloft_lower_outer_points=[
    for (i =[1 : (2*flueSteps)]) 
        concat(xLowerOuterFlue(i), yLowerOuterFlue(i), ground+tubeInsert)
];




// logic
difference(){
    union(){
        basicShape(height); 
        outerCurvedLoft2();
    };
    union(){
        innerCurvedLoft2(); 
        airSupplySpacer();
    };
};

// test
*difference(){
    outerCurvedLoft2();
    innerCurvedLoft2();
};

/*
// Colorful spheres on every point, for debugging purposes.
many_colors = 20;                // Choose as you like, influences the rainbow.
size_debug_sphere = 1;          // Depends on the size of your model.
        
for (i= [0 : 2*flueSteps -1 ])
    color([cos(many_colors*i)/2+0.5, 
        -sin(many_colors*i)/2+0.5, 
        -cos(many_colors*i)/2+0.5, 
        1])
    translate(flueloft_upper_inner_points[i]) sphere(size_debug_sphere);

for (i= [0 : 2*flueSteps -1 ])
    color([cos(many_colors*i)/2+0.5, 
        -sin(many_colors*i)/2+0.5, 
        -cos(many_colors*i)/2+0.5, 
        1])
    translate(flueloft_lower_inner_points[i]) sphere(size_debug_sphere);

echo(version = version());
*/