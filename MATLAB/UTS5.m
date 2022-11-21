n = -5:1:5

function x = x(n)
  x = 1.*(n == -1 | n == 0 | n == 1) + 0.5.*(n == 2)
end

%<----------------- 5a ------------------>
subplot(3, 1, 1)
stem(n, x(n-1))
title("x[n-1]")
ylim([-2, 2])
grid on

subplot(3, 1, 2)
stem(n, x(-n))
title("x[-n]")
ylim([-2, 2])
grid on

subplot(3, 1, 3)
stem(n, x(2-n))
title("x[2-n]")
ylim([-2, 2])
grid on

%<----------------- 5b and c ------------------>\
ge = (x(n) + x(-n))/2
go = (x(n) - x(-n))/2

subplot(2, 1, 1)
plot(n, ge)
grid on
ylim([-2, 2])
title("Even parts of the function")

subplot(2, 1, 2)
plot(n, go)
grid on
title("Odd parts of the function")

