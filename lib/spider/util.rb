module Util
  def nil_or_contains_url(e)
    e if  e =~ /http:\/\/.+(.com|.net|.org|edu)/
  end

  def has_dot_com(i)
    i.split(/['"]/)[0]
  end

  def has_href(i)
    i if i =~ /href=/
  end

  def has_quote(i)
    i.split(/['"]/)[0]
  end

  def has_id(i)
  end

end
