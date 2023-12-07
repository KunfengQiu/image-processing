clear all;close all;clc; % Clear all variables, close all figures, and clear the command window

path='C:/MatCode_3/a5pore/'; % Define the path where the image sequences are stored

file=fullfile(path,'*.tif'); % Create a file path pattern to locate all TIFF images in the specified path
TIF_image=dir(file); % Retrieves a list of TIFF images in the directory
 
pa_A17P_test_counts =zeros(1,87); % put the number of images here in the first blank
pa_A17P_test_area =zeros(1,87);   % put the number of images here in the first blank
pa_A17P_test_ratio = zeros(1,87); % put the number of images here in the first blank
for k_Im=0:numel(TIF_image)-1 % Iterate through each TIFF image
	clear X Y p_counts p_Area % Clear variables from previous iterations
	filename=fullfile(path,TIF_image(k_Im+1).name) % Retrieve the file path for the current image
	imdata = imread(filename); s = size(imdata); % Read the image and gets its size
	imdata(imdata == 0) =1; % Replace 0 values in the image with 1
	imdata(imdata == 255 ) =0; % Replace 255 values in the image with 0
	im_data = imdata(1:s(1)-1,1:s(2)-1); % Trim the image data
	s = size(im_data); % Gets the size of the trimmed image data
	[X,Y,p_counts,p_Area]=image_erosion(im_data); % Perform an erosion operation and obtains counts and areas
	pa_A17P_test_counts(k_Im+1) = length(X); % Store the count of objects in the image
	pa_A17P_test_area(k_Im+1) = sum(sum(p_Area)); % Store the total area of objects in the image
	total_area =s(1)*s(2); % Calculate the total area of the image
	pa_A17P_test_ratio(k_Im+1) = pa_A17P_test_area(k_Im+1)/total_area; % Store the ratio of object area to total area
end

pa_A17P_test_counts = reshape(pa_A17P_test_counts,[1,87])'; % Reshape the counts array
pa_A17P_test_area = reshape(pa_A17P_test_area,[1,87])';     % Reshape the area array
pa_A17P_test_ratio = reshape(pa_A17P_test_ratio,[1,87])';   % Reshape the ratio array


imge_name = strcat('bottom_Counts.mat'); % Specify the filename for storing counts
save(char(imge_name),'pa_A17P_test_counts'); % Save the counts data in a .mat file
imge_name = strcat('bottom_area.mat'); % Specify the filename for storing area data
save(char(imge_name),'pa_A17P_test_area'); % Save the area data in a .mat file
imge_name = strcat('bottom_ratio.mat'); % Specify the filename for storing ratio data
save(char(imge_name),'pa_A17P_test_ratio'); % Save the ratio data in a .mat file