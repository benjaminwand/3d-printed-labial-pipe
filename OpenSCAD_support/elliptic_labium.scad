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

module elliptic_beard(){
    intersection(){
    loft(upper_beard_points, lower_beard_points, number_of_layers); // hier Bart teil einführen
    translate([0, 0, ground])
        difference(){
            cylinder(height, d=(2*outerDiameter)); 
            translate([0, 0, -0.1])cylinder((height + 0.2), d=(outerDiameter)); 
        }
    }  
}

