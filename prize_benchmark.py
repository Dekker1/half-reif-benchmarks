from datetime import timedelta
from pathlib import Path

import minizinc

from minizinc_slurm import Configuration, schedule

schedule(
    instances=Path("./prize.csv"),
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
    output_dir=Path("./output/prize/"),
)
