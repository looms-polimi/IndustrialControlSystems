within Tests.Controllers.MCDC.PI;
model SampledAntiWindup "PI: anti-windup on, sampled (Ts = 0.05)"
  extends Base(AntiWindup=true, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PI: anti-windup on, sampled (Ts = 0.05). Configuration: <code>AntiWindup=true, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with Sampled for AntiWindup (limits held, recovery after the set-point reversal vs. the output leaving the limits).</p>
</html>"));
end SampledAntiWindup;
