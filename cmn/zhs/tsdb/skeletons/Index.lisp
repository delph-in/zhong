;;;
;;; this file should be `Index.lisp' and reside in the directory containing the
;;; tsdb(1) test suite skeleton databases (typically a subdirectory `skeletons'
;;; in the tsdb(1) database root directory `*tsdb-home*').
;;;
;;; the file should contain a single un-quote()d Common-Lisp list enumerating
;;; the available skeletons, e.g.
;;;
;;;   (((:path . "english") (:content . "English TSNLP test suite"))
;;;    ((:path . "csli") (:content . "CSLI (ERGO) test suite"))
;;;    ((:path . "vm") (:content . "English VerbMobil data")))
;;;
;;; where the individual entries are assoc() lists with at least two elements:
;;;
;;;   - :path --- the (relative) directory name containing the skeleton;
;;;   - :content --- a descriptive comment.
;;;
;;; the order of entries is irrelevant as the `tsdb :skeletons' command sorts
;;; the list lexicographically before output.
;;;

(
  ((:path . "tiniest") (:content . "The tiniest testsuite"))
  ((:path . "mrs") (:content . "The MRS testsuite"))
  ((:path . "chart-mapping") (:content . "chart-mapping testing"))

  ((:path . "le") (:content . "le testsuite"))
  ((:path . "classifiers") (:content . "classifiers testsuite"))
  ((:path . "quantifers") (:content . "quantifers testsuite"))
  ((:path . "raising-control") (:content . "raising-control testsuite"))
  ((:path . "vv-compounds") (:content . "vv-compounds testsuite"))
  
  ((:path . "fu-berlin") (:content . "Free University Berlin Testsuite"))

  ((:path . "mcg-smallest") (:content . "Mandarin Chinese Grammmar - smallest"))
  ((:path . "mcg-wxl") (:content . "Mandarin Chinese Grammmar - wxl-20120625"))

  ((:path . "jec") (:content . "JEC Basic Sentence Data"))

  ((:path . "ntumc01") (:content . "NTU-MC Corpus - 01"))
  ((:path . "ntumc02") (:content . "NTU-MC Corpus - 02"))
  ((:path . "ntumc03") (:content . "NTU-MC Corpus - 03"))
  ((:path . "ntumc04") (:content . "NTU-MC Corpus - 04"))
  ((:path . "ntumc05") (:content . "NTU-MC Corpus - 05"))
  ((:path . "ntumc06") (:content . "NTU-MC Corpus - 06"))
  ((:path . "ntumc07") (:content . "NTU-MC Corpus - 07"))
  ((:path . "ntumc08") (:content . "NTU-MC Corpus - 08"))

  ((:path . "pctb01") (:content . "Penn Chinese Treebank (LDC10T07) - 01"))
  ((:path . "pctb02") (:content . "Penn Chinese Treebank (LDC10T07) - 02"))
  ((:path . "pctb03") (:content . "Penn Chinese Treebank (LDC10T07) - 03"))
  ((:path . "pctb04") (:content . "Penn Chinese Treebank (LDC10T07) - 04"))
  ((:path . "pctb05") (:content . "Penn Chinese Treebank (LDC10T07) - 05"))
  ((:path . "pctb06") (:content . "Penn Chinese Treebank (LDC10T07) - 06"))
  ((:path . "pctb07") (:content . "Penn Chinese Treebank (LDC10T07) - 07"))
  ((:path . "pctb08") (:content . "Penn Chinese Treebank (LDC10T07) - 08"))
  ((:path . "pctb09") (:content . "Penn Chinese Treebank (LDC10T07) - 09"))
  ((:path . "pctb10") (:content . "Penn Chinese Treebank (LDC10T07) - 10"))

  ((:path . "sinica01") (:content . "Sinica treebank taken from NLTK - 01"))
  ((:path . "sinica02") (:content . "Sinica treebank taken from NLTK - 02"))
  ((:path . "sinica03") (:content . "Sinica treebank taken from NLTK - 03"))
  ((:path . "sinica04") (:content . "Sinica treebank taken from NLTK - 04"))
  ((:path . "sinica05") (:content . "Sinica treebank taken from NLTK - 05"))
  ((:path . "sinica06") (:content . "Sinica treebank taken from NLTK - 06"))
  ((:path . "sinica07") (:content . "Sinica treebank taken from NLTK - 07"))
  ((:path . "sinica08") (:content . "Sinica treebank taken from NLTK - 08"))
  ((:path . "sinica09") (:content . "Sinica treebank taken from NLTK - 09"))
  ((:path . "sinica10") (:content . "Sinica treebank taken from NLTK - 10"))
)

 
