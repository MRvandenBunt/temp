#!/bin/bash

for aSub in sn*
do

    echo "WORKING ON $aSub"

    cp -r stim_times/$aSub
    cd $aSub

    afni_proc.py -subj_id ${aSub} -script SH_${aSub}_pid.tcsh -out_dir ${aSub}.pidSH \
		-dsets func/sn*_?_*.nii.gz  \
		-blocks tshift align tlrc volreg blur mask scale regress \
		-copy_anat anat/*MPRAGE*.nii.gz \
		-anat_has_skull yes \
		-tcat_remove_first_trs 4 \
		-volreg_align_e2a -volreg_tlrc_warp \
		-tlrc_opts_at -init_xform AUTO_CENTER \
		-align_opts_aea -ginormous_move \
		-tshift_opts_ts -tpattern alt+z2 \
		-blur_size 8 -volreg_align_to MIN_OUTLIER  \
		-regress_stim_times stim_times/timing-* \
		-regress_stim_labels c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 \
		-regress_local_times \
		-regress_est_blur_epits \
		-regress_est_blur_errts \
		-regress_basis 'GAM' \
		-regress_censor_outliers 0.1 \
		-regress_censor_motion 0.3 \
		-regress_reml_exec \
		-regress_opts_3dD \
		-num_glt 17 \
		-gltsym 'SYM: +c1' -glt_label 1 'aud_word_mis1' \
		-gltsym 'SYM: +c2' -glt_label 2 'vis_word_mis1' \
		-gltsym 'SYM: +c3' -glt_label 3 'aud_psw_mis1' \
		-gltsym 'SYM: +c4' -glt_label 4 'vis_psw_mis1' \
		-gltsym 'SYM: +c5' -glt_label 5 'aud_word_match' \
		-gltsym 'SYM: +c6' -glt_label 6 'vis_word_match' \
		-gltsym 'SYM: +c7' -glt_label 7 'picture_cue' \
		-gltsym 'SYM: +c8' -glt_label 8 'vis_sem-rel_mis' \
		-gltsym 'SYM: +c9' -glt_label 9 'vis_cstring_mis' \
    -gltsym 'SYM: +c1' -glt_label 10 'aud_word_mis2' \
    -gltsym 'SYM: +c2' -glt_label 11 'vis_word_mis2' \
    -gltsym 'SYM: +c3' -glt_label 12 'aud_psw_mis2' \
    -gltsym 'SYM: +c4' -glt_label 13 'vis_psw_mis2' \

		-jobs 12 -rout \
		-bash -execute

	cd ../
done
