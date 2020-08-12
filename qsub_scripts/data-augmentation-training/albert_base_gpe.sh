#$ -S /bin/bash

#$ -N ALBERT_BASE_GPE
#$ -j y

#$ -l tmem=16G
#$ -l h_rt=50:00:00
#$ -l gpu=true

#$ -cwd

export PATH=/share/apps/python-3.7.2-shared/bin:${PATH}
export LD_LIBRARY_PATH=/share/apps/python-3.7.2-shared/lib:${LD_LIBRARY_PATH}

source /share/apps/examples/source_files/cuda/cuda-10.1.source

export RACE_DIR=../../../RACE
python3 ../../run_multiple_choice.py \
--task_name race \
--model_name_or_path albert-base-v2 \
--data_dir $RACE_DIR \
--max_seq_length 512 \
--per_gpu_eval_batch_size=4 \
--per_gpu_train_batch_size=4 \
--output_dir ../../output/albert_base-gpe \
--do_train \
--learning_rate 1e-5 \
--num_train_epochs 2 \
--gradient_accumulation_steps 8 \
--perturbation_type 'GPE' \
--perturbation_num_train 2 \
--augment \
--overwrite_output_dir \
