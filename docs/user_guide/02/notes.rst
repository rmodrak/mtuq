
Detailed notes
==============

How metadata are read in
------------------------

What matters in practice is simply that enough information is present in the SAC headers for ObsPy attributes to be populated.

This follows because MTUQ uses only a thin wrapper over `obspy.read` for reading SAC files.  Similarly, for storing waveform data, MTUQ uses `obspy.Trace` and `obspy.Stats` data structures within its own `mtuq.Dataset` container.   

The following ObsPy attributes must be correctly populated from SAC metadata: `stats.network`, `stats.station`, `stats.location`, `stats.sac.stala`, `stats.sac.stlo`, `stats.starttime`


How metadata are used
---------------------

In MTUQ, `network`, `station`, and `location` codes are used for sorting individual waveforms into `mtuq.Datasets`.

Station `latitude` and `longitude` are used to extract Green's functions at the correct locations, as well as for distance-dependent data processing.

Trace `starttime` and `endtime` are used during misfit evaluation to align observed waveforms correctly with synthetic waveforms.


Custom coordinate systems
-------------------------

By default, distance and azimuth calculations are performed on station `latitude` and `longitude` values using ObsPy geodetic functions.

To support local x,y coordinates, UTM coordinates, or other custom systems, these distance and azimuth functions (and also the meaning of the `latitude` and `longitude` values themselves) can be overridden through source code modifications.
