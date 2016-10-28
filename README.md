![alt text](https://raw.githubusercontent.com/soundbooze/soundbooze-feature/master/uduk.png "UDUK")

# CupLiKhan
Noise and Distortion Resistant Audio Fingerprinting written in Octave. Proof of concept, not meant to be used in production environment. There are many area of improvements need to be done.

# Usage

```
>> cuplikhan_build
[+] Building chromaprint: mp3/
Elapsed time is 1000.43 seconds.

>> cuplikhan_lookup(V, 'q/query_test.mp3');
[+] Playing query
[+] Searching
[+] Max value:
maximum correlation: 0.186237 idx: 1791 | frame (6615001)
filename: mp3//song49.mp3

(*) Lookup
Elapsed time is 9.48699 seconds.

```

## Requirements

GNU Octave
(https://www.gnu.org/software/octave/)

MP3 Read
(http://www.ee.columbia.edu/ln/rosa/matlab/mp3read.html)

OpenBSD Songs
(http://openbsd.cs.toronto.edu/pub/OpenBSD/songs/)
___

![alt text](https://licensebuttons.net/l/by-nc/3.0/88x31.png "Creative Commons")
###Attribution-NonCommercial 
###CC BY-NC

This license lets others remix, tweak, and build upon your work non-commercially, and although their new works must also acknowledge you and be non-commercial, they don’t have to license their derivative works on the same terms.
