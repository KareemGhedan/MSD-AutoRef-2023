function [f, t] = createProofFig()
    % Create figure at right top for BOOP and Last Touch Proof with
    % tiledlayout
    % To plot to specific axes (subplot): nexttile(t,1) OR nexttile(t,2)
    f = figure('Name','Assistant Referee Proof','NumberTitle','off');
    f.Position = [860 520 1050 460];
    t = tiledlayout(f,1,2);
end