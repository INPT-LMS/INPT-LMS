package inpt.lms.stockage.dao;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.TypeAssociation;

@Repository
public interface AssociationFichierDAO 
		extends PagingAndSortingRepository<AssociationFichier,Long> {

	List<AssociationFichier> findByFichierInfo_IdAndTypeAssociation(Long idFichier,
			TypeAssociation type);
	
	Long deleteByFichierInfo_IdAndTypeAssociation(Long idFichier,
			TypeAssociation type);
}
