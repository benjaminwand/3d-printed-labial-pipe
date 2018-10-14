// elliptic labium cut 



// correction so it doesn't cut through pipe in undesired place
color("blue", alpha=0.2)
	translate([0, 0, outerDiameter/4 - outCut /2/ sqrt(2)])
		difference(){
			cylinder(h=outerDiameter, d=outerDiameter + 2* minWallThickness, center=false, $fn=(30+outerDiameter));
			sphere(d=outerDiameter, $fn=(30+outerDiameter));
		}

