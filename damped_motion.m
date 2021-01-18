%15/03/2018
function damped_motion 

    %Initial parameter values
    %Mass
    m=2;
    %Spring constants
    k1=8;
    k2=8;
    %Damping coefficient
    b=1.5;
    %Distance of gaps
    d1=0.5;
    d2=0.1;
    %Total integration time
    t_end=50.0;
    %Integration step
    dt=0.01;
    %Initial displacement
    x=-1.0;
    %Initial velocity
    v=0;
    %Used to quit whilst loop
    exit_flag=0;
    [time_data,disp_data,vel_data,a_data] = response (m,k1,k2,b,d1,d2,x,dt,t_end);
   
    while (exit_flag==0)
        %These are printed in the command window and can then be selected
        fprintf('Program to convert a mass springs motion to numerical values\n\n');
        fprintf('1. Display variables\n'); 
        fprintf('2. Display graphically position response\n');
        fprintf('3. Display graphically velocity response\n');
        fprintf('4. Display graphically acceleration response\n');
        fprintf('5. Change fixed parameters\n');
        fprintf('6. Change system parameters\n');
        fprintf('7. Exit program\n'); 
        choice = input('Please select: ');
        switch (choice)
            %When chosen, prints values of variables
            case{1}     
                fprintf('Mass = %d\n', m)
                fprintf('Spring Constant 1 = %d\n', k1)
                fprintf('Spring Constant 2 = %d\n', k2)
                fprintf('Damping Coefficient = %d\n', b)
                fprintf('Gap 1 = %d\n', d1)
                fprintf('Gap 2 = %d\n', d2)
                fprintf('Total integration time = %d\n', t_end)
                fprintf('Integration step = %d\n', dt)
                fprintf('Initial displacement = %d\n', x)
                fprintf('Velocity = %d\n', v)
            %When chosen, takes values stored from the functions below and 
            %plots graph of displacement against time
            case{2}   
                [time_data,disp_data,~,~] = response (m,k1,k2,b,d1,d2,x,dt,t_end);
                time_data; 
                disp_data;
                %Plot graph of displacement against time
                plot(time_data,disp_data);
                %Title of graph
                title('Graph of displacement against time'); 
                %x-axis label
                xlabel('Time/ s'); 
                %y-axis label
                ylabel('Displacement/ m'); 
            %When chosen takes values stored from functions below and plots
            %graph of velocity against time
            case{3}    
                [time_data,~,vel_data,~] = response (m,k1,k2,b,d1,d2,x,dt,t_end);
                time_data;
                vel_data;
                %Plot graph of velocity against time
                plot (time_data, vel_data);
                %Title of graph
                title ('Graph of velocity against time'); 
                %x-axis label
                xlabel('Time/ s');
                %y-axis label
                ylabel('Velocity/ m/s');
            %When chosen takes values stored from functions below and plots
            %graph of acceleration against time
            case{4}  
                [time_data,~,~,a_data] = response (m,k1,k2,b,d1,d2,x,dt,t_end);
                time_data;
                a_data;
                %Plot graph of acceleration against time
                plot (time_data, a_data);
                %Title of graph
                title ('Graph of acceleration against time'); 
                %x-axis label
                xlabel('Time/ s');
                %y-axis label
                ylabel('Acceleration/ m/s^2');
            %When chosen, allows to change the fixed parameters of the system
            case{5}
                [m,k1,k2,b,d1,d2,x] = changefixedparams (m,k1,k2,b,d1,d2,x);
            %When chosen, allows to change the system parameters i.e., the 
            %time over which the integration occurs and the integration step 
            %used in the calculations of velocity and displacement
            case{6}  
                [dt,t_end] = changesystparams (dt,t_end);
            %This will exit the program when selected
            case{7}
                exit_flag = 1;  
            otherwise
                disp('Invalid entry');
        end
    end
disp('Leaving program');
end

%The function below will carry out the calculations for the system and
%store them so that a graph can be plotted

function [time_data,disp_data,vel_data,a_data] = response (m,k1,k2,b,d1,d2,x,dt,t_end)
    %Starting condition for velocity
    v = 0; 
    time_data=[];
    disp_data=[];
    vel_data =[];
    a_data =[];
    for t=0:dt:t_end 
        %Equation below valid for when the mass is touching the first spring, s1
        if(x<-d1) 
          a =(-(k1 * (x+d1))  - (b * v))/m;  
        %Equation below valid for when the mass is touching the second spring, s2
        elseif(x>d2) 
          a=(-(k2 * (x-d2)) -(b * v))/m;
        %Equation below valid for all other points in time (i.e., when the 
        %mass is not touching either springs)
        else 
          a=(-b * v)/m;
        end
        %Equation to calculate new velocity after increase in time of "dt", 
        %i.e., the integration step
        v = v + (a * dt); 
        %Equation to calculate new displacement after increase in time of 
        %"dt", i.e., the integration step
        x = x + (v * dt); 
        %Store the time data before going back to start of/quitting loop
        time_data(end+1) = t; 
        %Store the displacement data before going back to start of/quitting loop
        disp_data(end+1)= x;
        %Store the velocity data before going back to start of/quitting loop
        vel_data(end+1)= v;
        %Store the acceleration data before going back to start of/quitting loop
        a_data(end+1)=a;
    %End this loop and go back to the 'for' statement until "t_end" is
    %reached
    end
%This ends the whole function when the values of velocity and displacement
%have been calculated and stored up to "t_end"
end 

%This function changes the fixed parameters of the system

function [m,k1,k2,b,d1,d2,x] = changefixedparams (m,k1,k2,b,d1,d2,x)
%Below are the variables which can then be changed
    m = input('Mass?');
    k1 = input('Spring constant of first spring?');
    k2 = input('Spring constant of second spring?');
    b = input('Damping coefficient?');
    d1 = input('Distance of first gap (between spring 1 and mass)?');
    d2 = input('Distance of second gap (between spring 2 and mass)?');
    x = input('Initial displacement?');
end 

%This function changes the system parameters

function [dt,t_end] = changesystparams (dt,t_end)  
    dt = input('Integration step?');
    t_end = input('Total integration time?');
end
