function [CaSignal] = FJ_Traces(data)

[data2, n] = FS_Format(data,10);
files = imresize(data2,0.25);
%files = convn(files(:,:,8:end), single(reshape([1 1 1] / 3, 1, 1, [])), 'same'); % Smooth
[SpatMap,CaSignal,width,height,contour,Json] = CaImSegmentation2(files,40,7,2,1)


% plot traces
% figure(); for i = 1:30; plot(zscore(CaSignal(i,:))+i*3, 'linewidth',2); hold on; end; axis tight off
