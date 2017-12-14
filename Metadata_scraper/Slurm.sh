#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=20:00:00
#SBATCH --partition=largemem
#SBATCH --account=alzgen
 
module load anaconda3

./metadata.sh
