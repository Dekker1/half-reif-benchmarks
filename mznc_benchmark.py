from datetime import timedelta
from pathlib import Path

import minizinc

from mzn_bench import Configuration, schedule

schedule(
    instances=Path("./mznc_instances.csv"),
    timeout=timedelta(minutes=20),
    configurations=[
        Configuration(
            "CBC",
            solver=minizinc.Solver.lookup("cbc"),
            other_flags={"no-half-reifications": True, "no-chain-compression": True},
        ),
        Configuration(
            "CBC HR",
            solver=minizinc.Solver.lookup("cbc"),
        ),
        Configuration(
            "CPLEX",
            solver=minizinc.Solver.lookup("cplex"),
            other_flags={"no-half-reifications": True, "no-chain-compression": True},
        ),
        Configuration(
            "CPLEX HR",
            solver=minizinc.Solver.lookup("cplex"),
        ),
        Configuration(
            "Gecode",
            solver=minizinc.Solver.lookup("gecode"),
            other_flags={"no-half-reifications": True, "no-chain-compression": True},
        ),
        Configuration("Gecode HR", solver=minizinc.Solver.lookup("gecode")),
        Configuration(
            "Gurobi",
            solver=minizinc.Solver.lookup("gurobi"),
            other_flags={"no-half-reifications": True, "no-chain-compression": True},
        ),
        Configuration(
            "Gurobi HR",
            solver=minizinc.Solver.lookup("gurobi"),
        ),
        Configuration(
            "SCIP",
            solver=minizinc.Solver.lookup("scip"),
            other_flags={"no-half-reifications": True, "no-chain-compression": True},
        ),
        Configuration(
            "SCIP HR",
            solver=minizinc.Solver.lookup("scip"),
        ),
    ],
    memory=16384,
    nodelist=["critical001"],
    output_dir=Path("./output/mznc/"),
)
