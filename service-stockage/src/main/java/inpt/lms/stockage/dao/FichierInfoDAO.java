package inpt.lms.stockage.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import inpt.lms.stockage.model.FichierInfo;
import inpt.lms.stockage.model.TypeAssociation;

public interface FichierInfoDAO extends PagingAndSortingRepository<FichierInfo, Long> {

	Page<FichierInfo> findByAssociations_IdCorrespondantAssociationAndAssociations_TypeAssociation(
			String idCorrespodant,TypeAssociation type,Pageable pagination);

}
