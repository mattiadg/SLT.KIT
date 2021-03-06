#!/bin/bash

set=$1
input=$2
name=$3

model=model.pt
if [ $# -ne 3 ]; then
    model=$4
fi

if [ -z "$BASEDIR" ]; then
    BASEDIR=/
fi

if [ -z "$NMTDIR" ]; then
    NMTDIR=/opt/NMTGMinor/
fi

if [ -z "$GPU" ]; then
    GPU=0
fi

if [ -z "$BEAMSIZE" ]; then
    BEAMSIZE=1
fi


if [ $GPU == -1 ]; then
    gpu_string=""
else
    gpu_string="-gpu "$GPU
fi


mkdir -p $BASEDIR/data/$name/eval/

if [ $BEAMSIZE == 1 ]; then
    out=$BASEDIR/data/$name/eval/$set.t
else
    out=$BASEDIR/data/$name/eval/$set.beam$BEAMSIZE.t
fi

python3 -u $NMTDIR/translate.py $gpu_string \
       -model $BASEDIR/model/$name/$model \
       -src $BASEDIR/data/$input/eval/$set.scp \
       -batch_size 32 -verbose\
       -beam_size $BEAMSIZE -alpha 1.0 \
       -encoder_type audio -asr_format scp -concat 4 \
       -normalize \
       -output $out
