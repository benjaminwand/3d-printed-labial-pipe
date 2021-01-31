# 3d-printed labial pipe

This is a collection of FreeCAD and OpenSCAD files that will help you to 3D-print a part of a labial pipe, to be used with a piece of tube. 

## Howto
This is how to go from here:
1. pick a file
2. choose and add measurements
3. export .stl
4. print. 

### Versions
Not necessarily the latest file is the one you want. Every 0.x has distinct features and then follow bugfixes. Please look at the images below to choose a pipe you want.

0.1 First attempt for pipes with 60mm diameter, made with tinkercad.com , here for sentimental reasons <br>
![/pics/0.01.png](/pics/0.01.png)<br>
0.2 Fully proportional pipe part as FreeCAD file <br>
![/pics/0.02.x.png](/pics/0.02.x.png)<br>
0.2.3 Bug fixes, mostly for cases of very narrow labium <br>
0.3 has (along the pipe) curved labium <br>
![/pics/0.03.x.png](/pics/0.03.x.png)<br>
0.3.1 Curved labium pipe with minor bugfixes <br>
0.3.3 bugfix, sounds much better <br>
0.4.1 creative approach that did not work <br>
![/pics/0.04.x.png](/pics/0.04.x.png)<br>
0.4.2 now it makes tiny tones :) <br>
0.5 Back to straight labium, better proportions, especially for wide labium, and it is hollow in the ‘block’. Surprise: the labium doesn’t need to be at the end of the sounding tube in a flue <br>
![/pics/0.05.x.png](/pics/0.05.x.png)<br>
0.5.1 like 0.5 but more flue pipe like outer shape <br>
0.6 Experimental shape for the purpose of dividing long tubes, so far I can’t make sense of the pitch that comes out but it does sound nice <br>
![/pics/0.06.x.png](/pics/0.06.x.png)<br>
0.7 like 0.5 with optional block chamfer <br> 
![/pics/0.07.x.png](/pics/0.07.x.png)<br>
0.7.1 bugfix <br>
0.7.2 like 0.7.1 but more flue pipe like outer shape <br>
0.8 has ears and optional block chamfer <br> 
![/pics/0.08.x.png](/pics/0.08.x.png) <br>
0.9 has boxbeard  and optional block chamfer <br> 
![/pics/0.09.x.png](/pics/0.09.x.png)<br>
0.9.1 like 0.9 but more flue pipe like outer shape <br>
0.10 experimental transverse flute <br> 
![/pics/0.10.x.png](/pics/0.10.x.png) <br>
0.10.4 most elegant 0.10.x<br>
0.10.5 has adjustable labium angle <br>
0.11 experimental transverse flute with different geometry <br> 
![/pics/0.11.x.png](/pics/0.11.x.png)<br>
0.11.3 alternative <br>
0.11.4 most elegant 0.11.x <br>
0.11.5 has adjustable labium angle <br>
0.12 ‘the owl’ flute with two tubes <br> 
![/pics/0.12.x.png](/pics/0.12.x.png)<br>
0.12.4 most elegant 0.12.x <br>
0.12.5 has adjustable labium angle <br>
0.12.6 bugfix <br>
0.12.7 alternative <br>
0.13 curved labium and hollow in the bottom <br> 
![/pics/0.13.x.png](/pics/0.13.x.png) <br>
0.14 new experimental traverse flute <br> 
![/pics/0.14.x.png](/pics/0.14.x.png) <br>
0.14.2 bugfix for larger pipes <br>
0.15 pipe with 45° (diagonal) labium, for the purpose of easier slicing <br> 
![/pics/0.15.x.png](/pics/0.15.x.png) <br>
0.15.1 - 0.15.9 several ways of 45° labium <br>
0.16 like 0.5 but has nicks <br> 
![/pics/0.16.x.png](/pics/0.16.x.png) <br>
0.17 curved 45° (diagonal) labium <br>
![/pics/0.17.x.png](/pics/0.17.x.png) <br>
0.18 traverse flute with nicks <br>
![/pics/0.18.x.png](/pics/0.18.x.png) <br>
0.19 angular entire flue pipe for printing upright <br>
![/pics/0.19.x.png](/pics/0.19.x.png) <br>
0.20 flue pipe with adjustable labium angle <br>
![/pics/0.20.x.png](/pics/0.20.x.png) <br>
0.21 traverse pipe with air supply from below <br>
![/pics/0.21.x.png](/pics/0.21.x.png) <br>
0.22 pipe with 360° labium that prints in one piece <br>
![/pics/0.22.x.png](/pics/0.22.x.png) ![/pics/0.22photo.png](/pics/0.22photo.png) <br>
0.23 pipe with 360° labium that prints in two pieces, please use a screw to connect them <br>
![/pics/0.23.x.png](/pics/0.23.x.png) ![/pics/0.23photo.png](/pics/0.23photo.png) <br>
0.24 pipe with 360° labium that prints in two pieces and also prints the labium <br>
![/pics/0.24.x.png](/pics/0.24.x.png) <br>
0.24 pipe with 45° (diagonal) labium (similar to 0.15) but looking like a slightly squashed beverage can <br>
![/pics/0.25.x.png](/pics/0.25.x.png) <br>

[THe 360° files (0.22 - 0.24) got their own blog article.](https://benjaminwand.github.io/verbose-cv/projects/flauto_mirabilis.html)

[There are reversed free reed pipes as well.](https://github.com/benjaminwand/3d-printed-reversed-free-reed-pipe)

[And there are diaphone pipes.](https://github.com/benjaminwand/3d-printed-diaphone-pipe)

### choosing measurements
Picking the exact measurements for organ pipes is an advanced subject that includes experience and opinion. If you don’t know where to start, [webpipecalc](https://cuervo.phoenix.uberspace.de/webpipecalc/) can help. You are limited by the diameters of the tubes you can buy. ‘Diameter’ in webpipecalc means inner diameter of the tube.

You can avoid picking measurements (other then for your pipe, which is given) by choosing file 0.22 or 0.23 because they don’t have cut up and labium width measurements.

### adding measurements and exporting .stl
Please add the desired measurements into the spreadsheet (FreeCAD) or ‘variables’ section (OpenSCAD). If you are unfamiliar with both FreeCAD and OpenSCAD and just want an .stl file [you can find them amongst my Thingiverse publications.](https://www.thingiverse.com/bettercallitart/designs) I’ve also made [an introduction video for using the FreeCAD and OpenSCAD files in this repository.](https://youtu.be/g_tp1z9HByQ)

Some OpenSCAD files require at least Version 2018.

### printing
For most pipes I got the best printing results when slicing at a 45° angle and ‘support touching build plate’, so that there is no support structure under the labium. <br>
![https://cdn.thingiverse.com/renders/2a/03/54/e3/72/e935fcfeddd0d054e9dca2f05e988bd0_preview_featured.jpg](https://cdn.thingiverse.com/renders/2a/03/54/e3/72/e935fcfeddd0d054e9dca2f05e988bd0_preview_featured.jpg)<br>
Some pipes (0.10, 0.11, 0.12, 0.15, 0.17, 0.18, 0.19, 0.21, 0.22, 0.23) should be printed in normal orientation though.

## Design thoughts
I was pondering the design of flue pipes from wood and metal, and came to the conclusion that the design has a lot to do with the material. Wooden pipes are built angular because that is easier than woodturning, and metal pipes are made in a round shape because less soldering. So, what would be a good design for 3D-printing? Well, something with a flat base would be handy. But then, most 3D-printers can’t print large enough for most organ pipes, organ pipes get really large you know. So I decided to use tubes from the hardware store and only 3D-print the intricate part, therefore the 3D-printed organ pipes would be round. I made the outside of many pipes hexagonal because that offers the best ratio of stability vs. little space consuming. <br>
Initially, in order to be compatible with organ builders (and people who work with wood in general), the foot was round like in wooden organ pipes, so it would be compatible with a somewhat traditional wind-chest design. Later I went for designs where one could stick in a pipe. Which can be a short pipe as well and then it fits a wind chest again. <br>
However, I don’t think it is necessary to have the foot in the middle of the cup, having it off, like in a recorder, made the design easier (I was thinking of getting the support structure removed after printing) while I couldn’t find substantial disadvantages. Also it enabled pipes that were hollow below the labium, which means the generator can be somewhere in the resonator.

In the later works (0.20 and onwards) I got playful out of enjoyment for 3d modeling.

## More online info about flue pipes (German only)
http://www.arndt-bruenner.de/hausorgel/CalcMens.htm <br>
http://www.orgel-info.de/Mensuren.pdf <br>
https://de.wikipedia.org/wiki/Orgelpfeife#Intonation <br>
http://orgelromantik.aeoline.de/2009/02/06/uber-labien-aufschnitte-und-kerne-der-labialpfeifen/ <br>
http://orgelromantik.aeoline.de/2009/12/02/die-zehn-wichtigsten-tabellen-zu-pfeifenmasen/ <br>
http://orgelromantik.aeoline.de/2011/01/14/orgel-stimmen-mit-dem-ipad/ <br>

## Spektrogramm
Looking at what you are doing (mac): <br>
ffmpeg -f avfoundation -i ":0" -lavfi showspectrum=s=1440x900:slide=rscroll -c:v rawvideo -r 25 -pix_fmt yuv420p -f matroska - | mpv -
<br>
Linux: ffplay -f pulse -i "default"


## other files
### flue and labium only
To figure out the generator sound/frequency <br>
![/pics/straight.png](/pics/straight.png) <br>
### tuning and misc
Parametric tuning devices, [some of which got their own blog article.](https://benjaminwand.github.io/verbose-cv/projects/introducing_tuning.html)

## state of the project
At some point I became tired of deploying the latest features into all files, if you want a pipe with specific features, please file a GitHub issue. I’m somewhat motivated to make OpenSCAD files of pipes that so far only exist as FreeCAD version, tell me which one you want. I’m not motivated in the opposite direction.

I’m happy to answer questions.

I'd be happy to hear about your instrument!

Licensed under CC-BY <br>
https://creativecommons.org/licenses/by/4.0/legalcode