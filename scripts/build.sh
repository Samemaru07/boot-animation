#!/bin/bash
ffmpeg -framerate 60 -i frames/frame-%04d.png \
  -c:v libx264 -crf 0 -pix_fmt yuv420p \
  boot.mp4

ffmpeg -i boot.mp4 \
  -vf "tpad=start_duration=3:color=black" \
  -c:v libx264 -crf 0 -pix_fmt yuv420p \
  boot_padded.mp4
