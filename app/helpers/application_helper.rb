module ApplicationHelper

def default_profile_picture(user)
 
      if user.avatar_url.blank?  
        user.avatar= "d-man-profile.jpg"
        image_tag("d-man-profile.jpg",:id => "userPic")          
      else 
        image_tag(user.avatar_url(:profile),:id => "userPic"  ) 
      end

end


def default_small_picture(user)
    if user.avatar_url.blank?
      image_tag("d-man-small.jpg")  
    else 
      image_tag(user.avatar_url(:small))   
    end
end

end
