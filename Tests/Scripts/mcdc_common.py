"""Shared helpers of the MC/DC test generators (layout, checks, file writing)."""
import pathlib
import textwrap

U = "Tests.Utilities"
REAL, BOOL = "{0,0,127}", "{255,0,255}"
SRC = {"y": (110, 0)}                       # MSL sources: output at (110, 0)
SISO = {"u": (-120, 0), "y": (110, 0)}      # MSL SISO blocks

def html(s):
    return s.replace('"', '\\"')


def ann_line(L, a, b, color):
    return f"  connect({a}, {b}) annotation (Line(points={L.points(a, b)}, color={color}));"


def place(L, n):
    return f"annotation (Placement(transformation(extent={L.placement(n)})))"


class Check:
    """A check component: Tests.Utilities.<kind> name(mods) placed in the check grid."""

    def __init__(self, name, kind, mods, doc):
        self.name, self.kind, self.mods, self.doc = name, kind, mods, doc


def check_grid(L, checks, x0, y0, cols=2, dx=30, dy=-30):
    for i, c in enumerate(checks):
        L.comp(c.name, {"passed": (110, 0)}, x0 + (i % cols) * dx, y0 + (i // cols) * dy)


def check_decls(L, checks):
    out = []
    for c in checks:
        mods = ",\n      ".join(c.mods)
        out.append(f"  {U}.{c.kind} {c.name}(\n      {mods})\n    \"{c.doc}\"\n    {place(L, c.name)};")
    return "\n".join(out)


def passed_decl(checks):
    terms = " and ".join(f"{c.name}.passed" for c in checks)
    return f"  Boolean passed = {terms}\n    \"true if every enabled check of this configuration passed\";"


def write(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(textwrap.dedent(text).lstrip("\n"))


def write_package(pkg_dir, within, name, doc, order):
    short = doc.split(". ")[0].split("\n")[0].rstrip(".")
    write(pkg_dir / "package.mo", f'''
within {within};
package {name} "{short}"
  extends Modelica.Icons.ExamplesPackage;
  annotation (Documentation(info="<html>
{html(doc)}
</html>"));
end {name};
''')
    (pkg_dir / "package.order").write_text("\n".join(order) + "\n")


def variant_file(pkg_dir, within, name, mods, desc, pairs, experiment):
    m = ", ".join(f"{k}={v}" for k, v in mods.items())
    ext = f"Base({m})" if m else "Base"
    write(pkg_dir / f"{name}.mo", f'''
within {within};
model {name} "{desc}"
  extends {ext};
  annotation (experiment({experiment}), Documentation(info="<html>
<p>{html(desc)}. Configuration: <code>{html(m) or "all options off"}</code>.</p>
<p>MC/DC role: {html(pairs)}</p>
</html>"));
end {name};
''')




PROBLEMS = []


def report(name, found, L):
    """Record and print the layout check of one base model."""
    bad = {k: v for k, v in found.items() if v and k != "crossings"}
    if found["crossings"] or bad:
        PROBLEMS.append((name, found))
    print(f"{name:40s} through={len(found['through_icon'])} hugs={len(found['hugs_edge'])} "
          f"crossings={len(found['crossings'])} offgrid={len(found['off_grid'])} canvas={L.canvas()}")
