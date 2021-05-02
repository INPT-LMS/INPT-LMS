package inpt.lms.stockage.dao;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.TypeAssociation;

public interface AssociationFichierDAO 
		extends PagingAndSortingRepository<AssociationFichier,Long> {

	List<AssociationFichier> findByFichierInfo_IdAndTypeAssociation(Long idFichier,
			TypeAssociation type);
	
	Long deleteByFichierInfo_IdAndTypeAssociation(Long idFichier,
			TypeAssociation type);
}
