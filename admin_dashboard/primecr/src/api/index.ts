import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";

export const apiSlice = createApi({
  reducerPath: "api",
  tagTypes: [],
  baseQuery: fetchBaseQuery({
    baseUrl: "https://dalalihub.onrender.com/api/v1",
  }),
  endpoints: (builder) => ({
    
  }),
});
