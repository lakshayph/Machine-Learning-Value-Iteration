function value_iteration(environment_file, ntr, gamma, k)
p=[];
num_iterations = str2double(k);
reward = str2double(ntr);
discount = str2double(gamma);
filename = fopen(environment_file);
    while (~feof(filename))
        C = textscan(filename,'%s', 1, 'Delimiter', '\n');
        C = C{1,1};  
        p = [p;strsplit(C{1}, ',')];
    end
fclose(filename);
U = zeros(size(p,1),size(p,2));
prob(1,:) = [.8000,.1000,.1000,0];
prob(2,:) = [.1000,.8000,0,.1000];
prob(3,:) = [.1000,0,.8000,.1000];
prob(4,:) = [0,.1000,.1000,.8000];
dummy = zeros(4,1);
    for j=1:size(p,1)
        for q=size(p,2):-1:1
            if(strcmp(p(j,q),'1.0'))
                U(j,q) = 1.0;
            end
            if (strcmp(p(j,q),'-1.0'))
                U(j,q) = -1.0;
            end
        end
    end
    for i=1:num_iterations
        for j=size(p,1):-1:1
            for q=1:size(p,2)
                if(i==1)
                    if ((j~=size(p,1)-1 | q~=2) && (~strcmp(p(j,q),'1.0')) && (~strcmp(p(j,q),'-1.0')))
                        U(j,q) = reward;
                    end
                else
                    if ((j~=size(p,1)-1 | q~=2) && (~strcmp(p(j,q),'1.0')) && (~strcmp(p(j,q),'-1.0')))
                        for t=1:4
                            if (t==1)%checking for up
                               if(j-1==0)%up
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,1);
                                elseif(strcmp(p(j-1,q),'1.0')||strcmp(p(j-1,q),'-1.0'))
                                    dummy(t) = dummy(t)+U(j-1,q)*prob(t,1);
                                elseif((j-1==size(p,1)-1)&&(q==2))
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,1);
                                else
                                    dummy(t) = dummy(t)+U(j-1,q)*prob(t,1);
                                end
                                if(q-1==0)%left
                                    dummy(t) = dummy(t) + U(j,q)*prob(t,2);
                                elseif((q-1==2)&&(j==size(p,1)-1))
                                    dummy(t) = dummy(t) + U(j,q)*prob(t,2);
                                else
                                    dummy(t) = dummy(t) + U(j,q-1)*prob(t,2);
                                end
                                if(q+1==size(p,2)+1)%right
                                    dummy(t) = dummy(t) + U(j,q)*prob(t,3);
                                elseif((strcmp(p(j,q+1),'1.0'))||(strcmp(p(j,q+1),'-1.0')))
                                    dummy(t) = dummy(t) + U(j,q+1)*prob(t,3);
                                elseif((j==size(p,1)-1)&&(q+1==2))
                                    dummy(t) = dummy(t) + U(j,q)*prob(t,3);
                                else
                                    dummy(t) = dummy(t) + U(j,q+1)*prob(t,3);
                                end
                            end
                            if (t==2)%checking for left
                                if(q-1==0)
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,2);
                                elseif ((q-1==2)&&(j==size(p,1)-1))
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,2);
                                else 
                                    dummy(t) = dummy(t)+U(j,q-1)*prob(t,2);
                                end
                                if(j-1==0)
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,1);
                                elseif(strcmp(p(j-1,q),'1.0')||strcmp(p(j-1,q),'-1.0'))
                                    dummy(t) = dummy(t)+U(j-1,q)*prob(t,1);
                                elseif((j-1==size(p,1)-1)&&(q==2))
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,1);
                                else
                                    dummy(t) = dummy(t)+U(j-1,q)*prob(t,1);
                                end
                                if(j+1==size(p,1)+1)
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,4);
                                elseif(strcmp(p(j+1,q),'1.0')||strcmp(p(j+1,q),'-1.0'))
                                    dummy(t) = dummy(t)+U(j+1,q)*prob(t,4);
                                elseif((j+1==size(p,1)-1)&&(q==2))
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,4);
                                else
                                    dummy(t) = dummy(t)+U(j+1,q)*prob(t,4);
                                end
                            end
                            if (t==3)%checking for right
                                if(q+1==size(p,2)+1)
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,3);
                                elseif ((q+1==2)&&(j==size(p,1)-1))
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,3);
                                elseif(strcmp(p(j,q+1),'1.0')||strcmp(p(j,q+1),'-1.0'))
                                    dummy(t) = dummy(t)+U(j,q+1)*prob(t,3);
                                else 
                                    dummy(t) = dummy(t)+U(j,q+1)*prob(t,3);
                                end
                                if(j-1==0)
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,1);
                                elseif(strcmp(p(j-1,q),'1.0')||strcmp(p(j-1,q),'-1.0'))
                                    dummy(t) = dummy(t)+U(j-1,q)*prob(t,1);
                                elseif((j-1==size(p,1)-1)&&(q==2))
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,1);
                                else
                                    dummy(t) = dummy(t)+U(j-1,q)*prob(t,1);
                                end
                                if(j+1==size(p,1)+1)
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,4);
                                elseif(strcmp(p(j+1,q),'1.0')||strcmp(p(j+1,q),'-1.0'))
                                    dummy(t) = dummy(t)+U(j+1,q)*prob(t,4);
                                elseif((j+1==size(p,1)-1)&&(q==2))
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,4);
                                else
                                    dummy(t) = dummy(t)+U(j+1,q)*prob(t,4);
                                end
                            end
                            if (t==4)%checking for down
                                if(j+1==size(p,1)+1)
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,4);
                                elseif(strcmp(p(j+1,q),'1.0')||strcmp(p(j+1,q),'-1.0'))
                                    dummy(t) = dummy(t)+U(j+1,q)*prob(t,4);
                                elseif((j+1==size(p,1)-1)&&(q==2))
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,4);
                                else
                                    dummy(t) = dummy(t)+U(j+1,q)*prob(t,4);
                                end
                                if(q+1==size(p,2)+1)
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,3);
                                elseif ((q+1==2)&&(j==size(p,1)-1))
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,3);
                                elseif(strcmp(p(j,q+1),'1.0')||strcmp(p(j,q+1),'-1.0'))
                                    dummy(t) = dummy(t)+U(j,q+1)*prob(t,3);
                                else 
                                    dummy(t) = dummy(t)+U(j,q+1)*prob(t,3);
                                end
                                if(q-1==0)
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,2);
                                elseif ((q-1==2)&&(j==size(p,1)-1))
                                    dummy(t) = dummy(t)+U(j,q)*prob(t,2);
                                else 
                                    dummy(t) = dummy(t)+U(j,q-1)*prob(t,2);
                                end
                            end
                        end
                    U(j,q) = reward + (discount*max(dummy));
                    dummy = zeros(4,1);
                    end
                end
            end
        end
        %disp(U);
    end
    for i=1:size(p,1)
        for j=1:size(p,2)
        fprintf('%6.3f ',U(i,j));
        end
        fprintf('\n');
    end
end