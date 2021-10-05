#!/bin/bash
#SBATCH -J K-points      # Job name
#SBATCH -p normal        # name of partition for QE calculation
#SBATCH -o job.%j.out    # Name of stdout output file (%j expands to jobId)
#SBATCH -N 1             # Total number of nodes requested
#SBATCH -n 4             # Total number of mpi tasks requested
#SBATCH -t 02:00:00      # Run time (hh:mm:ss)

# load needed modules
module load qe/6.7

# run the calculation
./kpoints.sh
