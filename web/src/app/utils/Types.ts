export type User = {
  id?: number;
  fullName?: string;
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
  owner?: {
    professorID?: number;
  };
  // XXX Devoirs à revoir
  devoirs?: any[];
};

export type Devoir = {
  id?: string;
  idCours?: string;
  idPropprietaire?: number;
  devoirInfos?: DevoirInfos;
  reponses?: ReponseDevoir[];
  type?: 'DEVOIR' | 'QUIZZ';
};

export type DevoirInfos = {
  type?: 'DEVOIR' | 'QUIZZ';
  contenu?: string;
  dateLimite?: Date;
};

export type ReponseDevoir = {
  id?: string;
};

export interface Publication {
  id?: string;
  idProprietaire?: number;
  nomUser?: string;
  prenomUser?: string;
  datePublication?: Date;
  idCours?: string;
  contenuPublication?: string;
  fichier?: string;
  image?: string;
  commentaires?: Commentaire[];
  likes?: Like[];
}

export interface Commentaire {
  id?: string;
  idPublication: string;
  idProprietaire?: number;
  contenuCommentaire: string;
}

export interface Like {
  id?: string;
  idProprietaire?: number;
  idPublication?: string;
  dateLike?: Date;
}

export interface Conversation {
  id: string;
  nomParticipant1: string;
  nomParticipant2: string;
  idParticipant1: number;
  idParticipant2: number;
  lastMessage?: Message;
}

export interface Message {
  id?: string;
  contenu?: string;
  date?: string;
  idDestinataire?: number;
  idEmetteur?: number;
  idDiscussion?: string;
}
