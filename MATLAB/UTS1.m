
function y = x(t)
  y = (1-t).*(0 <= t & t <= 1)

function y = dx(t)
  y = -1.*(0 <= t & t <= 1)

function y = ix(t)
  y = (-t).*(0 <= t & t <= 1) - 1.*(t > 1)


%<-------------------- NO 1a --------------------->
t = [-5:1/1000:5]
plot(t, x(t))
title("x(t)")

subplot(3, 1, 1)
plot(t, x(t+1))
title("x(t+1)")

subplot(3, 1, 2)
plot(t, x(t-1))
title("x(t-1)")

subplot(3, 1, 3)
plot(t, x(-t))
title("x(-t)")
%<-------------------- NO 1b --------------------->
subplot(2, 1, 1)
plot(t, 0.5.*(x(t)+x(-t)))
title("0.5[x(t) + x(-t)]")

subplot(2, 1, 2)
plot(t, 0.5.*(x(t)-x(-t)))
title("0.5[x(t) - x(-t)]")
%<-------------------- NO 1c --------------------->
subplot(2, 1, 1)
plot(t, x(2*t))
title("x(2t)")

subplot(2, 1, 2)
plot(t, x(0.5*t))
title("x(0.5t)")
%<-------------------- NO 1d --------------------->
subplot(2, 1, 1)
plot(t, dx(t))
title("dx(t)/dt")
ylim([-2, 1])

subplot(2, 1, 2)
plot(t, ix(t))
title("Integral of y(t)")
ylim([-2, 1])
