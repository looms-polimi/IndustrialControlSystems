within Tests.MathOperations.MCDC.RealType.Expression;
model NoInputs "RealType.Expression: inputs disabled"
  extends Base(useInputs=false);
  annotation (experiment(StopTime=4.5, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>RealType.Expression: inputs disabled. Configuration: <code>useInputs=false</code>.</p>
<p>MC/DC role: pairs with Base for useInputs.</p>
</html>"));
end NoInputs;
