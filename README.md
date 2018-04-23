# IVUS image preprocessing and segmentation

Lucas Daniel Lo Vercio

Pladema Institute (Facultad de Ciencias Exactas, UNCPBA, Tandil, Argentina) and CONICET (Consejo Nacional de Investigaciones Científicas y Técnicas, Argentina)

Supervised by Mariana del Fresno and Ignacio Larrabide

## Introduction
This toolbox provides processing for 20 MHz IVUS images, particularly enhancement for lumen, vessel wall and sourrounding tissues (LoVercio2016), and classification of morphological structures (LoVercio2017). These are necessary steps for lumen-intima and media-adventicia segmentation.

Lumen-intima and media-adventitia segmentation publication is under review.

## License

MIT License

Copyright 2017 Lucas D. Lo Vercio

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Lumen and background classification

functionGetScoreMaps.m

Returns the pixel classification for Lumen and Background of an IVUS image in polar coordinates.

### Citing

Lucas Lo Vercio, José Ignacio Orlando, Mariana del Fresno, y Ignacio Larrabide. Assessment of image features for vessel wall segmentation in intravascular ultrasound images. International Journal of Computer Assisted Radiology and Surgery, 2016. ISSN 1861-6429.

https://link.springer.com/article/10.1007/s11548-015-1345-4

```
@article{LoVercio2016,
author={Lo Vercio, Lucas and Orlando, Jos{\'e} Ignacio and del Fresno, Mariana and Larrabide, Ignacio},
title={Assessment of image features for vessel wall segmentation in intravascular ultrasound images},
journal={International Journal of Computer Assisted Radiology and Surgery},
issn={1861-6429},
year={2016},
volume={11},
number={8},
pages={1397--1407},
}
```

## Morphological structures classification

functionMarkStructures.m

Returns the presence of shadow, echogenic plaque or bifurcations in each column of an IVUS image in polar coordinates.

### Citing

Lucas Lo Vercio, Mariana del Fresno, y Ignacio Larrabide. Detection of morphological structures for vessel wall segmentation in IVUS using random forests. In 12th International Symposium on Medical Information Processing and Analysis. 2017.

https://www.spiedigitallibrary.org/conference-proceedings-of-spie/10160/1/Detection-of-morphological-structures-for-vessel-wall-segmentation-in-IVUS/10.1117/12.2255748.short?SSO=1

```
@inproceedings{LoVercio2017,
author={Lo Vercio, Lucas and del Fresno, Mariana and Larrabide, Ignacio},
title={Detection of morphological structures for vessel wall segmentation in IVUS using Random Forests},
booktitle={Proc. SPIE 10160, 12th International Symposium on Medical Information Processing and Analysis},
year = {2017}
}
```

There are also some third party libraries included in our code. If you use it, please cite:

**Color map CoolWarmUChar257.csv provided by Kenneth Moreland:** Diverging Color Maps for Scientific Visualization. Kenneth Moreland. In Proceedings of the 5th International Symposium on Visual Computing, December 2009. DOI 10.1007/978-3-642-10520-3_9.

**Sample IVUS images provided by Simone Balocco:** Simone Balocco et al. Standardized evaluation methodology and reference database for evaluating IVUS image segmentation. Comput Med Imaging Graph, 38(2):70-90, 2014.

## Lumen-intima and media-adventitia segmentation

Submitted