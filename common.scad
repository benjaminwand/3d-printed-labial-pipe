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


module cylinder_outer(height,radius,fn){  	//from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}
   
module curvedFlueLoft(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        hull(){
        	translate([0, airSupplyY, loftFloor]) cylinder(h=0.1, d=lowerDiameter, center=true);
        	translate([0, airSupplyY, (ground + tubeInsert)])cylinder(h=0.1, d=lowerDiameter, center=true);
        }
       	for (a = [(angle*-0.5) : (angle/flueSteps) : (angle*0.5)])
            hull(){
            rotate ([0, 0, a]) translate ([0, (outerDiameter*-0.5), loftCeiling]) cube ([flueStepWidth, upperDiameter, 0.1], center=true);
            translate ([0, airSupplyY, (loftFloor + tubeInsert)]) cylinder (0.1, d=lowerDiameter);
        };
    };
}

module outerCurvedLoft(){
    curvedFlueLoft(    
        upperDiameter = (flueWidth + minWallThickness), 
        lowerDiameter = (outerTube + 2 * minWallThickness),
        loftCeiling = 0,
        loftFloor = ground
    );
}

module innerCurvedLoft(){
    curvedFlueLoft(
        upperDiameter = flueWidth, 
        lowerDiameter = innerTube, 
        loftCeiling = 0.1, 
        loftFloor = (ground-0.1)
    ); 
}
    
module outerCurvedLoft2(){
    curvedFlueLoft2(    
        upperDiameter = (flueWidth + minWallThickness), 
        lowerDiameter = (outerTube + 2 * minWallThickness),
        loftCeiling = 0,
        loftFloor = ground
    );
}

module innerCurvedLoft2(){
    curvedFlueLoft2(
        upperDiameter = flueWidth, 
        lowerDiameter = innerTube, 
        loftCeiling = 0.1, 
        loftFloor = (ground-0.1)
    ); 
}

module airSupplySpacer(){
    translate ([0, airSupplyY, (ground-0.1)]) 
    cylinder (tubeInsert, d=outerTube, center=false);
}
