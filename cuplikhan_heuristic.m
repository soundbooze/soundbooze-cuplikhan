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

[q, qfs] = mp3read("q/query_noise.mp3");

disp('[+] Playing query');
fflush (stdout);

sound(q, qfs);

[qch,qt] = chromagram(q, qfs);

disp('[+] Searching');
fflush (stdout);

zIndex = 1;

for i = 3 : 7
  filename = ["mp3/song4" num2str(i) ".mp3"];
  [db, dbfs] = mp3read(filename);
  db = (db(:,1)+db(:,2) ) ./ max(abs(db(:,1)+db(:,2)));
      
  queryLen = length(q);
  step = dbfs;
  totalLen = length(db) - queryLen;

  idx = 1;
  for i = 1: step : totalLen
    frame_start = i;
    frame_end = i + queryLen;
    [fch,ft] = chromagram(db(frame_start:frame_end), dbfs);
    
    [mq, nq] = size(qch);
    [mf, nf] = size(fch);
    Q = reshape(qch, 1, mq * nq);
    F = reshape(fch, 1, mf * nf);

    holder(idx++) = corr(Q, F);
  endfor

  a3(zIndex).maximum = max(holder);
  a3(zIndex).idx = find(holder==max(holder));
  a3(zIndex++).f = filename;
endfor

maxim = 0;
maxid = 0;
n = 0;

for i = 1 : length(a3)
  mm = a3(i).maximum;
  if (mm > maxim)
    maxim = mm;
    maxid = a3(i).idx;
    n = i;
  endif
endfor

disp('[+] Max value:');
fflush (stdout);

printf("maximum correlation: %d idx: %d\n", a3(n).maximum, a3(n).idx);
printf("filename: %s\n", a3(n).f);
fflush (stdout);

[f, fs] = mp3read(a3(n).f);
f = f(fs * a3(n).idx : fs * a3(n).idx + fs * (length(q) / qfs));
sound(f, fs);

toc;