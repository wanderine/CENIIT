#!/bin/bash

#Subject=17904
#Subject=18428
Subject=18975


# Create new nifti header with isotropic voxels
fslcreatehd 256 256 203 1 1 1 1 1 0 0 0 16  ${Subject}/T1_tmp.nii.gz 

# Interpolate T1 volume to get isotropic voxels
flirt -in ${Subject}/T1.nii.gz -applyxfm -init /usr/local/fsl/etc/flirtsch/ident.mat -out ${Subject}/T1_isotropic.nii.gz -paddingsize 0.0 -interp sinc -datatype float -ref ${Subject}/T1_tmp.nii.gz

# Interpolate brainmask volume to get isotropic voxels
flirt -in ${Subject}/brainmask.nii.gz -applyxfm -init /usr/local/fsl/etc/flirtsch/ident.mat -out ${Subject}/brainmask_isotropic.nii.gz -paddingsize 0.0 -interp nearestneighbour -datatype float -ref ${Subject}/T1_tmp.nii.gz 


# Interpolate tumor mask volume to get isotropic voxels
flirt -in ${Subject}/tumor_mask.nii.gz -applyxfm -init /usr/local/fsl/etc/flirtsch/ident.mat -out ${Subject}/tumor_mask_isotropic.nii.gz -paddingsize 0.0 -interp nearestneighbour -datatype float -ref ${Subject}/T1_tmp.nii.gz 



# Transform activity maps to T1 isotropic
flirt -interp sinc -in ${Subject}/motor.feat/thresh_zstat1.nii.gz -ref ${Subject}/T1_isotropic.nii.gz -applyxfm -init ${Subject}/motor.feat/reg/example_func2highres.mat  -out ${Subject}/thresh_zstat1_T1.nii.gz &

flirt -interp sinc -in ${Subject}/motor.feat/thresh_zstat2.nii.gz -ref ${Subject}/T1_isotropic.nii.gz -applyxfm -init ${Subject}/motor.feat/reg/example_func2highres.mat  -out ${Subject}/thresh_zstat2_T1.nii.gz &

flirt -interp sinc -in ${Subject}/motor.feat/thresh_zstat3.nii.gz -ref ${Subject}/T1_isotropic.nii.gz -applyxfm -init ${Subject}/motor.feat/reg/example_func2highres.mat  -out ${Subject}/thresh_zstat3_T1.nii.gz &

wait 



# Threshold activity maps

fslmaths ${Subject}/thresh_zstat1_T1.nii.gz -thr 3.1 ${Subject}/thresh_zstat1_T1.nii.gz

fslmaths ${Subject}/thresh_zstat2_T1.nii.gz -thr 3.1 ${Subject}/thresh_zstat2_T1.nii.gz

fslmaths ${Subject}/thresh_zstat3_T1.nii.gz -thr 3.1 ${Subject}/thresh_zstat3_T1.nii.gz

# Multiply activity maps with brain mask

fslmaths ${Subject}/thresh_zstat1_T1.nii.gz -mul ${Subject}/brainmask_isotropic.nii.gz ${Subject}/thresh_zstat1_T1_masked.nii.gz

fslmaths ${Subject}/thresh_zstat2_T1.nii.gz -mul ${Subject}/brainmask_isotropic.nii.gz ${Subject}/thresh_zstat2_T1_masked.nii.gz

fslmaths ${Subject}/thresh_zstat3_T1.nii.gz -mul ${Subject}/brainmask_isotropic.nii.gz ${Subject}/thresh_zstat3_T1_masked.nii.gz







#CDT=3.1

# Get smoothness and number of voxels
#text=`cat ${Subject}/motor.feat/stats/smoothness`
#temp=${text[$((0))]}
#values=()
#values+=($temp)
#SMOOTHNESS=${values[$((1))]}
#VOXELS=${values[$((3))]}

# Apply RFT cluster threshold of p = 0.05
#/usr/local/fsl/bin/cluster -i ${Subject}/zstat1_T1.nii.gz -t ${CDT} -p 0.05 -d ${SMOOTHNESS} --volume=${VOXELS} --othresh=${Subject}/thresh_zstat1_T1 -o ${Subject}/cluster_list_zstat1 --connectivity=26 --scalarname=Z 

#/usr/local/fsl/bin/cluster -i ${Subject}/zstat2_T1.nii.gz -t ${CDT} -p 0.05 -d ${SMOOTHNESS} --volume=${VOXELS} --othresh=${Subject}/thresh_zstat2_T1 -o ${Subject}/cluster_list_zstat2 --connectivity=26 --scalarname=Z 

#/usr/local/fsl/bin/cluster -i ${Subject}/zstat3_T1.nii.gz -t ${CDT} -p 0.05 -d ${SMOOTHNESS} --volume=${VOXELS} --othresh=${Subject}/thresh_zstat3_T1 -o ${Subject}/cluster_list_zstat3 --connectivity=26 --scalarname=Z 






#flirt -interp sinc -in ${Subject}/motor.feat/thresh_zstat1.nii.gz -ref ${Subject}/T1.nii.gz -applyxfm -init ${Subject}/motor.feat/reg/example_func2highres.mat  -out ${Subject}/thresh_zstat1_T1.nii.gz &

#flirt -interp sinc -in ${Subject}/motor.feat/thresh_zstat2.nii.gz -ref ${Subject}/T1.nii.gz -applyxfm -init ${Subject}/motor.feat/reg/example_func2highres.mat  -out ${Subject}/thresh_zstat2_T1.nii.gz &

#flirt -interp sinc -in ${Subject}/motor.feat/thresh_zstat3.nii.gz -ref ${Subject}/T1.nii.gz -applyxfm -init ${Subject}/motor.feat/reg/example_func2highres.mat  -out ${Subject}/thresh_zstat3_T1.nii.gz &







