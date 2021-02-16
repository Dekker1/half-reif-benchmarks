if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
    >&2 echo "Remember: you need to run me as 'source bench_env.sh', not execute it!"
    exit
fi

# Create or activate Python virtual environment
if [ -d venv ]; then
    source venv/bin/activate
else
    python3 -m venv venv
    source venv/bin/activate
    python3 -m pip install mzn-bench
fi

# Set other environment variables and load cluster modules
cmake -S software/minizinc -B software/minizinc/build -DCMAKE_INSTALL_PREFIX=`pwd`/software/install/
cmake --build software/minizinc/build --config Release --target install
cmake -S software/chuffed -B software/chuffed/build -DCMAKE_INSTALL_PREFIX=`pwd`/software/install/
cmake --build software/chuffed/build --config Release --target install

export PATH=`pwd`/software/install/bin:$PATH
export LD_LIBRARY_PATH=`pwd`/software/install/bin:$LD_LIBRARY_PATH
