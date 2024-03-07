clc
clear

data = load('Data/Livestream/data.mat');
model = load('Data\Livestream\model.mat');
% Poll for the rigid body data a regular intervals (~1 sec) for 10 sec.
	fprintf( '\nPrinting rigid body frame data approximately every second for 10 seconds...\n\n' )
	for idx = 1 : 10  
		java.lang.Thread.sleep( 996 );
		%data = natnetclient.getFrame; % method to get current frame
		
		if (isempty(data.RigidBodies(1)))
			fprintf( '\tPacket is empty/stale\n' )
			fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
			return
		end
		fprintf( 'Frame:%6d  ' , data.iFrame )
		fprintf( 'Time:%0.2f\n' , data.fTimestamp )
		for i = 1:model.RigidBodyCount
			fprintf( 'Name:"%s"  ', model.RigidBody( i ).Name )
            data.model.RigidBody.
			fprintf( 'X:%0.1fmm  ', data.RigidBodies( i ).x * 1000 )
			fprintf( 'Y:%0.1fmm  ', data.RigidBodies( i ).y * 1000 )
			fprintf( 'Z:%0.1fmm\n', data.RigidBodies( i ).z * 1000 )			
		end
	end 
	disp('NatNet Polling Sample End' )