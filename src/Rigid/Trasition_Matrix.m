clc;
close all;

%Define Constants and Initial Conditions
params.m = 1;
params.M = 10;
params.beta = 0.1;
params.L = 1;
%params.gamma = 0.0043633;
params.a=0.5;
params.b=0.5;


theta_range = linspace(-.2,.3,20);
d_theta_range = linspace(-.7,-.05,20);
d_phi_range = linspace(-1,0.2,20);
transitions = zeros(8001,8001);
transitions(1,1) = 1;
gamma_range = linspace(.25*(pi/180),1*(pi/180),10);
for gs = 1:1
    gs
    params.gamma = gamma_range(gs);
    %params.gamma= 0.0043633;
for i = 1:20
    for j = 1:20
        for k = 1:20
            
    q0 =[theta_range(i);2*theta_range(i);d_theta_range(j);d_phi_range(k)];      
    [T,Q, info] = solve_one_step_level_ground(q0,params);
    q_next = Q(:,end);
    %Determine which state this maps to
%     if (info == 1)
%     info
%     q_next
%     pause(5)
%     end
    %Error or failure state
    if (info ~= 1)
        transitions(indexer(i,j,k)+1,1) = transitions(indexer(i,j,k)+1,1) + 1;
        %break
    %end
    %Answer isn't in one of the "buckets" of states
    elseif (q_next(1)>theta_range(20))||(q_next(1)<theta_range(1))
        transitions(indexer(i,j,k)+1,1) = transitions(indexer(i,j,k)+1,1) + 1;
    elseif (q_next(3)>d_theta_range(20))||(q_next(3)<d_theta_range(1))
        transitions(indexer(i,j,k)+1,1) = transitions(indexer(i,j,k)+1,1) + 1;
    elseif (q_next(4)>d_phi_range(20))||(q_next(4)<d_phi_range(1))
        transitions(indexer(i,j,k)+1,1) = transitions(indexer(i,j,k)+1,1) + 1;
    %Map to correct state
    else
        for l = 1:20
            if q_next(1) > theta_range(l)
                theta_state = l;
            end
        end
        for m = 1:20
            if q_next(3) > d_theta_range(m)
                d_theta_state = m;
            end
        end
        for n = 1:20
            if q_next(4) > d_phi_range(n)
                d_phi_state = n;
            end
        end
%     if (info == 1)
%     theta_state
%     d_theta_state
%     d_phi_state
%     pause(5)
%     end
        transitions(indexer(i,j,k)+1,indexer(theta_state,d_theta_state,d_phi_state)+1) = transitions(indexer(i,j,k)+1,indexer(theta_state,d_theta_state,d_phi_state)+1) + 1;      
        if ((indexer(i,j,k))==indexer(theta_state,d_theta_state,d_phi_state)+1)
            disp('This may be a stable point')
            disp(strcat('theta(0) = ',num2str(q0(1))))
            disp(strcat('phi(0) = ',num2str(q0(2))))
            disp(strcat('d_theta(0) = ',num2str(q0(3))))
            disp(strcat('d_phi(0) = ',num2str(q0(4))))
            disp(strcat('gamma = ',num2str(gamma_range(gs))))
            disp(strcat(num2str(q0(1)),';',num2str(q0(2)),';',num2str(q0(3)),';',num2str(q0(4))))
        end
    end    
        end
    end
end
    
end
trans_mat = transitions;

function index = indexer(i,j,k)
index = (k-1)*400+(j-1)*20+i;
end
   