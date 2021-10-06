#!/bin/bash
#SBATCH -J Phonon        # Job name
#SBATCH -p normal        # name of partition for QE calculation
#SBATCH -o job.%j.out    # Name of stdout output file (%j expands to jobId)
#SBATCH -N 1             # Total number of nodes requested
#SBATCH -n 16            # Total number of mpi tasks requested
#SBATCH -t 00:30:00      # Run time (hh:mm:ss)

# load needed modules
module load qe/6.7

# run the calculation
mpirun -np 16 pw.x -nk 4 -npw 4 -inp scf.in > scf.out
mpirun -np 16 ph.x -nk 4 -npw 4 -inp ph.in > ph.out
mpirun -np 4 q2r.x < q2r.in > q2r.out
mpirun -np 8 matdyn.x < dos.in > dos.out
mpirun -np 8 matdyn.x < band.in > band.out

