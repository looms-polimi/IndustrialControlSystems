within Tests.Controllers.MCDC.AutoTuning.ATPIrelayNCdigital;
model TrackingAntiWindup "AutoTuning.ATPIrelayNCdigital: tracking and anti-windup on"
  extends Base(useTS=true, AntiWindup=true);
  annotation (experiment(StopTime=260, Interval=0.05, Tolerance=1e-6), Documentation(info="<html>
<p>AutoTuning.ATPIrelayNCdigital: tracking and anti-windup on. Configuration: <code>useTS=true, AntiWindup=true</code>.</p>
<p>MC/DC role: pairs with Tracking for AntiWindup inside the tracking branch (TR = 1.5 is limited to CSmax).</p>
</html>"));
end TrackingAntiWindup;
