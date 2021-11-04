package waterbnb.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import waterbnb.models.User;
import waterbnb.services.UserService;



@Component
public class UserValidator implements Validator {
    private final UserService userService;
    
    public UserValidator(UserService userService) {
    	this.userService = userService;
    }
   
    
    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }
    
    @Override
    public void validate(Object target, Errors errors) {
        User user = (User) target;
        
        if (!user.getPasswordConfirmation().equals(user.getPassword())) {

            errors.rejectValue("passwordConfirmation", "Match");
        }
        
        if (!userService.validateEmail(user.getEmail())) {
        	errors.rejectValue("email", "InvalidEmail");
        }
        
        
    }
}
