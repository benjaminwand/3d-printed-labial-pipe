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
flueSteps = 17;  // flue seems to behave weird for some values

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

module curvedFlueLoft2(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        hull(){
        	translate([0, airSupplyY, loftFloor]) 
                cylinder(h=0.1, d=lowerDiameter, center=true);
        	translate([0, airSupplyY, (ground + tubeInsert + 0.1)])
                cylinder(h=0.1, d=lowerDiameter, center=true);
        };
    //    fluePolyhedron();
                  // zusammen gestecktes fluePolyhedron
        polyhedron( 
            points = [
            for (i=[0 : (4*flueSteps-1)]) 
                if (i%2 == 0)
                    [
for (i =[(270+angle*0.5) : (angle/flueSteps*-1) : (270-angle*0.5)]) 
    concat(xUpperInnerFlue(i,upperDiameter), yUpperInnerFlue(i,upperDiameter), loftCeiling),
for (i =[(270-angle*0.5) : (angle/flueSteps) : (270+angle*0.5)]) 
    concat(xUpperOuterFlue(i,upperDiameter), yUpperOuterFlue(i,upperDiameter), loftCeiling)
                    ][i/2]
                else
                    [
for (i =[1 : (2*flueSteps)]) 
    concat(xLowerFlue(i,lowerDiameter), yLowerFlue(i,lowerDiameter), ground+tubeInsert) 
                    ][(i-1)/2]                 // ground+tubeInsert-0.1 für anti-koplanar?
            ],
            faces = [
                [for (i= [1 : 2 : 4*flueSteps]) i],
                [for (i= [4*flueSteps : -2 : 1]) i],
                for (i= [1: 2 : (flueSteps*4)]) 
                    concat(i % (flueSteps*4), (i+1) % (flueSteps*4), (i+2) % (flueSteps*4)),
                for (i= [0: 2 : (flueSteps*4)-1]) 
                    concat((i+2) % (flueSteps*4), (i+1) % (flueSteps*4), i % (flueSteps*4))
            ]
        );
    };
};

// functions for the flue polyhedron
function alpha(c) = (360 * (0.5*c-0.25) / flueSteps); //starts with 1 on unit circle
function xLowerFlue(i,lowerDiameter) = cos(alpha(i))*lowerDiameter/2;
function yLowerFlue(i,lowerDiameter) = sin(alpha(i))*lowerDiameter/2 + airSupplyY;
    
function xUpperInnerFlue(i,upperDiameter) = cos(i)*(outerDiameter-upperDiameter)/2;
function yUpperInnerFlue(i,upperDiameter) = sin(i)*(outerDiameter-upperDiameter)/2;
function xUpperOuterFlue(i,upperDiameter) = cos(i)*(outerDiameter+upperDiameter)/2;
function yUpperOuterFlue(i,upperDiameter) = sin(i)*(outerDiameter+upperDiameter)/2;

upperPoints=[
    for (i =[(270+angle*0.5) : (angle/(flueSteps-1)*-1) : (270-angle*0.5)]) 
        concat(xUpperOuterFlue(i), yUpperOuterFlue(i), 0),
    for (i =[(270-angle*0.5) : (angle/(flueSteps-1)) : (270+angle*0.5)]) 
        concat(xUpperInnerFlue(i), yUpperInnerFlue(i), 0)
];

lowerPoints=[
    for (i =[1 : (2*flueSteps)]) 
        concat(xLowerFlue(i), yLowerFlue(i), ground+tubeInsert)
];

fluePolyhedronPoints=[
    for (i=[0 : (4*flueSteps-1)]) 
        if (i%2 == 0)
            upperPoints[i/2]
        else
            lowerPoints[(i-1)/2]
];
        
fluePolyhedronFaces = [
    [for (i= [1 : 2 : 4*flueSteps]) i],
    [for (i= [4*flueSteps : -2 : 1]) i],
    for (i= [1: 2 : (flueSteps*4)]) 
        concat(i % (flueSteps*4), (i+1) % (flueSteps*4), (i+2) % (flueSteps*4)),
    for (i= [0: 2 : (flueSteps*4)-1]) 
        concat((i+2) % (flueSteps*4), (i+1) % (flueSteps*4), i % (flueSteps*4))
];
//echo(fluePolyhedronFaces=fluePolyhedronFaces);

module fluePolyhedron(upperDiameter, lowerDiameter, loftCeiling) {polyhedron( 
    points = fluePolyhedronPoints,
    faces = fluePolyhedronFaces);
};


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

// test

color("red")outerCurvedLoft2();
color("blue")innerCurvedLoft2();



/* todo:
polyhedron troubleshooting
Labiumcut
assembly
height
*/

echo(version=version());






// OpenSCAD loft demo, with n layers.

// Add the same amount of points for upper and lower face,
// preferably clockwise (looking from above).
// If those things are unclear, try combinations 
// of upper/lower, clockwise/counterclockwise.
// Start over matching points, otherwise the polyhedron will be twisted.
// It is possible defining the points by code.

my_upper_points = upperPoints;   
my_lower_points = lowerPoints;     
        
// More layers make it smoother and harder to calculate.
number_of_layers = 5 ;   

loft_edge_point_numbers = len(my_upper_points);   
echo(loft_edge_point_numbers = loft_edge_point_numbers);

function average(number_point, index_point, number_of_layers, this_layer) = 
    ((my_upper_points[number_point][index_point] * (number_of_layers - this_layer) / number_of_layers)
    + (my_lower_points[number_point][index_point] * this_layer / number_of_layers)
    );
           
points = [
    for (i = [0 : number_of_layers])
        for (j = [0 : loft_edge_point_numbers - 1])
            [average(j, 0, number_of_layers, i),
            average(j, 1, number_of_layers, i),
            average(j, 2, number_of_layers, i)]
];    
//echo(points = points);

faces = [
    [for (i= [0 : loft_edge_point_numbers-1]) i], // Upper plane.
    for (i = [0 : number_of_layers -1])
        for (j = [0 : loft_edge_point_numbers - 1]) // Towards lower points.
            [loft_edge_point_numbers * i + (j+1)%loft_edge_point_numbers, 
            loft_edge_point_numbers * i + j, 
            loft_edge_point_numbers * (i+1) + j],
    for (i = [1 : number_of_layers])
        for (j = [0 : loft_edge_point_numbers - 1]) // Towards upper points.
            [loft_edge_point_numbers * i + j, 
            loft_edge_point_numbers * i + (j+1) % loft_edge_point_numbers, 
            loft_edge_point_numbers * (i-1) + (j+1) % loft_edge_point_numbers],
    [for (i= [(loft_edge_point_numbers) * (number_of_layers+1) -1  : -1 : loft_edge_point_numbers * number_of_layers ]) i], // Lower plane.
];
//echo(faces = faces);
    
module loft(upper_points, lower_points, number_of_layers)   
polyhedron( 
    points = points,
    faces = faces
);

loft(my_upper_points, my_lower_points, number_of_layers);

// Colorful spheres on every point, for debugging purposes.
many_colors = 20;                // Choose as you like, influences the rainbow.
size_debug_sphere = 1;          // Depends on the size of your model.
        
for (i= [0 : (loft_edge_point_numbers) * (number_of_layers+1) -1 ])
    color([cos(many_colors*i)/2+0.5, 
        -sin(many_colors*i)/2+0.5, 
        -cos(many_colors*i)/2+0.5, 
        1])
    translate(points[i]) sphere(size_debug_sphere);

echo(version = version());
