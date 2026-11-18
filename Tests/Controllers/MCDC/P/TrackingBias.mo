within Tests.Controllers.MCDC.P;
model TrackingBias "P: tracking and bias on"
  extends Base(useTS=true, useBIAS=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>P: tracking and bias on. Configuration: <code>useTS=true, useBIAS=true</code>.</p>
<p>MC/DC role: pairs with Tracking for useBIAS inside the tracking branch (the bias is not added while tracking).</p>
</html>"));
end TrackingBias;
