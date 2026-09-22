WoL3
====

**WoL3 is a release candidate.** File layouts and contents may still change
before the stable release, and there is no publication to cite yet. For
production work, use [WoL2](download#release-2-wol2).
{: .notice--warning}

- [What it is](#what-it-is)
- [How it was made](#how-it-was-made)
- [How to get it](#how-to-get-it)
- [How to use it](#how-to-use-it)
- [Citation](#citation)

***


## What it is

WoL3 is the third release of the Web of Life reference phylogeny and genome
catalog. It comprises **196,062** bacterial and archaeal genomes, dereplicated
at 99% average nucleotide identity (ANI), organized within a single
cross-domain phylogeny built from **455** marker genes.

Current release candidate: **3.0.0-rc.4** (`wol3_rc4`, 2026-09-14).

| Genomes | Archaea | Bacteria | Phyla | Classes | Orders | Families | Genera | Species |
|--------:|--------:|---------:|------:|--------:|-------:|---------:|-------:|--------:|
| 196,062 | 3,918 | 192,144 | 120 | 399 | 1,324 | 3,535 | 14,698 | 56,502 |

Genomes are drawn from NCBI RefSeq and GenBank, with RefSeq preferred where a
genome appears in both, plus 192 genomes carried over directly from WoL2.
10,753 of the 15,953 WoL2 genomes (67.4%) are retained.

Two design choices distinguish WoL3 from earlier releases.

**Dereplication at 99% ANI**, rather than the 95% threshold commonly used as a
species boundary. This deliberately retains within-species genomic diversity.
The motivation is long reads: where short reads cannot reliably distinguish
near-identical genomes, longer reads carry more alignment information, and a
reference collapsed at 95% discards that resolution before the aligner sees it.

**A single bacterial-archaeal phylogeny.** Both domains sit in one tree, so
observations from the same community can be analyzed together using
phylogeny-aware methods such as [UniFrac](https://en.wikipedia.org/wiki/UniFrac)
and [Faith's PD](https://en.wikipedia.org/wiki/Phylogenetic_diversity).
Resources that maintain separate bacterial and archaeal trees cannot simply be
concatenated into a shared evolutionary coordinate system.


## How it was made

**Marker gene selection.** Open reading frames from the 15,953 WoL2 genomes
were assigned to KEGG Orthology groups with
[KofamScan](https://github.com/takaram/kofam_scan), and a set of 1,000 marker
genes was selected with [TMarSel](https://github.com/pnnl/TMarSel), which
maximizes the average number of marker genes per genome. WoL3 genomes were then
annotated against those 1,000 markers.

**Alignment.** Per-gene multiple sequence alignments were computed with
[WITCH](https://github.com/c5shen/WITCH), then filtered in two steps:
[TAPER](https://github.com/chaoszhang/TAPER) to mask likely-misaligned residues
within individual sequences, and
[PASTA](https://github.com/smirarab/pasta)'s `run_seqtools.py` to mask
low-occupancy alignment columns and drop sequences covering too little of the
remaining alignment.

**Marker gene filtering.** From the 1,000 candidates, markers were retained
when they had both broad genome occupancy and high topological concordance with
the WoL2 backbone, measured by quartet score. This yielded the **455** marker
genes used for phylogenetic reconstruction.

**Phylogeny.** The tree was built with
[uDance](https://github.com/balabanmetin/uDance) in tree mode, using the
**WoL2 phylogeny as the backbone**. New genomes were placed onto the backbone
with [APPLES-2](https://github.com/balabanmetin/apples); the placement tree was
then decomposed into partitions, gene trees and species trees were inferred
within each partition with [ASTRAL](https://github.com/smirarab/ASTRAL), branch
lengths were estimated, and the partition trees were stitched back together.

Building on the WoL2 backbone rather than reconstructing from scratch is what
makes a tree of this size tractable, and it keeps successive releases consistent
with one another. It also means WoL3 is best understood as an expanded and
updated reference phylogeny, not a fresh de novo reconstruction of bacterial and
archaeal evolution.

**Post-processing.** The resulting tree was rerooted at the internal edge that
most cleanly separates bacterial from archaeal leaves, and long-branch outlier
taxa were identified with
[TreeShrink](https://github.com/uym2/TreeShrink) and pruned.


## How to get it

Everything is served from one FTP tree:

- [**ftp.microbio.me/wol3**](https://ftp.microbio.me/wol3/) &mdash; start with the
  [README](https://ftp.microbio.me/wol3/wol3_rc4_ftp/README.md) and
  [version.txt](https://ftp.microbio.me/wol3/wol3_rc4_ftp/version.txt)

```
wol3_rc4_ftp/
├── version.txt          release version, date, genome count
├── genomes/             host-masked nucleotide FASTA + genome ID list
├── proteins/            predicted ORFs and their coordinates
├── metadata/            196,062 rows x 49 columns, including QC statistics
├── taxonomy/            phylogeny-guided 7-rank lineages
├── phylogeny/           three Newick files over the same 196,062 tips
├── function/            CAZy, EC, eggNOG, GO, KEGG, Pfam, UniRef
└── databases/           pre-built Bowtie2, Minimap2, GSearch and RYpe indexes
```

The three trees differ only in what is written at internal nodes:

| File | Internal node labels |
|---|---|
| `tree.nwk` | none &mdash; branch lengths only; **use this for UniFrac / Faith's PD** |
| `tree_branch_support.nwk` | support values (0&ndash;1) |
| `tree_decorated_branchonly.nwk` | taxon names |

**Genome identifiers.** Every record is keyed by a 10-character WoL genome ID:
`G` followed by 9 digits, derived from the NCBI assembly accession
(`GCF_000005825.2` &rarr; `G000005825`). These IDs are the tree tip labels and
the first column of every table, so all files join on one key. IDs beginning
with `H` are reserved for future genomes not sourced from NCBI.

Note that the 192 genomes ported directly from WoL2 have no CheckM2, rRNA or
NCBI annotation-count values; those metadata fields are blank for them.

Because this is a release candidate, pin the release directory name
(`wol3_rc4`) in any pipeline you build against it, and record the contents of
`version.txt` alongside your results.


## How to use it

A reference this size is only useful if it can be queried without rebuilding
anything locally, so WoL3 ships pre-built indexes:

| Directory | Tool | Layout |
|---|---|---|
| `databases/bowtie2/wol3_rc4/` | Bowtie2 | 1,000 buckets, `bucket_000`&hellip;`bucket_999` |
| `databases/minimap2/wol3_rc4/single/` | Minimap2 | one whole-set index (HiFi preset) |
| `databases/minimap2/wol3_rc4/sharded/` | Minimap2 | 1,000 per-bucket indexes (HiFi preset) |
| `databases/gsearch/wol3_rc4/` | GSearch | HNSW graph for approximate nearest-neighbor genome search |
| `databases/ryxdi/wol3_rc4-w20.ryxdi/` | RYpe | RY-minimizer index, k=64, w=20 |

Bucketing is shared: bucket *N* holds the same genomes in the Bowtie2 index,
both Minimap2 shard sets and the manifests, so per-bucket results can be merged
across tools. The authoritative genome-to-bucket map is
`databases/manifests/wol3_rc4/assignments.tsv`.

The sharded layout supports **distributed read mapping**, which rests on the
observation that any given read matches only a small fraction of the reference:
reads are first routed to candidate partitions and aligned only within those.
The GSearch index supports **genome classification** by approximate
nearest-neighbor search over MinHash sketches rather than exhaustive
comparison, which is what makes classifying newly assembled MAGs against a
196,062-genome reference practical. That index is expandable, so new genomes
can be classified without rebuilding it.


## Citation

There is no WoL3 publication yet. Until one is available, cite the release
directory and version, and cite
[uDance](https://doi.org/10.1038/s41587-023-01868-8) for the phylogeny
construction method. See [Citation](start#citation) for the full list of WoL
papers.
