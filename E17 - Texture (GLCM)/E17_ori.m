prefix = {'Bark', 'Bush', 'Fabric', 'Floor', 'Flower', 'Food', 'Gravel', 'Hair', 'Marble', 'Metal', 'Paint' };
o=[1 1];
numFrame = (1:9);
E = zeros(11,9);
for i = 1:11%size(prefix)
    for j = 1 :9%numel(numFrame)
        %fn = sprintf ( 'data/%s.%d.png', prefix{i}, j );
        %f = imread(fn);
        f = imread('Bark.1.png');
        if ~islogical(f)
            f = im2uint8(f);
        end
        G = get_glcm(f);
        %figure;imshow(G,[]);
        
        %h = imhist(f(:)); % calculate histogram counts
        %h(h==0) = [];% remove zero
        %pij = h ./ numel(f);% normalize
        
        E(i,j) = -1*get_entropy(G);
    end
end
figure;imshow(G,[]);