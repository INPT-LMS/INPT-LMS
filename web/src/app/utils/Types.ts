export type User = {
  id?: number;
  nom?: string;
  prenom?: string;
  email?: string;
  password?: string;
  estProfesseur?: boolean;
  enseigneA?: string;
  etudieA?: string;
  langue?: string;
};

export type Class = {
  id?: number;
  nom?: string;
  prenom?: string;
  email?: string;
  password?: string;
  estProfesseur?: boolean;
  enseigneA?: string;
  etudieA?: string;
  langue?: string;
};

export interface Publication {
  idPublication?: string;
  idProprietaire?: number;
  datePublication?: Date;
  idCours?: string;
  contenuPublication?: string;
  fichier?: string;
  commentaires?: Commentaire[];
  likes?: Like[];
}

export interface Commentaire {
  idCommentaire?: string;
  idPublication: string;
  idProprietaire?: number;
  contenu: string;
}

export interface Like {
  idLike?: string;
  idPublication: string;
  idProprietaire?: number;
  dateLike?: Date;
}
