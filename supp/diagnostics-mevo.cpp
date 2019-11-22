
#include <RcppArmadillo.h>
#include <vector>  // vector class
#include <cmath>


using namespace Rcpp;

//[[Rcpp::depends(RcppArmadillo)]]
//[[Rcpp::plugins(cpp11)]]



/*
 ======================================================================================
 ======================================================================================

 +Gamma model functions

 ======================================================================================
 ======================================================================================
 */



//' Incomplete Gamma function
//'
//' @noRd
//'
inline double incG(const double& a, const double& z) {
    return R::pgamma(z, a, 1.0, 0, 0) * R::gammafn(a);
}




//' Mean of truncated Gamma distribution
//'
//' From http://dx.doi.org/10.12988/astp.2013.310125.
//' As in that paper, b > 0 is the scale and c > 0 is the shape.
//'
//' @noRd
//'
double trunc_Gamma_mean(const double& b, const double& c,
                        const double& xl, const double& xu) {

    // Ran the following in Mathematica to find out that this part goes to
    // zero as xu goes to infinity:
    // > Limit[b^(-c + 1) Exp[-x/b] x^c, x -> Infinity, Assumptions -> c in real && b > 0]
    // So if xu is Inf, then we set this to zero:
    double k_;
    if (xu == arma::datum::inf) {
        k_ = 0;
    } else {
        k_ = std::exp(-1.0 * xu / b) * std::pow(b, 1-c) * std::pow(xu, c);
    }
    double k = c / (
        b * incG(1+c, xl/b) - b * incG(1+c, xu/b) +
            k_ -
            std::exp(-1.0 * xl / b) * std::pow(b, 1.0 - c) * std::pow(xl, c)
    );
    double z = -(b * b) * k * (- incG(1+c, xl / b) + incG(1+c, xu / b));
    return z;
}

//' Create a vector of Gamma values for a discrete Gamma distribution.
//'
//'
//' @noRd
//'
//[[Rcpp::export]]
std::vector<double> discrete_gamma(const unsigned& k, const double& shape) {

    std::vector<double> gammas;

    if (shape <= 0 || k <= 1) {
        gammas.push_back(1.0);
        return gammas;
    }

    gammas.reserve(k);

    double scale = 1 / shape;
    double d_k = 1.0 / static_cast<double>(k);

    double p_cutoff = d_k;
    double xl = 0, xu = 0;

    for (unsigned i = 0; i < k; i++) {
        xl = xu;
        if (p_cutoff < 1) {
            xu = R::qgamma(p_cutoff, shape, scale, 1, 0);
        } else xu = arma::datum::inf;
        gammas.push_back(trunc_Gamma_mean(scale, shape, xl, xu));
        p_cutoff += d_k;
    }

    return gammas;

}

