
C extension modules
-------------------

In addition to the default numba implementation, MTUQ includes C extension modules for accelerating computational bottlenecks.



Compiling C extensions
----------------------

The C extension modules can be compiled using the `c-compiler  <https://anaconda.org/conda-forge/compilers>`_ conda-forge package, which seems to work well on most Linux, Mac, and Windows systems.

.. code::

    conda install c-compiler

To experiment with different compilation settings, users are free to comment out `c-compiler` in `env.yaml` and specify a different compiler via the `CC` environment vairable.

To compile the C extensions:

.. code::

    ./build_ext.sh


Troubleshooting Cython compilation
----------------------------------

To troubleshoot Cython installation, users can try modifying the C source code files listed in `setup.py`, or try varying the compilation settings determined by `setup.py`, the `CC` environment variable, the conda environment, and the underlying system environment.

