function [out] = DU_assign_directed(out);

clear out.index.aligned_directed
mov_time_idx = out.mov_time(out.index.movie_idx);

for i = 1:size(out.index.song_start,2)
    Array = mov_time_idx-out.index.song_start(i);
    Array(Array<=0) = nan;
[~,loc1(i)]= min(Array);

out.index.aligned_directed(i) = out.index.directed(loc1(i));
end