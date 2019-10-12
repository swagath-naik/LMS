class FacultyProfile < ApplicationRecord
  validate :presence_of_fname, :presence_of_fdes



def presence_of_fname
    unless fname.present?
      errors.add("Faculty Name ", "can't be blank")
    end
end
def presence_of_fdes
    unless fdes.present?
      errors.add("Designation ", "can't be blank")
    end
end

def admin?
false
end
def role
"faculty"
end
end
