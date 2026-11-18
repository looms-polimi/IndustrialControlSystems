within Tests.Controllers.MCDC.Digital.PID_2dof_TDO_FullyEventBased;
model ManualTracking "Digital.PID_2dof_TDO_FullyEventBased: manual and tracking inputs on"
  extends Base(useMAN=true, useTS=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Digital.PID_2dof_TDO_FullyEventBased: manual and tracking inputs on. Configuration: <code>useMAN=true, useTS=true</code>.</p>
<p>MC/DC role: pairs with Tracking for `man` (manual has priority over tracking).</p>
</html>"));
end ManualTracking;
