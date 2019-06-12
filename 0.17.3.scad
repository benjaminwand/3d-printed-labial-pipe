  
// flue pipe

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/loft.scad>
include <OpenSCAD_support/elliptic_flue_polyhedron.scad>
include <OpenSCAD_support/elliptic_labium.scad>
include <OpenSCAD_support/pipe_version.scad>

outerDiameterIdx = 1;
innerDiameterIdx = 2;
labiumWidthIdx = 3;
outCutIdx = 4;
lengthFlueIdx = 5;
outerTubeIdx = 6;
innerTubeIdx = 7;
minWallThicknessIdx = 8;
floorThicknessIdx = 9;
flueWidthIdx = 10;
flueStepsIdx = 11;         // only works well for few values
number_of_layersIdx = 12 ;   // .. of the flue loft

pipe =  [ [ outerDiameterIdx, 110],
[ innerDiameterIdx, 103],
[ labiumWidthIdx, 83],
[ outCutIdx, 25],
[ lengthFlueIdx, 100],
[ outerTubeIdx, 25],
[ innerTubeIdx, 23],
[ minWallThicknessIdx, 1.8],
[ floorThicknessIdx, 2],
[ flueWidthIdx, 1],
[ flueStepsIdx, 31],
[ number_of_layersIdx, 15]];

pipes = [ pipe ];

/* Below take out as a function */
outerDiameter = lookup(outerDiameterIdx, pipe);
innerDiameter = lookup(innerDiameterIdx, pipe);
labiumWidth = lookup(labiumWidthIdx, pipe);
outCut = lookup(outCutIdx, pipe);
lengthFlue = lookup(lengthFlueIdx, pipe);
outerTube = lookup(outerTubeIdx, pipe);
innerTube = lookup(innerTubeIdx, pipe);
minWallThickness = lookup(minWallThicknessIdx, pipe);
floorThickness = lookup(floorThicknessIdx, pipe);
flueWidth = lookup(flueWidthIdx, pipe);
flueSteps = lookup(flueStepsIdx, pipe);         // only works well for few values
number_of_layers = lookup(number_of_layersIdx, pipe);  

// proportions, are most likely good like that
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
height = floorThickness
    + lengthFlue
    + labiumWidth / sqrt(2)
    + (outerDiameter - innerDiameter) * 2; 
    
// calculations, don't touch in production use
labium_angle_45 = labiumWidth * 360 / outerDiameter / PI / sqrt(2);
ground = (lengthFlue + floorThickness)*-1;
airSupplyX = (ground + tubeInsert) / sqrt(2);
airSupplyY = sin(270+labium_angle_45*0.4)*(outerDiameter+flueWidth)/4 - outerDiameter/4;
soundingLength = height - pipeInsert - floorThickness;

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// flueLength warning
if ((lengthFlue + floorThickness) < (tubeInsert + labiumWidth/2/sqrt(2) + outCut/sqrt(2)))
    echo("(lengthFlue + floorThickness) is too short");

// inner flue loft calculations
function alpha(c) = (360 * (0.5*c-0.25) / flueSteps); //starts with 1 on unit circle

flueloft_upper_inner_points = [
    for (i =[(270+labium_angle_45*0.5) : (-labium_angle_45/(flueSteps-1)) : (270-labium_angle_45*0.5)]) 
        concat(
            cos(i)*(outerDiameter+flueWidth)/2 - (outCut-0.1)/sqrt(2), 
            sin(i)*(outerDiameter+flueWidth)/2, 
            -cos(i)*(outerDiameter+flueWidth)/2 - (outCut-0.1)/sqrt(2)
        ),
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45/(flueSteps-1)) : (270+labium_angle_45*0.5)]) 
        concat(
            cos(i)*(outerDiameter-flueWidth)/2 - (outCut-0.1)/sqrt(2), 
            sin(i)*(outerDiameter-flueWidth)/2, 
            -cos(i)*(outerDiameter-flueWidth)/2 - (outCut-0.1)/sqrt(2)
        )
];
    
flueloft_lower_inner_points=[
    for (i =[1 : (2*flueSteps)]) 
        concat(
            cos(alpha(i))*innerTube/2 + airSupplyX, 
            -sin(alpha(i))*innerTube/2 + airSupplyY, 
            ground+tubeInsert)
];

// outer flue loft calculations

flueloft_upper_outer_points=[
    for (i =[(270+labium_angle_45*0.55) : (-labium_angle_45*1.1/(flueSteps-1)) : (270-labium_angle_45*0.55)]) 
        concat(
            cos(i)*((outerDiameter+flueWidth)/2+minWallThickness) - (outCut-0.05)/sqrt(2), 
            sin(i)*((outerDiameter+flueWidth)/2+minWallThickness), 
            -cos(i)*((outerDiameter+flueWidth)/2+minWallThickness) - (outCut-0.05)/sqrt(2)
        ),
    for (i =[(270-labium_angle_45*0.55) : (labium_angle_45*1.1/(flueSteps-1)) : (270+labium_angle_45*0.55)]) 
        concat(
            cos(i)*((outerDiameter-flueWidth)/2-minWallThickness) - (outCut-0.05)/sqrt(2), 
            sin(i)*((outerDiameter-flueWidth)/2-minWallThickness), 
            -cos(i)*((outerDiameter-flueWidth)/2-minWallThickness) - (outCut-0.05)/sqrt(2)
        )
];
   
flueloft_lower_outer_points=[
    for (i =[1 : (2*flueSteps)]) 
        concat(
            cos(alpha(i))*(outerTube/2+minWallThickness) + airSupplyX, 
            -sin(alpha(i))*(outerTube/2+minWallThickness) + airSupplyY, 
            ground+tubeInsert)
];
    
//  beard points
upper_beard_points=[
    for (i =[(270+labium_angle_45*0.55) : (-labium_angle_45*1.1/(flueSteps-1)) : (270-labium_angle_45*0.55)]) 
        concat(
            cos(i)*((outerDiameter+flueWidth+minWallThickness)/2), 
            sin(i)*((outerDiameter+flueWidth+minWallThickness)/2), 
            -cos(i)*((outerDiameter+flueWidth+minWallThickness)/2)
        ),
    for (i =[(270-labium_angle_45*0.55) : (labium_angle_45*1.1/(flueSteps-1)) : (270+labium_angle_45*0.55)]) 
        concat(
            cos(i)*outerDiameter/4, 
            sin(i)*outerDiameter/4, 
            -cos(i)*outerDiameter/4
        )
];
    
lower_beard_points=[
    for (i =[(270+labium_angle_45*0.55) : (-labium_angle_45*1.1/(flueSteps-1)) : (270-labium_angle_45*0.55)]) 
        concat(
            cos(i)*((outerDiameter+flueWidth)/2+minWallThickness) - outCut/sqrt(2), 
            sin(i)*((outerDiameter+flueWidth)/2+minWallThickness), 
            -cos(i)*((outerDiameter+flueWidth)/2+minWallThickness) - outCut/sqrt(2)
        ),
    for (i =[(270-labium_angle_45*0.55) : (labium_angle_45*1.1/(flueSteps-1)) : (270+labium_angle_45*0.55)]) 
        concat(
            cos(i)*outerDiameter/4 - outCut/sqrt(2), 
            sin(i)*outerDiameter/4, 
            -cos(i)*outerDiameter/4 - outCut/sqrt(2)
        )
];
    
// elliptic loft filler
fill_upper_points = [flueloft_upper_outer_points[0] + [0.01, 0, 0.01],
    flueloft_upper_outer_points[round(flueSteps/2)] + [0.01, 0, 0.01],
    (flueloft_upper_outer_points[flueSteps-1] + [0.01, 0, 0.01]),
    [-outCut/sqrt(2), 0, -outCut/sqrt(2)] + [0.01, 0, 0.01]];

fill_lower_points = [flueloft_lower_outer_points[0],
    flueloft_lower_outer_points[round(flueSteps/2)],
    flueloft_lower_outer_points[flueSteps-1],
    [-outCut, 0, ground + tubeInsert]];
    
// labum cut points
    
labium_line=[
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45*1.1/flueSteps) : (270+labium_angle_45*0.6)]) 
        concat(
            cos(i)*outerDiameter/2, 
            sin(i)*outerDiameter/2, 
            -cos(i)*outerDiameter/2)
];
    
lower_inner_labium_cut=[
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45*1.1/flueSteps) : (270+labium_angle_45*0.6)]) 
        concat(
            cos(i)*outerDiameter/8 - outCut / sqrt(2), 
            sin(i)*outerDiameter/8, 
            -cos(i)*outerDiameter/8 - outCut / sqrt(2))
];

lower_outer_labium_cut=[
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45*1.1/flueSteps) : (270+labium_angle_45*0.6)]) 
        concat(
            cos(i)*outerDiameter*7/8 - outCut / sqrt(2), 
            sin(i)*outerDiameter*7/8, 
            -cos(i)*outerDiameter*7/8 - outCut / sqrt(2))
];
    
upper_inner_labium_cut=[
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45*1.1/flueSteps) : (270+labium_angle_45*0.6)]) 
        concat(
            cos(i)*outerDiameter/8 + outerDiameter/2 - outCut / sqrt(2), 
            sin(i)*outerDiameter/8, 
            -cos(i)*outerDiameter/8 + outerDiameter/2 - outCut / sqrt(2))
];
    
upper_outer_labium_cut=[
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45*1.1/flueSteps) : (270+labium_angle_45*0.6)]) 
        concat(
            cos(i)*outerDiameter*7/8 + outerDiameter/2 - outCut / sqrt(2), 
            sin(i)*outerDiameter*7/8, 
            -cos(i)*outerDiameter*7/8 + outerDiameter/2 - outCut / sqrt(2))
];

labium_cut_points=[
		for (i = [0 : flueSteps - 1])
            for (j = [0:4])
                if (j%5 == 0) lower_inner_labium_cut[i]
                else if (j%5 == 1) upper_inner_labium_cut[i]
                else if (j%5 == 2) labium_line[i]
                else if (j%5 == 3) upper_outer_labium_cut[i]
                else lower_outer_labium_cut[i]
                
	];
                
labium_cut_faces=[                     // Copying from loft module
        [for (i= [0 : 4]) i], // Upper plane
        for (i = [0 : flueSteps -2])
            for (j = [0 : 4]) // Towards lower points
                [5 * i + (j+1)%5, 
                5 * i + j, 
                5 * (i+1) + j],
        for (i = [1 : (flueSteps-1)])
            for (j = [0 : 4]) // Towards upper points
                [5 * i + j, 
                5 * i + (j+1) % 5, 
                5 * (i-1) + (j+1) % 5],
        [for (i= [5 * (flueSteps) -1  : -1 : 5 * (flueSteps-1) ]) i], // Lower plane    
];

// logic
difference(){
    union(){
        basicShapeRound(height); 
        outer_elliptic_loft();
        elliptic_loft_fill();
        elliptic_beard();
    };
    union(){
        inner_elliptic_loft(); 
        airSupplySpacer(x=airSupplyX);
        elliptic_labium_cut();
    };
};

// version number
vertical_version_number ("0.17.3");

echo(version = version());



/*
todo:
* what is this weird bug where flueSteps can only have certain values?
* what is this bug with "PolySet has nonplanar faces"? beard oder loft_fill schient das Prolem zu sein
* add eliptic loft fill inside for very large pipes
*/