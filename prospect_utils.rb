require 'date'

module ProspectUtils
  def draft_eligible?(dob)
    # Rules for draft eligibility https://en.wikipedia.org/wiki/NHL_Entry_Draft#Eligible_players

    draft_age        = age(draft_date, dob)
    draft_age_cutoff = age(draft_date_cutoff, dob)

    return false if draft_age < 18
    return false if draft_age > 20
    return false if draft_age_cutoff > 20

    true
  end

  def draft_eligible_year(dob)
    draft_date.year - (age(draft_date, dob) - 18)
  end

  def draft_date(year = nil)
    date = Time.new.to_date

    return Date.new(year, 9, 15)      if year
    return Date.new(date.year, 9, 15) if date <= Date.new(date.year, 9, 15)

    Date.new(date.year + 1, 9, 15)
  end

  def draft_date_cutoff(year = nil)
    Date.new(draft_date(year).year, 12, 31)
  end

  def age(end_date, birth_date)
    (end_date.strftime('%Y%m%d').to_i - birth_date.strftime('%Y%m%d').to_i) / 10000
  end
end
