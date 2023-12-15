declare namespace Express {
  interface Request {
    userId?: string;
    queryString?: string;
    populate?: string;
    page?: number;
    limit?: number;
    customQuery: {};
  }
  interface ReqQuery {
    filterParameter?: {};
  }
}
