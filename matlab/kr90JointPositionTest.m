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


KR90=kr90_mdl;

initOri=[1 0 0;0 -1 0;0 0 -1];
initPos=[0.3;1.9;0.92]
n0=KR90.ikine([initOri,initPos;0 0 0 1]);
setJoints(clientID,handle_motor,vrep,n0);
T=KR90.fkine(n0);
pause(10);
trajPosX1=0.3:-0.01:-0.3;
trajPosY1=1.9:-0.01:1.7;
for i=1:size(trajPosX1,2)
    T(1,4)=trajPosX1(i);
    nq=KR90.ikine(T,n0);
    setJoints(clientID,handle_motor,vrep,nq)
    pause(0.1)
end
for i=1:size(trajPosY1,2)
    T(2,4)=trajPosY1(i);
    nq=KR90.ikine(T,n0);
    setJoints(clientID,handle_motor,vrep,nq)
    pause(0.1)
end

    else
        disp('Failed connecting to remote API server');
    end
    vrep.delete(); % call the destructor!
    
    disp('Program ended');
end


function setJoints(clientID,handle_motor,vrep,newJoints)
for i=1:6
   %newJoints(i)=deg2rad(newJoints(i));
   vrep.simxSetJointTargetPosition(clientID,handle_motor(i),newJoints(i),vrep.simx_opmode_oneshot); 
end
end

function  actualJoints=getJoints(clientID,handle_motor,vrep)
for i=1:6
   [resp, actualJoints(i)] = vrep.simxGetJointPosition(clientID,handle_motor(i),vrep.simx_opmode_blocking);
end
end
