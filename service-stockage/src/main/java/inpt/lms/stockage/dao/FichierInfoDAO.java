package inpt.lms.stockage.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import inpt.lms.stockage.model.FichierInfo;
import inpt.lms.stockage.model.TypeAssociation;



@Repository
public interface FichierInfoDAO extends PagingAndSortingRepository<FichierInfo, Long> {

	Page<FichierInfo> findAllByAssociations_IdCorrespondantAssociationAndAssociations_TypeAssociation(
			String idCorrespondantAssocatin,TypeAssociation typeAssociation,Pageable pagination);
	
	List<FichierInfo> findAllByAssociations_IdCorrespondantAssociationAndAssociations_TypeAssociation(
			String idCorrespondantAssocatin,TypeAssociation typeAssociation);
	
	@Query("SELECT SUM(fi.size) FROM FichierInfo fi JOIN AssociationFichier af "
			+ "ON af.fichierInfo = fi WHERE fi.idProprietaire = ?1 AND "
			+ "af.typeAssociation = 'SAC'")
	Long getUsedSpaceUser(Long idUtilisateur);

	
}
