clear all;close all;clc; % Clear all variables, close all figures, and clear the command window

path='C:/MatCode_3/image_sequences'; % Define the path where the image sequences are stored
file=fullfile(path,'*.tif'); % Create a file path pattern to locate all TIFF images in the specified path
TIF_image=dir(file); % Retrieve information about TIFF images using the file path pattern
 
for k_Im=0:numel(TIF_image)-1 % Loop through each TIFF image in the directory
	filename=fullfile(path,TIF_image(k_Im+1).name); % Create the full file path for the current TIFF image
	imdata = imread(filename); % Read the current TIFF image
	s = size(imdata); % Get the size of the image
	im_data=imdata(2:s(1)-1,2:s(2)-1); % Extract a region of interest by removing border pixels
	im_data(im_data == 0) =1; % Modify pixel values: Replace 0 with 1 
	im_data(im_data == 255) =0; % Modify pixel values: Replace 255 with 0
	[X,Y,p_counts,p_Area]=image_erosion(im_data); % Perform erosion-related operations on the modified image data
	s = size(im_data) % Obtain the size of the im_data matrix and assigns it to s
	im_result =zeros(s(1),s(2)); % Create a matrix im_result filled with zeros, having dimensions extracted from s
	for k = 1:p_counts % Initiate a loop to run from 1 to 'p_counts'
		im_result(Y(k),X(k)) =1; % Set specific positions in the im_result matrix to 1 based on coordinates from X and Y arrays
	end
	figure; % Display the processed image
	imshow(im_result) % Display the im_result matrix
	hold on;plot(X,Y,'r.');hold off; % Plot red dots at the specified coordinates (X, Y) over the displayed image 
	
	s = size(im_result) % Obtain the size of the im_result matrix and assigns it to s
	X_resolution =s(1);Y_resolution =s(2); % Extract the number of rows and columns from im_result and assigns them to X_resolution and Y_resolution, 
	X_blocks_no = 1;Y_blocks_no = 1; % Set the number of blocks in the x and y dimensions to 1
	block_Xstep = X_resolution/X_blocks_no; % Calculate the step size (width) for each block in the x-direction
	block_Ystep = Y_resolution/Y_blocks_no; % Calculate the step size (height) for each block in the y-direction

	counts_blocks = zeros(X_blocks_no,Y_blocks_no); % Initialize an empty matrix counts_blocks with dimensions based on X_blocks_no and Y_blocks_no
	for x_blocks = 0:X_blocks_no-1 %  Loop iterating through x-blocks from 0 to X_blocks_no - 1
		for y_blocks =0:Y_blocks_no-1 % Loop iterating through y-blocks from 0 to Y_blocks_no - 1
			data_block_cache = im_result(x_blocks*block_Xstep+1:(x_blocks+1)*block_Xstep,y_blocks*block_Ystep+1:(y_blocks+1)*block_Ystep); % Extract a block of data from im_result based on current x and y block positions
			counts_blocks(x_blocks+1,y_blocks+1) = sum(sum(data_block_cache)); % Count the number of pixels within the block and stores the count in counts_blocks matrix
		end
	end
	
	image_no = num2str(k_Im+1) % Generate a string representing the current image number in the loop
	imge_name = strcat('Image_001',image_no,'.mat'); % Create a filename for saving the counts of pixel values within blocks as a .mat file
	save(char(imge_name),'counts_blocks') % Save the counts_blocks matrix as a .mat file using the generated filename
end
