(defgroup highlight-beyond-fill-column nil
  "Fontify beyond the fill-column."
  :group 'fill)

(defface highlight-beyond-fill-column-face
  '((t (:underline t)))
  "Face used to highlight beyond the fill-column."
  :group 'highlight-current-line)

(defun highlight-beyond-fill-column-lock (limit)
  "Function for font-lock to highlight beyond the `fill-column' until LIMIT."
  (let ((original-point (point)))       ;; remember the point
    ;; if already past the fill column start on next line
    (if (> (current-column) fill-column)
        (forward-line 1))
    (while (and (< (point) limit)       ; still within limit
                ;; the line has less than `fill-column' columns
                (or (< (move-to-column fill-column) fill-column)
                    (= (point) (line-end-position)))) ; end of line
      ;; goto next line
      (forward-line 1))

    (if (>= (point) limit)              ; beyond limit
        (progn
          (goto-char original-point)    ; restore point
          nil)                          ; return nil

      (set-match-data (list (point-marker) ; set match data
                            (progn
                              (end-of-line)
                              (point-marker))))
      ;; return t indicating that the match data was set
      t)))

;;;###autoload
(defun highlight-beyond-fill-column ()
  "Setup this buffer to highlight beyond the `fill-column'."
  (interactive)
  (font-lock-add-keywords
   nil
   '((highlight-beyond-fill-column-lock 0 'highlight-beyond-fill-column-face
                                        prepend))))

(provide 'highlight-beyond-fill-column)
