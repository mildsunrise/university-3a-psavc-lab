lambda0 = 2;
lambda1 = 5;
p = 0.8;

%% Activitat 1

T = 5;
alpha = 0.05;

gamma_p = poissinv(1 - alpha, lambda0 * p * T)
P_FA = 1 - poisscdf(gamma_p, lambda0 * p * T)
P_D  = 1 - poisscdf(gamma_p, lambda1 * p * T)

%% Activitat 2

bit = rand(1, 1e4) >= 0.5;
lambdaK = [ lambda0, lambda1 ];
M = poissrnd(lambdaK(bit+1) * p * T);
out_bit = M > gamma_p;

P_FA_p = probability(out_bit(~bit))
P_D_p  = probability(out_bit(bit))

%% Activitat 3

axes
xlabel('P_{FA}');
ylabel('P_D');
grid on
hold on

for T = 1:0.5:10
    gamma_p = 0:70;
    P_FA = 1 - poisscdf(gamma_p, lambda0 * p * T);
    P_D  = 1 - poisscdf(gamma_p, lambda1 * p * T);
    plot(P_FA, P_D);
end

hold off

%% Utilitats

function p = probability(x)
    p = nnz(x) / numel(x);
end
