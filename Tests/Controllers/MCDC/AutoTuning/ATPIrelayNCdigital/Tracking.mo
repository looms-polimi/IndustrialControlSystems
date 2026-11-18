within Tests.Controllers.MCDC.AutoTuning.ATPIrelayNCdigital;
model Tracking "AutoTuning.ATPIrelayNCdigital: tracking inputs on"
  extends Base(useTS=true);
  annotation (experiment(StopTime=260, Interval=0.05, Tolerance=1e-6), Documentation(info="<html>
<p>AutoTuning.ATPIrelayNCdigital: tracking inputs on. Configuration: <code>useTS=true</code>.</p>
<p>MC/DC role: pairs with Base for useTS, and gives TS both values within the run.</p>
</html>"));
end Tracking;
