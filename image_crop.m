clear all;close all;clc; % Clear all variables, close all figures, and clear the command window

filename='C:/MatCode_3/image_sequences/s18b_factal_Bi to iv.tif';
% Define the filename and load the image. Change the file position and file name if necessary here. 

imdata = imread(filename); % Read the image data from the defined file
s = size(imdata); % Get the size of the input image
im_data=imdata(2:s(1)-1,2:s(2)-1); % Extract a portion of the image (excluding borders)
s = size(im_data) % Get the size of the extracted image
X_resolution =s(1);Y_resolution =s(2); % Store the resolution in both X-direction and Y-direction

% define how many sub_iamges you want
X_blocks_no = 4;Y_blocks_no = 8; % Number of blocks in both X-direction and Y-direction (Note: X and Y are reversed here)
block_Xstep = X_resolution/X_blocks_no; % Calculate the size of each X-direction block

block_Ystep = Y_resolution/Y_blocks_no; % Calculate the size of each Y-direction block
image_block_no = 1 % Initialize image block number
output_path = 'C:/MatCode_3/image_ccrops/' % define the output path
for x_blocks = 0:X_blocks_no-1 % Loop through each block in the image in X-direction
	for y_blocks =0:Y_blocks_no-1 % Loop through each block in the image in Y-direction
		data_block_cache = im_data(x_blocks*block_Xstep+1:(x_blocks+1)*block_Xstep,y_blocks*block_Ystep+1:(y_blocks+1)*block_Ystep); % Extract a data block from the image
		image_no = num2str(image_block_no+1); % converts the numerical value of image_block_no+1 to a string format and stores it in the variable image_no
		image_name = strcat(output_path,'D4002_',image_no,'.tif') % Generate image name based on block number
		imwrite(data_block_cache,image_name) % Write the data_block_cache as an individual TIFF image using the generated name
		image_block_no = image_block_no+1 %  Increment image block number for the next iteration
	end
end