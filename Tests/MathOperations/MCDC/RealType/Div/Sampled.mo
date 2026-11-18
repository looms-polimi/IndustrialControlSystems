within Tests.MathOperations.MCDC.RealType.Div;
model Sampled "RealType.Div: sampled (Ts = 0.1)"
  extends Base(Ts=0.1);
  annotation (experiment(StopTime=5.5, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>RealType.Div: sampled (Ts = 0.1). Configuration: <code>Ts=0.1</code>.</p>
<p>MC/DC role: pairs with Base for `Ts > 0` in the floating-point branch.</p>
</html>"));
end Sampled;
