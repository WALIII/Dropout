function out = DU_Voltage(voltage);

figure();
hold on;

% find peaks


count1 = 1;
count2 = 1;
count3 = 1;

% pad
pad = 100;

% Range
R = [6600 0.95*1e4  1.4*1e4];
R2 = [8000 1.2*1e4 1.5*1e4];

for i = 1:size(voltage(:,:),1)
    plot(1:size(voltage,2),voltage(i,:)+800*i);
    % Range 2
        [a,b]  = findpeaks(voltage(i,:),'MinPeakHeight',400);
        if size(b,2)>0;
        for ii = 1: size(b,2);
            if b(ii)>R(1) && b(ii)<R2(1);
                out.spikes1(count1,:) = voltage(i,b(ii)-pad:b(ii)+pad);
                count1 = count1+1;
            elseif b(ii)>R(2) && b(ii)<R2(2);
                out.spikes2(count2,:) = voltage(i,b(ii)-pad:b(ii)+pad);
                count2 = count2+1;
            elseif b(ii)>R(3) && b(ii)<R2(3);
                out.spikes3(count3,:) = voltage(i,b(ii)-pad:b(ii)+pad);
                count3 = count3+1;
            end
        end
        end

end

% RGB
line([R(1) R(1)], [0 10e4],'Color','r');
line([R2(1) R2(1)], [0 10e4],'Color','r');

line([R(2) R(2)], [0 10e4],'Color','g');
line([R2(2) R2(2)], [0 10e4],'Color','g');

line([R(3) R(3)], [0 10e4],'Color','b');
line([R2(3) R2(3)], [0 10e4],'Color','b');


figure(); 
hold on; 
plot(-out.spikes1','r'); 
plot(-out.spikes3','b');
plot(-out.spikes2','g');


