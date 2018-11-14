module basicShape(height)
translate ([0, 0, ground]) union(){
    difference(){
	   	union(){
	        intersection(){
	            rotate ([0, 0, 30]) 
                    cylinder_outer(height, (outerDiameter*0.5+minWallThickness), 6);
	            translate ([0,0,(height/2)]) 
                    cube ([outerDiameter*2, (sqrt(3)*(outerDiameter*0.5+minWallThickness)), height], center = true);
	 	    };
	        cylinder(height, d=(outerDiameter + 2* minWallThickness), $fn=(30+outerDiameter)); 
	   	};
        union(){
        	translate ([0, 0, floorThickness]) 
                cylinder(height, d=innerDiameter, center=false, $fn=(10+outerDiameter));
        	translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false, $fn=(10+outerDiameter));
        };
    };
};

module basicShapeFlat(height)
translate ([0, 0, ground]) union(){
    difference(){
        union(){
            intersection(){
                rotate ([0, 0, 30]) 
                    cylinder_outer(height, (outerDiameter*0.5+minWallThickness), 6);
                translate ([0,0,(height/2)]) 
                    cube ([outerDiameter*2, (sqrt(3)*(outerDiameter*0.5+minWallThickness)), height], center = true);
            };
            cylinder(height, d=(outerDiameter + 2* minWallThickness), $fn=(30+outerDiameter)); 
        };
        union(){
            translate ([0, 0, floorThickness]) 
                cylinder(height, d=innerDiameter, center=false, $fn=(10+outerDiameter));
            translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false, $fn=(10+outerDiameter));
            translate([outerDiameter*-1, airSupplyY - outerDiameter - minWallThickness, -0.1])
                cube([outerDiameter*2, outerDiameter, floorThickness + lengthFlue + 0.2]);
        };
    };
};

module basicShapeRound(height)
translate ([0, 0, ground]) union(){
    difference(){   
	    cylinder(height, d=(outerDiameter + 2* minWallThickness), $fn=(30+outerDiameter)); 
        union(){
        	translate ([0, 0, floorThickness]) 
                cylinder(height, d=innerDiameter, center=false, $fn=(10+outerDiameter));
        	translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false, $fn=(10+outerDiameter));
        };
    };
};

module basicShape15(height)
translate ([0, 0, ground]) union(){
    difference(){   
	    union(){
            cylinder(height, d=(outerDiameter + 2* minWallThickness), $fn=(30+outerDiameter)); 
            translate ([0, 0, -ground]) rotate([90, 0, 0])
                cylinder(outerDiameter/2 + minWallThickness, outerDiameter/2, labiumWidth/sqrt(2));
        };
        union(){
        	translate ([0, 0, floorThickness]) 
                cylinder(height, d=innerDiameter, center=false, $fn=(10+outerDiameter));
        	translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false, $fn=(10+outerDiameter));
            translate ([0, 0, -ground]) rotate([90, 0, 0])
                cylinder(innerDiameter/2, innerDiameter/2, labiumWidth/sqrt(2) - minWallThickness);
        };
    };
};

module cylinder_outer(height,radius,fn){  	//from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}
   
module airSupplySpacer(x=0){
    translate ([x, airSupplyY, (ground-0.1)]) 
    cylinder (tubeInsert, d=outerTube, center=false, $fn=(20+outerTube));
}