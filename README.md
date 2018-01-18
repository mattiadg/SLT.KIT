# SLT.KIT

This repository contains a Spoken Language Translation System. It can be used to translate the output of an Automatic Speech Recognition (ASR) system. The system contains of an monolingual translation system that adds punctuation marks to the output of the ASR system. Furthermore, it recases the output. Then the output is translated by an machine translation system system. The system can be used to train such system as well as pre-trained systems are availabel. The systems can be trained and used by installing the docker container.

The system uses the following software:
* [OpenNMT-py](https://github.com/OpenNMT/OpenNMT-py)
* [Moses](http://www.statmt.org/moses/)
* [Subword NMT](https://github.com/rsennrich/subword-nmt)
* [Translation error rate](http://www.cs.umd.edu/%7Esnover/tercom/)
* [BEER](https://github.com/stanojevic/beer)
* [CharacTER](https://github.com/rwth-i6/CharacTER)


Requirements:
* [Docker](https://www.docker.com/)

## Installation ##

```bash
	git clone https://github.com/jniehues-kit/SLT.KIT.git
	cd SLT.KIT
	docker build -t slt.kit -f Dockerfile.ST-Baseline .
```

## Run ##


* Starting the docker container (e.g. source language English (en) and target language German (de))


```bash
	docker run -ti --rm --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=$gpuid slt.kit
	export sl=en
	export tl=de
```

* Within a docker container

  1 Training a model or download pre-trained model
    * Training a model

```bash
	/opt/SLT.KIT/systems/${model}/Train.sh
```

    * Download a pre-trained model


```bash
	/opt/SLT.KIT/systems/${model}/Download.sh
```



  2 Translate test set

```bash
	/opt/SLT.KIT/systems/${model}/Translate.sh $testset
```




where $model can be:
* smallTED

and $testset can be:
* dev2010
* tst2010
* tst2013
* tst2014
* tst2015


## Models ##


### small TED ###

SLT model trained only on the [TED corpus] (https://wit3.fbk.eu/)

Peformance:

| SET | BLEU | TER | BEER | CharacTER | BLEU(ci) | TER(ci) |
| --- | ---- | --- | ---- | --------- | -------- | ------- |
| dev2010 | 14.46 | 70.98 | 46.61 | 83.77 | 15.42 | 69.00 |
| dev2010 (manual Transcript) | 23.45 | 56.74 | 54.44 | 56.77 | 25.03 | 55.17 |
| tst2010 | 10.41 | 76.53 | 36.15 | 318.59 | 11.04 | 74.96 |
| tst2010 (manual Transcript) | 24.81 | 55.66 | 53.34 | 55.85 | 26.41 | 54.04 |
| tst2013 | 13.91 | 71.71 | 44.54 | 80.07 | 14.81 | 69.60 |
| tst2013 (manual Transcript) | 26.05 | 54.27 | 54.34 | 54.22 | 27.49 | 52.98 |
| tst2014 | 13.24 | 72.34 | 43.78 | 83.44 | 14.03 | 70.57 |
| tst2014 (manual Transcript) | 22.31 | 58.36 | 51.85 | 57.66 | 23.18 | 57.44 |
| tst2015 | 13.03 | 83.20 | 43.66 | 74.03 | 13.75 | 81.30 |
| tst2015 (manual Transcript) | 25.07 | 57.76 | 53.10 | 54.77 | 26.06 | 56.81 |


