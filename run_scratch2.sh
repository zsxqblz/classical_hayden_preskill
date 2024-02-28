#!/bin/zsh
#SBATCH --job-name=2D
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=20G         # memory per cpu-core (4G is default)
#SBATCH --time=23:59:59          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --array=0-0
#SBATCH --mail-user=yz4281@princeton.edu

let i=8
let nAsites=i
let nBsites=100
let nsteps=500
let nstB=5
let nmeas_start=i+5
let nmeas_end=i+5
let nmeas_step=1

let id=i
let date=240226

echo $nAsites 
echo $nBsites
echo $nsteps
echo $nstB
echo $nmeas_start
echo $nmeas_end
echo $nmeas_step
echo data/${date}/${date}_n${id}_$SLURM_ARRAY_TASK_ID

julia run_scratch2.jl $nAsites $nBsites $nsteps $nstB $nmeas_start $nmeas_end $nmeas_step data/${date}/${date}_n${id}_$SLURM_ARRAY_TASK_ID