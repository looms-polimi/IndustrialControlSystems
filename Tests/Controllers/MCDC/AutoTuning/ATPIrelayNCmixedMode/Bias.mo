within Tests.Controllers.MCDC.AutoTuning.ATPIrelayNCmixedMode;
model Bias "AutoTuning.ATPIrelayNCmixedMode: bias input on"
  extends Base(useBIAS=true);
  annotation (experiment(StopTime=260, Interval=0.05, Tolerance=1e-6), Documentation(info="<html>
<p>AutoTuning.ATPIrelayNCmixedMode: bias input on. Configuration: <code>useBIAS=true</code>.</p>
<p>MC/DC role: pairs with Base for useBIAS (output = reference + bias).</p>
</html>"));
end Bias;
