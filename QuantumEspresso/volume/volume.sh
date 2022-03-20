#!/bin/bash
# This bash script will optimize the volume of Hexagonal crystals scanning 
# from -3 to +3 % of experimental volume. For testing case a=b=1.0 and c=4.0
# Written by: Rajendra Adhikari, Department of Physics,
# Kathmandu University, Kavre, Nepal
# Date: 20th March, 2022
# please do NOT remove above copyright notice.

rm -rf etot.dat stress.dat
a0 = 3.2162899971  # alat  1.0000000  0.000000000   0.00000
b0 = 3.2162899971  # blat -0.5000000  0.866025404   0.00000
c0 = 5.2399621010  # clat  0.0000000  0.000000000   1.63000
pi=3.14159265358979323846
angle=(2.0/3.0)*pi
for m in {0..24}
  do
    alat=`echo "a0*(97.0/100.0+$m*0.0025)" | bc -l`
    clat=`echo "c0*(97.0/100.0+$m*0.0025)" | bc -l`
    vol=`echo "alat*alat*clat*s(angle)" | bc -l`
cat > scf.in << EOF
&control
    calculation='scf'
    restart_mode='from_scratch'
    pseudo_dir = '../pseudo'
    outdir='./'
    disk_io='none'
    tstress=.true.
    tprnfor=.true.
/
&system
    ibrav=4
    celldm(1)=$alat
    nat=2
    ntyp=1
    nbnd=8
    ecutwfc=60.0
    occupations='fixed'
/
 &electrons
    conv_thr = 2.0d-8
    mixing_beta = 0.7
/
ATOMIC_SPECIES
  Ga  28.085  Ga.upf
  N   14.007  N.upd
ATOMIC_POSITIONS {crystal}
  Ga  0.333333333     0.666666667     0.999119997
  Ga  0.666666667     0.333333333     0.499119997
  N   0.333333333     0.666666667     0.375880003
  V   0.666666667     0.333333333     0.875880003
K_POINTS {automatic}
 8 8 2 0 0 0
EOF
mpirun -np 12 pw.x -nk 2 -npw 6 -inp scf.in > scf.out
te=`grep ! scf.out | tail -1 | awk '{print $5}'`
ft=`grep 'l fo' scf.out|awk '{print $4}'`
sxx=`grep -A1 'l   s' scf.out|tail -1|awk '{print $4}'`
echo "$alat  $sxx" >> stress.dat
echo "$alat clat $te" >> etot.dat
echo "$vol  $te" >> etot.dat
echo "$alat  $ft" >> force.dat
mv scf.in scf$m.in
mv scf.out scf$m.out
done
