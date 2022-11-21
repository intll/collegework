function y = y(t)
  y = (100*t).*(-10 <= t & t <= 10) + 1000.*(t > 10) - 1000.*(t < -10)

function x = x(t)
  x = 20.*cos(2.*pi.*t).*us(t)

%<---------------------- 2a ------------------------>
t = -20:1/1000:20
plot(t, y(t))
title("y(t) and x(t)")
ylim([-1100, 1100])

%<---------------------- 2b ------------------------>
t = -2:1/1000:4
plot(t, y(x(t)), t, x(t))
title("y(t) and x(t)")
lgd = legend("y(t)", "x(t)", "Location", "northwest", "FontSize", 8)
ylim([-1100, 1100])

%<---------------------- 2c ------------------------>
subplot(2, 1, 1)
plot(t, y(x(t)), "r")
title("Input x(t)")
ylim([-1100, 1100])

subplot(2, 1, 2)
plot(t, y(x(t-2)))
title("Input x(t-2)")
ylim([-1100, 1100])
