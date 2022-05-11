%��������Ⱥ��С��������ʡ�������ʡ���������
function TSP(pop, cp, mp, mg)
%clear;
clc;
tStart = tic; % �㷨��ʱ��
 
%%%%%%%%%%%%�Զ������%%%%%%%%%%%%%

[cityNum,cities] = Read('dsj100.tsp');
cities = cities';
%cityNum = 100;
maxGEN = mg;% ��������
popSize = pop; % �Ŵ��㷨��Ⱥ��С
crossoverProbabilty = cp; %�������
mutationProbabilty = mp; %�������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
gbest = Inf;

% �����������ɵĳ��о���
distances = calculateDistance(cities);
 
% ������Ⱥ��ÿ���������һ��·��
pop = zeros(popSize, cityNum);
for i=1:popSize
    pop(i,:) = randperm(cityNum); 
end
offspring = zeros(popSize,cityNum);
%����ÿ������С·�����ڻ�ͼ
minPathes = zeros(maxGEN,1);
 
% GA�㷨
for  gen=1:maxGEN
 
    % ������Ӧ�ȵ�ֵ����·���ܾ���
    [fval, sumDistance, minPath, maxPath] = fitness(distances, pop);
 
    % ���̶�ѡ��
    tournamentSize=4; %���ô�С
    for k=1:popSize
        % ѡ�񸸴����н���
        tourPopDistances=zeros( tournamentSize,1);
        for i=1:tournamentSize
            randomRow = randi(popSize);
            tourPopDistances(i,1) = sumDistance(randomRow,1);
        end
 
        % ѡ����õģ���������С��
        parent1  = min(tourPopDistances);
        [parent1X,parent1Y] = find(sumDistance==parent1,1, 'first');
        parent1Path = pop(parent1X(1,1),:);
 
 
        for i=1:tournamentSize
            randomRow = randi(popSize);
            tourPopDistances(i,1) = sumDistance(randomRow,1);
        end
        parent2  = min(tourPopDistances);
        [parent2X,parent2Y] = find(sumDistance==parent2,1, 'first');
        parent2Path = pop(parent2X(1,1),:);
 
        subPath = crossover(parent1Path, parent2Path, crossoverProbabilty);%����
        subPath = mutate(subPath, mutationProbabilty);%����
 
        offspring(k,:) = subPath(1,:);
        
        minPathes(gen,1) = minPath; 
    end
    fprintf('����:%d   ���·��:%.2fKM \n', gen,minPath);
    % ����
    pop = offspring;
    % ������ǰ״̬�µ����·��
    if minPath < gbest
        gbest = minPath;
        paint(cities, pop, gbest, sumDistance,gen);
    end
end
figure 
plot(minPathes, 'MarkerFaceColor', 'red','LineWidth',1);
title('��������ͼ��ÿһ�������·����');
set(gca,'ytick',500:100:5000); 
ylabel('·������');
xlabel('��������');
grid on
tEnd = toc(tStart);
fprintf('ʱ��:%d ��  %f ��.\n', floor(tEnd/60), rem(tEnd,60));

function val=randi(s)
    temp=randperm(s);
    val=temp(1);
    
%�������
function [ distances ] = calculateDistance( city )
    [N, col] = size(city);
    distances = zeros(col);
    for i=1:col
        for j=1:col
            distances(i,j)= distances(i,j)+ sqrt( (city(1,i)-city(1,j))^2 + (city(2,i)-city(2,j))^2  );           
        end
    end


% �������
function [childPath] = crossover(parent1Path, parent2Path, prob)
    random = rand();
    if prob >= random
        [l, length] = size(parent1Path);
        childPath = zeros(l,length);
        setSize = floor(length/2) -1;
        offset = randi(setSize);
        for i=offset:setSize+offset-1
            childPath(1,i) = parent1Path(1,i);
        end
        iterator = i+1;
        j = iterator;
        while any(childPath == 0)
            if j > length
                j = 1;
            end
 
            if iterator > length
                iterator = 1;
            end
            if ~any(childPath == parent2Path(1,j))
                childPath(1,iterator) = parent2Path(1,j);
               iterator = iterator + 1;
            end
            j = j + 1;
        end
    else
        childPath = parent1Path;
    end


% ����������Ⱥ����Ӧ��ֵ
function [ fitnessvar, sumDistances,minPath, maxPath ] = fitness( distances, pop ) 
    [popSize, col] = size(pop);
    sumDistances = zeros(popSize,1);
    fitnessvar = zeros(popSize,1);
    for i=1:popSize
       for j=1:col-1
          sumDistances(i) = sumDistances(i) + distances(pop(i,j),pop(i,j+1));
       end 
    end
    minPath = min(sumDistances);
    maxPath = max(sumDistances);
    for i=1:length(sumDistances)
        fitnessvar(i,1)=(maxPath - sumDistances(i,1)+0.000001) / (maxPath-minPath+0.00000001);
    end


%��ָ����·������ָ���ĸ��ʽ��и���
function [ mutatedPath ] = mutate( path, prob )
    random = rand();
    if random <= prob
        [l,length] = size(path);
        index1 = randi(length);
        index2 = randi(length);
        %����
        temp = path(l,index1);
        path(l,index1) = path(l,index2);
        path(l,index2)=temp;
    end
        mutatedPath = path; 


%���Ƴ���·��
function [ output_args ] = paint( cities, pop, minPath, totalDistances,gen)
    gNumber=gen;
    [M, length] = size(cities);
    xDots = cities(1,:);
    yDots = cities(2,:);
    %figure(1);
    title('GA TSP');
    plot(xDots,yDots, 'p', 'MarkerSize', 14, 'MarkerFaceColor', 'blue');
    xlabel('����');
    ylabel('γ��');
    axis equal
    hold on
    [minPathX,C] = find(totalDistances==minPath,1, 'first');
    bestPopPath = pop(minPathX, :);
    bestX = zeros(1,length);
    bestY = zeros(1,length);
    for j=1:length
       bestX(1,j) = cities(1,bestPopPath(1,j));
       bestY(1,j) = cities(2,bestPopPath(1,j));
    end
    title('GA TSP');
    plot(bestX(1,:),bestY(1,:), 'red', 'LineWidth', 1.25);
    legend('����', '·��');
    axis equal
    grid on
    %text(5,0,sprintf('��������: %d ��·������: %.2f',gNumber, minPath),'FontSize',10);
    drawnow
    hold off


%��ָ���ļ��ж�ȡ��������
function [n_citys,city_position] = Read(filename)
    fid = fopen(filename,'rt');
    location=[];
    A = [1 2];
    tline = fgetl(fid);
    while ischar(tline)
        if(strcmp(tline,'NODE_COORD_SECTION'))
            while ~isempty(A)
                A=fscanf(fid,'%f',[3,1]);
                if isempty(A)
                    break;
                end
                location=[location;A(2:3)'];
            end
        end
        tline = fgetl(fid); 
        if strcmp(tline,'EOF')
            break;
        end
    end
    [m,n]=size(location);
    n_citys = m;
    city_position=location;
    fclose(fid);