function plotData(data)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    figure; hold on;
    cluster_1 =data(:,1);
    cluster_2 =data(:,2);
    plot(cluster_1,cluster_2,'yo','LineWidth',2,'MarkerSize',12);

    set(gcf,'un','n','pos',[0,0,1,1]);figure(gcf)

    %hold on;

    % Specified in plot order
    %legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6','Cluster 7','location','eastoutside')
    hold off;



end

