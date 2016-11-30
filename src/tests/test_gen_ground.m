% generate N knot points as well as a finer grid to make sure the interpolation is
% working
N = 20;
x_0 = 0; x_end = 1;
x = linspace(x_0,x_end,N);
eps = 1e-6;
x_fine = linspace(x_0+eps,x_end-eps,N*10);

% generate a rough terrain with gaussian noise
y1 = randn(size(x));
y2 = randn(size(x));

% create the ground functions
g1 = gen_ground(x,y1);
g2 = gen_ground(x,y2);

% compute the ground locations on the fine grid
g1_vec = zeros(size(x_fine));
g2_vec = zeros(size(x_fine));
for i=1:length(g1_vec)
    g1_vec(i) = g1(x_fine(i));
    g2_vec(i) = g2(x_fine(i));
end

% plot the ground points against the computed ground on the finer grid and
% show that the two terrains are different
plot(x,y1); hold on
plot(x_fine,g1_vec,'o')

plot(x,y2);
plot(x_fine,g2_vec,'o')