# image-processing

This codes are some image processing operations.

Image_Crop: Load an image from a specified file path and divide the image into multiple smaller blocks and saves each block as a separate image in a specified output directory.

Image_Erosion: A function takes a binary image as input and performs erosion-related operations to extract centroid coordinates, area, and count of regions present in the image using the regionprops function.

Main_Tif_Particles_Statistics: Process each TIFF image by removing border pixels, adjusting pixel values, performing erosion-related operations, and identifying features and extract information about image resolution and divide the image into blocks to count pixel values within these blocks.

Counts_Area_Ratio_Particles: Performs image processing (erosion), computes counts, areas, and ratios for objects within each image, and then saves the computed data into separate .mat files for counts, areas, and ratios.
