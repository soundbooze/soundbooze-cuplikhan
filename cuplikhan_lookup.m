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
 
function [] = cuplikhan_lookup(V, filename)
  
  [q, qfs] = mp3read(filename);

  disp('[+] Playing query');
  fflush (stdout);

  sound(q, qfs);

  tic;

  [qch,qt] = chromagram(q, qfs);

  [mq, nq] = size(qch);
  Q = reshape(qch, 1, mq * nq);

  disp('[+] Searching');
  fflush (stdout);

  idx = 1;
  for i = 1 : length(V)
     [mf, nf] = size(V(i).chromaprint);
     Q = resize(Q, mf, nf);
     holder(idx++) = corr(Q, V(i).chromaprint);
  endfor

  disp('[+] Max value:');
  fflush (stdout);

  maximum = max(holder);
  mindex = find(holder==maximum);

  printf("maximum correlation: %d idx: %d | frame (%d)\n", maximum, mindex, V(mindex).i);
  printf("filename: %s\n", V(mindex).f);
  printf('\n(*) Lookup\n');
  
  toc;
  fflush (stdout);

  [f, fs] = mp3read(V(mindex).f);
  f = f(V(mindex).i : V(mindex).i + (length(q)));
  sound(f, fs);

end