clc;
clear;
data = csvread('dataset.csv');
[dataRow, dataCol] = size(data);
dataT=data(:,1:1);
dataB=data(:,2:2);



%% =========== Define the SOM Architecture ================================
% Determine the number of rows and columns in the self-organizing map
somRow = 15;
somCol = 15;

% Number of iteration for convergence
Iteration = 100;

%%=========== Parameter Setting For SOM ===================================
% Initial size of topological neighbourhood of the winning neuron
width_Initial = 15;

% Time constant for initial topological neighbourhood size
t_width = Iteration/log(width_Initial);

% Initial time-varying learning rate
learningRate_Initial = 1;

% Time constant for the time-varying learning rate
t_learningRate = Iteration;


fprintf('\nInitializing The Weight Of Neurons Randomly ...\n')
% Initial weight vector of neuron
somMap = randInitializeWeights(somRow,somCol,dataCol);
% Plot the training data
    %cluster_1 =somMap(:,:,1);
    %cluster_2 =somMap(:,:,2);
    %plot(cluster_1,cluster_2);
    plotData(data)
    hold on;

for t = 1:Iteration
    
    % Size of topological neighbourhood of the winning neuron at the
    % iteration of i
    width = width_Initial*exp(-t/t_width);
    
    width_Variance = width^2;
    
    % The time-varying learning rate at the iteration of i
    learningRate = learningRate_Initial*exp(-t/t_learningRate);
    
    
    % Prevent learning rate become too small
    if learningRate <0.025
        learningRate = 0.1;
    end
    
    
    %% ================= The Competitive Process  =========================
    % Compute the Euclidean distance between each neuron and input
    [euclideanDist, index] = findBestMatch( data, somMap, somRow, ...
                                            somCol, dataRow, dataCol );
    
    % Find the index of winning neuron
    [minM,ind] = min(euclideanDist(:));
    [win_Row,win_Col] = ind2sub(size(euclideanDist),ind);
    
    %% Return the index of winning neuron
    %% ================= The End of Competitive Process  ==================
    
    
    
    %% ================= The Cooperative Process  =========================
    % Compute the neighborhood function for each neuron
    neighborhood = computeNeighbourhood( somRow, somCol, win_Row, ...
                                            win_Col, width_Variance);
    
    %% Return the lateral distance between each neuron and winning neuron
    %% ================= The End Of Cooperative Process  ==================
    
    
    
    %% ================= The Adaptive Process  ============================ 
    % Update the weight of all the neuron on the grid
    somMap = updateWeight( data, somMap, somRow, somCol, ...
                            dataCol, index, learningRate, neighborhood)

    %% ================= The End Of Adaptive Process  =====================
    
    
    %% ========== Illustrate The Updated Clustering Results  ==============
    % Weight vector of neuron
    dot = zeros(somRow*somCol, dataCol);
    % Matrix for SOM plot grid
    matrix = zeros(somRow*somCol,1);
    % Matrix for SOM plot grid for deletion
    matrix_old = zeros(somRow*somCol,1);
    
   
    ind = 1;  
    hold on;
    f1 = figure(1);
    set(f1,'name',strcat('Iteration #',num2str(t)),'numbertitle','off');

    % Retrieve the weight vector of neuron
    for r = 1:somRow
        for c = 1:somCol      
            dot(ind,:)=reshape(somMap(r,c,:),1,dataCol);
            ind = ind + 1;
        end
    end

    % Plot SOM
    for r = 1:somRow
        Row_1 = 1+somRow*(r-1);
        Row_2 = r*somRow;
        Col_1 = somRow*somCol;

        matrix(2*r-1,1) = plot(dot(Row_1:Row_2,1),dot(Row_1:Row_2,2),'--ro','LineWidth',2,'MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',4);
        matrix(2*r,1) = plot(dot(r:somCol:Col_1,1),dot(r:somCol:Col_1,2),'--ro','LineWidth',2,'MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',4);

        matrix_old(2*r-1,1) = matrix(2*r-1,1);
        matrix_old(2*r,1) = matrix(2*r,1);

    end

    % Delete the SOM plot from previous iteration
    if t~=Iteration  
        for r = 1:somRow
            delete(matrix_old(2*r-1,1));
            delete(matrix_old(2*r,1));
            drawnow;
        end
    end

    
    %% =================== The End Of Illustration  =======================
end