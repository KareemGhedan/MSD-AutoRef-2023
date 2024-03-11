%% for streaming data
%% modified with the code from NatNetPollingSample code
% Motive 2.3 and Natnet 4.0

%% defining the client
nat = natnet;
%% adding in ip addresses and connection types
nat.HostIP = '192.168.5.101';
nat.ClientIP = '192.168.6.193';
% nat.ConnectionType = 'Multicast';
nat.ConnectionType = 'Unicast';
%% connecting to the host and checking the connection
nat.connect;
% checking if connection is successful
if ( nat.IsConnected == 0 )
    fprintf( 'Client failed to connect\n' )
    fprintf( '\tMake sure the host is connected to the network\n' )
    fprintf( '\tand that the host and client IP addresses are correct\n\n' )
    return
end
%% getting the asset descriptions for the asset and checking the number of assets
model = nat.getModelDescription;
% checking number of rigid bodies
if ( model.RigidBodyCount < 1 )
    fprintf('\tNo Ridid bodies\n')
    return
end
%% getting data of a single frame and corresponding data

frame1 = nat.getFrame;

% check to verify that data streaming is working
if (isempty(frame1.RigidBodies(1)))
    fprintf( '\tPacket is empty/stale\n' )
    fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
    return
end

% frame number
frame1.iFrame;

% time 
frame1.fTimestamp;

% Co-ordinates quaternions of the rigid bodies
for i = 1:model.RigidBodyCount
    % name of the rigidbody
    Name = frame1.RigidBody( i ).Name
    % ID of the rigidbody
    ID = frame1.RigidBodies(i).ID
    % X value of the rigidbody in mm
    x = frame1.RigidBodies( i ).x * 1000
    % Y value of the rigidbody in mm
    y = frame1.RigidBodies( i ).y * 1000
    % Z value of the rigidbody in mm
    z = frame1.RigidBodies( i ).z * 1000 
    % Quaternion X value of the rigidbody
    qx = frame1.RigidBodies( i ).qx
    % Quaternion Y value of the rigidbody
    qy = frame1.RigidBodies( i ).qy
    % Quaternion Z value of the rigidbody
    qz = frame1.RigidBodies( i ).qz
    % Quaternion W value of the rigidbody
    qw = frame1.RigidBodies( i ).qw
    % Meanerror
    meanerror = frame1.RigidBodies( i ).MeanError



    % Sample calculation of rotation from quaternions
    q = quaternion(qx, qy, qz, qw)

    % there are two ways to get orientations. One is euler angles and the other
    % is the outcome in 3D by single orientation.


    % calculating Euler angles
    qmat = [qw qx qy qz];
    % Rotation matrix
    R = quat2rotm(qmat);
    % euler angles, use what rotation type is needed.
    eulangles = rotm2eul(R,"ZYX")

    % Single orientation in 3D
    % rotation angle
    theta = 2 * acos(qw)
    % unit vector
    u = [qx, qy, qz] / sqrt(1 - qw^2)


end


%% making it into a loop
% this is how we can collect data for longer windows. Instead of for loop,
% we can implement a while loop where the data will be taken whenever the
% conditions becomes false


for idx = 1:5000

    data = nat.getFrame;

    % check to verify that data streaming is working
    if (isempty(data.RigidBodies(1)))
        fprintf( '\tPacket is empty/stale\n' )
        fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
        return
    end

    % frame number
    data.iFrame;

    % time
    data.fTimestamp;


    

    for i=1:model.RigidBody

        % name of the rigidbody
        Name = frame1.RigidBody( i ).Name;
        % ID of the rigidbody
        ID = frame1.RigidBodies(i).ID;
        % X value of the rigidbody in mm
        x = frame1.RigidBodies( i ).x * 1000;
        % Y value of the rigidbody in mm
        y = frame1.RigidBodies( i ).y * 1000;
        % Z value of the rigidbody in mm
        z = frame1.RigidBodies( i ).z * 1000;
        % Quaternion X value of the rigidbody
        qx = frame1.RigidBodies( i ).qx;
        % Quaternion Y value of the rigidbody
        qy = frame1.RigidBodies( i ).qy;
        % Quaternion Z value of the rigidbody
        qz = frame1.RigidBodies( i ).qz;
        % Quaternion W value of the rigidbody
        qw = frame1.RigidBodies( i ).qw;
        % Meanerror
        meanerror = frame1.RigidBodies( i ).MeanError;



        % Sample calculation of rotation from quaternions
        q = quaternion(qx, qy, qz, qw);

        % there are two ways to get orientations. One is euler angles and the other
        % is the outcome in 3D by single orientation.


        % calculating Euler angles
        qmat = [qw qx qy qz];
        % Rotation matrix
        R = quat2rotm(qmat);
        % euler angles, use what rotation type is needed.
        eulangles = rotm2eul(R,"ZYX");

        % Single orientation in 3D
        % rotation angle
        theta = 2 * acos(qw);
        % unit vector
        u = [qx, qy, qz] / sqrt(1 - qw^2);


    end


end



%% further processing the data

% [~,ind] = unique(mat,'rows', 'first');
% matunique = mat(sort(ind),:);
% 
% timediff = zeros(length(matunique(:,1)),1);
% for i=2:length(matunique(:,1))
% 
%     timediff(i) = matunique(i,1)-matunique(i-1,1);
% 
% end
% 
% freqint = 1./timediff;
% 
% matunique = [matunique timediff freqint];
% save matunique.mat;