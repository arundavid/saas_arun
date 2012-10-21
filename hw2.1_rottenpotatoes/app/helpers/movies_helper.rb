module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def rating_on?(rating)
    if session[:ratings] == nil
      return false
    else
      session[:ratings].keys.include?(rating)
    end
  end
  def hilite?(name)
    return 'hilite' if name == session[:sort]
    nil 
  end
end
