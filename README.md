# ESHAPE: Morphology Analysis tools
The elliptic Fourier analysis (EFA) can extract arbitrary two-dimensional curves to a series of elliptic Fourier descriptors (EFDs), which was originally proposed by Kuhl and Giardina in 1982 for object recognition of a segment in an image. As a powerful mathematical tool, EFA can provide quantitative criteria for shape analysis, classification, reconstruction, and modeling, which has been widely used in plant science, marine biology, evolutionary biology and anthropology. The procedure of GM using EFA includes contour extraction, EFDs calculation and EFD normalization. Aside from the low efficiency in outline extraction and low quantity in datasets, EFD normalization has long been a matter of trouble. None of existing normalization method can give homologous results when dealing with planar translation, scaling, rotation, symmetry, reverse, and analogous basic transformations simultaneously. Therefore, it is of great significance to improve the computational efficiency of EFA for true EFD normalization and develop a user-friendly software for organ annotation and geometric feature extraction using digital specimens.
We develop a user-friendly software ESHAPE for public service, integrating better contour extraction, efficient EFDs calculation, and true EFD normalization under all basic contour transformations.This software encompasses two parts: contour extraction and elliptic Fourier analysis. The process of contour extraction includes four steps: manual target selection, automatic segmentation, automatic contour outlining with manual correction and automatic chain code generation. Many functions focus on meeting the challenges of contour extraction generated in the preservation and digitization process of specimens, such as incomplete edges by white strips, low image contrast, noises by fragile, overlapping and damaged organs.Elliptic Fourier analysis. 
This part comprises two functions: normalizing the EFDs and visualizing reconstructed shapes. 
    
- Object selection. The software allows object selection from digital images, supporting various formats such as PNG, JPG, and BMP. Users can zoom in and out by utilizing the mouse scroll wheel and move left and right by pressing and holding the left button to quickly locate the object. The "Polygon Selection" function enables manual creation of polygonal regions, crucial for selecting overlapping objects.
- Segmentation and chain code generation. The functions address challenges of contour extraction generated in the preservation and digitization of specimens, including incomplete edges due to white strips, low image contrast, and noises from fragile, overlapping and damaged organs. 
- Size and Saving. By selecting two points on the ruler, if any, and inputting the corresponding realistic distance to determine the actual dimensions of individual pixel points, the software calculate the area and circumference. The results, including boundary coordinates, encoded chain code, area and perimeter sizes, and labeled images, are saved with user-defined tags. Notably, labeled images from diverse taxa are crucial for build large datasets, accelerating data-driven applications in biodiversity research for scientific discovery.
- Elliptic Fourier analysis. During computation, users can define the harmonic number and choose normalization options, all engaged as a default setup for true EFDs. Ultimately, user-defined normalized EFDs can be exported for comparative applications and further analysis.      

# Manual
[Manual](https://github.com/jiajie789/ESHAPE/blob/main/Manual.pdf)

# Install
Download the last release of ESHAPE from [here](https://github.com/jiajie789/ESHAPE)

Developed using MATLAB, ESHAPE requires MATLAB R2016a or later version for compilation and execution. ESHAPE is distributed as a zip package. You just need to **unzip the zip package** to any location on your computer and run the file "ESHAPE.m" in MATLAB to execute the program.

# Code Checklist
A.	ESHAPE.fig   Graphical user interface of main page.
B.	ESHAPE.m   Source program of main page. ESHAPE can be run by executing this file using MATLAB 2016a or later.
C.	functions
1)	cal_area_c.m   Calculate area and circumference.
2)	calc_dc_components_modify.m   Calculate DC (Direct Current) components.
3)	calc_harmonic_coefficients_modify.m   Calculate the n-th set of four harmonic coefficients.
4)	calc_traversal_dist.m   Generate position coordinates of chain code. Number of harmonic elements (n), and number of points for reconstruction (m) must be specified.
5)	calc_traversal_time.m   Calculate traversal time which is defined as accumulated time consumed by every component of the chain code.
6)	calc_traversal_vector.m   Generate position coordinates of chain code. 
7)	code2axis.m   Convert chain code to coordinates.
8)	fourier_approx_norm_modify_20231008.m   Generate position coordinates of fourier approximation of chain code.
9)	gui_chain_code_func20221129.m   Generate chain code based on binary image.
10)	is_completed_chain_code.m   Check whether the chain code is closed.
11)	plot_chain_code.m   Plot chain code with certain color and line width. Chain code should be written in chain vector.
12)	plot_fourier_approx_modify.m   Plot the fourier approximation, given a chain code, number of harmonic elements (n), and number of points for reconstruction (m). Normalization can be applied by setting "normalized = 1".
13)	WriteDataToFile.m   Write data to txt.
14)	EFA.fig   Graphical user interface of "Ellipse Fourier Analysis" page.
15)	EFA.m   Source program of ‘Ellipse Fourier Analysis’ page that enter into from main page.

Other codes used in case study and stored in file "transform"
1)	chain_code_ysysmmetry_func.m   Generate y-axis symmetric chain code.
2)	chain_code_xsysmmetry_func.m   Generate x-axis symmetric chain code.
3)	chain_code_starting_func.m   Generate starting point change chain code.
4)	chain_code_rotatew_func.m   Generate anticlockwise rotating chain code.
5)	chain_code_rotatec_func.m   Generate clockwise rotating chain code.
6)	chain_code_reverse_func.m   Generate reversal chain code.
