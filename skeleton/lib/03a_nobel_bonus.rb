# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  ### not sure how to do this one yet :^D
  execute(<<-SQL)
    SELECT
      nobels.yr
    FROM
      nobels
    JOIN
     (
        SELECT 
          nobels.yr
        FROM
          nobels
        WHERE
          subject = 'Physics' 
     ) AS yr_phys
    ON nobels.yr = yr_phys.yr
    LEFT OUTER JOIN
     (
        SELECT 
          nobels.yr
        FROM
          nobels
        WHERE
          subject = 'Chemistry' 
     ) AS yr_chem
    ON nobels.yr = yr_chem.yr
    WHERE
      yr_chem.yr IS NULL
    GROUP BY
      nobels.yr;
  SQL
end
