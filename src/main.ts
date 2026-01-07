import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { Environment } from 'libs/utils/environment.utils';
import { Logger } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const globalPrefix = 'api';
  app.setGlobalPrefix(globalPrefix);

  await app.listen(Environment.PORT);
  Logger.log(`🚀 Application is running on: http://localhost:${Environment.PORT}/${globalPrefix}`,);
}
bootstrap();
