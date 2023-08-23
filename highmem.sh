#!/bin/bash
#SBATCH --partition=highmem
#SBATCH --qos=highmem
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mail-type=ALL          # Email user when job starts, ends and aborts
#SBATCH --mail-user=zihanwu7-c@my.cityu.edu.hk       # Email user


# matlab to run `cocluster.m`

# Path: /cm/shared/apps/maths/matlab/R2020b/bin/matlab
OUTPUT=/home/zihanwu7/scratch/ndata/result/highmem_cocluster_output.txt
cd /home/zihanwu7/scratch/ndata/
/cm/shared/apps/maths/matlab/R2020b/bin/matlab -nosplash -nodesktop -r "run('main.m');exit;" > $OUTPUT

# OUTPUT=/home/jeff/zihan/ndata/cocluster_output.txt
# cd /home/jeff/zihan/ndata/
# /home/jeff/zihan/MATLAB/bin/matlab -nosplash -nodesktop -r "run('main.m');exit;" > $OUTPUT

date >> $OUTPUT