function nnc = setNNC(connectionType, clientIP, hostIP)
    % Function to instantiate natnet client class
    % Require no input, 3 optional input
    % Input connectionType: 'Unicast' default or 'Multicast'
    % Input clientIP: your IP (e.g. '192.168.232')
    % Input hostIP: server IP (e.g. '192.168.5.101')

    if nargin > 3
        error("Error: Too many inputs")
    end

    switch nargin
        case 0
            connectionType = 'Unicast';
            clientIP = '192.168.6.232';     % Change to your IP address
            hostIP = '192.168.5.101';
        case 1
            clientIP = '192.168.6.232';     % Change to your IP address
            hostIP = '192.168.5.101';
        case 2
            hostIP = '192.168.5.101';
    end

    % create an instance of the natnet client class
    nnc = natnet;

	% connect the client to the server (unicast/multicast over local loopback)
	nnc.HostIP = hostIP;
	nnc.ClientIP = clientIP;
	nnc.ConnectionType = connectionType;
	nnc.connect;
	if ( nnc.IsConnected == 0 )
		fprintf( 'Client failed to connect\n' )
		fprintf( '\tMake sure the host is connected to the network\n' )
		fprintf( '\tand that the host and client IP addresses are correct\n\n' ) 
		return
    else
        fprintf( 'Client is connected\n' )
	end
end