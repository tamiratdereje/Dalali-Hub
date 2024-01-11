import { apiSlice } from "..";

export const extendedAuthApiSlice = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    // Add your endpoint definitions here
    login: builder.mutation({
      query: (loginData) => ({
        url: "",
        headers: {
          "Content-Type": "application/json",
        },
        body: loginData,
      }),
      transformErrorResponse: (response: any) => {
        // TODO: register the token on loca
      },
    }),
  }),
});

export const {useLoginMutation} = extendedAuthApiSlice;
