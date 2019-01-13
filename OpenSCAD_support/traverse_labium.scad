// traverse labium cut

module labium_cut(){
    translate ([0 ,0,-labiumWidth/2])
        linear_extrude(labiumWidth, $fn=50) 
            polygon(points = labium_polygon_points);
};