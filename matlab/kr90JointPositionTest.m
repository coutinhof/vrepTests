function kr90JointPositionTest()

    disp('Program started');
    % vrep=remApi('remoteApi','extApi.h'); % using the header (requires a compiler)
    vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    vrep.simxFinish(-1); % just in case, close all opened connections
    clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

    if (clientID>-1)
        disp('Connected to remote API server');
        

        
% Recebendo os handlers dos necessarios
for i=1:6
    [resp, handle_motor(i)] = vrep.simxGetObjectHandle(clientID,strcat('joint',int2str(i)),vrep.simx_opmode_blocking);
end


%Test posição juntas
% Recebendo os handlers dos necessarios
for i=1:6
    [resp, juntaPos(i)] = vrep.simxGetJointPosition(clientID,handle_motor(i),vrep.simx_opmode_blocking);
end
juntaPos=juntaPos*(180/pi)

    else
        disp('Failed connecting to remote API server');
    end
    vrep.delete(); % call the destructor!
    
    disp('Program ended');
end