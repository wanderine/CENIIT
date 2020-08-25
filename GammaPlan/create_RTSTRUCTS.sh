#!/bin/bash

# conda activate nnUNetDicom

gzip 18975_tumor_mask_isotropic_256cube.nii

gzip 18975_finger_256cube.nii

gzip 18975_foot_256cube.nii

gzip 18975_lips_256cube.nii

python3.7 convert_to_RTSTRUCT.py 18975_tumor_mask_isotropic_256cube.nii.gz dicom/ dicom_RTSTRUCT/ Tumor

python3.7 convert_to_RTSTRUCT.py 18975_finger_256cube.nii.gz dicom/ dicom_RTSTRUCT/ Finger

python3.7 convert_to_RTSTRUCT.py 18975_foot_256cube.nii.gz dicom/ dicom_RTSTRUCT/ Foot

python3.7 convert_to_RTSTRUCT.py 18975_lips_256cube.nii.gz dicom/ dicom_RTSTRUCT/ Lips




