function [x,y,z,qx,qy,qz,qw,ts,id] = nncPolling(frame,i)
	% To be used for nncPollAll function
    % Get pose of a rigid body for 1 frame
    % input frame = NatNetClient.getFrame
    % input i = the number of rigid body found from OptiTrack
    % output position,orientation in Quaternion, time stamp, rigid body id
	
    if isempty(data.RigidBodies(1))
        fprintf( '\tPacket is empty/stale\n' )
        fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
        return
    end

    x = double(frame.RigidBodies(i).x);
    y = double(frame.RigidBodies(i).y);
    z = double(frame.RigidBodies(i).z);
    qx = double(frame.RigidBodies(i).qx);
    qy = double(frame.RigidBodies(i).qy);
    qz = double(frame.RigidBodies(i).qz);
    qw = double(frame.RigidBodies(i).qw);
    ts = double(frame.fTimestamp);
    id = double(frame.RigidBodies(i).ID);
end