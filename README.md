# ESHAPE: Morphology Analysis tools
The elliptic Fourier analysis (EFA) can extract arbitrary two-dimensional curves to a series of elliptic Fourier descriptors (EFDs), which was originally proposed by Kuhl and Giardina in 1982 for object recognition of a segment in an image. As a powerful mathematical tool, EFA can provide quantitative criteria for shape analysis, classification, reconstruction, and modeling, which has been widely used in plant science, marine biology, evolutionary biology and anthropology. The procedure of GM using EFA includes contour extraction, EFDs calculation and EFD normalization. Aside from the low efficiency in outline extraction and low quantity in datasets, EFD normalization has long been a matter of trouble. None of existing normalization method can give homologous results when dealing with planar translation, scaling, rotation, symmetry, reverse, and analogous basic transformations simultaneously. Therefore, it is of great significance to improve the computational efficiency of EFA for true EFD normalization and develop a user-friendly software for organ annotation and geometric feature extraction using digital specimens.

In this study, we develop a user-friendly software ESHAPE for public service, integrating better contour extraction, efficient EFDs calculation, and true EFD normalization under all basic contour transformations.This software encompasses two parts: contour extraction and elliptic Fourier analysis. 

# Manual
[Manual](https://github.com/pdc789/ESHAPE/blob/main/Manual.pdf)

# Install

This software is developed using MATLAB 2016a and can be downloaded from the following website: https://github.com/pdc789/ESHAPE (not including "installer_ESHAPE.exe") or https://www.scidb.cn/en/anonymous/bTJRakVm (including "installer_ESHAPE.exe"). After downloading, extract all the files from 'ESHAPE.zip' into a folder named 'ESHAPE'. Two selection:

(1) For the MATLAB environment: Locate the 'ESHAPE.m' file and run it using MATLAB 2016a or later. This action will guide you to the main program interface. 

(2) For the standalone application: In cases where MATLAB 2016a or a more recent version is not already installed, an installer that includes the necessary MATLAB Runtime is provided. Locate and double-click the 'installer_ESHAPE.exe' file to generate the 'ESHAPE.exe' file. Subsequently, double-click on 'ESHAPE.exe' to launch the application.

# Code Checklist
1.Main program

ESHAPE.m   Source program of main page. ESHAPE can be run by executing this file using MATLAB 2016a or later.

ESHAPE.fig   Graphical user interface of main page.

2.Functions

Contour extraction

1)gui_chain_code_func.m   Generate chain code based on binary image.

2)code2axis.m   Convert chain code to coordinates.

3)is_completed_chain_code.m   Check whether the chain code is closed.

4)plot_chain_code.m   Plot chain code with certain color and line width. Chain code should be written in chain vector.

5)cal_area_c.m   Calculate area and circumference.

6)WriteDataToFile.m   Write data to txt.

Elliptic Fourier analysis 

7)EFA.m   Source program of "Ellipse Fourier Analysis" page that enter into from main page.

8)EFA.fig   Graphical user interface of "Ellipse Fourier Analysis" page.

9)fourier_approx_norm_modify_20231008.m   Generate position coordinates of fourier approximation of chain code.

10)calc_harmonic_coefficients_modify.m   Calculate the n-th set of four harmonic coefficients.

11)calc_dc_components_modify.m   Calculate DC (Direct Current) components.

12)calc_traversal_dist.m   Generate position coordinates of chain code. Number of harmonic elements (n), and number of points for reconstruction (m) must be specified.

13)calc_traversal_time.m   Calculate traversal time which is defined as accumulated time consumed by every component of the chain code.

14)plot_fourier_approx_modify.m   Plot the fourier approximation, given a chain code, number of harmonic elements (n), and number of points for reconstruction (m). Normalization can be applied by setting "normalized = 1".

3.Transform

15)MainDlg.m   Main program for the normalization test under basic transformations.

16)chain_code_ysysmmetry_func.m   Generate y-axis symmetric chain code.

17)chain_code_xsysmmetry_func.m   Generate x-axis symmetric chain code.

18)chain_code_starting_func.m   Generate starting point change chain code.

19)chain_code_rotatew_func.m   Generate anticlockwise rotating chain code.

20)chain_code_rotatec_func.m   Generate clockwise rotating chain code.

21)chain_code_reverse_func.m   Generate reversal chain code.


4.Source files

The codes are based on the procedure of Elliptic Fourier analysis established by Kuhl and Giardina (1982).

Copyright (c) 2011, auralius manurung.

# License
Copyright (c), IBCAS@2023,GPL-2.0
All rights reserved.
