within Tests.Controllers.MCDC.AutoTuning.ATPIrelayNCdigital;
model AntiWindup "AutoTuning.ATPIrelayNCdigital: anti-windup on"
  extends Base(AntiWindup=true);
  annotation (experiment(StopTime=260, Interval=0.05, Tolerance=1e-6), Documentation(info="<html>
<p>AutoTuning.ATPIrelayNCdigital: anti-windup on. Configuration: <code>AntiWindup=true</code>.</p>
<p>MC/DC role: pairs with Base for AntiWindup (limits held, recovery after the set-point reversal vs. the output leaving the limits).</p>
</html>"));
end AntiWindup;
