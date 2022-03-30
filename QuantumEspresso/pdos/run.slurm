#!/bin/bash
#SBATCH -J pdos_calc      # Job name
#SBATCH -p normal        # name of partition for QE calculation
#SBATCH -o job.%j.out    # Name of stdout output file (%j expands to jobId)
#SBATCH -N 1             # Total number of nodes requested
#SBATCH -n 12             # Total number of mpi tasks requested
#SBATCH -t 00:10:00      # Run time (hh:mm:ss)

# load needed modules
module load qe/7.0

# run the calculation
mpirun -np 12 pw.x -nk 2 -npw 6 -inp scf.in > scf.out
mpirun -np 12 pw.x -nk 2 -npw 6 -inp nscf.in > nscf.out
mpirun -np 4 dos.x < dos.in > dos.out
mpirun -np 4 projwfc.x < pdos.in > pdos.out
