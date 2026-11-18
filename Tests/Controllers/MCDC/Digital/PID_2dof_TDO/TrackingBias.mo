within Tests.Controllers.MCDC.Digital.PID_2dof_TDO;
model TrackingBias "Digital.PID_2dof_TDO: tracking and bias on"
  extends Base(useTS=true, useBIAS=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Digital.PID_2dof_TDO: tracking and bias on. Configuration: <code>useTS=true, useBIAS=true</code>.</p>
<p>MC/DC role: pairs with Tracking for useBIAS (no bias while tracking).</p>
</html>"));
end TrackingBias;
