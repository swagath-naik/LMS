class AdminController < ApplicationController

  before_action :require_login 
  

def show

#@profile=AdminProfile.find(params[:id])
@user=User.find_by(profile_id: params[:id], profile_type: "AdminProfile")

 if @user.blank? 
   
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end
end

def indexBookIssue
  @user=User.find_by(profile_id: params[:id], profile_type: "AdminProfile")  
  @bookIssue = BookIssue.all
  @books=Book.all
end


def search
#@profile=AdminProfile.find(params[:id])
@user=User.find_by(profile_id: params[:id], profile_type: "AdminProfile") 

end

def issue
#@profile=AdminProfile.find(params[:id])
@user=User.find_by(profile_id: params[:id], profile_type: "AdminProfile")
end

def issueBook
  @user=User.find_by(profile_id: params[:id], profile_type: "AdminProfile")  
  searchKey = params[:searchKey] 
  if  searchKey==nil
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end  
  @bookResults = Book.where("(lower(title) = ? OR lower(author) = ?) AND issued = ?",searchKey.downcase,searchKey.downcase,false)  
   
  render 'issueBook'
end



 def issuetrue
  @user=User.find_by(profile_id: params[:id], profile_type: "AdminProfile")
  
  username = params[:username]
  bookId = params[:bookId]

   if  username==nil
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end

   if  bookId==nil
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end

  @userResult = User.where("username = ?",username)

  if @userResult.blank? 
    flash[:danger]="Book Issue Failed! Borrower username Not Registered."
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end

  @book=Book.find_by(bookId: params[:bookId])

  if @book.blank? 
    flash[:danger]="Book Issue Failed! Wrong BookId."
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end

  if @book.issued 
    flash[:danger]="Book Issue Failed! Wrong BookId."
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end

  @currIssuedBooks = BookIssue.where("username = ? ",username)

  if @userResult[0].profile_type=="FacultyProfile" and @currIssuedBooks.size >=8
    flash[:danger]="Book Cannot Be Issued! Max. Limit Reached For "+username
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  elsif @userResult[0].profile_type=="StudentProfile" and @currIssuedBooks.size >=4
    flash[:danger]="Book Cannot Be Issued! Max. Limit Reached For "+username
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end


  if @book.update_attributes(issued: true)
    @bookIssue=BookIssue.create(username: username, BookId: bookId)
    flash[:success]="Book Issued Successfully"
    redirect_to '/admin/'+current_user.profile_id.to_s
  else
    flash[:danger]="Book Issued Failed!"
    redirect_to '/admin/'+current_user.profile_id.to_s
  
  end
  
end

def searchResult

  @user=User.find_by(profile_id: params[:id], profile_type: "AdminProfile")

	searchKey = params[:searchKey]
  if  searchKey==nil
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end	
	@bookResults = Book.where("lower(title) = ? OR lower(author) = ?",searchKey.downcase,searchKey.downcase)	
	 	
	#render 'searchResult'
	
	#redirect_to controller:"parcels", action: "show", id: parcel_location
end

def return
  @user=User.find_by(profile_id: params[:id], profile_type: "AdminProfile")
end

def returnBook
  @user=User.find_by(profile_id: params[:id], profile_type: "AdminProfile")
  searchKey = params[:searchKey]
  if  searchKey==nil
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end   
  @borrowername = params[:searchKey]
  
  @bookResults = BookIssue.where("lower(username) = ? ",searchKey.downcase)  
  @books=Book.all
  
  require 'date'
  $today=Date.today

  render 'returnBook'
end

def performReturn 
  bookId = params[:id]
  if  bookId==nil
    redirect_to '/admin/'+current_user.profile_id.to_s and return
  end 
  @book=Book.find_by(bookId: params[:id])

  if @book.update_attributes(issued: false)
   @bookResults=BookIssue.find_by(bookId: params[:id])
   @bookResults.destroy
   flash[:success]="Book Returned Successfully"
   redirect_to '/admin/'+current_user.profile_id.to_s
  end

end

end
