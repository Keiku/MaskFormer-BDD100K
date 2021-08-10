# docker build
docker-compose up -d dev

# docker run
docker run --gpus all --ipc=host --rm -it \
       -v /home/keiichi.kuroyanagi/lost+found/clones/Study-MaskFormer/:/Study-MaskFormer/ \
       -v /home/keiichi.kuroyanagi/lost+found/datasets/ADE20K/ADEChallengeData2016/:/Study-MaskFormer/datasets/ADEChallengeData2016/ \
       -u (id -u):(id -g) \
       -e HOSTNAME=(hostname) \
       -e HOME=/home/docker \
       --workdir /Study-MaskFormer \
       --ipc host \
       mask-former
