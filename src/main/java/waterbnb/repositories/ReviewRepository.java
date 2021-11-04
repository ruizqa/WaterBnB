package waterbnb.repositories;



import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;


import waterbnb.models.Review;


@Repository
public interface ReviewRepository extends CrudRepository<Review, Long> {

}
