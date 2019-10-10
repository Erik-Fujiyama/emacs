;;; djvu-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "djvu" "djvu.el" (23700 49069 973732 307000))
;;; Generated autoloads from djvu.el

(autoload 'djvu-find-file "djvu" "\
Read and edit Djvu FILE on PAGE.  Return Read buffer.
If VIEW is non-nil start external viewer.
If NOSELECT is non-nil visit FILE, but do not make it current.
If NOCONFIRM is non-nil don't ask for confirmation when reverting buffer
from file.

\(fn FILE &optional PAGE VIEW NOSELECT NOCONFIRM)" t nil)

(autoload 'djvu-inspect-file "djvu" "\
Inspect Djvu FILE on PAGE.
Call djvused with the same sequence of arguments that is used
by `djvu-init-page'.  Display the output in `djvu-script-buffer'.
This may come handy if `djvu-find-file' chokes on a Djvu file.

\(fn FILE &optional PAGE)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; djvu-autoloads.el ends here
