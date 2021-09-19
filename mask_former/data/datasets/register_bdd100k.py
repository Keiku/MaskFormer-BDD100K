# Copyright (c) Facebook, Inc. and its affiliates.
import os

from detectron2.data import DatasetCatalog, MetadataCatalog
from detectron2.data.datasets import load_sem_seg

BDD100K_SEM_SEG_CATEGORIES = [
    {"name": "direct", "id": 0, "trainId": 0},
    {"name": "alternative", "id": 1, "trainId": 1},
    {"name": "background", "id": 2, "trainId": 2},
]


def _get_bdd100k_meta():
    # Id 0 is reserved for ignore_label, we change ignore_label for 0
    # to 255 in our pre-processing, so all ids are shifted by 1.
    stuff_ids = [k["id"] for k in BDD100K_SEM_SEG_CATEGORIES]
    assert len(stuff_ids) == 3, len(stuff_ids)

    # For semantic segmentation, this mapping maps from contiguous stuff id
    # (in [0, 91], used in models) to ids in the dataset (used for processing results)
    stuff_dataset_id_to_contiguous_id = {k: i for i, k in enumerate(stuff_ids)}
    stuff_classes = [k["name"] for k in BDD100K_SEM_SEG_CATEGORIES]

    ret = {
        "stuff_dataset_id_to_contiguous_id": stuff_dataset_id_to_contiguous_id,
        "stuff_classes": stuff_classes,
    }
    return ret


def register_all_bdd100k(root):
    root = os.path.join(root, "bdd100k")
    meta = _get_bdd100k_meta()
    for name, dirname in [("train", "train"), ("val", "val")]:
        image_dir = os.path.join(root, "images_detectron2", dirname)
        gt_dir = os.path.join(root, "annotations_detectron2", dirname)
        name = f"bdd100k_sem_seg_{name}"
        DatasetCatalog.register(
            name, lambda x=image_dir, y=gt_dir: load_sem_seg(y, x, gt_ext="png", image_ext="jpg")
        )
        MetadataCatalog.get(name).set(
            stuff_classes=meta["stuff_classes"][:],
            image_root=image_dir,
            sem_seg_root=gt_dir,
            evaluator_type="sem_seg",
            ignore_label=2,
        )


_root = os.getenv("DETECTRON2_DATASETS", "datasets")
register_all_bdd100k(_root)
