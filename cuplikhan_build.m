%{

/*
 * Copyright (c) 2015 SoundBooze <soundbooze@gmail.com>
 *                            _ _                        
 *  ___  ___  _   _ _ __   __| | |__   ___   ___ _______ 
 * / __|/ _ \| | | | '_ \ / _` | '_ \ / _ \ / _ \_  / _ \
 * \__ \ (_) | |_| | | | | (_| | |_) | (_) | (_) / /  __/
 * |___/\___/ \__,_|_| |_|\__,_|_.__/ \___/ \___/___\___|
 *                                                     
 *
 */
 
%}
 
tic;

directory = 'mp3/';

printf('[+] Building chromaprint: %s\n', directory);
fflush (stdout);

list = dir(directory);

z = 1;
for i = 3 : length(list)
  filename = [directory "/" list(i).name];
  [db, dbfs] = mp3read(filename);
  db = (db(:,1)+db(:,2) ) ./ max(abs(db(:,1)+db(:,2)));
      
  queryLen = dbfs * 30;
  step = dbfs;
  totalLen = length(db) - queryLen;
  
  for i = 1: step : totalLen
    frame_start = i;
    frame_end = i + queryLen;
    [fch,ft] = chromagram(db(frame_start:frame_end), dbfs);
    
    [mf, nf] = size(fch);
    F = reshape(fch, 1, mf * nf);  
    V(z).chromaprint = F;
    V(z).f = filename;
    V(z).i = i;
    z++;
  endfor
endfor

toc;