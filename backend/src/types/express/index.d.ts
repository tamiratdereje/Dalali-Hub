declare namespace Express {
  interface Request {
    userId?: string;
    advancedResults: {
      success: boolean;
      count: number;
      pagination: { [key: string]: { page: number; limit: number } };
      data: any[];
    };
    customQuery: {};
  }
}
