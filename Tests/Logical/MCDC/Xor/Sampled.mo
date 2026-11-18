within Tests.Logical.MCDC.Xor;
model Sampled "Xor: sampled (Ts = 0.1)"
  extends Base(Ts=0.1);
  annotation (experiment(StopTime=8.5, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>Xor: sampled (Ts = 0.1). Configuration: <code>Ts=0.1</code>.</p>
<p>MC/DC role: pairs with Base for `Ts > 0`.</p>
</html>"));
end Sampled;
