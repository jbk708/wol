Download
========

WoL has three releases. **Most users should use WoL2**; see
[which release should I use?](start#which-release-should-i-use) if you are not
sure.


## Release 3 (WoL3)

A **release candidate**: 196,062 genomes dereplicated at 99% ANI, built for
long-read metagenomics. Formats may still change and there is no publication to
cite yet.

- [**ftp.microbio.me/wol3**](https://ftp.microbio.me/wol3/) &mdash; pre-built
  Bowtie2, Minimap2, GSearch and RYpe indexes are included
- [**WoL3**](wol3) &mdash; what it is, how it was made, and how to use it


## Release 2 (WoL2)

The current release: **15,953 genomes** and **380 marker genes**, released
February 2023. Everything is served from one FTP tree:

- [**ftp.microbio.me/pub/wol2**](https://ftp.microbio.me/pub/wol2/) &mdash; start with the [00README](https://ftp.microbio.me/pub/wol2/00README)

| Directory | Contents |
|---|---|
| [`phylogeny/`](https://ftp.microbio.me/pub/wol2/phylogeny/) | Reference trees, built with uDance |
| [`genomes/`](https://ftp.microbio.me/pub/wol2/genomes/) | Genome catalog and sequences |
| [`taxonomy/`](https://ftp.microbio.me/pub/wol2/taxonomy/) | NCBI- and GTDB-based taxonomic annotation |
| [`proteins/`](https://ftp.microbio.me/pub/wol2/proteins/) | Protein-coding gene catalog and coordinates |
| [`rrnas/`](https://ftp.microbio.me/pub/wol2/rrnas/) | Ribosomal RNA sequences |
| [`function/`](https://ftp.microbio.me/pub/wol2/function/) | Functional annotation (UniRef, GO, eggNOG, Pfam, KEGG, MetaCyc) |
| [`databases/`](https://ftp.microbio.me/pub/wol2/databases/) | Pre-built databases (Bowtie2 and others) |

A standard operating procedure for building the release from scratch is
provided as [`wol2sop.sh`](https://ftp.microbio.me/pub/wol2/wol2sop.sh).

If you are analyzing shotgun metagenomes, you most likely want the Bowtie2
database under `databases/` together with
[**Woltka**](https://github.com/qiyunzhu/woltka). In
[Qiita](https://qiita.ucsd.edu/), `WoLr2` is already the default and no
download is needed.


## Release 1 (WoL1)

The 2019 release: **10,575 genomes** and **381 marker genes**. It remains
available and supported for reproducing published analyses. It is hosted at
three locations:

1. This website provides trees, taxonomy, metadata, code, protocols and renderings.
2. Large sequence files and pre-built databases are hosted at our Globus endpoint [**WebOfLife**](https://app.globus.org/file-manager?origin_id=5055eb43-d82b-43f6-8bcb-6be9dfd32748) (see [instruction](#download-via-globus) below).
3. Data files needed for running microbiome data analyses using WoL are hosted at our FTP site: [ftp.microbio.me/pub/wol-20April2021](http://ftp.microbio.me/pub/wol-20April2021/) (total size: 7.8 GB).


### Quickest start

Click to download the [**tree**](data/trees/tree.nwk) and the [**metadata**](data/genomes/metadata.tsv.xz) and it is good to go!

[QIIME 2](https://qiime2.org/) users may download the pre-compiled [**tree.qza**](data/trees/tree.qza) and [**taxonomy.qza**](data/taxonomy/ncbi/taxonomy.qza).

Also check out the [quick-start](start) guide for (bit) more details.


### Pre-built databases

Our Globus endpoint hosts pre-built databases which work out-of-the-box with popular bioinformatics tools:

- QIIME2, BLAST, Bowtie2, SHOGUN, Kraken, Centrifuge, etc.


### Genome sequences

Genome sequences are hosted at our Globus endpoint. We also provide protocols for directly downloading genome data from NCBI. See [instruction](data/genomes).


### Interactive download

Our [interactive tree viewer](empress) allows you to select a node and download data of the corresponding clade, including a **substree**, and a list of links pointing to original NCBI data files (genomes, proteins, RNAs, etc.), which can be batch-downloaded using a [script](data/genomes/batch_down.sh) we provided.


### Download via Globus

We use the [Globus](https://www.globus.org/) service to share very large data files. Please navigate to our Globus endpoint:

 - [**WebOfLife**](https://app.globus.org/file-manager?origin_id=5055eb43-d82b-43f6-8bcb-6be9dfd32748)

If you work with centralized supercomputing facilities, you may consult your IT staff. It is possible that there is an institute account for Globus which allows you to directly transfer the data files to the supercomputer.

If you want to download the data files to your local computer, you may sign up for a [Globus ID](https://www.globusid.org/create) (it's free), download and install [Globus Connect Personal](https://www.globus.org/globus-connect-personal), search for enpoint name "WebOfLife" (or directly click the link above), then start to transfer files.

This [official tutorial](https://docs.globus.org/how-to/get-started/) explains the usage of Globus.
