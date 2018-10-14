// flue pippe. work in progress.

include <OpenSCAD_support/common.scad>
include <OpenSCAD_support/loft.scad>
include <OpenSCAD_support/elliptic_flue_polyhedron.scad>
include <OpenSCAD_support/elliptic_labium.scad>
include <OpenSCAD_support/pipe_version.scad>

// variables
outerDiameter = 40;
innerDiameter = 36;
labiumWidth = 35;
outCut = 10;
lengthFlue = 40;
outerTube = 16;
innerTube = 13;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.8;
flueSteps = 20;         // only works well for few values of flueSteps, zb 20
number_of_layers = 8 ;   // .. of the flue loft

// proportions, are most likely good like that
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
airSupplyY = -outerDiameter/2/sqrt(2);    // y position of air supply
height = floorThickness
    + lengthFlue
    + outCut / sqrt(2)
    + outerDiameter / sqrt(2); 
    
// calculations, don't touch in production use
labiumX = sin(labiumWidth * 180 / outerDiameter / PI) * outerDiameter; 
labium_angle_45 = labiumWidth * 360 / outerDiameter / PI / sqrt(2);
ground = (lengthFlue + floorThickness)*-1;
soundingLength = height - pipeInsert - floorThickness;
labium_polygon_points = 
    [[-outCut/sqrt(2), -outerDiameter/4, -outCut/sqrt(2)],
    [outerDiameter/2-outCut/sqrt(2), -outerDiameter/4, outerDiameter/2-outCut/sqrt(2)],
    [0, -outerDiameter/2, 0],
    [outerDiameter/2-outCut/sqrt(2) , -outerDiameter*3/4, outerDiameter/2-outCut/sqrt(2)],
    [-outCut/sqrt(2) , -outerDiameter*3/4, -outCut/sqrt(2)]];

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
            cos(alpha(i))*innerTube/2 + airSupplyY, 
            -sin(alpha(i))*innerTube/2 + airSupplyY, 
            ground+tubeInsert)
];

// outer flue loft calculations

flueloft_upper_outer_points=[
    for (i =[(270+labium_angle_45*0.55) : (-labium_angle_45*1.1/(flueSteps-1)) : (270-labium_angle_45*0.55)]) 
        concat(
            cos(i)*((outerDiameter+flueWidth)/2+minWallThickness) - outCut/sqrt(2), 
            sin(i)*((outerDiameter+flueWidth)/2+minWallThickness), 
            -cos(i)*((outerDiameter+flueWidth)/2+minWallThickness) - outCut/sqrt(2)
        ),
    for (i =[(270-labium_angle_45*0.55) : (labium_angle_45*1.1/(flueSteps-1)) : (270+labium_angle_45*0.55)]) 
        concat(
            cos(i)*((outerDiameter-flueWidth)/2-minWallThickness) - outCut/sqrt(2), 
            sin(i)*((outerDiameter-flueWidth)/2-minWallThickness), 
            -cos(i)*((outerDiameter-flueWidth)/2-minWallThickness) - outCut/sqrt(2)
        )
];
   
flueloft_lower_outer_points=[
    for (i =[1 : (2*flueSteps)]) 
        concat(
            cos(alpha(i))*(outerTube/2+minWallThickness) + airSupplyY, 
            -sin(alpha(i))*(outerTube/2+minWallThickness) + airSupplyY, 
            ground+tubeInsert)
];
    
// elliptic loft filler
fill_upper_points = [flueloft_upper_outer_points[0],
    flueloft_upper_outer_points[round(flueSteps/2)],
    flueloft_upper_outer_points[flueSteps-1],
    [-outCut/sqrt(2), 0, -outCut/sqrt(2)]];

fill_lower_points = [flueloft_lower_outer_points[0],
    flueloft_lower_outer_points[round(flueSteps/2)],
    flueloft_lower_outer_points[flueSteps-1],
    [-outCut, 0, ground + tubeInsert]];
    
// labum cut points
    
labium_line=[
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45/flueSteps) : (270+labium_angle_45*0.5)]) 
        concat(
            cos(i)*outerDiameter/2, 
            sin(i)*outerDiameter/2, 
            -cos(i)*outerDiameter/2)
];
    
lower_inner_labium_cut=[
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45/flueSteps) : (270+labium_angle_45*0.5)]) 
        concat(
            cos(i)*outerDiameter/4 - outCut / sqrt(2), 
            sin(i)*outerDiameter/4, 
            -cos(i)*outerDiameter/4 - outCut / sqrt(2))
];

lower_outer_labium_cut=[
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45/flueSteps) : (270+labium_angle_45*0.5)]) 
        concat(
            cos(i)*outerDiameter*3/4 - outCut / sqrt(2), 
            sin(i)*outerDiameter*3/4, 
            -cos(i)*outerDiameter*3/4 - outCut / sqrt(2))
];
    
upper_inner_labium_cut=[
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45/flueSteps) : (270+labium_angle_45*0.5)]) 
        concat(
            cos(i)*outerDiameter/4 + outerDiameter/2 - outCut / sqrt(2), 
            sin(i)*outerDiameter/4, 
            -cos(i)*outerDiameter/4 + outerDiameter/2 - outCut / sqrt(2))
];
    
upper_outer_labium_cut=[
    for (i =[(270-labium_angle_45*0.5) : (labium_angle_45/flueSteps) : (270+labium_angle_45*0.5)]) 
        concat(
            cos(i)*outerDiameter*3/4 + outerDiameter/2 - outCut / sqrt(2), 
            sin(i)*outerDiameter*3/4, 
            -cos(i)*outerDiameter*3/4 + outerDiameter/2 - outCut / sqrt(2))
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
               
//echo(labium_cut_points=len(labium_cut_points));
                
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

//echo(labium_cut_faces=labium_cut_faces);





// logic
difference(){
    union(){
        basicShapeRound(height); 
        outer_elliptic_loft();
        elliptic_loft_fill();
    };
    union(){
 //       curved_labium_cut();
        inner_elliptic_loft(); 
        airSupplySpacer(x=airSupplyY);
        elliptic_labium_cut();
    };
};
/*
	difference(){
		polyhedron(
			points=labium_cut_points, 
			faces=labium_cut_faces);
	    difference(){
	        translate([0, 0, outerDiameter-labium_angle_45/ sqrt(2)])
	            cylinder(h=outerDiameter, d=outerDiameter, center=false, $fn=(30+outerDiameter));
	        union(){
			translate([-outerDiameter/sqrt(2), 0, -outerDiameter/sqrt(2)])
				rotate ([0,45,0])                
					cube ([outerDiameter*2, outerDiameter*2, outerDiameter*2], center=true);
	        rotate([0,45,0])
	            resize(newsize=[outerDiameter*sqrt(2),outerDiameter,outerDiameter/sqrt(2)]) 
	                sphere(r=10);
			};
	    };
	};
*/

// version number
vertical_version_number ("0.17 sketch");

/*
//rainbows
module rainbow 
    (points,		    // A vector of points, the only must-have
	many_colors = 30,   // Determins width of gradient
	size_sphere = 1)    // Depends on the size of your model
{
for (i= [0 : len(points)-1 ])
    color([cos(many_colors*i)/2+0.5, 
        -sin(many_colors*i)/2+0.5, 
        -cos(many_colors*i)/2+0.5, 
        1])
    translate(points[i]) sphere(size_sphere);
}

rainbow(labium_cut_points);
*/


echo(version = version());

/*
todo:
* implement labium cut
* beard
*/