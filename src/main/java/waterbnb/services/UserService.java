package waterbnb.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import waterbnb.models.Place;
import waterbnb.models.Review;
import waterbnb.models.User;
import waterbnb.repositories.PlaceRepository;
import waterbnb.repositories.ReviewRepository;
import waterbnb.repositories.UserRepository;



@Service
public class UserService {
    private final UserRepository userRepository;
    private final PlaceRepository placeRepository;
    private final ReviewRepository reviewRepository;
    
    public UserService(UserRepository userRepository,PlaceRepository placeRepository, ReviewRepository reviewRepository ) {
        this.userRepository = userRepository;
        this.placeRepository = placeRepository;
        this.reviewRepository = reviewRepository;
    }
    
    public boolean validateEmail (String email) {
    	Optional<User> u = userRepository.findByEmail(email);
    	if(u.isPresent()) {
            return false;
    	} else {
    	    return true;
    	}
    	
    }
    
    // register user and hash their password
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepository.save(user);
    }
    
    // find user by email
    public User findByEmail(String email) {
    	Optional<User> u = userRepository.findByEmail(email);
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    
    // find user by id
    public User findUserById(Long id) {
    	Optional<User> u = userRepository.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    
    // authenticate user
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
    	Optional<User> u = userRepository.findByEmail(email);
        // if we can't find it by email, return false
        if(!u.isPresent()) {
            return false;
        } else {
            User user = u.get();
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }
    
    public List<Place> findPlaceByLocation(String location) {
    	List<Place> places = placeRepository.findByAddressContaining(location);
    	return places;
    }
    
    public Place findPlaceById(Long id) {
    	Optional<Place> p = placeRepository.findById(id);
    	if(p.isPresent()) {
            return p.get();
    	} else {
    	    return null;
    	}
    }
    
    public void savePlace(User host, Place place) {
    	place.setHost(host);
    	placeRepository.save(place);
    	
    }
    
    public void updatePlace(Place place) {
    	placeRepository.save(place);
    	
    }
    
    
    public void saveReview(User sender, Place place, Review review) {
    	review.setSender(sender);
    	review.setPlace(place);
    	reviewRepository.save(review);
    	    	
    }
    
    
    public String validatePlace (String address, String description, double cost, String poolSize) {
    	String result = "";
    	
    	if (address.length() <1 | description.length()<1) {
    		result += "The address and description must be at least 1 character long.\n";
    	}
    	
    	if (poolSize.length()<1) {
    		result += "Please select a pool size.\n";
    	}
    	
    	if (cost<1) {
    		result += "Please enter the cost of the rental.\n";
    	}
    	
    	return result;
    	
    }
    
    
    
}

