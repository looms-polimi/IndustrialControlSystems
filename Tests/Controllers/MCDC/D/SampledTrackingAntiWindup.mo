within Tests.Controllers.MCDC.D;
model SampledTrackingAntiWindup "D: tracking and anti-windup on, sampled (Ts = 0.05)"
  extends Base(useTS=true, AntiWindup=true, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>D: tracking and anti-windup on, sampled (Ts = 0.05). Configuration: <code>useTS=true, AntiWindup=true, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with SampledTracking for AntiWindup inside the tracking branch (TR = 1.5 is limited to CSmax).</p>
</html>"));
end SampledTrackingAntiWindup;
