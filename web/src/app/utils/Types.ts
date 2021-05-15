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
  courseID?: string;
  courseName?: string;
  courseDescription?: string;
  imageURL?: string;
  students?: {
    memberID?: number;
  }[];
  visibility?: {
    visiblityID?: number;
    name?: string;
  };
  // XXX Devoirs à revoir
  devoirs?: any[];
};

export interface Publication {
  id?: string;
  idProprietaire?: number;
  datePublication?: Date;
  idCours?: string;
  contenuPublication?: string;
  fichier?: string;
  image?: string;
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
  idProprietaire?: number;
  idPublication?: string;
  dateLike?: Date;
}
