# ADE20k Scene Parsing

# Scene Parsing
# download from MIT Scene Parsing Benchmark http://sceneparsing.csail.mit.edu/
wget http://data.csail.mit.edu/places/ADEchallenge/ADEChallengeData2016.zip
wget http://data.csail.mit.edu/places/ADEchallenge/release_test.zip
unzip ADEChallengeData2016.zip
unzip release_test.zip
mv release_test ADEChallengeData2016/

# annotations_instance
wget http://sceneparsing.csail.mit.edu/data/ChallengeData2017/annotations_instance.tar
tar -xvf annotations_instance.tar

# run prepare_ade20k_sem_seg.py and prepare_ade20k_pan_seg.py
cd /home/keiichi.kuroyanagi/lost+found/clones/Study-MaskFormer
# for fish shell
set DETECTRON2_DATASETS '/home/keiichi.kuroyanagi/lost+found/datasets/ADE20K/ADEChallengeData2016'
python datasets/prepare_ade20k_sem_seg.py
python datasets/prepare_ade20k_pan_seg.py
