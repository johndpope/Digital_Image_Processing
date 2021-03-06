prefix = ('key');
for image = 1:4
    fn = sprintf('%s.%d.jpg',prefix,image);
    f = imread(fn);
    f = rgb2gray(f); %gray image

    level = graythresh(f);%otus
    BW = imbinarize(f,level);%thresholding

    invert = 1 - BW; %invert image
    se = strel('square',5); 
    closeBW = imclose(invert,se); %imcolse image
    %cc = bwconncomp(closeBW);
    %rp = regionprops(cc, 'Area');
    %[maxArea, maxIndex] = max([rp.Area]);
    ccl = bwlabel(closeBW); %CCL
    status = regionprops(ccl,'Area');%small region removal
    Area = [status.Area];
    % get binary image
    areaValue = find(Area==max(Area));
    ccl(ccl~=areaValue)=0;
    ccl(ccl==areaValue)=1;
    figure;imshow(ccl);
    
    %get centroid, Compute the center of gravity.  Use regionprops 'Centroid'
    stats = regionprops(ccl,'Centroid');
    centroid = [stats.Centroid];
    centroid = floor(centroid);
    %get major axis
    [stats] = regionprops(ccl,'MajorAxisLength');
    majorAxis = stats.MajorAxisLength;
    %get minor axis
    [stats]= regionprops(ccl,'MinorAxisLength');
    minorAxis = stats.MinorAxisLength;
    %get the distance, Compute centroid distance function of that largest region
    distance = sqrt( (majorAxis/2)^2 + (minorAxis/2)^2);
    distance = floor(distance);

    rotation = [];
    
    for theta = 1:360
        for d = 1:distance
            r = floor(centroid(2) + d * sind(theta));
            c = floor(centroid(1) + d * cosd(theta));
            if(ccl(r,c)== false)
                rotation(360-theta+1) = d;
                break;
            end
        end
    end
    % get the largest value in raidus
    maximum_value = max(max(rotation(:)));
    % find the max theta value
    maxTheta = find(maximum_value == rotation);
    figure;plot([1:360],rotation,'-r'); title('CDF');
end