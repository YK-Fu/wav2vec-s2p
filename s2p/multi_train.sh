PREFIX=w2v_unsup_gan_xp
TASK_DATA=/work/yukuanfu88/uasr_wav2vec/u-s2p/audio/large_clean/precompute_pca512_cls128_mean_pooled
TEXT_DATA=/work/yukuanfu88/uasr_wav2vec/u-s2p/text/voxpopuli_trans/phones
KENLM_PATH=/work/yukuanfu88/uasr_wav2vec/u-s2p/text/voxpopuli_trans/phones/lm.phones.filtered.06.bin
export HYDRA_FULL_ERROR=1

PYTHONPATH=$FAIRSEQ_ROOT PREFIX=$PREFIX fairseq-hydra-train \
    -m --config-dir config/gan \
    --config-name w2vu \
    task.data=${TASK_DATA} \
    dataset.num_workers=0 \
    task.text_data=${TEXT_DATA} \
    task.kenlm_path=${KENLM_PATH} \
    common.user_dir=${FAIRSEQ_ROOT}/examples/wav2vec/unsupervised \
    model.code_penalty=2,4 model.gradient_penalty=1.5,2.0 \
    model.smoothness_weight=0.5,0.75,1.0  \
    distributed_training.distributed_world_size=1 'common.seed=range(0,5)' \
    optimization.max_update=150000 \
    +description="large_noisy_wiki_3_test"
