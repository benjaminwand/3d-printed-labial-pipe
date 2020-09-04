// 45° labium cut

module labium_cut(){
    translate([-outCut/sqrt(2), 0, -outCut/sqrt(2)])
    rotate([0, 45, 0])
        translate ([-labiumWidth/2,0,0])
            rotate([90, 0, 90])
                linear_extrude(labiumWidth, $fn=50) 
                    polygon(points = labium_polygon_points);
};