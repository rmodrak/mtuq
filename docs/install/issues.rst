
Installation notes
==================


Cython extension modules
------------------------

MTUQ uses Cython extension modules for a significant speed up.

By default, Cython extension modules are compiled using the conda-forge `compilers channel <https://anaconda.org/conda-forge/compilers>`_, which seems to work well on most Linux, Mac, and Windows systems.


Cython compilation settings
---------------------------

To experiment with different compilation settings, users are free to comment out the `c-compiler` dependency in `env.yaml` and specify a different C compiler via the `CC` environment vairable.

For faster experimentation, users can run 

.. code::

    ./build_ext.sh

which compiles the Cython extensions directly, without first installilng all the other dependencies in the conda environment file.


Troubleshooting Cython compilation errors
-----------------------------------------

If Cython modules fail to compile, MTUQ installation will usually exit with a traceback ending with `CondaEnvException: Pip failed` message.  More informative error output can then be obtained by running `build_ext.sh`.

To troubleshoot Cython installation, users can modify the Cython files listed in `setup.py`, as well the the compilation settings determined by `setup.py`, the `CC` environment variable, the conda environment, and the underlying system environment.

Alternatively, users can bypass Cython compilation errors by adding `optional=True` to the extension module settings `setup.py`:

.. code::

    ext_modules = [
        Extension(
            'mtuq.misfit.waveform.c_ext_L2', ['mtuq/misfit/waveform/c_ext_L2.c'],
            include_dirs=[numpy.get_include()],
            extra_compile_args=get_compile_args(),
            optional=True,
        )

MTUQ will then fall back to slower pure Python implementations at runtime.



Instaseis installation
----------------------

MTUQ uses Instaseis to generate synthetic seismograms.

Currently, Instaseis installation via conda forge does not reliably work, so we implement a workaround using a modified Instaseis repository hosted on GitHub.

Similar to Cython extensions, Instaseis includes Fortran extensions for code speedup, so we include the `fortran-compiler` dependency in `env.yaml`.



Speeding up conda installs
--------------------------

Older versions of the conda package manager can be very slow. For a potential speed up, conda can be updated as follows:

.. code::

    conda update -n base conda

For reference, the largest potential speed up comes from the new `mamba <https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community>`_ dependency solver, which was `adopted <https://conda.org/blog/2023-11-06-conda-23-10-0-release>`_ in the 23.10 release.


MTUQ installation on Apple Silicon Macs
---------------------------------------

Installation on Apple Silicon Macs (M1, M2, M3) is now possible using the default installation procedure.  

A modified conda environment file `env_arm64.yaml` is no longer necessary.

