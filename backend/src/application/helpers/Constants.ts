export enum Environments {
  DEVELOPMENT = "development",
  PRODUCTION = "production",
  TEST = "test",
}

export const isDevEnvironment = () => {
  console.log("process.env.NODE_ENV: ", process.env.NODE_ENV);
  return process.env.NODE_ENV === Environments.DEVELOPMENT;
};

export const isProdEnvironment = () => {
  return process.env.NODE_ENV === Environments.PRODUCTION;
};
