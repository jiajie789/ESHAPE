# ESHAPE: Morphology Analysis tools
The elliptic Fourier analysis (EFA) can extract arbitrary two-dimensional curves to a series of elliptic Fourier descriptors (EFDs), which was originally proposed by Kuhl and Giardina in 1982 for object recognition of a segment in an image. As a powerful mathematical tool, EFA can provide quantitative criteria for shape analysis, classification, reconstruction, and modeling, which has been widely used in plant science, marine biology, evolutionary biology and anthropology. The procedure of GM using EFA includes contour extraction, EFDs calculation and EFD normalization. Aside from the low efficiency in outline extraction and low quantity in datasets, EFD normalization has long been a matter of trouble (Haines and Crampton 2000, Bonhomme et al., 2014, Wishkerman et al., 2018). None of existing normalization method can give homologous results when dealing with planar translation, scaling, rotation, symmetry, reverse, and analogous basic transformations simultaneously. Therefore, it is of great significance to improve the computational efficiency of EFA for true EFD normalization and develop a user-friendly software for organ annotation and geometric feature extraction using digital specimens.
We develop a user-friendly software ESHAPE for public service, integrating better contour extraction, efficient EFDs calculation, and true EFD normalization under all basic contour transformations.This software encompasses two parts: contour extraction and elliptic Fourier analysis. The process of contour extraction includes four steps: manual target selection, automatic segmentation, automatic contour outlining with manual correction and automatic chain code generation. Many functions focus on meeting the challenges of contour extraction generated in the preservation and digitization process of specimens, such as incomplete edges by white strips, low image contrast, noises by fragile, overlapping and damaged organs.Elliptic Fourier analysis. This part comprises two functions: normalizing the EFDs and visualizing reconstructed shapes. 
    
- Object selection. The software allows object selection from digital images, supporting various formats such as PNG, JPG, and BMP. Users can zoom in and out by utilizing the mouse scroll wheel and move left and right by pressing and holding the left button to quickly locate the object. The "Polygon Selection" function enables manual creation of polygonal regions, crucial for selecting overlapping objects.
- Segmentation and chain code generation. The functions address challenges of contour extraction generated in the preservation and digitization of specimens, including incomplete edges due to white strips, low image contrast, and noises from fragile, overlapping and damaged organs. 
- Size and Saving. By selecting two points on the ruler, if any, and inputting the corresponding realistic distance to determine the actual dimensions of individual pixel points, the software calculate the area and circumference. The results, including boundary coordinates, encoded chain code, area and perimeter sizes, and labeled images, are saved with user-defined tags. Notably, labeled images from diverse taxa are crucial for build large datasets, accelerating data-driven applications in biodiversity research for scientific discovery.
- Elliptic Fourier analysis. During computation, users can define the harmonic number and choose normalization options, all engaged as a default setup for true EFDs. Ultimately, user-defined normalized EFDs can be exported for comparative applications and further analysis.      

# Manual
[Manual]https://github.com/jiajie789/ESHAPE/blob/main/Manual.pdf


