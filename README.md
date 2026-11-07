<div align="center">
<h1> <b>[CVPR 2025 Highlight]</b> <br> GigaHands: A Massive Annotated Dataset of Bimanual Hand Activities </h1>
<a href="https://ivl.cs.brown.edu/research/gigahands.html"><img src="https://img.shields.io/badge/Project_Page-green" alt="Project Page"></a>
<a href="https://www.arxiv.org/abs/2412.04244" target="_blank" rel="noopener noreferrer"> <img src="https://img.shields.io/badge/Paper-VGGT" alt="Paper PDF"></a>
<a href="https://ivl.cs.brown.edu/assets/images/projects/gigahands/gigahands_explain.mp4"> <img src="https://img.shields.io/badge/Demo-blue" alt="Demo"></a>

**[Brown IVL](https://ivl.cs.brown.edu/)**
<p>
    <a href="https://freddierao.github.io/">Rao Fu<sup>*</sup></a>
    ·
    <a href="https://kristen-z.github.io/">Dingxi Zhang<sup>*</sup></a>   
    ·
    <a href="https://www.alex-jiang.com/about/">Alex Jiang</a> 	 
    ·
    <a href="https://wanjia-fu.com/">Wanjia Fu</a>          
    ·
    <a href="https://austin-funk.github.io/">Austin Funk</a> 
    ·
    <a href="https://dritchie.github.io/">Daniel Ritchie</a> 
    ·
    <a href="https://cs.brown.edu/people/ssrinath/">Srinath Sridhar</a>
</p>

<img src="./assets/teaser.jpg" alt="[Teaser Figure]" style="zoom:80%;" />
</div>

## 📢 Updates

- [2026/11/07] 🤗 **The full GigaHands dataset is now hosted on Hugging Face: [freddie007/GigaHands](https://huggingface.co/datasets/freddie007/GigaHands)**. It includes hand poses, object poses and meshes, multiview RGB videos (1.06 TB), text annotations, demo data, and checkpoints. All download links below now point there. See the [dataset card](https://huggingface.co/datasets/freddie007/GigaHands) for the file layout and download recipes.

- [2025/09/04] For full **object poses**, see [`object_poses/`](https://huggingface.co/datasets/freddie007/GigaHands/tree/main/object_poses). There are a total of 3.3k object motion sequences. Object meta annotation is provided in [`object_meta/scene_wise_round1/`](https://huggingface.co/datasets/freddie007/GigaHands/tree/main/object_meta/scene_wise_round1). Please checkout the [README_object](README_object.md) for usage. 
- [2025/07/21] We provide [hand-object mesh visualizer](./render_mesh_video.py). The visualizer provides hand-object temporal alignment, and camera parameter usage. 

- [2025/07/09] For **object meshes**, you can download them from [`object_meta/`](https://huggingface.co/datasets/freddie007/GigaHands/tree/main/object_meta). 

  We also provide smoother 3D hand poses that are aligned with the object coordinate system, derived from MANO parameters — included as `keypoints_3d_mano_align/` in every [`hand_poses/<session>.tar.gz`](https://huggingface.co/datasets/freddie007/GigaHands/tree/main/hand_poses).
  Note: the previously provided `keypoints_3d_mano` were also generated from MANO parameters, but have been normalized and recentered to better support motion generation training.

- [2025/04/30] For **multiview RGB videos**, see [`multiview_rgb_vids/`](https://huggingface.co/datasets/freddie007/GigaHands/tree/main/multiview_rgb_vids). There is one uncompressed `.tar` per session containing all 51 camera views. [`tar_index.csv.gz`](https://huggingface.co/datasets/freddie007/GigaHands/resolve/main/multiview_rgb_vids/tar_index.csv.gz) gives each clip's byte offset, so single clips can be fetched with HTTP range requests.

- [2025/04/02] We are pleased to release our full **hand pose** dataset, available for download from [`hand_poses/`](https://huggingface.co/datasets/freddie007/GigaHands/tree/main/hand_poses), one `.tar.gz` per session (including all `keypoints_3d`, `keypoints_3d_mano`, `keypoints_3d_mano_align`, `params` and camera parameters). 

Complete **text annotation** are available [here](https://huggingface.co/datasets/freddie007/GigaHands/resolve/main/annotations_v2.jsonl). We used the `rewritten_annotation` for model training. 

More data coming soon! 🔜

## 🗒️ Overview
Understanding bimanual human hand activities is a critical problem in AI and robotics. We cannot build large models of bimanual activities because existing datasets lack the scale, coverage of diverse hand activities, and detailed annotations. We introduce GigaHands, a massive annotated dataset capturing 34 hours of bimanual hand activities from **56 subjects** and **417 objects**, totaling **14k motion clips** derived from **183 million frames** paired with **84k text annotations**. Our markerless capture setup and data acquisition protocol enable fully automatic 3D hand and object estimation while minimizing the effort required for text annotation. The scale and diversity of GigaHands enable broad applications, including text-driven action synthesis, hand motion captioning, and dynamic radiance field reconstruction.

## 📂 Data Format

We store our dataset on Hugging Face: [freddie007/GigaHands](https://huggingface.co/datasets/freddie007/GigaHands). It was previously hosted on Globus.
### Demo Data

You can download 5 demo sequences from [here](https://huggingface.co/datasets/freddie007/GigaHands/resolve/main/demo/gigahands_demo_all.tar.gz).

<summary>Directory Structure (Click to expand)</summary>

<details>
    ```text
    gigahands_demo/
    ├── hand_pose/
    │   ├── p<participant id>-<scene>-<squence id>/
    │   │   ├── bboxes/
    │   │   ├── keypoints_2d/
    │   │   ├── keypoints_3d/
    │   │   ├── keypoints_3d_mano/
    │   │   ├── mano_vid/
    │   │   ├── params/
    │   │   ├── rgb_vid/
    │   │   │   ├── brics-odroid-<camera id>-camx/
    │   │   │       ├── xxx.mp4
    │   │   │       ├── xxx.txt
    │   │   ├── repro_2d_vid/
    │   │   ├── repro_3d_vid/
    │   │   ├── optim_params.txt
    │   ├── ...
    └── object_pose/
        ├── p<participant id>-<scene>-<squence id>/
        │   ├── mesh/
        │   ├── pose/
        │   ├── render/
        │   ├── segmentation/
        ├── ...
</details>

### Whole Dataset

The dataset directory should look like this:

```python
./dataset/GigaHands/
├── multiview_rgb_vids/
    ├── p<participant id>-<scene>/
        ├── brics-odroid-<camera id>/
            ├── brics-odroid-<camera id>_<sequence 0 timestamp>.mp4
            ├── brics-odroid-<camera id>_<sequence 1 timestamp>.mp4
            ├── ...
├── hand_poses/
    ├── p<participant id>-<scene>/
        ├── keypoints_3d/				# 3D hand keypoints (triangulate multi-view 2D keypoints.)
        ├── keypoints_3d_mano/				# 3D hand keypoints (extract from mano parms and normalized, more smooth)
        ├── keypoints_3d_mano_align/			# 3D hand keypoints (from mano params, in world coordinates, aligned with object poses)
        ├── params/					# mano parameters
        ├── optim_params.txt				# camera parameters
├── object_poses/
    ├── <scene name>
        ├── <object name>
            ├── p<participant id>-<scene>_<squence id>/
                ├── pose				# object 6DoF poses
├── object_meta/                                        # all scanned and generated meshes
    ├── <scene name>
        ├── <object name>
    ├── scene_wise_round1
        ├── <scene name>_annotated_round1.csv           # annotation for object mesh occurance, tracking success <--> scene-sequence id

└── annotations_v2.jsonl 				# text annotations
└── instruction_script.json 			# original instruction for filming
└── multiview_camera_video_map.csv      # scene-sequence id <-> multiview rgb video id mapping
```
Download with the Hugging Face CLI (`pip install -U "huggingface_hub[cli]"`), then unpack the per-session tars:

```bash
# everything except videos (~20 GB)
hf download freddie007/GigaHands --repo-type dataset --local-dir dataset/GigaHands --exclude "multiview_rgb_vids/*.tar"
cd dataset/GigaHands
for f in hand_poses/*.tar.gz; do tar -xzf "$f" -C hand_poses && rm "$f"; done

# multiview RGB videos (~1.06 TB in total). Use --include "multiview_rgb_vids/p042-gopro.tar" for selected sessions only.
hf download freddie007/GigaHands --repo-type dataset --local-dir . --include "multiview_rgb_vids/*.tar"
for f in multiview_rgb_vids/*.tar; do tar -xf "$f" -C multiview_rgb_vids && rm "$f"; done
```

Individual components: multiview RGB videos [here](https://huggingface.co/datasets/freddie007/GigaHands/tree/main/multiview_rgb_vids), hand annotations and camera parameters (including smoothed 3D hand keypoints) [here](https://huggingface.co/datasets/freddie007/GigaHands/tree/main/hand_poses), object poses [here](https://huggingface.co/datasets/freddie007/GigaHands/tree/main/object_poses), object meshes and the object mesh mapping with scene-sequence id [here](https://huggingface.co/datasets/freddie007/GigaHands/tree/main/object_meta), text annotations [here](https://huggingface.co/datasets/freddie007/GigaHands/resolve/main/annotations_v2.jsonl), the original instruction script grouped by scenario, scene, activity [here](https://huggingface.co/datasets/freddie007/GigaHands/resolve/main/instruction_script.json), scene-sequence mapping with video id meta file [here](https://huggingface.co/datasets/freddie007/GigaHands/resolve/main/multiview_camera_video_map.csv).

## Installation

This code requires:

* Python 3.8+
* conda3 or miniconda3
* CUDA capable GPU (one is enough)

1. Create a virtual environment and install necessary dependencies

```shell
conda create -n gigahands python==3.8
conda activate gigahands
conda install pytorch==2.2.0 torchvision==0.17.0 torchaudio==2.2.0 pytorch-cuda=12.1 -c pytorch -c nvidia
conda install -c conda-forge ffmpeg
pip install -r requirements.txt
```

3. Install EasyMocap

```shell
cd third-party/EasyMocap
python setup.py develop
```

4. Download [mano](https://mano.is.tue.mpg.de/download.php) models and place the `MANO_*.pkl` files under `body_models/smplh`.
5. Download the pretrained models by running `bash dataset/download_pretrained_models.sh` (or from [here](https://huggingface.co/datasets/freddie007/GigaHands/resolve/main/checkpoints/checkpoints.zip)), which should be like:

```shell
./checkpoints/GigaHands/
./checkpoints/GigaHands/GPT/			# Text-to-motion generation model
./checkpoints/GigaHands/VQVAE/ 			# Motion autoencoder
./checkpoints/GigaHands/text_mot_match/		# Motion & Text feature extractors for evaluation
```

## 🎥 Visualizations

Example use of **hand pose and object pose annotation**: After downloading hand pose, object pose and object meshes, run the script below to **visualize hand-object mesh**. 

[▶ Video demo (MP4, 211k)](visualizations/17_instruments/p003-instrument_0033/output.mp4)
```bash
python render_mesh_video.py \
    --dataset_root <data_root_path> \
    --scene_name 17_instruments \
    --session_name p003-instrument \
    --seq_id 33 \
    --object_name ukelele_scan \
    --mesh_name ukelele-simplified1_1.obj \
    --render_camera brics-odroid-011_cam0 \
    --save_root visualizations

```

You will see videos of the rendered hand-object mesh in `visualizations` directory.
<img src='visualizations/17_instruments/p003-instrument_0033/output.gif' width=480>


Example use for **text-hand annotations**. Visualizer below is customized for training text-hand models. 

```bash
python visualize_hands.py
```

You will see videos of the MANO render results and reprojected keypoints in the `visualizations` directory.


Example use for **multi-view videos**. Visualizer below is customized for **multiview video loading**. 

```bash
python multiview_videoloader.py \
    --video_root_dir <your-path-to-multiview_rgb_vids> \
    --session <session name, i.e. p001-folder> \
    --seqid <sequence id, i.e. 17> \
    --out_dir <your-path-to-hand_poses (which contains optim_params.txt)>
```

You will see 3 concatenated frames from multi-views from targeted session and sequence id under the `visualizations` directory.


## 🚀 Inference - text2motion

Sampling results from customized descriptions:

```bash
python gen_motion_custom.py --resume-pth ./checkpoints/GigaHands/VQVAE/net_last.pth --resume-trans ./checkpoints/GigaHands/GPT/net_best_fid.pth --input-text ./input.txt
```

## 🏋️ Training - text2motion

The results are saved in the folder `output`.

**Training motion VQ-VAE**:

```bash
python3 train_vq_hand.py \
--batch-size 256 \
--lr 2e-4 \
--total-iter 300000 \
--lr-scheduler 200000 \
--nb-code 512 \
--down-t 2 \
--depth 3 \
--dilation-growth-rate 3 \
--out-dir output \
--dataname GigaHands \
--vq-act relu \
--quantizer ema_reset \
--loss-vel 0.5 \
--recons-loss l1_smooth \
--exp-name VQVAE \
--window-size 128
```

**Training T2M GPT model**:

```bash
python3 train_t2m_trans_hand.py  \
--exp-name GPT \
--batch-size 128 \
--num-layers 9 \
--embed-dim-gpt 1024 \
--nb-code 512 \
--n-head-gpt 16 \
--block-size 51 \
--ff-rate 4 \
--drop-out-rate 0.1 \
--resume-pth output/VQVAE/net_last.pth \
--vq-name VQVAE \
--out-dir output \
--total-iter 300000 \
--lr-scheduler 150000 \
--lr 0.0001 \
--dataname GigaHands \
--down-t 2 \
--depth 3 \
--quantizer ema_reset \
--eval-iter 10000 \
--pkeep 0.5 \
--dilation-growth-rate 3 \
--vq-act relu \
```

## Checklist

- [x] Release demo data
- [x] Release hand pose data
- [x] Release multi-view video data
- [x] Release object pose data (3.3k) and meshes
- [x] Release hand-object-motion and meshes correspondence file
- [x] Release inference code for text-to-motion task
- [x] Release training code for text-to-motion task

## Citation

If you find our work useful in your research, please cite:

```
@inproceedings{fu2025gigahands,
  title={Gigahands: A massive annotated dataset of bimanual hand activities},
  author={Fu, Rao and Zhang, Dingxi and Jiang, Alex and Fu, Wanjia and Funk, Austin and Ritchie, Daniel and Sridhar, Srinath},
  booktitle={Proceedings of the Computer Vision and Pattern Recognition Conference},
  pages={17461--17474},
  year={2025}
}
```

## Acknowledgement

We appreciate helps from :  

* Public code like [EasyMocap](https://github.com/zju3dv/EasyMocap), [text-to-motion](https://github.com/EricGuo5513/text-to-motion), [TM2T](https://github.com/EricGuo5513/TM2T), [MDM](https://github.com/GuyTevet/motion-diffusion-model), [T2M-GPT](https://github.com/Mael-zys/T2M-GPT) etc.
*  This research was supported by AFOSR grant FA9550-21 1-0214, NSF CAREER grant #2143576, and ONR DURIP grant N00014-23-1-2804. We would like to thank the Ope nAI Research Access Program for API support and extend our gratitude to Ellie Pavlick, Tianran Zhang, Carmen Yu, Angela Xing, Chandradeep Pokhariya, Sudarshan Harithas, Hongyu Li, Chaerin Min, Xindi Qu, Xiaoquan Liu, Hao Sun, Melvin He and Brandon Woodard.

## License

GigaHands is released under the Creative Commons Attribution-NonCommercial 4.0 International License.  See the [LICENSE](https://creativecommons.org/licenses/by-nc/4.0/) file for details.

[![CC BY-NC 4.0](https://licensebuttons.net/l/by-nc/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc/4.0/)

