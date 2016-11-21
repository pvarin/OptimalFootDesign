addpath ..

% test a simple harmonic oscillator
deriv = @(x) [x(2); -x(1)];

% setup the domain
N = 100;
t = linspace(0,10,N);
h = t(2)-t(1);

% initialize the solution and set initial condition
X = zeros(2,N);
X(:,1) = [1;0];

% integrate
for i=2:N
    X(:,i) = rk_step(deriv,X(:,i-1),h);
end

plot(t,X(1,:),'o'); hold on
plot(t,cos(t))