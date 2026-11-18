within Tests.MathOperations.MCDC.RealType.Mult;
model FixedPoint "RealType.Mult: fixed point"
  extends Base(FixedPoint=true);
  annotation (experiment(StopTime=4.5, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>RealType.Mult: fixed point. Configuration: <code>FixedPoint=true</code>.</p>
<p>MC/DC role: pairs with Base for FixedPoint.</p>
</html>"));
end FixedPoint;
