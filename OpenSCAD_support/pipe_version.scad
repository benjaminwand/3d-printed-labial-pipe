// version number
 
module version_number (number)
translate ([outerDiameter*0.5 + minWallThickness, 0, -lengthFlue])
rotate ([90,0,90])
linear_extrude(1) 
text(text=str(number), size=outerDiameter*0.13, halign = "center");

module vertical_version_number (number)
translate ([outerDiameter*0.5 - 0.3 + minWallThickness, 0, -lengthFlue])
rotate ([90,-90,90])
linear_extrude(1) 
text(text=str(number), size=outerDiameter*0.15, valign = "center");

module vertical_version_number_20 (number, corpus_angle = 0)
rotate ([0, corpus_angle, 0])
translate ([outerDiameter*-0.5 +0.3 - minWallThickness, 0, -lengthFlue])
rotate ([90,-90,-90])
linear_extrude(1) 
union(){
text(text=str("pipe: ", number), size=outerDiameter*0.18, valign = "bottom");
text(text=str("angle: ", corpus_angle, "°"), size=outerDiameter*0.18, valign = "top");
}
