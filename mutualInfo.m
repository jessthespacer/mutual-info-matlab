function I = mutualInfo(A, B, bitdepth)
    % MUTUALINFO Calculates the mutual information between two digital
    % images.
    %
    %   I = MUTUALINFO(A, B)        Mutual information of images A and B of
    %   identical size, using 256 bins for histograms.
    %
    %   I = MUTUALINFO(A, B, bitdepth)  Mutual information of images A and
    %   B of identical size, using 2^bitdepth bins for histograms.
    %
    %   It is assumed that 0*log2(0) = 0.
    %
    %   The result of MUTUALINFO(X, X) is nearly equal to that of
    %   entropy(X) for an arbitrary image X. Theoretically, they should be
    %   exactly equal, but are not in practice due to floating-point error.
    %   
    %   See also ENTROPY.
    %
    %   Adapted from <a href="matlab:web('https://www.mathworks.com/matlabcentral/fileexchange/13289-fast-mutual-information-of-two-images-or-signals')">MI</a> by Jose Delpiano.
    %
    %   References:
    %   T. M. Cover and J. A. Thomas, "Entropy, Relative Entropy, and
    %       Mutual Information," in Elements of Information Theory, 2nd ed.
    %       Hoboken, NJ: Wiley-Interscience, 2006, pp. 13–55.
    %   F. Maes, D. Loeckx, D. Vandermeulen, and P. Suetens, "Image
    %       registration using mutual information," in Handbook of
    %       Biomedical Imaging: Methodologies and Clinical Research,
    %       N. Paragios, J. Duncan, and N. Ayache, Eds., Boston, MA:
    %       Springer US, 2015, pp. 295–308. doi: 10.1007/978-0-387-09749-7_
    %       16.
    
    % Input validation, default to 8-bit if no bit depth provided
    arguments
        A {mustBeNonnegative, mustBeInteger}
        B {mustBeNonnegative, mustBeInteger}
        bitdepth (1,1) {mustBePositive, mustBeInteger} = 8
    end

    maxGL = 2^bitdepth - 1; 

    % Normalize gray levels to range [0, 1]
    if ~islogical(A)
        A = double(A)/maxGL;
        B = double(B)/maxGL;
        L = maxGL + 1;
    else
        L = 2;
    end
    
    % Calculate gray-level probability distributions
    pa = histcounts(A, L, ...
        BinLimits=[0 1], ...
        Normalization='probability');
    pb = histcounts(B, L, ...
        BinLimits=[0 1], ...
        Normalization='probability');
    pab = histcounts2(A, B, L, ...
        XBinLimits=[0 1], ...
        YBinLimits=[0 1], ...
        Normalization='probability');

    % Calculate mutual information
    papb = pa'*pb;
    idx = papb > 1e-12 & pab > 1e-12;   % Screen out singularities
    I = sum(pab(idx).*log2(pab(idx) ./ papb(idx)));
end