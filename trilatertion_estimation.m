function [] = trilat( X, d, real1, real2 )
	cla
	circles(X(1), X(5), d(1), 'edgecolor',[0 0 0],
    'facecolor', 'none','linewidth',4); %AP1 - black
	circles(X(2), X(6), d(2), 'edgecolor',[0 1 0],
    'facecolor', 'none','linewidth',4); %AP2 - green
	circles(X(3), X(7), d(3), 'edgecolor',[0 1 1],
    'facecolor', 'none','linewidth',4); %AP3 - cyan 
	circles(X(4), X(8), d(4), 'edgecolor',[1 1 0],
    'facecolor', 'none','linewidth',4); %AP4 - yellow
	axis([0 10 0 10])
	hold on
	tbl = table(X, d);
	d = d.^2;
	weights = d.^(-1);
	weights = transpose(weights);
	beta0 = [5, 5];
	modelfun = @(b,X)(abs(b(1)-X(:,1)).^2+abs(b(2)-X(:,2)).^2).^(1/2);
	mdl = fitnlm(tbl,modelfun,beta0, 'Weights', weights);
	b = mdl.Coefficients{1:2,{'Estimate'}}
	scatter(b(1), b(2), 70, [0 0 1], 'filled')
	scatter(real1, real2, 70, [1 0 0], 'filled')
	hold off
end