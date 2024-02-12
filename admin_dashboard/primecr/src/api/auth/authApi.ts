import { apiSlice } from "..";
import { userLoggedIn, userLoggedOut, userRegistration } from "./authSlice";



export const authApi = apiSlice.injectEndpoints({

  endpoints: (builder) => ({
    // endpoints here
    register: builder.mutation<RegistrationResponse, RegistrationData>({
      query: (data) => ({
        url: "auth/signup",
        method: "POST",
        body: data,
        credentials: "include" as const,
      }),
      async onQueryStarted(arg, { queryFulfilled, dispatch }) {
        try {
          console.log(arg)
          const result = await queryFulfilled;
          // dispatch(
          //   userRegistration({
          //     token: result.data.activationToken,
          //   })
          // );
        } catch (error: any) {
          console.log(error);
        }
      },
    }),
    activation: builder.mutation({
      query: ({ activation_token, activation_code }) => ({
        url: "auth/activate-user",
        method: "POST",
        body: {
          activation_token,
          activation_code,
        },
      }),
    }),
    login: builder.mutation({
      query: ({ email, password }) => ({
        url: "auth/login",
        method: "POST",
        body: {
          email,
          password,
        },
        credentials: "include" as const,
      }),
      async onQueryStarted(arg, { queryFulfilled, dispatch }) {
        try {
          const result = await queryFulfilled;
          // dispatch(
          //   userLoggedIn({
          //     accessToken: result.data.accessToken,
          //     user: result.data.user,
          //   })
          // );
        } catch (error: any) {
          console.log(error);
        }
      },
    }),
    logOut: builder.query({
      query: () => ({
        url: "auth/logout",
        method: "GET",
        credentials: "include" as const,
      }),
      async onQueryStarted(arg, { queryFulfilled, dispatch }) {
        try {
          dispatch(
            userLoggedOut()
          );
        } catch (error: any) {
          console.log(error);
        }
      },
    }),


  }),
});

export const {
  useRegisterMutation,
  useActivationMutation,
  useLoginMutation,
  // useSocialAuthMutation,
  useLogOutQuery
} = authApi;
