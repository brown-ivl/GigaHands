echo -e "Downloading pretrained models in `checkpoints` folder."
wget https://huggingface.co/datasets/freddie007/GigaHands/resolve/main/checkpoints/checkpoints.zip
rm -rf checkpoints

unzip checkpoints.zip
echo -e "Cleaning\n"
rm checkpoints.zip

echo -e "Downloading done!"
