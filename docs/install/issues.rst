
Installation notes
==================


A common cause of installation errors
--------------------------------------

On Unix and Linux systems, a non-writeable `/tmp` directory can cause the installation to fail in with unexpected or difficult-to-diagnose error messages.

A useful troubleshooting step is to set the ``TMPDIR`` environment variable to a directory that exists and is writeable.


Installation on Unix systems
-----------------------------

MTUQ installation is supported on Unix-like systems.


Installation on MacOS systems
-----------------------------

MTUQ installation is supported on MacOS systems.

MTUQ installation on Apple Silicon Macs is now possible using the default installation procedure.  A modified conda environment file is no longer necessary.


Installation on Windows
-----------------------

MTUQ installation is not currently supported on Windows, however, we invite users to test it and contribute portability fixes.


Accelerating computational bottlenecks
--------------------------------------

Our previous approach of using C extension modules to speed up computational bottlenecks has been deprecated in favor of numba acceleration.

While the C extension modules are no longer automatically compiled during MTUQ installation, users can do so manually.


Speeding up conda installs
--------------------------

Older versions of the conda package manager can be very slow. For a potential speed up, conda can be updated as follows:

.. code::

    conda update -n base conda

For reference, the largest potential speed up comes from the new `mamba <https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community>`_ dependency solver, which was `adopted <https://conda.org/blog/2023-11-06-conda-23-10-0-release>`_ in the 23.10 release.


