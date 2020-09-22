#!/bin/bash

python3 datasets/load_harmonic_video.py --save_folder=/content/drive/My\ Drive/datasets/loaded_harmonic
python3 datasets/load_div2k.py --save_folder=/content/drive/My\ Drive/datasets/loaded_div2k

python3 datasets/prepare_dataset.py --video_folder=/content/drive/My\ Drive/datasets/loaded_harmonic --dataset_folder=/content/drive/My\ Drive/datasets/train --type=blocks --temporal_radius=1 --frames_per_scene=2 --block_size=36 --stride=36 --crop --scene_changes=/content/drive/My\ Drive/datasets/scene_changes_harmonic.json --block_min_std=20.0
python3 datasets/prepare_div2k_dataset.py --div2k_folder=/content/drive/My\ Drive/datasets/loaded_div2k/train --dataset_folder=/content/drive/My\ Drive/datasets/train_div2k --type=blocks --temporal_radius=1 --block_size=36 --stride=36
python3 datasets/prepare_div2k_dataset.py --div2k_folder=/content/drive/My\ Drive/datasets/loaded_div2k/test --dataset_folder=/content/drive/My\ Drive/datasets/test_div2k --type=full --temporal_radius=1

mkdir /content/drive/My\ Drive/datasets/train_merged
cat /content/drive/My\ Drive/datasets/train_div2k/dataset.tfrecords /content/drive/My\ Drive/datasets/train/dataset.tfrecords > /content/drive/My\ Drive/datasets/train_merged/dataset.tfrecords
echo $(($(sed -n 1p /content/drive/My\ Drive/datasets/train/dataset_info.txt) + $(sed -n 1p /content/drive/My\ Drive/datasets/train_div2k/dataset_info.txt))) > /content/drive/My\ Drive/datasets/train_merged/dataset_info.txt
tail -n +2 /content/drive/My\ Drive/datasets/train/dataset_info.txt >> /content/drive/My\ Drive/datasets/train_merged/dataset_info.txt
