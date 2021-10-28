#! /usr/bin/python3
from vpython import *
scene = canvas(title = '<h1>Bola numa mesa que oscila</h1>', center=vec(0,3,0),
               forward=vec(0.5,0,-1), autoscale=0, range=7)
scene.caption = """
Carregue no botão direito e desloque o rato para rodar o sistema.
Para ver mais de perto ou longe, carregue no botão do meio e desloque
o rato, ou use a roda do rato.
Para deslocar o sistema, use a tecla Shift em simultâneo com o botão do lado
esquerdo e desloque o rato."""
bola = sphere (pos=vec(0,5,0), radius=0.4, color=color.red)
mesa = box (pos=vec(0,0,0), size=vec(5,0.5,5), color=color.blue)
(alfa, beta, omega) = (0.9, 0.28, 8);
(g, dt, v, fase) = (-9.8, 0.01, 0, 0)
while True:
    rate(100)
    bola.pos.y += v*dt
    ym = beta*sin(fase)
    vm = beta*omega*cos(fase)
    if (v < vm) and (bola.pos.y < (ym + bola.radius)):
        bola.pos.y = ym + bola.radius
        v = (1 + alfa)*vm - alfa*v
    else: v += g*dt
    mesa.pos.y = ym - 0.25
    fase += omega*dt
    if fase > 2*pi: fase -= 2*pi
