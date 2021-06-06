package inpt.lms.stockage.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import inpt.lms.stockage.model.AssociationFichier;
import inpt.lms.stockage.model.TypeAssociation;

@Repository
public interface AssociationFichierDAO 
		extends PagingAndSortingRepository<AssociationFichier,Long> {

	List<AssociationFichier> findAllByFichierInfo_IdAndTypeAssociation(Long id,
			TypeAssociation typeAssociation);
	
	Page<AssociationFichier> findAllByFichierInfo_NomIgnoreCaseContainingAndIdCorrespondantAssociationAndTypeAssociation(
			String partieNom,String idCorrespondant, TypeAssociation typeAssociation,
			Pageable page);
	
	Long deleteByFichierInfo_IdAndTypeAssociation(Long idFichier,
			TypeAssociation type);

	Page<AssociationFichier> findAllByIdCorrespondantAssociationAndTypeAssociation(String idAssocie,
			TypeAssociation typeAssociation, Pageable pagination);
	
	boolean existsByIdAndIdCorrespondantAssociationAndTypeAssociation(
			Long idAssoc, String idAssocie,TypeAssociation typeAssociation);
	
	Optional<AssociationFichier> findByIdAndIdCorrespondantAssociationAndTypeAssociation(
			Long idAssoc, String idAssocie,TypeAssociation typeAssociation);
	
	Optional<AssociationFichier> findByIdCorrespondantAssociationAndTypeAssociation(
			String idAssocie,TypeAssociation typeAssociation);

	Optional<AssociationFichier> findByIdCorrespondantAssociationAndTypeAssociationAndFichierInfo_IdProprietaire(
			String idCorrespondant, TypeAssociation typeAssociation ,long id);
}
