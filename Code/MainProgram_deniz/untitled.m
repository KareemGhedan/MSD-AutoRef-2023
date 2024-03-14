t = uitable;
c = uicontrol('Style','checkbox','String','Add data');
c.Position = [320 100 80 20];
waitfor(c,'Value');
t.Data = magic(5);