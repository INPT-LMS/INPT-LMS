// TODO des erreurs plus sophistiquées
import { ErrorHandler } from '@angular/core';

interface Error {
  error: string;
  status: number;
}

export class MyErrorsHandler implements ErrorHandler {
  handleError(error: Error) {
    console.log(error);
  }
}
