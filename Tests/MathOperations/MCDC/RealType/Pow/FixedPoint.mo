within Tests.MathOperations.MCDC.RealType.Pow;
model FixedPoint "RealType.Pow: fixed point"
  extends Base(FixedPoint=true);
  annotation (experiment(StopTime=5.5, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>RealType.Pow: fixed point. Configuration: <code>FixedPoint=true</code>.</p>
<p>MC/DC role: pairs with Base for FixedPoint.</p>
</html>"));
end FixedPoint;
