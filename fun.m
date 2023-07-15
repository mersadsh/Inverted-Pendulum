function cost=fun(K)

assignin('base','K',K)

out=sim('sys.slx');

cost=trapz(out.tout,abs(out.Err.*out.tout))+trapz(out.tout,abs(out.U1.*out.tout));