package waterbnb.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import waterbnb.models.Place;


@Repository
public interface PlaceRepository extends CrudRepository<Place, Long> {
	List<Place> findByAddressContaining(String address);
}
