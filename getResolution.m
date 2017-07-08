function[out]=getResolution()

info = imaqhwinfo('winvideo');

if (isempty(info.DeviceIDs))
    error('No Image Aquisition Adaptor available');
end

f= info.DeviceInfo.SupportedFormats;
max=0;

for i=1:length(f)
    a=f{i};
    s = regexprep(a, 'RGB24_', '');
    s = regexprep(s, 'YUY2_', '');
    s = regexprep(s, 'I420_', '');
    s = regexprep(s, 'x', '*');
    if max<eval(s)
        out=a;
        max=eval(s);
    end
end

end
