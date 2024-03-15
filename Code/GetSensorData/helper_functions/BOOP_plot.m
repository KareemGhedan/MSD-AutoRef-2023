function BOOP_plot(field_corners, ball_pos, ball_radius, t)
    % Create subplot to figure 1st axis
    % Require 4 inputs
    % Input field_size = 4 points of the field in [z_left z_right;x_bot x_top]
    % Input ball_pos = x and z position of the ball in [x z]
    % Input ball_radius = ball radius in meter
    % Input t = TiledChartLayout object

    % Choose the first axis
    nexttile(t,1);
    hold on

    % Plot field
    p1 = plot([field_corners(2,1) field_corners(2,1)], [field_corners(1,1) field_corners(1,2)], "black");
    plot([field_corners(2,2) field_corners(2,2)], [field_corners(1,1) field_corners(1,2)], "black")
    plot([field_corners(2,1) field_corners(2,2)], [field_corners(1,1) field_corners(1,1)], "black")
    plot([field_corners(2,1) field_corners(2,2)], [field_corners(1,2) field_corners(1,2)], "black")
    plot([0 0], [field_corners(1,1) field_corners(1,2)], "black")
    
    % Plot ball
    th = 0:pi/50:2*pi;
    xunit = ball_radius * cos(th) + ball_pos(1);
    yunit = ball_radius * sin(th) + ball_pos(2);
    b1 = plot(xunit, yunit, 'm', 'LineWidth', 2);
    % plot(ball_pos(1), ball_pos(2), 'o', 'MarkerSize', convlength(ball_radius*2,'m','in')/72)
    % circle(ball_pos(1),ball_pos(2),ball_radius);
    
    grid on
    ylim([-7 7])
    xlim([-7 7])
    title('Ball Out Of Play Proof')
    xlabel('[meter] at x-axis')
    ylabel('[meter] at z-axis')
    legend([p1, b1], {'field line','ball position'});
    hold off
end