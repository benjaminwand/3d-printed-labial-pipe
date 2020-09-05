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

module basicShape15_11(height)
translate ([0, 0, ground]) union(){
    difference(){   
	    hull(){
            cylinder(height, d=(outerDiameter + 2* minWallThickness), $fn=(30+outerDiameter)); 
            translate([0, airSupplyY +minWallThickness, -ground])rotate([90, 0, 0])
                rotate_extrude($fn = 2*outerDiameter) translate([ccle, 0, 0]) 
                    circle(r = 2*minWallThickness );
        };
        union(){
        	translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false, $fn=(10+outerDiameter));
            hull(){
        	translate ([0, 0, floorThickness]) 
                cylinder(height - pipeInsert, d=innerDiameter, center=false, $fn=(10+outerDiameter));
            translate([0, airSupplyY +minWallThickness, -ground])rotate([90, 0, 0])
                rotate_extrude($fn = 2*outerDiameter) translate([ccle, 0, 0]) 
                    circle(r = 0.01 );
            };
        };
    };
};

module basicShape15_12(height)
translate ([0, 0, ground]) union(){
    difference(){   
	    hull(){
            cylinder(height, d=(outerDiameter + 2* minWallThickness), $fn=(30+outerDiameter)); 
            translate([0, airSupplyY +minWallThickness, -ground])rotate([0, 45, 0])rotate([90, 0, 0])
                rotate_extrude($fn = 2*outerDiameter, angle = 180) translate([ccle, 0, 0]) 
                    circle(r = 2*minWallThickness );
            translate([-(labiumWidth/2+outCut/2)/sqrt(2), airSupplyY + minWallThickness, (labiumWidth/2-outCut/2)/sqrt(2)-ground]) rotate([90, 0, 0])
                rotate_extrude($fn = 2*outerDiameter) translate([labiumWidth*0.1, 0, 0]) 
                    circle(r = 2*minWallThickness);
        };
        union(){
        	translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false, $fn=(10+outerDiameter));
            hull(){
        	translate ([0, 0, floorThickness]) 
                cylinder(height - pipeInsert, d=innerDiameter, center=false, $fn=(10+outerDiameter));
            translate([0, airSupplyY +minWallThickness, -ground])rotate([0, 45, 0])rotate([90, 0, 0])
                rotate_extrude($fn = 2*outerDiameter, angle = 180) translate([ccle, 0, 0]) 
                    circle(r = 0.01 );
            translate([-(labiumWidth/2+outCut/2)/sqrt(2), airSupplyY + minWallThickness, (labiumWidth/2-outCut/2)/sqrt(2)-ground]) rotate([90, 0, 0])
                rotate_extrude($fn = 2*outerDiameter) translate([labiumWidth*0.1, 0, 0]) 
                    circle(r = 0.01);
            };
        };
    };
};

module basicShape15_13(height)
translate ([0, 0, ground]) union(){
    difference(){   
	    hull(){
            cylinder(height, d=(outerDiameter + 2* minWallThickness), $fn=(30+outerDiameter)); 
            translate([0, airSupplyY+2*minWallThickness,-ground])rotate ([0, 45, 0])
                cube([labiumWidth + 2*minWallThickness, 6*minWallThickness, outCut+2*minWallThickness], true);
            translate([outCut/2/sqrt(2), airSupplyY +2*minWallThickness, outCut/2/sqrt(2) -ground])
                rotate([0, 45, 0])rotate([90-shapeAngle, 0, 0]) 
                    scale([1, curveHeight, 1]) 
            rotate_extrude($fn = 2*outerDiameter, angle = 180) 
                translate([labiumWidth/2, 0, 0]) 
                        circle(r = 3*minWallThickness);
            
        };
        union(){
        	translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false, $fn=(10+outerDiameter));
            hull(){
        	translate ([0, 0, floorThickness]) 
                cylinder(height - pipeInsert, d=innerDiameter, center=false, $fn=(10+outerDiameter));
            translate([0, airSupplyY+2*minWallThickness,-ground])rotate ([0, 45, 0])
                cube([labiumWidth, 2*minWallThickness, outCut], true);
            translate([outCut/2/sqrt(2), airSupplyY +2*minWallThickness, outCut/2/sqrt(2) -ground])
                rotate([0, 45, 0])rotate([90-shapeAngle, 0, 0])
                   scale([1, curveHeight, 1])  rotate_extrude($fn = 2*outerDiameter, angle = 180) translate([labiumWidth/2, 0, 0]) 
                    circle(r = minWallThickness);
            };
        };
    };
};

module basicShape20(height, corpus_angle)
rotate ([0, corpus_angle, 0])
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
}

module basicShape21()
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

module cylinder_outer(height,radius,fn){  	//from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}
   
module airSupplySpacer(x=0){
    translate ([x, airSupplyY, (ground - 0.1 - tubeInsert)]) 
    cylinder (2*tubeInsert, d=outerTube, center=false, $fn=(20+outerTube));
}
module airSupplySpacerTraverse(x=0){
    translate ([x, - outerDiameter/2, (ground-0.1)]) 
    cylinder (tubeInsert, d=outerTube, center=false, $fn=(20+outerTube));
}