
(in-package :cl-user)

;; TODO do this only when it's the first line
(set-dispatch-macro-character #\# #\!
  (lambda (stream char n)
    (declare (ignore char n))
    (do* ((ch (read-char stream nil nil) (read-char stream nil nil)))
         ((or (null ch) (eql ch #\newline)) (values)))))

;; make the new executable
(copy-file (ccl::kernel-path)
           (make-pathname :defaults (ccl::kernel-path)
                          :name (concatenate 'string (pathname-name (ccl::kernel-path)) "-script"))
           :if-exists :supersede)

;; change mode for linux executable
#+linux
(ccl:run-program "/bin/sh" (list "-c"
                                 (concatenate 'string
                                              "chmod +x "
                                              (native-translated-namestring
                                               (make-pathname :defaults (ccl::kernel-path)
                                                              :name (concatenate 'string (pathname-name (ccl::kernel-path)) "-script"))))))

;; save the image
(ccl:save-application
 (make-pathname :defaults (ccl::kernel-path)
                :name (concatenate 'string (pathname-name (ccl::kernel-path)) "-script")
                :type "image"))

