function varargout = spectrogram (varargin)
  if nargin == 5
    [varargout{1:nargout}] = specgram (varargin{1},varargin{4},varargin{5},varargin{2},varargin{3}); 
  elseif nargin == 4
    [varargout{1:nargout}] = specgram (varargin{1},varargin{4},[],varargin{2},varargin{3}); 
  elseif nargin == 3
    [varargout{1:nargout}] = specgram (varargin{1},[],[],varargin{2},varargin{3}); 
  elseif nargin == 2
    [varargout{1:nargout}] = specgram (varargin{1},[],[],varargin{2},[]); 
  elseif nargin == 1
    [varargout{1:nargout}] = specgram (varargin{1},[],[],hamming(256),[]); 
  end
endfunction