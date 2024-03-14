function [x,y,z,qx,qy,qz,qw,ts,id] = nncPolling(nnc,i)
	% Get pose of a rigid body for 1 frame
    % input nnc = instance of NatNet client
    % input i = the number of rigid body found from OptiTrack
    % output position,orientation in Quaternion, time stamp, rigid body id

    % Get data 
	data = nnc.getFrame; % method to get current frame
	
    if isempty(data.RigidBodies(1))
        fprintf( '\tPacket is empty/stale\n' )
        fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
        return
    end

    x = double(data.RigidBodies(i).x);
    y = double(data.RigidBodies(i).y);
    z = double(data.RigidBodies(i).z);
    qx = double(data.RigidBodies(i).qx);
    qy = double(data.RigidBodies(i).qy);
    qz = double(data.RigidBodies(i).qz);
    qw = double(data.RigidBodies(i).qw);
    ts = double(data.fTimestamp);
    id = double(data.RigidBodies(i).ID);
end