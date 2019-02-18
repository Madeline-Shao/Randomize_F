%@author: Madeline Shao
%% Randomizing more than two conditions Experiment F
try
    Screen('Preference','SkipSyncTests',1);
    rng('shuffle'); %reseeds random number generator
    [window,rect]=Screen('OpenWindow',0) %window: name of window, %rect, coords of window
    Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); %makes transparent
    HideCursor(); 

    window_w = rect(3);
    window_h = rect(4);
    center_x = window_w/2; %x center of screen
    center_y = window_h/2; %y center of screen
    
    cd('Stimuli');
    mask = imread('mask.png');
    mask = mask(:,:,1);

    %reads img 1
    img1 = imread ('1.png'); 
    img1(:,:,4)  = mask;
    texture1(1:6) = Screen('MakeTexture', window, img1); 

    %reads img 2
    img49 = imread ('49.png'); 
    img49(:,:,4)  = mask;
    texture2(1:6) = Screen('MakeTexture', window, img49); 

    %img properties
    image_size =  size(img1);
    image_height = image_size(1);
    image_width = image_size(2);
    
    %the 4 diff quadrants
    
%     xy_rect1=[window_w/4-image_width/2, window_h/4-image_width/2, window_w/4+image_width/2, window_h/4+image_width/2];
%     xy_rect2=[window_w*0.75-image_width/2, window_h/4-image_width/2, window_w*0.75+image_width/2, window_h/4+image_width/2];
%     xy_rect3=[window_w/4-image_width/2, window_h*0.75-image_width/2, window_w/4+image_width/2, window_h*0.75+image_width/2];
%     xy_rect4=[window_w*0.75-image_width/2, window_h*0.75-image_width/2, window_w*0.75+image_width/2, window_h*0.75+image_width/2];
    
    %2 vs 6 in each quadrant
    %quad1
%     gridLocX = linspace(image_width, window_w/2 - image_width, 2);
%     gridLocY = linspace(window_h/4, window_h/4, 1);
%     [x, y] = meshgrid(gridLocX, gridLocY); %grid of display points

    ntrials=8;

    % If you have more than 2 conditions you can set up several vectors for
    % each set of conditions 
    condition_set_1 = repmat([1 49], 1, 4); % create a vector using repmat for two types of oranges  
    condition_set_2 = repmat([1:4], 1, 2);% create a vector using repmat for 4 quadrants of the screen  
    condition_set_3 = repmat([1 500], 1, 4); % create a vector using repmat for the 2 timing conditions  
    condition_set_4 = repmat([2 6], 1, 4); % create a vector using repmat for the 2 timing conditions   

%     experiment_matrix = vertcat(condition_set_1, condition_set_2, condition_set_3, condition_set_4); %  vertically concatenate the vectors into one matrix 
%     experiment_matrix_shuffled = experiment_matrix(:,randperm(size(experiment_matrix,2)));%shuffles the whole experiment matrix by columns

    cond_set_1_shuf = Shuffle(condition_set_1); % call a specific row in the matrix later...
    cond_set_2_shuf = Shuffle(condition_set_2); % call a specific row in the matrix later...
    cond_set_3_shuf = Shuffle(condition_set_3); % call a specific row in the matrix later...
    cond_set_4_shuf = Shuffle(condition_set_4); % call a specific row in the matrix later...
    
    for i = 1:ntrials
        %which orange
        if cond_set_1_shuf(i)==1
            orange=texture1;
        else
            orange=texture2;
        end
        %which quad
        if cond_set_2_shuf(i)==1
            %quadrant=xy_rect1;
            %2 vs 6
            if cond_set_4_shuf(i) == 2
                gridLocX = linspace(image_width, window_w/2 - image_width, 2);
                gridLocY = linspace(window_h/4, window_h/4, 1);
                [x, y] = meshgrid(gridLocX, gridLocY); %grid of display points
            else
                gridLocX = linspace(image_width, window_w/2 - image_width, 3);
                gridLocY = linspace(image_height, window_h/2-image_height, 2);
                [x, y] = meshgrid(gridLocX, gridLocY); %grid of display points
            end
        elseif cond_set_2_shuf(i)==2
            %quadrant=xy_rect2;
            %2 vs 6
            if cond_set_4_shuf(i) == 2
                gridLocX = linspace(window_w/2+image_width, window_w - image_width, 2);
                gridLocY = linspace(window_h/4, window_h/4, 1);
                [x, y] = meshgrid(gridLocX, gridLocY); %grid of display points
            else
                gridLocX = linspace(window_w/2+image_width, window_w - image_width, 3);
                gridLocY = linspace(image_height, window_h/2-image_height, 2);
                [x, y] = meshgrid(gridLocX, gridLocY); %grid of display points
            end
        elseif cond_set_2_shuf(i)==3
            %quadrant=xy_rect3;
            %2 vs 6
            if cond_set_4_shuf(i) == 2
                gridLocX = linspace(image_width, window_w/2 - image_width, 2);
                gridLocY = linspace(window_h*0.75, window_h*0.75, 1);
                [x, y] = meshgrid(gridLocX, gridLocY); %grid of display points
            else
                gridLocX = linspace(image_width, window_w/2 - image_width, 3);
                gridLocY = linspace(window_h/2+image_height, window_h-image_height, 2);
                [x, y] = meshgrid(gridLocX, gridLocY); %grid of display points
            end
        else
            %quadrant=xy_rect4
            %2 vs 6
            if cond_set_4_shuf(i) == 2
                gridLocX = linspace(window_w/2+image_width, window_w - image_width, 2);
                gridLocY = linspace(window_h*0.75, window_h*0.75, 1);
                [x, y] = meshgrid(gridLocX, gridLocY); %grid of display points
            else
                gridLocX = linspace(window_w/2+image_width, window_w - image_width, 3);
                gridLocY = linspace(window_h/2+image_height, window_h-image_height, 2);
                [x, y] = meshgrid(gridLocX, gridLocY); %grid of display points
            end
        end
        %how long to wait
        if cond_set_3_shuf(i)==1
            wait=1
        else
            wait=0.5
        end
        %num of oranges
        if cond_set_4_shuf(i)==2
            num=2
        else
            num=6
        end
        
        xy_rect = [x(:)'-image_width/2; y(:)'-image_height/2; x(:)'+image_width/2; y(:)'+image_height/2];
        
        Screen('DrawTextures',window, orange(1:num), [], xy_rect);
        Screen('Flip', window);
        WaitSecs(wait);
        Screen('Flip',window);          
        WaitSecs(0.5);
    end
    Screen('CloseAll');
catch
    Screen('CloseAll');
    rethrow(lasterror)
end
