;; -*- mode: lisp-interaction; lexical-binding: t; -*-

(require 'set)

(cl-defun d:generate-diff (dict &key old-commit new-commit old-version new-version)
  "Generate diff for DICT.
This asks Git to generate a diff between OLD-COMMIT and NEW-COMMIT.

The output file is named
  \"DICT - <OLD-COMMIT>-<NEW-COMMIT> - {added|removed}.json\"."
  (declare (indent 1))
  (let ((removed (set-new))
        (added (set-new))
        (size 0))
    (with-current-buffer (get-buffer-create "test")
      (erase-buffer)
      (call-process
       "git" nil '(t nil) nil
       "diff" "-U0"
       old-commit new-commit
       "--"
       (format "../%s.json" dict))
      (setq size (buffer-size))
      (goto-char (point-min))
      (search-forward "+++")
      (catch 'done
        (while (not (eobp))
          (catch 'continue
            (beginning-of-line)
            (forward-line)
            (message "%s%%" (* 100 (/ (point) size 1.0)))
            (unless (memql (char-after) '(?- ?+))
              (throw 'continue nil))
            (let ((flag (char-after))
                  title)
              (when (search-forward "{" nil t)
                (forward-char -1)
                ;; (message "%s" (line-number-at-pos))
                (setq title (gethash "title" (json-parse-buffer)))
                (if (eql flag ?-)
                    (set-add removed title)
                  (set-add added title))))))))
    ;; (with-temp-file (format "%s - %s-%s - modified.json" dict old-version new-version)
    ;;   (insert
    ;;    (json-serialize (seq-into (seq-intersection added removed) 'vector))))
    (with-temp-file (format "%s - %s-%s - added.json" dict old-version new-version)
      (insert
       (json-serialize (seq-into (seq-difference added removed) 'vector))))
    (with-temp-file (format "%s - %s-%s - removed.json" dict old-version new-version)
      (insert
       (json-serialize (seq-into (seq-difference removed added) 'vector))))))

(progn
  (pcase-dolist (`(,dict ,old-version ,new-version)
                 '(("dict_concised" "2014_20230628" "2014_20230926")
                   ("dict_idioms" "2020_20230629" "2020_20230927")
                   ("dict_mini" "2019_20230629" "2019_20230927")
                   ("dict_revised" "2015_20230626" "2015_20230928")))
    (d:generate-diff dict
      :old-commit "cc95b03"
      :new-commit "2028973"
      :old-version old-version
      :new-version new-version))
  (k/send-notification "Done"))
