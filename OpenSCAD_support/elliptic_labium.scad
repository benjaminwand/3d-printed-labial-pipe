// elliptic labium cut 

module elliptic_labium_cut(){
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
	            resize(newsize=[outerDiameter*sqrt(2),outerDiameter,outerDiameter/2]) 
	                sphere(r=10);
			};
	    };
	};
}

