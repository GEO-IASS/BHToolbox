function adjustFigSize(fig, horz, vert, varargin)

[option] = process_options(varargin, 'option', 'none');

screensize = get( groot, 'Screensize');
width = screensize(3);
height = screensize(4);
if strcmp(option,'none')
    set(fig,'Position',[(width/2)-horz/2, (height/2)-vert/2, horz, vert]);
elseif strcmp(option,'full')
    horz = 0.98*width;
    vert = 0.85*height;
    set(fig,'Position',[(width/2)-horz/2, (height/2)-vert/2, horz, vert]);
end

end