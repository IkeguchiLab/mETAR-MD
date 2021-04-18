#PBS -N jgpcr
#PBS -q q0002
#PBS -l select=2

cd $PBS_O_WORKDIR
. /home/g0002/share/gromacs/gromacs-2016.3/bin/GMXRC

export OMP_NUM_THREADS=5

gmx grompp -f step6.0_minimization.mdp -o step6.0_minimization.tpr -c step5_charmm2gmx.pdb -p topol.top -maxwarn -1

aprun -n 16 -d 5 -N 8 -S 4 -j 1 -cc depth gmx_mpi mdrun -v -deffnm step6.0_minimization
