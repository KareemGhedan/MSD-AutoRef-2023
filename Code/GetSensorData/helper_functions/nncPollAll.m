function data = nncPollAll(nnc)
    % Poll all rigid bodies for 1 frame
    % input nnc = instance of NatNet client
    % output data = matrix with rows [x,y,z,qx,qy,qz,qw,ts,id] and columns of Rigid Bodies
    % Require 1 input, 4 optional input

    model = nnc.getModelDescription();
    if ( model.RigidBodyCount < 1 )
        fprintf( 'No Rigid Body found\n' )
	    return
    end
    
    nBodies = model.RigidBodyCount;
    data = zeros(9,nBodies);
    for i = 1:nBodies
        [x,y,z,qx,qy,qz,qw,ts,id] = nncPolling(nnc,i);
        data(:,i) = [x,y,z,qx,qy,qz,qw,ts,id]';
    end
end