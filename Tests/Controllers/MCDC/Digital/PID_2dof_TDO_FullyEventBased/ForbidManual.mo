within Tests.Controllers.MCDC.Digital.PID_2dof_TDO_FullyEventBased;
model ForbidManual "Digital.PID_2dof_TDO_FullyEventBased: forbid and manual inputs on"
  extends Base(useForbid=true, useMAN=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Digital.PID_2dof_TDO_FullyEventBased: forbid and manual inputs on. Configuration: <code>useForbid=true, useMAN=true</code>.</p>
<p>MC/DC role: pairs with Forbid for `not man` in the forbid decisions (manual increments pass F_inc).</p>
</html>"));
end ForbidManual;
