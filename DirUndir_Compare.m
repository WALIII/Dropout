%DirUndir_Compare 01

% Compare activity btw the two cases


rule1 = find( Motif_ind(3,:) ==  0 );% Undirected 
rule2 = find( Motif_ind(3,:) ==  1 );% Directed song

[idx1, calcium1, song1] = FS_PreMotor_plot2(song,calcium,align,1,Motif_ind,rule1);

[idx2, calcium2, song2] = FS_PreMotor_plot2(song,calcium,align,1,Motif_ind,rule2);

Cal{1} = calcium1; Cal{2} = calcium2 ; 
Alp{1} = align; Alp{2} = align; 
FS_PreMotor_trace_comp(Cal, Alp)



figure(); 
ax1 = subplot(211);
imagesc(song1);
ax2 = subplot(212);
imagesc(song2);
title('Undirected');
linkaxes([ax1, ax2], 'x');
a2 = align/25*48000/1000;
xlim([a2-100 a2+100]);
colormap(hot);



figure(); 
ax1 = subplot(211);
imagesc(cat(1,song1,song2));
linkaxes([ax1, ax2], 'x');
a2 = align/25*48000/1000;
xlim([a2-100 a2+100]);
ax1 = subplot(212);
imagesc(cat(1,calcium1{3},calcium2{3}));
colormap(hot);
