addpath ..

% test a simple harmonic oscillator
deriv = @(x) [x(2); -x(1)];

% end the integration when the the first component equals 0
collision = @(x) x(1);

% initial conditions and 
x0 = [1,0];
h = 0.1;

[T,X] = rk_solve(deriv, h, x0, collision);

plot(T,X(1,:))

