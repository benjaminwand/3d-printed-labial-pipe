// variables
outerDiameter = 40;
innerDiameter = 36;
labiumWidth = 35;
outCut = 10;
lengthFlue = 40;
outerTube = 14;
innerTube = 11;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.8;

// calculations, don't touch in daily use
labiumY = sin(labiumWidth * 180 / outerDiameter / PI) * outerDiameter;
angle = labiumWidth * 360 / outerDiameter / PI;
floor = (lengthFlue + floorThickness)*-1;
tubeInsert = outerTube + 5;

// flueLength warning
if (lengthFlue < outerTube * 2)
    echo("lengthFlue is too short");

module cylinder_outer(height,radius,fn){  	//from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}
   
module flueLoft(upperDiameter, lowerDiameter, loftCeiling, loftFloor) {
    union() {
        translate([0, (outerDiameter*-0.5), loftFloor]) cylinder (tubeInsert, d=lowerDiameter);
        for (a = [(angle*-0.5) : 1.2 : (angle*0.5)])
            hull () {
            rotate ([0, 0, a]) translate ([0, (outerDiameter*-0.5), loftCeiling]) cylinder (0.1, d=upperDiameter, $fn = 15);
            translate ([0, (outerDiameter*-0.5), (loftFloor + tubeInsert)]) cylinder (0.1, d=lowerDiameter);
        };
    };
}

module basicShape(height)
translate ([0, 0, floor]) union(){
    intersection (){
        rotate ([0, 0, 30]) cylinder_outer(height, (outerDiameter*0.5+minWallThickness), 6);
        translate ([0,0,50]) cube ([outerDiameter*2, (sqrt(3)*(outerDiameter*0.5+minWallThickness)), height], center = true);
        };
    cylinder_outer(height, (outerDiameter*0.5+minWallThickness), 60);
};


// flue
difference (){
flueLoft((flueWidth+minWallThickness), (outerTube+minWallThickness),0,floor);
flueLoft(flueWidth, innerTube, 0.1, (floor-0.1));
};

// Grundform
basicShape(100);

/* todo:
Grundform, hab schon cylinder_outer
Labiumcut
assembly
*/

echo(version=version());