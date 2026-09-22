Quick-Start Guide
=================

- [What it is(n't)](#what-it-is-and-isnt)
- [Which release should I use?](#which-release-should-i-use)
- [How it was made](#how-it-was-made)
- [How to get it](#how-to-get-it)
- [How to view it](#how-to-view-it)
- [How to use it in research](#how-to-use-it-in-research)
- [Information for users of...](#information-for-users-of)
- [How to cite it](#citation)

***


## What it is (and isn't)

We present a **reference phylogenetic tree** (or more precisely, mutiple trees depending on your choice) for bacterial and archaeal genomes that are publicly available from [NCBI RefSeq](https://www.ncbi.nlm.nih.gov/refseq/) and [GenBank](https://www.ncbi.nlm.nih.gov/genbank/). It means to serve as a reference for researchers to explore the evolution and diversity of microbes, and to improve the study of microbial communities.

We do not attempt to create a new taxonomy. However we provide annotations (and curations) for the tree and the genome catalog based on either [NCBI](https://www.ncbi.nlm.nih.gov/taxonomy) or [GTDB](http://gtdb.ecogenomic.org/) taxonomy.


## Which release should I use?

There are three releases of WoL. **Most users should use WoL2**, which is the
current stable release and the default reference database in
[Qiita](https://qiita.ucsd.edu/)'s shotgun metagenomics pipeline.
[WoL3](wol3) is available as a release candidate, and is worth considering if
you work with long reads and can accept a format that is not yet final.

| | [**WoL3**](wol3) | **WoL2** (current) | **WoL1** |
|---|---|---|---|
| Released | release candidate, 2026 | Feb 2023 | Apr 2019 |
| Genomes | 196,062 | 15,953 | 10,575 |
| Marker genes | 455 | 380 | 381 |
| Dereplication | 99% ANI | &mdash; | &mdash; |
| Tree-building method | [uDance](https://github.com/balabanmetin/uDance) on the WoL2 backbone | [uDance](https://github.com/balabanmetin/uDance) | [ASTRAL](https://github.com/smirarab/ASTRAL) |
| Taxonomy | phylogeny-guided, GTDB-style | NCBI, GTDB | NCBI, GTDB |
| Download | [ftp.microbio.me/wol3](https://ftp.microbio.me/wol3/) | [ftp.microbio.me/pub/wol2](https://ftp.microbio.me/pub/wol2/) | [this site](download) and [Globus](https://app.globus.org/file-manager?origin_id=5055eb43-d82b-43f6-8bcb-6be9dfd32748) |
| Woltka database name | &mdash; | `WoLr2` | `WoLr1` |
| Publication | none yet | see [Citation](#citation) | [Nat Commun 2019](https://www.nature.com/articles/s41467-019-13443-4) |

WoL2 covers 2 domains, 124 phyla, 321 classes, 914 orders, 2,057 families,
6,811 genera and 12,258 species. WoL3 covers 120 phyla, 399 classes, 1,324
orders, 3,535 families, 14,698 genera and 56,502 species.

**WoL1 is not deprecated.** It remains available and fully supported for
reproducing published analyses, and the rest of this site still describes it.
Pages that have not yet been updated for WoL2 are marked as such.

**The 2019 _Nature Communications_ paper describes WoL1.** If you are citing the
phylogeny itself, cite that paper; if you are using WoL2, also cite the
[uDance](https://doi.org/10.1038/s41587-023-01868-8) paper, which describes how
it was built. See [Citation](#citation).


## How it was made

**WoL1** used [**ASTRAL**](https://github.com/smirarab/ASTRAL) to generate a consensus tree by summarizing individual trees of [**381**](data/markers) single-copy marker genes extracted from [**10,575**](data/genomes) genomes sampled to maximize covered biodiversity.

For comparative purpose, we also generated multiple trees using the conventional gene alignment concatenation strategy, and using multiple alternative genome and gene sampling rules. Detailed [protocols](protocols) are provided.

**WoL2** was built with [**uDance**](https://github.com/balabanmetin/uDance), a divide-and-conquer workflow that refines regions of a tree independently and can extend an existing tree rather than rebuilding it from scratch. This is what makes the phylogeny updatable as new genomes are added, and it is the basis for future releases.

**WoL3** extends the WoL2 phylogeny with uDance, using it as a backbone rather than rebuilding from scratch, and is reconstructed from [**455**](wol3#how-it-was-made) marker genes across [**196,062**](wol3) genomes dereplicated at 99% ANI. See [WoL3](wol3) for details.


## How to get it

**For WoL3** (release candidate), everything is at
[ftp.microbio.me/wol3](https://ftp.microbio.me/wol3/), including pre-built
Bowtie2, Minimap2, GSearch and RYpe indexes. See [WoL3](wol3).

**For WoL2** (current release), everything is at
[ftp.microbio.me/pub/wol2](https://ftp.microbio.me/pub/wol2/): the phylogeny,
genome catalog, taxonomy, rRNAs, proteins, functional annotation and pre-built
databases. See the [download](download) page.

**For WoL1**, we recommend using this [**tree**](data/trees/tree.nwk) as the reference phylogeny for observations and downstream applications, together with the genome [**metadata**](data/genomes/metadata.tsv.xz).

Multiple trees, built using different input data and methodology, together with the corresponding metadata, curated taxonomy and other information, are provided in this repository. Please browse the [**data**](data) directory for details.

The genome and protein sequences, multiple sequence alignments and other large data files are available at [Globus](https://www.globus.org/), with endpoint name [**WebOfLife**](https://app.globus.org/file-manager?origin_id=5055eb43-d82b-43f6-8bcb-6be9dfd32748) (owner: jdereus@globusid.org). For instruction on how to transfer files via Globus, please read this [guide](https://docs.globus.org/how-to/get-started/).

Basic data files needed for running microbiome data analyses using WoL are hosted at our FTP site: [ftp.microbio.me/pub/wol-20April2021](http://ftp.microbio.me/pub/wol-20April2021/) (total size: 7.8 GB).


## How to view it

We present an [interactive visualization](empress) of the tree. You can zoom, collapse, label, and color the tree. Mouse over individual tips or nodes to view its taxonomy (NCBI or GTDB), to navigate to external databases, or to export download links or subtree.

We also provide high-resolution PDF images in multiple layouts and collapsed at multiple ranks, and their [FigTree](http://tree.bio.ed.ac.uk/software/figtree/) and [iTOL](https://itol.embl.de/)-ready rendering packages, as well as the protocol and source code for rendering, at [**gallery**](gallery).

Alternatively, you can always start with the raw Newick files, and metadata of taxa and nodes provided at [data](data) to build your own view!


## How to use it in research

In addition to direct eyeballing, you can use the reference phylogeny in actual research to extend the understanding of the composition and diversity of microbial communities.

### Genome and taxonomy database

The 10,575-genome catalog, with its _curated_ taxonomy, can be compiled into a reference genome database, and plugged into your existing analysis workflow (e.g., for metagenomic profiling). See this [protocol](protocols/genome_database).

### Microbial community ecology

This reference phylogeny enables classical diversity analyses designed during the 16S rRNA era, such as [**UniFrac**](https://en.wikipedia.org/wiki/UniFrac) for beta diversity, and [**Faith's PD**](https://en.wikipedia.org/wiki/Phylogenetic_diversity) for alpha diversity, on WGS datasets. Finer-grained output is enabled at per-genome level resolution (we call it  "**OGU**"). See this [protocol](protocols/community_ecology) and corresponding source code.

### Phylogeny-based profiling

We present a novel metagenomic profiling strategy, which _solely relies on phylogeny, and NOT taxonomy_, to enable higher-resolution and more accurate classification, and new insights in light of evolution. WGS data are directly assigned to internal nodes of the tree, and can be visualized in our interface. See this [protocol](protocols/tree_profiling) and corresponding source code.


## Information for users of

### NCBI

IDs of our genome pool are directly translated from NCBI assembly accessions. Duplicate genomes are merged. Copies of genome sequences are hosted at our Globus endpoint. Instructions are provided to download genomes fresh from the original NCBI server. See [details](data/genomes).

### GTDB

Mappings to GTDB genomes IDs are provided in the genome metadata. In the current release, 9,732 (92.03%) of the 10,575 genomes have corresponding GTDB IDs. Annotation (and curation) of our tree using GTDB taxonomy are provided. The relative evolutionary divergence (RED) ([Parks et al., 2018](https://www.nature.com/articles/nbt.4229)) of tree nodes (which are mapped to taxonomic groups) are provided.

### IMG

Mappings to IMG genome/taxon IDs. are provided in the genome metadata. In the current release, 6,758 (63.91%) of the 10,575 genomes have corresponding IMG IDs.

### QIIME 2

The reference tree can be used for the diversity analysis of shotgun metagenomes, using phylogeny-aware algorithms such as [**UniFrac**](https://en.wikipedia.org/wiki/UniFrac) for beta diversity, and [**Faith's PD**](https://en.wikipedia.org/wiki/Phylogenetic_diversity) for alpha diversity. See this [protocol](protocols/community_ecology).

A derivative for 16S rRNA-based analysis now exists: **[Greengenes2](https://github.com/biocore/q2-greengenes2)**
places 16S rRNA sequences onto the WoL2 backbone, so that amplicon and shotgun
data can be analyzed in one consistent reference tree
([McDonald et al., 2024](https://doi.org/10.1038/s41587-023-01845-1)).

### Qiita

The WoL database is implemented in [**Qiita**](https://qiita.ucsd.edu/), where
**WoLr2 is the default reference database** for the shotgun metagenomics
pipeline (per-sample Bowtie2 alignment followed by Woltka classification).
Users can run the analysis from the graphic user interface; see the
[Woltka Qiita guide](https://github.com/qiyunzhu/woltka/blob/main/doc/qiita.md).

### PhyloPhlAn

The 381 marker genes used to build the tree are a curated subsample of the 400 marker genes originally implemented in [PhyloPhlAn](https://huttenhower.sph.harvard.edu/phylophlan). For each marker gene, we provide functional annotation, gene tree and its degree of congruence with the species evolution. Please see [data/markers](data/markers) and [data/trees/genes](data/trees/genes).

### Kraken / Centrifuge

Two things can be done for each program: (**basic**) The genome pool and a _curated taxonomy_ can be compiled into an improved reference genome database for metagenomic profiling. See this [protocol](protocols/genome_database) for details.

(**advanced**) The reference phylogeny can replace the NCBI taxonomy hierarchy used in a Kraken / Centrifuge analysis to guide the classification process. Query sequences are directly assigned to nodes instead of taxonomic ranks. See this [protocol](protocols/tree_profiling).

### SHOGUN

The genome pool, the curated taxonomy and the phylogenetic tree itself can be compiled into a reference database to improve metagenomic profiling. The intermediate files can be further used for community ecology analysis. See these protocols: [1](protocols/genome_database), [2](protocols/community_ecology) and [3](protocols/tree_profiling).

### TIPP

A TIPP-based integration has not been released. For metagenomic classification
against WoL today, the supported route is
[**Woltka**](https://github.com/qiyunzhu/woltka) on Bowtie2 alignments; see
[Microbial community ecology](#microbial-community-ecology) above. To place
*new genomes* into the reference phylogeny, see
[uDance](https://github.com/balabanmetin/uDance).


## Citation

If you use the data, code or protocols developed in this work, please cite the
WoL phylogeny paper:

> Zhu Q\*, Mai U\*, Pfeiffer W, Janssen S, Asnicar F, Sanders JG, Belda-Ferre P, Al-Ghalith GA, Kopylova E, McDonald D, Kosciolek T, Yin JB, Huang S, Salam N, Jiao J, Wu Z, Xu ZZ, Sayyari E, Morton JT, Podell S, Knights D, Li W, Huttenhower C, Segata N, Smarr L, Mirarab S, Knight R. [Phylogenomics of 10,575 genomes reveals evolutionary proximity between domains Bacteria and Archaea](https://www.nature.com/articles/s41467-019-13443-4). _Nature Communications_. 2019. **10**(1):5477. doi: 10.1038/s41467-019-13443-4.

Depending on what you use, please also cite:

**WoL2** &mdash; the current release was built with uDance:

> Balaban M, Jiang Y, Zhu Q, McDonald D, Knight R, Mirarab S. [Generation of accurate, expandable phylogenomic trees with uDance](https://doi.org/10.1038/s41587-023-01868-8). _Nature Biotechnology_. 2024. **42**(5):768-777. doi: 10.1038/s41587-023-01868-8.

**OGU analysis** &mdash; per-genome community ecology that bypasses taxonomy:

> Zhu Q, Huang S, Gonzalez A, McGrath I, McDonald D, Haiminen N, Armstrong G, Vázquez-Baeza Y, Yu J, Kuczynski J, Sepich-Poore GD, Swafford AD, Das P, Shaffer JP, Lejzerowicz F, Belda-Ferre P, Havulinna AS, Méric G, Niiranen T, Lahti L, Salomaa V, Kim HC, Jain M, Inouye M, Gilbert JA, Knight R. [Phylogeny-aware analysis of metagenome community ecology based on matched reference genomes while bypassing taxonomy](https://doi.org/10.1128/msystems.00167-22). _mSystems_. 2022. **7**(2):e00167-22. doi: 10.1128/msystems.00167-22.

**Greengenes2** &mdash; 16S rRNA and shotgun data unified on the WoL2 backbone:

> McDonald D, Jiang Y, Balaban M, Cantrell K, Zhu Q, Gonzalez A, Morton JT, Nicolaou G, Parks DH, Karst SM, Albertsen M, Hugenholtz P, DeSantis T, Song SJ, Bartko A, Havulinna AS, Jousilahti P, Cheng S, Inouye M, Niiranen T, Jain M, Salomaa V, Lahti L, Mirarab S, Knight R. [Greengenes2 unifies microbial data in a single reference tree](https://doi.org/10.1038/s41587-023-01845-1). _Nature Biotechnology_. 2024. **42**(5):715-718. doi: 10.1038/s41587-023-01845-1.


## Grants

**WoL1** ([Zhu et al., 2019](https://www.nature.com/articles/s41467-019-13443-4))

- National Science Foundation (NSF) grant 1565057 (R.K.)
- Alfred P. Sloan Foundation grant G-2017-9838 (R.K.)
- NSF grant III-1845967 (S.M.)
- National Natural Science Foundation of China grant 91951205 (W.L.)
- NSF Extreme Science and Engineering Discovery Environment (XSEDE)
  allocation BIO150043, on Comet at the San Diego Supercomputer Center
  (R.K., L.S., S.M.)

**[WoL3](wol3)**

- Minderoo Foundation grant CLB-3502
- National Institute on Aging grant U19AG063744
- National Institutes of Health (NIH) Pioneer Award DP1AT010885
- National Institute of General Medical Sciences (NIH-NIGMS) award R35GM142725
- OSG Consortium, which supported genome processing and is itself supported by
  NSF awards 2030508 and 2323298
- Advanced Cyberinfrastructure Coordination Ecosystem: Services & Support
  (ACCESS) allocation BIO250389, on Expanse at the San Diego Supercomputer
  Center, supported by NSF grants 2138259, 2138286, 2138307, 2137603 and
  2138296


## Contact

Please forward any questions to the project leader: **Dr. Qiyun Zhu** ([Qiyun.Zhu@asu.edu](mailto:Qiyun.Zhu@asu.edu)) or the senior PI: **Dr. Rob Knight** ([robknight@ucsd.edu](mailto:robknight@ucsd.edu)).
