/*
   Asymptote programs to draw physics related diagrams
   Copyright (C) 2023 Jaime E. Villate
   
   Version: 1.0
   Time-stamp: "2023-12-05 10:49:18 villate"

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License
   as published by the Free Software Foundation; either version 2
   of the License, or (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA  02110-1301, USA
*/
   
pen darkerpen (pen p=currentpen, real f) {
  real[] c=colors(p);
  if (c.length == 4)  return cmyk(c[0],c[1],c[2],f*c[3]+1.0-f)+0*p;
  else  return f*p;}

void vector(picture pic=currentpicture, Label s="", explicit pair orig,
            real mag, real ang, align align=NoAlign, pen p=currentpen) {
  pen q=p+3.33*linewidth(p);
  draw(pic, shift(orig)*rotate(ang)*((0,0)--(mag,0)), q,
       Arrow(HookHead,arrowsize(q)/6));
  if(s != "") {
    label(pic,s,shift(orig)*rotate(ang)*((0,0)--(mag,0)),align,currentpen);}}

void vector(picture pic=currentpicture, Label s="", explicit pair orig,
            explicit pair dest, align align=NoAlign, pen p=currentpen) {
  vector(pic,s,orig,length(dest-orig),degrees(dest-orig),align,p);}

void vectorin(picture pic=currentpicture, Label s="", explicit pair orig,
            align align=NoAlign, pen p=currentpen) {
  real d=6.6667*linewidth(p);
  pen q=p+3.3333*linewidth(p);
  draw(orig-(d,d)--orig+(d,d)^^orig+(-d,d)--orig+(d,-d),q);
  if(s != "") {
    label(pic,s,orig,align,currentpen);}}

void vectorout(picture pic=currentpicture, Label s="", explicit pair orig,
            align align=NoAlign, pen p=currentpen) {
  pen q=p+6.6667*linewidth(p);
  dot(orig,q);
  if(s != "") {
    label(pic,s,orig,align,currentpen);}}

void fieldline(picture pic=currentpicture, Label L="", path g,
               align align=NoAlign, pen p=currentpen, real pos=0.5) {
  if (pos == 0.5) {
    draw(pic,g,p,MidArcArrow(HookHead,arrowsize(p)/6));}
  else {
    draw(pic,g,p,ArcArrow(HookHead,arrowsize(p)/6,position=pos*length(g)));}
  if(L != "") {
    label(pic,L,g,align,currentpen);}}

void centershade(picture pic=currentpicture, path p, bool stroke=false,
                 pen in, pen out, pen drawpen=currentpen) { 
  pair center=0.5(max(p)+min(p));
  real radius=0.5abs(max(p)-min(p));
  radialshade(pic,p,in,center,0,out,center,radius);
  if (stroke) draw(pic,p,drawpen);}

void sphere(picture pic=currentpicture, real r=1, pair c=(0,0),
            pen p=currentpen, pen q=darkerpen(p,0.25)) {
  pair z=c+(0.375*r/sqrt(2),0.375*r/sqrt(2));
  radialshade(pic, shift(c)*scale(r)*unitcircle,p,z,0,q,z,1.375*r);}

void cylinder(picture pic=currentpicture, real r=1, real h=2,
         real f=0.3, pair c=(0,0), pen p=currentpen, pen q=darkerpen(p,0.4)) {
  if (f == 0) {
    path g=(-r,h)--(-r,0)--(r,0)--(r,h)--cycle;
    axialshade(pic, shift(c)*g,q,c-(r,0),p,c);
    axialshade(pic, shift(c)*g,q,c+(r,0),p,c,false);}
  else {
    path g=(-r,h/f)--arc((0,h/f),r,180,360)--(r,0)--arc((0,0),r,360,180)--cycle;
    axialshade(pic, shift(c)*scale(1,f)*g,q,c-(r,0),p,c);
    axialshade(pic, shift(c)*scale(1,f)*g,q,c+(r,0),p,c,false);
    axialshade(pic, shift(c+(0,h))*scale(r,f*r)*unitcircle,p,
               c+(0,h-f*r),q,c+(0,h+f*r));}}

void hollow_cylinder(picture pic=currentpicture, real r=1, real h=2,
         real f=0.3, pair c=(0,0), pen p=currentpen, pen q=darkerpen(p,0.4)) {
  path g1=(-r,h/f)--arc((0,h/f),r,180,0)--(r,0)--arc((0,0),r,0,180)--cycle;
  path g2=(-r,h/f)--arc((0,h/f),r,180,360)--(r,0)--arc((0,0),r,360,180)--cycle;
  axialshade(pic, shift(c)*scale(1,f)*g1,p,c-(r,0),q,c);
  axialshade(pic, shift(c)*scale(1,f)*g1,p,c+(r,0),q,c,false);
  axialshade(pic, shift(c)*scale(1,f)*g2,q,c-(r,0),p,c);
  axialshade(pic, shift(c)*scale(1,f)*g2,q,c+(r,0),p,c,false);}

void ring(picture pic=currentpicture, real r1=1, real r2=0.5, real h=2,
              real f=0.3, pair c=(0,0), pen p=currentpen) {
  path g1=(-r1,h/f)--arc((0,h/f),r1,180,0)--(r1,0)--arc((0,0),r1,0,180)--cycle;
  path g2=(-r2,h/f)--arc((0,h/f),r2,180,360)--(r2,0)--arc((0,0),r2,360,180)
    --cycle;
  axialshade(pic,shift(c)*scale(1,f)*g1,p,c-(r1,0),darkerpen(p,0.4),c);
  axialshade(pic,shift(c)*scale(1,f)*g1,p,c+(r1,0),darkerpen(p,0.4),c,false);
  axialshade(pic,shift(c)*scale(1,f)*g2,darkerpen(p,0.4),c-(r2,0),p,c);
  axialshade(pic,shift(c)*scale(1,f)*g2,darkerpen(p,0.4),c+(r2,0),p,c,false);
  axialshade(pic,shift(c+(0,h))*scale(r1,f*r1)*unitcircle^^
             shift(c+(0,h))*scale(r2,f*r2)*unitcircle,evenodd+darkerpen(p,0.8),
             c+(0,h-f*r2),evenodd+darkerpen(p,0.5),c+(0,h+f*r2));}

void torus(picture pic=currentpicture, real r1=1, real r2=0.5, pair c=(0,0),
           pen p=currentpen) {
  real r=(r1+r2)/2;
  path g1=shift(c)*scale(r1)*unitcircle;
  path g2=shift(c)*scale(r2)*unitcircle;
  radialshade(pic,g1^^g2,evenodd+p,c,r,evenodd+darkerpen(p,0.25),c,r2);
  radialshade(pic,g1^^g2,evenodd+darkerpen(p,0.25),c,r1,evenodd+p,c,r,false);}

void torus(picture pic=currentpicture, real r1, real r2, pair c=(0,0),
           pen p=currentpen) {
  real r=(r1+r2)/2;
  path g1=shift(c)*scale(r1)*unitcircle;
  path g2=shift(c)*scale(r2)*unitcircle;
  radialshade(pic,g1^^g2,evenodd+p,c,r,evenodd+darkerpen(p,0.25),c,r2);
  radialshade(pic,g1^^g2,evenodd+darkerpen(p,0.25),c,r1,evenodd+p,c,r,false);}

void torus_arc(picture pic=currentpicture, real r1, real r2,
           real ang1, real ang2, pair c=(0,0), pen p=currentpen) {
  real r=(r1+r2)/2;
  path g1=arc(c,r1,ang1,ang2);
  path g2=arc(c,r2,ang2,ang1);
  path g=g1--g2--cycle;
  radialshade(pic,g,p,c,r,darkerpen(p,0.25),c,r2);
  radialshade(pic,g,darkerpen(p,0.25),c,r1,p,c,r,false);}

void toroidal_cylinder(picture pic=currentpicture, real r1, real r2, real ang1,
                  real ang2, pair c=(0,0), pen p=currentpen, bool cap=true) {
  real r=(r1+r2)/2;
  real d=(r2-r1)/2;
  path ga;
  if (ang1 < ang2) {
    ga=arc((0,0),d,360,180);}
  else {
    ga=arc((0,0),d,0,180);}
  path gb=shift(c+r*(Cos(ang1),Sin(ang1)))*rotate(ang1)*scale(1,0.6)*ga;
  path g=gb--arc(c,r1,ang1,ang2)--arc(c,r2,ang2,ang1)--cycle;
  radialshade(pic,g,p,c,r,darkerpen(p,0.25),c,r2);
  radialshade(pic,g,darkerpen(p,0.25),c,r1,p,c,r,false);
  if (cap) {
    fill(pic,shift(c+r*(Cos(ang2),Sin(ang2)))*rotate(ang2)*scale(d,0.6*d)*
         unitcircle, darkerpen(p,0.6));}}

void cccc(picture pic=currentpicture, Label s="", path[] g, explicit pair orig,
              real mag, real ang, pair d, pen p=currentpen) {
  draw(pic,shift(orig)*rotate(ang)*g,p);
  if(s != "") {
    label(pic,s,orig+(mag/2)*(Cos(ang),Sin(ang)),d);}}

void resistor(picture pic=currentpicture, Label s="", explicit pair orig,
              real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag > 24) {
    path g=(0,0)--(mag/2-12,0);
    pair last=(mag/2-10.5,3);
    for (int i=1; i<4; ++i) {
      g=g--last--last+(3,-6);
      last=last+(6,0);}
    g=g--last--last+(3,-6)--(mag/2+12,0)--(mag,0);
    cccc(pic,s,g,orig,mag,ang,2d,p);}}

void resistor(picture pic=currentpicture, Label s="", explicit pair orig,
              explicit pair dest, pair d=N, pen p=currentpen) {
  resistor(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void inductor(picture pic=currentpicture, Label s="", explicit pair orig,
              real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag > 32) {
    path g=(0,0)--(mag/2-16,0);
    pair c=(mag/2-12,0);
    for (int i=0; i<4; ++i) {
      g=g--arc(c,4,180,0)--arc(c+(3,0),1,360,180);
      c+=(6,0);}
    g=g--arc(c,4,180,0)--(mag,0);
    cccc(pic,s,g,orig,mag,ang,2d,p);}}

void inductor(picture pic=currentpicture, Label s="", explicit pair orig,
              explicit pair dest, pair d=N, pen p=currentpen) {
  inductor(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void emfp(picture pic=currentpicture, Label s="", explicit pair orig,
              real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag >= 4) {
    real u=linewidth(currentpen);
    real z=mag/2;
    path[] g=(0,0)--(z-2,0)^^(z-2,8)--(z-2,-8)^^(z+2,4)--(z+2,-4)--(z+2+u,-4)
      --(z+2+u,4)--(z+2,4)^^(z+2,0)--(mag,0);
    cccc(pic,s,g,orig,mag,ang,3d,p);}}

void emfp(picture pic=currentpicture, Label s="", explicit pair orig,
              explicit pair dest, pair d=N, pen p=currentpen) {
  emfp(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void emfn(picture pic=currentpicture, Label s="", explicit pair orig,
              real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag >= 4) {
    real u=linewidth(currentpen);
    real z=mag/2;
    path[] g=(0,0)--(z-2,0)^^(z-2,4)--(z-2,-4)--(z-2-u,-4)--(z-2-u,4)--(z-2,4)
      ^^(z+2,8)--(z+2,-8)^^(z+2,0)--(mag,0);
    cccc(pic,s,g,orig,mag,ang,3d,p);}}

void emfn(picture pic=currentpicture, Label s="", explicit pair orig,
              explicit pair dest, pair d=N, pen p=currentpen) {
  emfn(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void capacitor(picture pic=currentpicture, Label s="", explicit pair orig,
              real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag > 4) {
    path[] g=(0,0)--(mag/2-2,0)^^(mag/2-2,6)--(mag/2-2,-6)^^(mag/2+2,6)--
      (mag/2+2,-6)^^(mag/2+2,0)--(mag,0);
    cccc(pic,s,g,orig,mag,ang,3d,p);}}

void capacitor(picture pic=currentpicture, Label s="", explicit pair orig,
              explicit pair dest, pair d=N, pen p=currentpen) {
  capacitor(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void ground(picture pic=currentpicture, explicit pair orig, real mag,
            real ang, pen p=currentpen) {
  if (mag > 6) {
    path[] g=(0,0)--(mag-6,0)^^(mag-6,-6)--(mag-6,6)^^
      (mag-4,-4.5)--(mag-4,4.5)^^(mag-2,-3)--(mag-2,3)^^(mag,-1.5)--(mag,1.5);
    cccc(pic,"",g,orig,mag,ang,N,p);}}

void ground(picture pic=currentpicture, explicit pair orig,
              explicit pair dest, pen p=currentpen) {
  ground(pic,orig,length(dest-orig),degrees(dest-orig),p);}

void openswitch(picture pic=currentpicture, Label s="", explicit pair orig,
                real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag >= 20) {
    path[] g=(0,0)--(mag/2-10,0)^^shift(mag/2-9,0)*unitcircle^^(mag/2+10,0)--
    (mag,0)^^shift(mag/2+9,0)*unitcircle^^(mag/2-8,0.5)--(mag/2+6.5,6);
    cccc(pic,s,g,orig,mag,ang,3d,p);}}

void openswitch(picture pic=currentpicture, Label s="", explicit pair orig,
              explicit pair dest, pair d=N, pen p=currentpen) {
  openswitch(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void closedswitch(picture pic=currentpicture, Label s="", explicit pair orig,
                  real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag >= 20) {
    path[] g=(0,0)--(mag/2-10,0)^^shift(mag/2-9,0)*unitcircle^^(mag/2+10,0)--
    (mag,0)^^shift(mag/2+9,0)*unitcircle^^(mag/2-8,0)--(mag/2+8,0);
    cccc(pic,s,g,orig,mag,ang,d,p);}}

void closedswitch(picture pic=currentpicture, Label s="", explicit pair orig,
              explicit pair dest, pair d=N, pen p=currentpen) {
  closedswitch(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void ammeter(picture pic=currentpicture, explicit pair orig, real mag,
                  real ang, pen p=currentpen) {
  if (mag >= 20) {
    path[] g=(0,0)--(mag/2-10,0)^^shift(mag/2,0)*scale(10)*unitcircle^^
      (mag/2+10,0)--(mag,0);
    draw(pic, shift(orig)*rotate(ang)*g,p);
    label(pic,"A",orig+(mag/2)*(Cos(ang),Sin(ang)));}}

void ammeter(picture pic=currentpicture, explicit pair orig,
             explicit pair dest, pen p=currentpen) {
  ammeter(pic,orig,length(dest-orig),degrees(dest-orig),p);}

void voltmeter(picture pic=currentpicture, explicit pair orig, real mag,
                  real ang, pen p=currentpen) {
  if (mag >= 20) {
    path[] g=(0,0)--(mag/2-10,0)^^shift(mag/2,0)*scale(10)*unitcircle^^
      (mag/2+10,0)--(mag,0);
    draw(pic, shift(orig)*rotate(ang)*g,p);
    label(pic,"V",orig+(mag/2)*(Cos(ang),Sin(ang)));}}

void voltmeter(picture pic=currentpicture, explicit pair orig,
             explicit pair dest, pen p=currentpen) {
  voltmeter(pic,orig,length(dest-orig),degrees(dest-orig),p);}

void meter(picture pic=currentpicture, Label s, explicit pair orig, real mag,
                  real ang, pen p=currentpen) {
  if (mag >= 20) {
    path[] g=(0,0)--(mag/2-10,0)^^shift(mag/2,0)*scale(10)*unitcircle^^
      (mag/2+10,0)--(mag,0);
    draw(pic, shift(orig)*rotate(ang)*g,p);
    label(pic,s,orig+(mag/2)*(Cos(ang),Sin(ang)));}}

void meter(picture pic=currentpicture, Label s, explicit pair orig,
             explicit pair dest, pen p=currentpen) {
  meter(pic,s,orig,length(dest-orig),degrees(dest-orig),p);}

void vgaugep(picture pic=currentpicture, Label s="$V$", explicit pair orig,
             real mag, real ang, pen p=currentpen) {
  if (mag >= 40) {
    pair ex=dir(ang),ey=dir(ang+90);
    draw(pic,orig+15*ex+15*ey--orig+(mag-15)*ex+15*ey);
    draw(pic,arc(orig+15*ex,15,90+ang,180+ang),ArcArrow(TeXHead));
    draw(pic,arc(orig+(mag-15)*ex,15,90+ang,ang),ArcArrow(TeXHead));
    label(pic,"$+$",orig+8*ex+2*ey);
    label(pic,"$-$",orig+(mag-8)*ex+2ey);
    if(s != "") {
      label(pic,s,orig+mag*ex/2+15*ey,UnFill(3pt));}}}

void vgaugep(picture pic=currentpicture, Label s="$V$", explicit pair orig,
              explicit pair dest, pen p=currentpen) {
  vgaugep(pic,s,orig,length(dest-orig),degrees(dest-orig),p);}

void vgaugen(picture pic=currentpicture, Label s="$V$", explicit pair orig,
              real mag, real ang, pen p=currentpen) {
  if (mag >= 40) {
    pair ex=dir(ang),ey=dir(ang+90);
    draw(pic,orig+15*ex+15*ey--orig+(mag-15)*ex+15*ey);
    draw(pic,arc(orig+15*ex,15,90+ang,180+ang),ArcArrow(TeXHead));
    draw(pic,arc(orig+(mag-15)*ex,15,90+ang,ang),ArcArrow(TeXHead));
    label(pic,"$-$",orig+8*ex+2*ey);
    label(pic,"$+$",orig+(mag-8)*ex+2ey);
    if(s != "") {
      label(pic,s,orig+mag*ex/2+15*ey,UnFill(3pt));}}}

void vgaugen(picture pic=currentpicture, Label s="$V$", explicit pair orig,
              explicit pair dest, pen p=currentpen) {
  vgaugen(pic,s,orig,length(dest-orig),degrees(dest-orig),p);}

void vsourcep(picture pic=currentpicture, Label s="$V$", explicit pair orig,
              real mag, real ang, pen p=currentpen) {
  if (mag >= 20) {
    path[] g=(0,0)--(mag/2-10,0)^^shift(mag/2,0)*scale(10)*unitcircle^^
      (mag/2+10,0)--(mag,0);
    pair ex=dir(ang),ey=dir(ang+90);
    draw(pic,shift(orig)*rotate(ang)*g,p);
    label(pic,"$+$",orig+(mag/2-14)*ex-4*ey);
    label(pic,"$-$",orig+(mag/2+14)*ex-5*ey);
    if(s != "") {
      label(pic,s,orig+mag*ex/2);}}}

void vsourcep(picture pic=currentpicture, Label s="$V$", explicit pair orig,
             explicit pair dest, pen p=currentpen) {
  vsourcep(pic,s,orig,length(dest-orig),degrees(dest-orig),p);}

void vsourcen(picture pic=currentpicture, Label s="$V$", explicit pair orig,
              real mag, real ang, pen p=currentpen) {
  if (mag >= 20) {
    path[] g=(0,0)--(mag/2-10,0)^^shift(mag/2,0)*scale(10)*unitcircle^^
      (mag/2+10,0)--(mag,0);
    pair ex=dir(ang),ey=dir(ang+90);
    draw(pic,shift(orig)*rotate(ang)*g,p);
    label(pic,"$-$",orig+(mag/2-14)*ex+5*ey);
    label(pic,"$+$",orig+(mag/2+14)*ex+4*ey);
    if(s != "") {
      label(pic,s,orig+mag*ex/2);}}}

void vsourcen(picture pic=currentpicture, Label s="$V$", explicit pair orig,
             explicit pair dest, pen p=currentpen) {
  vsourcen(pic,s,orig,length(dest-orig),degrees(dest-orig),p);}

void isource(picture pic=currentpicture, Label s="", explicit pair orig,
              real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag >= 20) {
    path[] g=(0,0)--(mag/2-10,0)^^shift(mag/2,0)*scale(10)*unitcircle^^
      (mag/2+10,0)--(mag,0);
    pair ex=dir(ang);
    draw(pic,shift(orig)*rotate(ang)*g,p);
    draw(pic,orig+(mag/2-8)*ex--orig+(mag/2+8)*ex,p,Arrow(TeXHead));
    if(s != "") {label(pic,s,orig+mag*ex/2,3.5d);}}}

void isource(picture pic=currentpicture, Label s="", explicit pair orig,
             explicit pair dest, pair d=N, pen p=currentpen) {
  isource(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void acsource(picture pic=currentpicture, Label s="", explicit pair orig,
              real mag, real ang, pair d=N, pen p=currentpen) {
  pair midp=orig+mag*dir(ang)/2;
  if (mag >= 20) {
    guide[] g=(0,0)--(mag/2-10,0)^^shift(mag/2,0)*scale(10)*unitcircle^^
      (mag/2+10,0)--(mag,0);
    draw(pic,midp-(6,0){(2,5)}..midp+(-3,3)..midp..midp+(3,-3)..
         {(2,5)}midp+(6,0));
    cccc(pic,s,g,orig,mag,ang,3.5d,p);}}

void acsource(picture pic=currentpicture, Label s="", explicit pair orig,
             explicit pair dest, pair d=N, pen p=currentpen) {
  acsource(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void acgauge(picture pic=currentpicture, Label s="$V$", explicit pair orig,
             real mag, real ang, pen p=currentpen) {
  if (mag >= 50) {
    pair ex=dir(ang),ey=dir(ang+90);
    pair midp=orig+(mag/2)*ex+15*ey;
    draw(pic,orig+15*ex+15*ey--orig+(mag/2-10)*ex+15*ey^^
         shift(orig+mag/2*ex+15*ey)*scale(10)*unitcircle^^
         orig+(mag/2+10)*ex+15*ey--orig+(mag-15)*ex+15*ey);
    draw(pic,arc(orig+15*ex,15,90+ang,180+ang),ArcArrow(TeXHead));
    draw(pic,arc(orig+(mag-15)*ex,15,90+ang,ang),ArcArrow(TeXHead));
    draw(pic,midp-(6,0){(2,5)}..midp+(-3,3)..midp..midp+(3,-3)..
         {(2,5)}midp+(6,0));
    if(s != "") {
      label(pic,s,orig+mag*ex/2+25*ey,ey);}}}

void acgauge(picture pic=currentpicture, Label s="$V$", explicit pair orig,
              explicit pair dest, pen p=currentpen) {
  acgauge(pic,s,orig,length(dest-orig),degrees(dest-orig),p);}

void impedance(picture pic=currentpicture, Label s="", explicit pair orig,
              real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag > 24) {
    path[] g=(0,0)--(mag/2-12,0)^^box((mag/2-12,-3),(mag/2+12,3))^^
      (mag/2+12,0)--(mag,0);
    cccc(pic,s,g,orig,mag,ang,2d,p);}}

void impedance(picture pic=currentpicture, Label s="", explicit pair orig,
              explicit pair dest, pair d=N, pen p=currentpen) {
  impedance(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void diode(picture pic=currentpicture, Label s="", explicit pair orig,
              real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag > 7) {
    path[] g=(0,0)--(mag/2-3.5,0)^^(mag/2-3.5,-4)--(mag/2-3.5,4)--(mag/2+3.5,0)
      --cycle^^(mag/2+3.5,-3)--(mag/2+3.5,3)^^(mag/2+3.5,0)--(mag,0);
    cccc(pic,s,g,orig,mag,ang,2d,p);}}

void diode(picture pic=currentpicture, Label s="", explicit pair orig,
              explicit pair dest, pair d=N, pen p=currentpen) {
  diode(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

void LED(picture pic=currentpicture, Label s="", explicit pair orig,
              real mag, real ang, pair d=N, pen p=currentpen) {
  if (mag > 7) {
    path[] g=(0,0)--(mag/2-3.5,0)^^(mag/2-3.5,-4)--(mag/2-3.5,4)--(mag/2+3.5,0)
      --cycle^^(mag/2+3.5,-3)--(mag/2+3.5,3)^^(mag/2+3.5,0)--(mag,0);
    cccc(pic,s,g,orig,mag,ang,2d,p);
    g=(0,0)--(4.3,4.3)^^(2.5,3.9)--(4.3,4.3)--(3.9,2.5);
    draw(pic,shift(orig)*rotate(ang)*shift(mag/2-2,7)*g,p);
    draw(pic,shift(orig)*rotate(ang)*shift(mag/2+1,5)*g,p);}}

void LED(picture pic=currentpicture, Label s="", explicit pair orig,
              explicit pair dest, pair d=N, pen p=currentpen) {
  LED(pic,s,orig,length(dest-orig),degrees(dest-orig),d,p);}

guide boxy(pair o=(0,0),real dx, real dz) {
  return o--o+dx*dir(30)--o+dx*dir(30)+(0,dz)--o+(0,dz)--cycle;}
guide boxz(pair o=(0,0),real dx, real dy) {
  return o--o+dx*dir(30)--o+dx*dir(30)+dy*dir(150)--o+dy*dir(150)--cycle;}
guide boxx(pair o=(0,0),real dy, real dz) {
  return o--o+dy*dir(150)--o+dy*dir(150)+(0,dz)--o+(0,dz)--cycle;}

pair isometric(real x, real y, real z) {return x*dir(210)+y*dir(-30)+(0,z);}
