# This gnuplot script will plot the total energy vs
# lattice constant of cubic crystals from -3 to +3 % of the
# experimental value 5.4307 Angstrom
# Written by: Rajendra Adhikari, Department of Physics,
# Kathmandu University, Kavre, Nepal
# Date: 17th July, 2020
# please do NOT remove above copyright notice.


# set terminal type
set term postscript enhanced color 'Helvetica-Bold,16'
set output 'ecut.ps'
xmin=40.0
xmax=110.
# ymin=-93.454
# ymax=-93.450
set xr [xmin : xmax]
# set yr [ymin : ymax]
set xl 'Kinetic energy cutoff (Ry)'
set yl 'Total energy (Ry)'
set format y '%9.3f'
set key top center
# defining line styles
set style line 1 lt 1 lw 3 pt 6 ps 2 lc rgb 'blue'

plot 'etot.dat' u 1:2 w lp noti ls 1,\
set output
! ps2pdf ecut.ps
! rm ecut.ps
