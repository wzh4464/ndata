#!/bin/bash
#SBATCH --partition=tiny         # Partition (job queue)
#SBATCH --nodes=1                # 1 computer nodes
#SBATCH --ntasks=1               # 1 task per node
#SBATCH --mem=40GB               # Request 30GB memory
#SBATCH --time=0-01:00:00        # Time limit day-hrs:min:sec
#SBATCH --error=run.err          # Error log
#SBATCH --output=run.out         # Output log
#SBATCH --mail-type=ALL          # Email user when job starts, ends and aborts
#SBATCH --mail-user=zihanwu7-c@my.cityu.edu.hk       # Email user


# matlab to run `cocluster.m`

# Path: /cm/shared/apps/maths/matlab/R2020b/bin/matlab
OUTPUT=/home/zihanwu7/scratch/cocluster_output.txt
# OUTPUT=/home/jeff/zihan/ndata/cocluster_output.txt

cd /home/zihanwu7/scratch/ndata/
/cm/shared/apps/maths/matlab/R2020b/bin/matlab -nosplash -nodesktop -r "run('cocluster.m');exit;" > $OUTPUT
# cd /home/jeff/zihan/ndata/
# /home/jeff/zihan/MATLAB/bin/matlab -nodisplay -nosplash -nodesktop -r "run('cocluster.m');exit;" >> $OUTPUT

date >> $OUTPUT
