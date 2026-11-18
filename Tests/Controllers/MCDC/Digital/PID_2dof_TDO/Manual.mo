within Tests.Controllers.MCDC.Digital.PID_2dof_TDO;
model Manual "Digital.PID_2dof_TDO: manual inputs on"
  extends Base(useMAN=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Digital.PID_2dof_TDO: manual inputs on. Configuration: <code>useMAN=true</code>.</p>
<p>MC/DC role: pairs with Base for useMAN (`not man` in the mode decision; CS += CSinc per sample).</p>
</html>"));
end Manual;
