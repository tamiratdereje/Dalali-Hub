declare namespace Express {
  interface Request {
    userId?: string;
    queryString?: string;
    populate?: string;
    page?: number;
    limit?: number;
    customQuery: {};
    sort: string;
  }
  interface ReqQuery {
    filterParameter?: {};
  }
}
