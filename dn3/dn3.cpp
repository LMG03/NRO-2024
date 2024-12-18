#include <iostream>
#include <cmath>

double calcAtan(double x, int N_koraki) {
    double arctan_vrednost = 0.0;
    for (int n = 0; n < N_koraki; ++n) {
        double term = pow(-1, n) * pow(x, 2 * n + 1) / (2 * n + 1);
        arctan_vrednost += term;
    }
    return arctan_vrednost;
}

double f(double x, int N_koraki) {
    double atan_part = calcAtan(x / 2.0, N_koraki);
    return exp(3 * x) * atan_part;
}

double trapezoidalIntegration(double a, double b, int n, int N_koraki) {
    double h = (b - a) / n; 
    double integral = 0.0;

    integral += f(a, N_koraki) / 2.0;
    integral += f(b, N_koraki) / 2.0;

    for (int i = 1; i < n; ++i) {
        double x_i = a + i * h;
        integral += f(x_i, N_koraki);
    }

    integral *= h;

    return integral;
}

int main() {
    // od kje do kje integral
    double a = 0.0;
    double b = M_PI / 4.0;

    // št. podintervalov
    int n = 1000;

    int N_koraki = 10;
    double result = trapezoidalIntegration(a, b, n, N_koraki);

    std::cout << "Vrednost našega integrala je: " << result << std::endl;

    return 0;
}