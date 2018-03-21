# 3d-printed labial pipe

## General
This is a collection of FreeCAD files that will help you to 3D-print a part of a labial pipe, to be used with a piece of tube. Because most organ pipes don't fit into most 3d-printers.

Please start by adding the desired measurements into the spreadsheet. If you don’t know which sizes to use, [webpipecalc](https://cuervo.phoenix.uberspace.de/webpipecalc/) can help. You are limited by the diameters of the tubes you can buy.

I got the best printing results when slicing at a 45° angle and ‘support touching build plate’, so that there is no support structure under the labium.

I'd be happy to hear about your instrument!

## Versions
The development is ongoing, and not necessarily the latest file is the one you want. Every 0.x has distinct features and then bugfixes. You probably want file 
* 0.5 (no block chamfer) or 
* 0.7.1. (block chamfer) or 
* 0.8 (has ears) or 
* 0.9 (has boxbeard) or 
* 0.2.3 (is filled below the mouth).

0.1 First attempt for pipes with 60mm diameter, made with tinkercad.com , here for sentimental reasons<br>
0.2 Fully proportional pipe part as FreeCAD file <br>
0.2.3 Bug fixes, mostly for cases of very narrow labium <br>
0.3 has (along the pipe) curved labium <br>
0.3.1 Curved labium pipe with minor bugfixes <br>
0.3.3 bugfix, sounds much better <br>
0.4.1 creative approach that did not work <br>
0.4.2 now it makes tiny tones :) <br>
0.5 Back to straight labium, better proportions, especially for wide labium, and it is hollow in the ‘block’. Surprise: the labium doesn’t need to be at the end of the sounding tube in a flue <br>
0.6 Experimental shape for the purpose of dividing long tubes, so far I can’t make sense of the pitch that comes out but it does sound nice <br>
0.7 like 0.5 with optional block chamfer <br>
0.7.1 bugfix <br>
0.8 has ears and optional block chamfer <br>
0.9 has boxbeard  and optional block chamfer <br>
0.10 experimental transverse flute <br>
0.10.4 most elegant 0.10.x<br>
0.10.5 has adjustable labium angle <br>
0.11 experimental transverse flute with different geometry <br>
0.11.3 alternative <br>
0.11.4 most elegant 0.11.x <br>
0.11.5 has adjustable labium angle <br>
0.12 ‘the owl’ flute with two tubes <br>
0.12.4 most elegant 0.12.x <br>
0.12.5 has adjustable labium angle <br>
0.12.6 bugfix <br>
0.12.7 alternative <br>

## Design thoughts
I was pondering the design of flue pipes from wood and metal, and came to the conclusion that the design has a lot to do with the material. Wooden pipes are built angular because that is easier than woodturning, and metal pipes are made in a round shape because less soldering. So, what would be a good design for 3D-printing? Well, something with a flat base would be handy. But then, most 3D-printers can’t print large enough for most organ pipes, organ pipes get really large you know. So I decided to use tubes from the hardware store and only 3D-print the intricate part, therefore the 3D-printed organ pipes would be round. I made the outside hexagonal because that offers the best ratio of stability vs. little space consuming.
In order to be compatible with organ builders (and people who work with wood in general), the foot would be round like in wooden organ pipes, so it would be compatible with a somewhat traditional wind-chest design. However, I don’t think it is necessary to have the foot in the middle of the cup, having it off, like in a recorder, made the design easier (I was thinking of getting the support structure removed after printing) while I’m not aware of substantial disadvantages.
I didn’t consider the size of the foot hole so far, will do so when I’ll experiment with an actual wind-chest.

## More online info about flue pipes (German only)
http://www.arndt-bruenner.de/hausorgel/CalcMens.htm <br>
http://www.orgel-info.de/Mensuren.pdf <br>
https://de.wikipedia.org/wiki/Orgelpfeife#Intonation <br>
http://orgelromantik.aeoline.de/2009/02/06/uber-labien-aufschnitte-und-kerne-der-labialpfeifen/ <br>
http://orgelromantik.aeoline.de/2009/12/02/die-zehn-wichtigsten-tabellen-zu-pfeifenmasen/ <br>
http://orgelromantik.aeoline.de/2011/01/14/orgel-stimmen-mit-dem-ipad/ <br>

## Spectrogramm
Looking at what you are doing (mac): <br>
ffmpeg -f avfoundation -i ":0" -lavfi showspectrum=s=1440x900:slide=rscroll -c:v rawvideo -r 25 -pix_fmt yuv420p -f matroska - | mpv -

## Future plans
* Currently I'm printing pipes with different parameters and filaments to see which sounds how and I continue designing flue pipes. 
* Soon, I'll do tests on [organ pipes with inverted free reed.](https://github.com/benjaminwand/3d-printed-reversed-free-reed-pipe) (Invention of Ernst Zacharias, see "Die dynamische Orgel." Instrumentenbau-Zeitschrift 1999, Heft 7-8, S. 26 and https://www.youtube.com/watch?v=3jkmdJ6xWm4)
* I actually want to build a small organ.