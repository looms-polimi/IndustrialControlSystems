within Tests.Controllers.MCDC.P;
model SampledGainScheduling "P: gain-scheduling input on (Kp_GS = 4), sampled (Ts = 0.05)"
  extends Base(useGS=true, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>P: gain-scheduling input on (Kp_GS = 4), sampled (Ts = 0.05). Configuration: <code>useGS=true, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with Sampled for useGS (output follows the scheduled gain).</p>
</html>"));
end SampledGainScheduling;
