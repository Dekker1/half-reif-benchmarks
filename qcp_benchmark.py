from datetime import timedelta
from pathlib import Path

import minizinc

from mzn_bench import Configuration, schedule

schedule(
    instances=Path("./qcp_max.csv"),
    timeout=timedelta(minutes=5),
    configurations=[
        Configuration(
            "Chuffed",
            minizinc.Solver.load(
                Path("./software/install/share/minizinc/solvers/chuffed.msc")
            ),
        ),
    ],
    nodelist=["critical001"],
    output_dir=Path("./output/qcp_max"),
)
