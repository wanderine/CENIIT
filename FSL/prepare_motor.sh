#!/bin/bash

Subject=18975

number=6

cd $Subject

unzip ${number}_finger_foot_lips.zip

cd ${number}_finger_foot_lips

fslmerge -tr bold.nii.gz * 2.5

fslroi bold.nii.gz bold_cut.nii.gz 4 180

cd ..

cp ${number}_finger_foot_lips/bold_cut.nii.gz motor.nii.gz
