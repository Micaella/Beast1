#!/bin/bash
#SBATCH --nodes=1               #Numero de Nós
#SBATCH --ntasks-per-node=1     #Numero de tarefas por Nó
#SBATCH --ntasks=1              #Numero de tarefas
#SBATCH --cpus-per-task=24      #Numero de threads por tarefa
#SBATCH -p nvidia_long          #Fila (partition) a ser utilizada
#SBATCH --time=05:30:00         #Altera o tempo limite do job
#SBATCH -J RNA-Seq              #Nome job
#SBATCH --exclusive             #Uso do nó de forma exclusiva

#Carregar os módulos
module load bowtie2/2.3
module load python/3.7.2
module load R/3.5.2_openmpi_2.0_gnu

#Acessa o diretório onde o script está localizado
DIR=$(pwd)
cd $DIR

#Permissão para acessar o script DESeq.R
chmod a+x $DIR/DESeq.R

SCRIPT_PYTHON=$DIR/rna-seq.py
BASE_GENOMICA=$DIR/mm9/mm9
MULTITHREAD_BOWTIE=6
INPUTS=$DIR/inputs/SRR
OUTPUTS=$DIR/outputs/
GTF=$DIR/Mus_musculus.NCBIM37.67.gtf
DESEQ=$DIR/DESeq.R

time python3 $SCRIPT_PYTHON $BASE_GENOMICA $MULTITHREAD_BOWTIE $INPUTS $OUTPUTS $GTF $DESEQ
