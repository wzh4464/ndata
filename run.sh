#!/bin/bash
#SBATCH --partition=batch         # Partition (job queue)
#SBATCH --nodes=1                # 1 computer nodes
#SBATCH --ntasks=1               # 1 task per node
#SBATCH --mem=40GB               # Request 30GB memory
#SBATCH --time=0-01:00:00        # Time limit day-hrs:min:sec
#SBATCH --output=run.out         # Standard output 
#SBATCH --error=run.err          # Error log


# matlab to run `indices_script.m`

# Path: /cm/shared/apps/maths/matlab/R2020b/bin/matlab
# OUTPUT=/home/zihanwu7/scratch/ndata/output.txt
OUTPUT=/home/jeff/zihan/ndata/output.txt

# cd /home/zihanwu7/scratch/ndata/
# /cm/shared/apps/maths/matlab/R2020b/bin/matlab -nodisplay -nosplash -nodesktop -r "run('indices_script.m');exit;" >> $OUTPUT
cd /home/jeff/zihan/ndata/
/home/jeff/zihan/MATLAB/bin/matlab -nodisplay -nosplash -nodesktop -r "run('indices_script.m');exit;" >> $OUTPUT

date >> $OUTPUT

