#!/bin/bash
#SBATCH --job-name=dc_linear
#SBATCH --time=24:00:00
#SBATCH --partition=normal
#SBATCH --mem=20G
#SBATCH --array=1-101
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -o dc_lin_out_%A_%a.txt
#SBATCH -e dc_lin_err_%A_%a.txt
#SBATCH --mail-user=narayan.subramaniyam@tuni.fi
#SBATCH --mail-type=END

module load teflon
module load matlab
srun matlab_multithread -nosplash -r "run_multivar_entropy($SLURM_ARRAY_TASK_ID); exit(0)"
