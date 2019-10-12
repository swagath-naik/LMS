class StudentProfile < ApplicationRecord
  validate :presence_of_sname

def presence_of_sname
    unless sname.present?
      errors.add("Student Name ", "can't be blank")
    end
end


def admin?
false
end
def role
"student"
end
end
