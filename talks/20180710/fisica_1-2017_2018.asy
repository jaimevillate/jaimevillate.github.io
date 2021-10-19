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

label("\textbf{\large Física 1 -- Ingeniería Informática -- 2018}",(90,100));
filldraw((0,0)--arc((0,0),80,90,315)--cycle,green,black);
filldraw((0,0)--arc((0,0),80,315,355)--cycle,yellow,black);
filldraw((0,0)--arc((0,0),80,-5,27)--cycle,cyan,black);
filldraw((0,0)--arc((0,0),80,27,52)--cycle,magenta,black);
filldraw((0,0)--arc((0,0),80,52,90)--cycle,red,black);

path g=((0,0)--(20,0)--(20,10)--(0,10)--cycle);
label("\textbf{226 alumnos inscritos}",(130,65),E);
filldraw(shift(100,40)*g,red,black);
label("24 faltaron a las clases",(130,45),E);
filldraw(shift(100,20)*g,magenta,black);
label("16 sin nota de los parciales",(130,25),E);
filldraw(shift(100,0)*g,cyan,black);
label("20 no hicieron el examen",(130,5),E);
filldraw(shift(100,-20)*g,yellow,black);
label("25 reprobaron",(130,-15),E);
filldraw(shift(100,-40)*g,green,black);
label("141 aprobaron",(130,-35),E);

