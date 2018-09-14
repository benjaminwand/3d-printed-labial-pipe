// variables
outerDiameter = 40;
innerDiameter = 36;
labiumWidth = 35;
outCut = 10;
lengthFlue = 40; //coordinate this with the frequency
outerTube = 14;
innerTube = 11;
minWallThickness = 1.2;
floorThickness = 2;
flueWidth = 0.8;
flueSteps = 10;

// proportions
tubeInsert = outerTube + 2.5; // length
pipeInsert = innerDiameter * 0.1 + 5; // length

// calculations, don't touch in daily use
labiumY = sin(labiumWidth * 180 / outerDiameter / PI) * outerDiameter; 
angle = labiumWidth * 360 / outerDiameter / PI;
ground = (lengthFlue + floorThickness)*-1;
flueStepWidth = labiumWidth * 180 / (outerDiameter+flueWidth) / PI / flueSteps;

// flueLength warning
if (lengthFlue < outerTube * 2)
    echo("lengthFlue is too short");

module cylinder_outer(height,radius,fn){  	//from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}
   
module curvedFlueLoft(upperDiameter, lowerDiameter, loftCeiling, loftFloor) {
    union() {
        translate([0, (outerDiameter*-0.5), loftFloor]) cylinder (h=(tubeInsert+0.1), d=lowerDiameter);
        for (a = [(angle*-0.5) : (angle/flueSteps) : (angle*0.5)])
            hull () {
            rotate ([0, 0, a]) translate ([0, (outerDiameter*-0.5), loftCeiling]) cube ([flueStepWidth, upperDiameter, 0.1], center=true);
            translate ([0, (outerDiameter*-0.5), (loftFloor + tubeInsert)]) cylinder (0.1, d=lowerDiameter);
        };
    };
}

module basicShape(height)
translate ([0, 0, ground]) union(){
    difference(){
	   	union(){
	        intersection (){
	            rotate ([0, 0, 30]) cylinder_outer(height, (outerDiameter*0.5+minWallThickness), 6);
	            translate ([0,0,50]) cube ([outerDiameter*2, (sqrt(3)*(outerDiameter*0.5+minWallThickness)), height], center = true);
	 	        };
	        cylinder_outer(height, (outerDiameter*0.5 + minWallThickness), 60);
	    	};
        union(){
        	translate ([0, 0, floorThickness]) cylinder(height, d=innerDiameter, center=false);
        	translate ([0, 0, (height - pipeInsert)]) cylinder(height, d=outerDiameter, center=false);
        };
    };
};

// actuall flue pipe
difference (){
    union (){
        basicShape(100); // Grundform
        curvedFlueLoft((flueWidth+minWallThickness), (outerTube+2*minWallThickness),0,ground);
        // aussen loft
    };
    union(){
        curvedFlueLoft(flueWidth, innerTube, 0.1, (ground-0.1)); // innen loft
        translate ([0, (outerDiameter*-0.5), (ground-0.1)]) cylinder (tubeInsert, d=outerTube, center=false); // schlauch reinsteck zylinder
    };
};


/* todo:
Labiumcut
assembly
*/

echo(version=version());