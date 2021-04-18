#PBS -N jgpcr-eq
#PBS -q q0002
#PBS -l select=2

cd $PBS_O_WORKDIR
. /home/g0002/share/gromacs/gromacs-2016.3/bin/GMXRC

export OMP_NUM_THREADS=5


cnt=1
cntmax=6

while [ ${cnt} -le ${cntmax} ]
do
pcnt=`expr ${cnt} - 1`
    if [ ${cnt} -eq 1 ]; then
      gmx grompp -f step6.${cnt}_equilibration.mdp -o step6.${cnt}_equilibration.tpr -c step6.${pcnt}_minimization.gro -r step5_charmm2gmx.pdb -n index.ndx -p topol.top -maxwarn -1
      aprun -n 16 -d 5 -N 8 -S 4 -j 1 -cc depth gmx_mpi mdrun -v -deffnm step6.${cnt}_equilibration
    else
      gmx grompp -f step6.${cnt}_equilibration.mdp -o step6.${cnt}_equilibration.tpr -c step6.${pcnt}_equilibration.gro -r step5_charmm2gmx.pdb -n index.ndx -p topol.top -maxwarn -1
      aprun -n 16 -d 5 -N 8 -S 4 -j 1 -cc depth gmx_mpi mdrun -v -deffnm step6.${cnt}_equilibration
    fi
    cnt=`expr ${cnt} + 1`
done
