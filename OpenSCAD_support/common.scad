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
	        cylinder(height, d=(outerDiameter + 2* minWallThickness)); 
	   	};
        union(){
        	translate ([0, 0, floorThickness]) 
                cylinder(height, d=innerDiameter, center=false);
        	translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false);
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
            cylinder(height, d=(outerDiameter + 2* minWallThickness)); 
        };
        union(){
            translate ([0, 0, floorThickness]) 
                cylinder(height, d=innerDiameter, center=false);
            translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false);
            translate([outerDiameter*-1, airSupplyY - outerDiameter - minWallThickness, -0.1])
                cube([outerDiameter*2, outerDiameter, floorThickness + lengthFlue + 0.2]);
        };
    };
};

module cylinder_outer(height,radius,fn){  	//from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}
   
module airSupplySpacer(){
    translate ([0, airSupplyY, (ground-0.1)]) 
    cylinder (tubeInsert, d=outerTube, center=false);
}