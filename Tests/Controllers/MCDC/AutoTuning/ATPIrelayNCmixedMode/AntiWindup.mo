within Tests.Controllers.MCDC.AutoTuning.ATPIrelayNCmixedMode;
model AntiWindup "AutoTuning.ATPIrelayNCmixedMode: anti-windup on"
  extends Base(AntiWindup=true);
  annotation (experiment(StopTime=260, Interval=0.05, Tolerance=1e-6), Documentation(info="<html>
<p>AutoTuning.ATPIrelayNCmixedMode: anti-windup on. Configuration: <code>AntiWindup=true</code>.</p>
<p>MC/DC role: pairs with Base for AntiWindup (limits held, recovery after the set-point reversal vs. the output leaving the limits).</p>
</html>"));
end AntiWindup;
