within Tests.Controllers.MCDC.D;
model SampledTrackingBias "D: tracking and bias on, sampled (Ts = 0.05)"
  extends Base(useTS=true, useBIAS=true, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>D: tracking and bias on, sampled (Ts = 0.05). Configuration: <code>useTS=true, useBIAS=true, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with SampledTracking for useBIAS inside the tracking branch (the bias is not added while tracking).</p>
</html>"));
end SampledTrackingBias;
