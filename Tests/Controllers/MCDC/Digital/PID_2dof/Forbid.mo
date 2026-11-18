within Tests.Controllers.MCDC.Digital.PID_2dof;
model Forbid "Digital.PID_2dof: forbid inputs on"
  extends Base(useForbid=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Digital.PID_2dof: forbid inputs on. Configuration: <code>useForbid=true</code>.</p>
<p>MC/DC role: pairs with Base for useForbid; F_inc while CS rises and falls, F_dec while it falls and rises (each condition of `F_inc and (not man) and cs > pre(cs)`).</p>
</html>"));
end Forbid;
