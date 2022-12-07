# docker-zellkonverter

[![gh-actions-build-status](https://github.com/royfrancis/docker-zellkonverter/workflows/build/badge.svg)](https://github.com/royfrancis/docker-zellkonverter/actions?workflow=build) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/royfrancis/zellkonverter?label=dockerhub)](https://hub.docker.com/repository/docker/royfrancis/zellkonverter)

This is a docker image built on top of the [zellkonverter](https://github.com/theislab/zellkonverter) R package to convert single-cell AnnData objects to SingleCellExperiment (SCE) class objects.

Run this in a directory containing **file.h5ad**. The output file will be **sce.Rds**.

```
docker run --rm --user "$(id -u):$(id -g)" -v ${PWD}:/zell/work royfrancis/zellkonverter:1.8
```

2022 • Roy Francis
