%<-----------Functions------------->
syms t;
y(t) = exp(-t).*cos(2.*pi.*t);
f(t) = y(t).*us(t);
e(t) = exp(-t);

%<------------Graphs-------------->
subplot(3, 1, 1)
fplot(f(t), [-1 10], 'k')
title("Graph of f(t)", 'FontName', 'Times')
ylim([-1, 1.5])
hold on
fplot(e(t), [-1 10], '--k')
fplot(-e(t), [-1 10], '--k')
hold off
grid on

subplot(3, 1, 2)
fplot(f(0.5.*t-1), [-1 10], 'k')
title("Graph of f(0.5t-1)", 'FontName', 'Times')
ylim([-1, 1.5])
hold on
fplot(e(0.5.*t-1), [-1 10], '--k')
fplot(-e(0.5.*t-1), [-1 10], '--k')
hold off
grid on

subplot(3, 1, 3)
fplot(f(1.2.*t-5), [-1 10], 'k')
title("Graph of f(1.2t-5)", 'FontName', 'Times')
ylim([-1, 1.5])
hold on
fplot(e(1.2.*t-5), [-1 10], '--k')
fplot(-e(1.2.*t-5), [-1 10], '--k')
hold off
grid on


