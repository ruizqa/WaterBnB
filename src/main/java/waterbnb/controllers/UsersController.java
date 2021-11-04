package waterbnb.controllers;


import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import waterbnb.constants.PoolSizes;
import waterbnb.models.Place;
import waterbnb.models.User;
import waterbnb.services.UserService;
import waterbnb.validator.UserValidator;


@Controller
public class UsersController {
    private final UserService userService;
    private final UserValidator userValidator;
    private final List<String> poolSizes = PoolSizes.poolSizes;
	
	public UsersController(UserService userService, UserValidator userValidator) {
		this.userService = userService;
		this.userValidator = userValidator;
	}
	
	@RequestMapping("/guest/signin")
    public String registerForm(@ModelAttribute("user") User user,
    		@ModelAttribute("userLogin") User userLogin, Model model) {
        return "users/index.jsp";
    }
	
	@RequestMapping(value="/registration", method=RequestMethod.POST)
	    public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session,
	    		@ModelAttribute("userLogin") User userLogin) {
	    	userValidator.validate(user, result);
	    	if(result.hasErrors()) {
	    		return "users/index.jsp";
	    	} 
	    	else {
	    		userService.registerUser(user);
	    		session.setAttribute("userId", user.getId());
	    		session.setAttribute("userType", user.getType());
	    		if(user.getType() == 1) {
	        		return"redirect:/host/dashboard";}
	        		else {
	        			
	        			return "redirect:/";
	        		}
	    	}

	    }
	    
	@RequestMapping(value="/login", method=RequestMethod.POST)
	    public String loginUser(@Valid @ModelAttribute("userLogin") User userLogin,BindingResult result,
	    		Model model, HttpSession session,@ModelAttribute("user") User user) {
		
		if(result.hasErrors()) {
    		return"users/index.jsp";
    	} else {
    		
    		if(userService.authenticateUser(userLogin.getEmail(), userLogin.getPassword())){
    			userLogin = userService.findByEmail(userLogin.getEmail());
        		session.setAttribute("userId", userLogin.getId());
        		session.setAttribute("userType", userLogin.getType());
        		if(userLogin.getType() == 1) {
        		return"redirect:/host/dashboard";}
        		else {
        			return "redirect:/";
        		}
    			
    		}
    		else {
    		model.addAttribute("error", "Wrong credentials. Please enter your valid credentials");
    		return "users/index.jsp";}
    	}
		

	    }
	
	@RequestMapping("/host/dashboard")
    public String home(@ModelAttribute("place") Place place, Model model, HttpSession session) {
		
		if(session.getAttribute("userId")==null) {
			return"redirect:/";
		}
		
		Long id = (Long) session.getAttribute("userId");
		User user = userService.findUserById(id);
		model.addAttribute("poolSizes", poolSizes);
		model.addAttribute("user", user);

        return "/places/hostDashboard.jsp";
    }
	
	

	
	
	@RequestMapping("/logout")
    public String logout(HttpSession session) {
		session.invalidate();
        return "redirect:/";
    }
	
	
}
