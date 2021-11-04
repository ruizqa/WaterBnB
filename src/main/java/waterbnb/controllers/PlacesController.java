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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import waterbnb.models.Place;
import waterbnb.models.Review;
import waterbnb.models.User;
import waterbnb.services.UserService;
import waterbnb.constants.PoolSizes;



@Controller
public class PlacesController {
	private final UserService userService;
    private final List<String>poolSizes= PoolSizes.poolSizes;
    
    
    public PlacesController(UserService userService) {
    	this.userService = userService;

    }
    

	@RequestMapping(value="/")
    public String search(Model model, HttpSession session) {
		if(session.getAttribute("userId")!=null) {
			model.addAttribute("log", true);
		}		
				
		return "/places/find.jsp";
		
    }
    
	@RequestMapping(value="/search")
    public String joinEvent(@RequestParam("location") String location, Model model, HttpSession session) {
		if(session.getAttribute("userId")!=null) {
			model.addAttribute("log", true);
		}
		List<Place> places = userService.findPlaceByLocation(location);
		model.addAttribute("places", places);
		return "/places/guestDashboard.jsp";
		
    }
    

    
	@RequestMapping(value="/addPlace", method=RequestMethod.POST)
    public String addEvent(@Valid @ModelAttribute("place") Place place, BindingResult result, HttpSession session, Model model) {
		Long id = (Long) session.getAttribute("userId");
		User user = userService.findUserById(id);
		model.addAttribute("user", user);

		
    	if(result.hasErrors()) {
    		model.addAttribute("poolSizes", poolSizes);
    		return"places/hostDashboard.jsp";
    	} else {
    		userService.savePlace(user, place);
    		return "redirect:/host/dashboard";
    	}

    }
	
	
	@RequestMapping(value="/place/{id}")
    public String joinEvent(@PathVariable (value="id") Long placeId, Model model, HttpSession session) {
		if(session.getAttribute("userId")!=null) {
			model.addAttribute("log", true);
		}
		Place place = userService.findPlaceById(placeId);
		model.addAttribute("place", place);
		return "/places/show.jsp";
		
    }
	
	@RequestMapping(value="/host/place/{id}")
    public String updatePlace(@PathVariable (value="id") Long placeId, HttpSession session, Model model) {
		if (session.getAttribute("userId")== null){
			return "redirect:/guest/signin";
		}
		Long user_id = (Long) session.getAttribute("userId");
		User user = userService.findUserById(user_id);
		Place place = userService.findPlaceById(placeId);
		model.addAttribute("poolSizes", poolSizes);
		model.addAttribute("user", user);
		model.addAttribute("place", place);
		return "/places/hostShow.jsp";
    }
	
	
	@RequestMapping(value="/updatePlace", method=RequestMethod.POST)
    public String updatePlace(@RequestParam("id") Long placeId,@RequestParam("address") String address,
    		@RequestParam("description") String description,
    		@RequestParam("cost") double cost, @RequestParam("poolSize") String poolSize,
    		RedirectAttributes redirectAttributes, Model model) {
	
		Place place = userService.findPlaceById(placeId);

		
		if(userService.validatePlace(address, description, cost, poolSize) == "") {
			place.setAddress(address);
			place.setDescription(description);
			place.setCost(cost);
			place.setPoolSize(poolSize);
			userService.updatePlace(place);
			
			return String.format("redirect:/host/place/%d",placeId);
			
		} else {
			
			String error = userService.validatePlace(address, description, cost, poolSize);
			redirectAttributes.addFlashAttribute("error", error);
			return String.format("redirect:/host/place/%d",placeId);

		}
		

		
    }
	
	@RequestMapping(value="/place/{id}/review")
    public String Review(@ModelAttribute("review") Review review, @PathVariable (value="id") Long placeId, Model model, HttpSession session) {
		if (session.getAttribute("userId")== null){
			return "redirect:/guest/signin";
		}
		Place place = userService.findPlaceById(placeId);
		model.addAttribute("place", place);
		return "/places/review.jsp";
		
    }
	
	@RequestMapping(value="/addReview", method=RequestMethod.POST)
    public String addEvent(@Valid @ModelAttribute("review") Review review, BindingResult result, HttpSession session, Model model) {
		Long id = (Long) session.getAttribute("userId");
		User user = userService.findUserById(id);
		model.addAttribute("user", user);

		
    	if(result.hasErrors()) {
    		
    		return"/places/review.jsp";
    	} else {
    		Place place = userService.findPlaceById(review.getPlaceId());
    		userService.saveReview(user,place,review);
    		return String.format("redirect:/place/%d", review.getPlaceId());
    	}

    }
	
	

	
	
}
