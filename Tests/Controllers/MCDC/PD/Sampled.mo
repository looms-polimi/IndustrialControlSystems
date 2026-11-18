within Tests.Controllers.MCDC.PD;
model Sampled "PD: sampled (Ts = 0.05, Backward Euler)"
  extends Base(Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PD: sampled (Ts = 0.05, Backward Euler). Configuration: <code>Ts=0.05</code>.</p>
<p>MC/DC role: pairs with Base for `Ts > 0` (the sampled branch); compared with the continuous ideal.</p>
</html>"));
end Sampled;
