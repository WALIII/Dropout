
figure();
for i = 1:size(data.directed,1)
    
    plot(squeeze(data.directed(i,:,1)),'r')
    [c(:,i)] = constrained_foopsi(y)
    plot(c(:,i),'b');
    hold on;
end
