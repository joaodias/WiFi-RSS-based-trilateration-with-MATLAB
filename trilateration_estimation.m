%--------------------------------------------------------------------------
%
% DESCRIPTION: Estimates the actual position based on previously estimated
%              distances
%
%      INPUTS: X - Matrix containing the coordinates for each AP position
%              d - Estimated distances to each AP, respectively
%              real1 - x coordinate of the known position
%              real2 - y coordinate of the known position
%              min_X - minimum X coordinate of the dataset
%              max_X - maximum X coordinate of the dataset
%              min_Y - minimum X coordinate of the dataset
%              max_Y - maximum Y coordinate of the dataset
%
%     OUTPUTS: Estimated position (x, y) 
%
%  REFERENCES: http://goo.gl/cGXmDw
%
%--------------------------------------------------------------------------

function [ b ] = trilat( X, d, real1, real2, min_X, max_X, min_Y, max_Y )
	cla;
    
    %plot the circles around the access points
    for n = 1:size(d)
       circles(X(n),X(size(d)+n),d(n),'edgecolor',[0 0 0],'facecolor','none','linewidth',4); 
    end

    %define the axis
	axis([min_X max_X min_Y max_Y]);
	hold on;
    
    %create a table with X and d
	tbl = table(X, d);
    
    %define the weights. Equals to 1 over the square of the distance
	d = d.^2;
	weights = d.^(-1);
	weights = transpose(weights);
    
    %approximated middle coordinates of dataset
	beta0 = [(max_X - min_X)/2, (max_Y - min_Y)/2];

    %define the model
	modelfun = @(b,X)(abs(b(1)-X(:,1)).^2+abs(b(2)-X(:,2)).^2).^(1/2);
    
    %fit the data to the model
	mdl = fitnlm(tbl,modelfun,beta0, 'Weights', weights);
    
    %estimated position
	b = mdl.Coefficients{1:2,{'Estimate'}};
    
    %plot the estimated position (blue)
	scatter(b(1), b(2), 70, [0 0 1], 'filled');
	
    %plot the real position (red)
    scatter(real1, real2, 70, [1 0 0], 'filled');
	hold off;
end