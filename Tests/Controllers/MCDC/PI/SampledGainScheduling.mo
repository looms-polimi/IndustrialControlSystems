within Tests.Controllers.MCDC.PI;
model SampledGainScheduling "PI: gain-scheduling inputs on (Kp_GS = 4, Ti_GS = 2.5), sampled (Ts = 0.05)"
  extends Base(useGS=true, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PI: gain-scheduling inputs on (Kp_GS = 4, Ti_GS = 2.5), sampled (Ts = 0.05). Configuration: <code>useGS=true, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with Sampled for useGS.</p>
</html>"));
end SampledGainScheduling;
