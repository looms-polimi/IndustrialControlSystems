within Tests.Controllers.MCDC.AutoTuning.ATPIrelayNCmixedMode;
model TrackingBias "AutoTuning.ATPIrelayNCmixedMode: tracking and bias on"
  extends Base(useTS=true, useBIAS=true);
  annotation (experiment(StopTime=260, Interval=0.05, Tolerance=1e-6), Documentation(info="<html>
<p>AutoTuning.ATPIrelayNCmixedMode: tracking and bias on. Configuration: <code>useTS=true, useBIAS=true</code>.</p>
<p>MC/DC role: pairs with Tracking for useBIAS inside the tracking branch (the bias is not added while tracking).</p>
</html>"));
end TrackingBias;
