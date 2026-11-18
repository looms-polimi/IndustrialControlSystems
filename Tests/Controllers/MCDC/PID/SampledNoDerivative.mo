within Tests.Controllers.MCDC.PID;
model SampledNoDerivative "PID: derivative path removed (Td = 0), sampled (Ts = 0.05)"
  extends Base(Td=0, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PID: derivative path removed (Td = 0), sampled (Ts = 0.05). Configuration: <code>Td=0, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with Sampled for `Td > 0`.</p>
</html>"));
end SampledNoDerivative;
