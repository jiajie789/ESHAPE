1.Main program
ESHAPE.m   Source program of main page. ESHAPE can be run by executing this file using MATLAB 2016a or later.
ESHAPE.fig   Graphical user interface of main page.

2.Functions

Contour extraction
1)gui_chain_code_func20221129.m   Generate chain code based on binary image.
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


5.License
Copyright (c), IBCAS@2023,GPL-2.0
All rights reserved.