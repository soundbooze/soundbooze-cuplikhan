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
 
function [v, t] = chromagram (x, fs)
    hopLength = 2048;
    blockLength = 4096;
    hannWindow = hann(blockLength,'periodic');
    
    if (size(x,2) > 1)
        x = mean(x,2);
    end

    if (length(x) > 1)
        x = x/max(abs(x));
    end      

    [X,f,t] = spectrogram([x; zeros(blockLength,1)],...
                                hannWindow,...
                                blockLength - hopLength,...
                                blockLength,...
                                fs);

    X = abs(X)*2/blockLength;
    v = chromaprint(X, fs);   
end

function [vpc] = chromaprint(X, fs)
    vpc = zeros(12, size(X,2));
    H  = generatePcFilters(size(X,1), fs);
    vpc = H * X.^2;
    vpc = vpc ./ repmat(sum(vpc,1), 12, 1);
    vpc (:,sum(X,1) == 0) = 0;
end

function [H] = generatePcFilters (iFftLength, fs)
    f_mid = 261.63;
    iNumOctaves = 4;
    
    while (f_mid*2^iNumOctaves > fs/2 )
        iNumOctaves = iNumOctaves - 1;
    end
    
    H = zeros (12, iFftLength);
    
    for (i = 1:12)
        afBounds  = [2^(-1/24) 2^(1/24)] * f_mid * 2* iFftLength/fs;
        for (j = 1:iNumOctaves)
           iBounds = [ceil(2^(j-1)*afBounds(1)) floor(2^(j-1)*afBounds(2))];
           H(i,iBounds(1):iBounds(2)) = 1/(iBounds(2)+1-iBounds(1));
        end
        f_mid   = f_mid*2^(1/12);
    end   
end