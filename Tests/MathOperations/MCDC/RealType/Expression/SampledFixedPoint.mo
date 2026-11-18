within Tests.MathOperations.MCDC.RealType.Expression;
model SampledFixedPoint "RealType.Expression: fixed point, sampled"
  extends Base(FixedPoint=true, Ts=0.1);
  annotation (experiment(StopTime=4.5, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>RealType.Expression: fixed point, sampled. Configuration: <code>FixedPoint=true, Ts=0.1</code>.</p>
<p>MC/DC role: pairs with FixedPoint for `Ts > 0` (fixed point).</p>
</html>"));
end SampledFixedPoint;
