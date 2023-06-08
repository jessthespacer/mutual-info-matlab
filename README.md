# MATLAB `mutualInfo()` function

Fast MATLAB function to calculate the mutual information of two images. Designed specifically for speed and to emulate functionality of MATLAB native `entropy()` function. For details on usage, see function docstring or execute `help mutualInfo`.

# Theory
The mutual information $I$ of two images $A$ and $B$ is given by [1]:

$$ I(A, B) = \sum_{a, b} p_{AB}(a, b) \log_2{\frac{p_{AB}(a, b)}{p_A(a)\ p_B(b)}} $$

Where $p_{AB}$ is the joint probability density function of the gray-levels of the images, and $p_A$ and $p_B$ are the probability density functions of the gray-levels of images $A$ and $B$, respectively.

The information entropy $H$ of an image $A$ is given by [2]:

$$ H(A) = -\sum_{a} p(a) \log_2{p(a)} $$

Where $p$ is the probability density function of the gray-levels of $A$.

The joint entropy of two images $A$ and $B$ is then given by [2]:

$$ H(A, B) = -\sum_{a} \sum_{b} p(a, b) \log_2{p(a, b)} $$

And the conditional entropy accordingly by [2]:

$$ H(B|A) = -\sum_{a} \sum_{b} p(a, b) \log_2{p(b|a)} $$

The mutual information of the images can then be expressed in terms of entropy by [2]:

$$ I(A, B) = H(B) - H(B|A) $$

The mutual information of an image with itself is then [2]:

$$ I(A, A) = H(A) - H(A|A) = H(A) $$

Therefore, the mutual information of an image with itself is equal to its entropy. For a given image `A` in MATLAB, `mutualInfo(A, A)` will yield a numerical result that is close to but not exactly identical to the result of `entropy(A)` due to floating point error.

# References
[1] F. Maes, D. Loeckx, D. Vandermeulen, and P. Suetens, “Image registration using mutual information,” in Handbook of Biomedical Imaging: Methodologies and Clinical Research, N. Paragios, J. Duncan, and N. Ayache, Eds., Boston, MA: Springer US, 2015, pp. 295–308. doi: [10.1007/978-0-387-09749-7_16](http://doi.org/10.1007/978-0-387-09749-7_16).

[2] T. M. Cover and J. A. Thomas, “Entropy, Relative Entropy, and Mutual Information,” in Elements of Information Theory, 2nd ed.Hoboken, NJ: Wiley-Interscience, 2006, pp. 13–55.
