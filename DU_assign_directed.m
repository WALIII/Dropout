function [out] = DU_assign_directed(out);

mov_time_idx = out.mov_time(out.index.movie_idx);

for i = 1:size(out.index.song_start,2)
[~,loc1(i)]= min(abs(out.index.song_start(i)-mov_time_idx));
out.index.aligned_directed(i) = out.index.directed(loc1(i));
end