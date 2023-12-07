function [X,Y,p_counts,p_Area]=image_erosion(im_data) % Define a function  to perform erosion-related operations or analysis on the input image data and extract certain information, such as centroid coordinates, count of regions, and area measurements
	image_gray = bwlabel(im_data); % Convert the binary image into a labeled image
	s = regionprops(image_gray, 'all'); % Extract region properties (centroid, area) from the labeled image
	% Extract centroid coordinates of each region and area of each region
    p_cords= cat(1,s.Centroid); % Centroid coordinates of regions
	p_Area = [s.Area]; %  Area of regions
    % Check if there are any regions detected
    if ~isempty(p_cords) %  If regions are found
        X= int32(p_cords(:,1));Y=int32(p_cords(:,2));p_counts = int32(length(X)); % Convert centroid coordinates to integer values and calculate the number of regions (counts) found
    else
        X=0;Y=0;p_counts=0;p_Area=0; % If no regions are found, set values to zero
    end
end	