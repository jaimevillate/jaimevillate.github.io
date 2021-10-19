settings.tex="pdflatex";  //doesn't work if asy is given option -o dir/file
if(settings.outformat == "") settings.outformat="pdf";
if(settings.outformat == "png") settings.render=2;
usepackage("inputenc","utf8");
usepackage("amsmath","intlimits");
usepackage("wasysym","integrals");
usepackage("newtxmath","cmintegrals");
usepackage("newtxtext");
usepackage("fontenc","T1");
texpreamble("\renewcommand{\encodingdefault}{T1}");
defaultpen(0.6);

label("\textbf{\large Física 2 -- Ingeniería Informática -- 2017}",(90,100));
filldraw((0,0)--arc((0,0),80,90,314)--cycle,green,black);
filldraw((0,0)--arc((0,0),80,-46,19)--cycle,yellow,black);
filldraw((0,0)--arc((0,0),80,19,53)--cycle,cyan,black);
filldraw((0,0)--arc((0,0),80,53,61)--cycle,magenta,black);
filldraw((0,0)--arc((0,0),80,61,90)--cycle,red,black);

path g=((0,0)--(20,0)--(20,10)--(0,10)--cycle);
label("\textbf{215 alumnos inscritos}",(130,65),E);
filldraw(shift(100,40)*g,red,black);
label("17 faltaron a las clases",(130,45),E);
filldraw(shift(100,20)*g,magenta,black);
label("5 sin nota de los parciales",(130,25),E);
filldraw(shift(100,0)*g,cyan,black);
label("20 no hicieron el examen",(130,5),E);
filldraw(shift(100,-20)*g,yellow,black);
label("39 reprobaron",(130,-15),E);
filldraw(shift(100,-40)*g,green,black);
label("134 aprobaron",(130,-35),E);

