%% Activitat 1

lambda = 2;
N = 20;
g = poissrnd(ones(N,1) * lambda);

%% Activitat 2

gs = 0:max(g);
figure(1); cla; hold on
hist(g, gs);
plot(gs, N * lambda.^gs * exp(-lambda) ./ factorial(gs));
legend('Histograma de g', 'Distribució teòrica');

%% Activitat 3

lambda_a = 2/(N*(N+1)) * (1:N) * g
lambda_b = sum(g) / N
lambda_c = sum(g) / (2*N)

%% Activitats 4, 5, 6

N = 1:20;
figure(2); cla; hold on
colors = { [1 .5 0], [0 .45 .74], [.5 0.18 0.56] };
xlim([N(1) N(end)]);

plot(lambda * (2*(2*N + 1)) ./ (3*N.*(N + 1)), 'Color', colors{1});
plot(lambda ./ N, 'LineWidth', 2, 'Color', colors{2});
plot(lambda ./ (4*N) + lambda^2 / 4, 'Color', colors{3});
plot(lambda ./ (4*N), 'Color', [.5 .5 .5]);

R = 1000;
lambdas = [];
for N = 1:20
    g = poissrnd(ones(N,R) * lambda);
    lambdas(N,:,1) = 2/(N*(N+1)) * (1:N) * g;
    lambdas(N,:,2) = sum(g, 1) / N;
    lambdas(N,:,3) = sum(g, 1) / (2*N);
end

for i = 1:3
    plot(mse(lambdas(:,:,i)', lambda), 'x', 'Color', colors{i});
    plot(mse(round(lambdas(:,:,i))', lambda), '*', 'Color', colors{i});
end

legend('MSE\{\lambda_A\}', 'MSE\{\lambda_B\} (CRB)', 'MSE\{\lambda_C\}', 'Var\{\lambda_C\}');

%% Utilitats

function e = mse(x_e, x)
    e = mean((x_e - x).^2);
end
