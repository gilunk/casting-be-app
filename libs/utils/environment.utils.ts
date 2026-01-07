import 'dotenv/config';

export class Environment {
  static NODE_ENV = process.env.NODE_ENV || 'development';
  static APP_NAME = process.env.APP_NAME || 'CASTING-BE';
  static PORT = process.env.PORT || 3000;
}
