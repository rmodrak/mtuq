
Graphics notes
==============


Frontends versus backends
-------------------------

Under the hood, MTUQ plotting functions are separated into `frontends <https://mtuqorg.github.io/mtuq/library/index.html#data-visualization>`_, which users call directly, and backends, which isolate calls to graphics libraries.

In addition to helping with planned transitions over time from one graphics library to another, this design also allows for a high degree of `user customization <https://mtuqorg.github.io/mtuq/user_guide/06/customizing_figures.html>`_.

By default, MTUQ currently uses matplotlib backends, which in terms of function syntax, are interchangeable with earlier GMT and PyGMT backends.


GMT and PyGMT backends
----------------------

To use GMT or PyGMT backends, it is necessary to first install PyGMT as follows:

.. code::

    conda install 'pygmt>=0.9'


Troubleshooting PyGMT installation
----------------------------------

To avoid known issues with early PyGMT versions, it is necessary to specifcy a minimum version as follows:

.. code::

    conda install 'pygmt>=0.9'


A conservative approach, which avoids possible issues with PyGMT 0.10 or later releases, is to specify the stable PyGMT 0.9 version:

.. code::

    conda install 'pygmt=0.9'



Moment tensor beachballs
------------------------

MTUQ now includes its own from-scratch beachball plotting functions, as well as wrappers over PyGMT beachball plotting functions.

We note that some versions of GMT and ObsPy plotted `non-double couple beachballs <https://github.com/obspy/obspy/issues/2388>`_ incorrectly.

