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
  ((:path . "interjections") (:content . "interjections testsuite"))
  ((:path . "symbols") (:content . "special characters testsuite"))
  ((:path . "A-not-A") (:content . "A-not-A testsuite"))
  ((:path . "malzhong") (:content . "A suite for testing mal-rules"))
  
  ((:path . "rslt") (:content . "rslt testsuite"))

  ((:path . "spec01") (:content . "The Adventure of the Speckled Band - the first 100 sentences"))

  ((:path . "fu-berlin") (:content . "Free University Berlin Testsuite"))

  ((:path . "mcg-smallest") (:content . "Mandarin Chinese Grammmar - smallest"))
  ((:path . "mcg-wxl") (:content . "Mandarin Chinese Grammmar - wxl-20120625"))

  ((:path . "jec") (:content . "JEC Basic Sentence Data"))

  ((:path . "ntumc") (:content . "NTU-MC Corpus"))

  ((:path . "pctb-dev") (:content . "Penn Chinese Treebank (LDC10T07) - DevData"))
  ((:path . "pctb-test") (:content . "Penn Chinese Treebank (LDC10T07) - TestData"))

  ((:path . "sinica-dev") (:content . "Sinica treebank taken from NLTK - DevData"))
  ((:path . "sinica-test") (:content . "Sinica treebank taken from NLTK - TestData"))
)

 
