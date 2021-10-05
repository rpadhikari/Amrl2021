# Amrl2021
This repo contains information and tutorials for workshop QE and Gamess. 
Please stay tuned for more information to be added soon. 
To download all the contents of this repo please issue the following command on the storage0 folder of the Supercomputer.

git clone https://github.com/rpadhikari/Amrl2021.git

After the successful download please issue the series of following commands:
1) cd QuantumEspresso/
# Optimizing the lattice constant of Si crystal (in Diamond crystal structire, inteeleaved FCC)
2) cd alat  
3) chmod a+x alat.sh   # change the file permission to run
4) sbatch run.slurm    # submit the job on Supercomputer
5) squeue              # monitor the job status
6) module load gnuplot/4.6.7   # loads the module gnuplot
7) gnuplot spline.plot         # generates the cubic spline fitting 
8) gnuplot alat.plot           # plots the total energy vs lattice constant
# copy the plot to your local machine and open using Adobe reader
# Identify the lattice value corresponding to minimum energy.

-Rajendra Adhikari
