;+
; NAME:
;       GET_MOST_PROBABLE
;
; PURPOSE:
;       Determine the most probable and 1-sigma uncertainties from a
;       1D likelihood function.
;
; CATEGORY:
;       Bayesian fitting.
;
; CALLING SEQUENCE:
;       result = get_most_probable(vals, likelihood)
;
; INPUTS:
;       vals : values
;       likelihood : the likelihood of each value
;
; KEYWORD PARAMETERS:
;
; OUTPUTS:
;       result : vector of 4 values 
;         [most probable, ave unc, -unc, +unc]
;
; OPTIONAL OUTPUTS:
;
; PROCEDURE:
;
; EXAMPLE:
;
; MODIFICATION HISTORY:
; 	Started     : Karl Gordon (6 Aug 2012)
;-

function get_most_probable, vals, log_likelihood

max_val = max(log_likelihood)

indxs = where((log_likelihood - max_val) GT -70.0,n_indxs)

if (n_indxs GT 0) then begin
    cum_likelihood = total(exp(log_likelihood - max_val),/CUMULATIVE)
    cum_prob /= max(cum_prob)
    
    tresult = interpol(cum_prob,[0.5,0.165,0.835]
    
    result = [tresult[0],0.5*(tresult[1]+tresult[2]),tresult[1],tresult[2]]
    
endif else begin

    result = [0.0,0.0,0.0,0.0]

endelse

return, result


end
