%UTS3.m
%<-------------------- 3 ---------------------->
t = -5:1/100:5

function x  = x(t)
  x = cos(2.*pi.*t + pi/4)
end


ge = (x(t) + x(-t))/2
go = (x(t) - x(-t))/2

subplot(2, 1, 1)
plot(t, ge)
grid on
title("Even parts of the function")

subplot(2, 1, 2)
plot(t, go)
grid on
title("Odd parts of the function")

