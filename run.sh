mkdir output
cd demo/
python demo.py \
	     --config-file ../configs/ade20k-150/maskformer_R50_bs16_160k.yaml \
	     --input ../datasets/ADEChallengeData2016/release_test/testing/ADE_test_00003481.jpg ../datasets/ADEChallengeData2016/release_test/testing/ADE_test_00003482.jpg \
	     --output ../output \
	     --opts MODEL.WEIGHTS ../pretrained_models/model_final_d8dbeb.pkl
