// flue pippe. work in progress.

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/loft.scad>
include <OpenSCAD_support/0.17_flue_polyhedron.scad>
include <OpenSCAD_support/curved_labium_cut.scad>
include <OpenSCAD_support/pipe_version.scad>

// variables
outerDiameter = 40;
innerDiameter = 36;
labiumWidth = 35;
outCut = 10;
lengthFlue = 45;
outerTube = 16;
innerTube = 13;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 1.5;
flueSteps = 19;         // only works for few values of flueSteps, zb 31

number_of_layers = 8 ;   // .. of the flue loft

// proportions, are most likely good like that
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
airSupplyY = outerDiameter*-0.45;    // y position of air supply
height = floorThickness
    + lengthFlue
    + outCut / sqrt(2)
    + outerDiameter / sqrt(2); 
    
// calculations, don't touch in production use
labiumX = sin(labiumWidth * 180 / outerDiameter / PI) * outerDiameter; 
labium_angle = labiumWidth * 360 / outerDiameter / PI;
labium_angle_45 = labiumWidth * 360 / outerDiameter / PI / sqrt(2);
ground = (lengthFlue + floorThickness)*-1;
flueStepWidth = labiumWidth * 180 / (outerDiameter+flueWidth) / PI / flueSteps;
soundingLength = height - pipeInsert - floorThickness;
labium_polygon_points = 
    [[0,0],
    [0, outCut + outerDiameter],
    [-outerDiameter/2, outCut],
    [-outerDiameter, outCut + outerDiameter],
    [-outerDiameter, 0]];

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// flueLength warning
if (lengthFlue < (tubeInsert + sqrt(labiumWidth) + sqrt(outCut)))
    echo("lengthFlue is too short");

// inner flue loft calculations
function alpha(c) = (360 * (0.5*c-0.25) / flueSteps); //starts with 1 on unit circle
function xLowerInnerFlue(i) = cos(alpha(i))*innerTube/2 + airSupplyY;
function yLowerInnerFlue(i) = -sin(alpha(i))*innerTube/2 + airSupplyY;
    
function xUpperInnerFlue1(i) = cos(i)*(outerDiameter-flueWidth)/2;
function yUpperInnerFlue1(i) = sin(i)*(outerDiameter-flueWidth)/2;
function zUpperInnerFlue1(i) = -cos(i)*(outerDiameter+flueWidth)/2;
function xUpperOuterFlue1(i) = cos(i)*(outerDiameter+flueWidth)/2;
function yUpperOuterFlue1(i) = sin(i)*(outerDiameter+flueWidth)/2;
function zUpperOuterFlue1(i) = -cos(i)*(outerDiameter-flueWidth)/2;

flueloft_upper_inner_points = [
    for (i =[(270+labium_angle_45*0.5) : (-labium_angle_45/(flueSteps-1)) : (270-labium_angle_45*0.5)]) 
        concat(
            xUpperOuterFlue1(i) - (outCut-0.1)/sqrt(2), 
            yUpperOuterFlue1(i), 
            zUpperInnerFlue1(i) - (outCut-0.1)/sqrt(2)
        ),
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45/(flueSteps-1)) : (270+labium_angle_45*0.5)]) 
        concat(
            xUpperInnerFlue1(i) - (outCut-0.1)/sqrt(2), 
            yUpperInnerFlue1(i), 
            zUpperOuterFlue1(i) - (outCut-0.1)/sqrt(2)
        )
];
    
flueloft_lower_inner_points=[
    for (i =[1 : (2*flueSteps)]) 
        concat(xLowerInnerFlue(i), yLowerInnerFlue(i), ground+tubeInsert)
];

// outer flue loft calculations
function xLowerOuterFlue(i) = cos(alpha(i))*(outerTube/2+minWallThickness) + airSupplyY;
function yLowerOuterFlue(i) = -sin(alpha(i))*(outerTube/2+minWallThickness) + airSupplyY;
    
function xUpperInnerFlue2(i) = cos(i)*((outerDiameter-flueWidth)/2-minWallThickness);
function yUpperInnerFlue2(i) = sin(i)*((outerDiameter-flueWidth)/2-minWallThickness);
function zUpperInnerFlue2(i) = -cos(i)*((outerDiameter-flueWidth)/2-minWallThickness);
function xUpperOuterFlue2(i) = cos(i)*((outerDiameter+flueWidth)/2+minWallThickness);
function yUpperOuterFlue2(i) = sin(i)*((outerDiameter+flueWidth)/2+minWallThickness);
function zUpperOuterFlue2(i) = -cos(i)*((outerDiameter+flueWidth)/2+minWallThickness);

flueloft_upper_outer_points=[
    for (i =[(270+labium_angle_45*0.5) : (-labium_angle_45/(flueSteps-1)) : (270-labium_angle_45*0.5)]) 
        concat(
            xUpperOuterFlue2(i) - outCut/sqrt(2), 
            yUpperOuterFlue2(i), 
            zUpperOuterFlue2(i) - outCut/sqrt(2)
        ),
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45/(flueSteps-1)) : (270+labium_angle_45*0.5)]) 
        concat(
            xUpperInnerFlue2(i) - outCut/sqrt(2), 
            yUpperInnerFlue2(i), 
            zUpperInnerFlue2(i) - outCut/sqrt(2)
        )
];
   

flueloft_lower_outer_points=[
    for (i =[1 : (2*flueSteps)]) 
        concat(xLowerOuterFlue(i), yLowerOuterFlue(i), ground+tubeInsert)
];
    
// labium line calculation
    
function x_labium_line(i) = cos(i)*outerDiameter/2;
function y_labium_line(i) = sin(i)*outerDiameter/2;
function z_labium_line(i) = -cos(i)*outerDiameter/2;
    
labium_line=[
    for (i =[(270+labium_angle_45*0.5) : (-labium_angle_45/flueSteps) : (270-labium_angle_45*0.5)]) 
        concat(
            x_labium_line(i), 
            y_labium_line(i), 
            z_labium_line(i)
        )
];
   

// logic
difference(){
    union(){
        basicShapeRound(height); 
        outer_elliptic_loft();
    };
    union(){
 //       curved_labium_cut();
        inner_elliptic_loft(); 
        airSupplySpacer(x=airSupplyY);
    };
};


 //       inner_elliptic_loft(); 


//rainbows
module rainbow 
    (points,		    // A vector of points, the only must-have
	many_colors = 31,   // Determins width of gradient
	size_sphere = 1)    // Depends on the size of your model
{
for (i= [0 : len(points)-1 ])
    color([cos(many_colors*i)/2+0.5, 
        -sin(many_colors*i)/2+0.5, 
        -cos(many_colors*i)/2+0.5, 
        1])
    translate(points[i]) sphere(size_sphere);
}

//rainbow(labium_line);
//rainbow(flueloft_upper_outer_points);
//rainbow(flueloft_lower_outer_points);


echo(version = version());

/*
todo:
* 3d labium_polygon_points
* labium cut polyhedron
* beard/filler polyhedron/form
*/