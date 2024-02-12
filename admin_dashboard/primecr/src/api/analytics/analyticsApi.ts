import { apiSlice } from ".."; 

export const analyticsApi = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getAllCourses: builder.query({
      query: () => ({
        url: "get-admin-courses",
        method: "GET",
        credentials: "include" as const,
      }),
    }),
    deleteCourse: builder.mutation({
      query: (id) => ({
        url: `delete-course/${id}`,
        method: "DELETE",
        credentials: "include" as const,
      }),
    }),
    editCourse: builder.mutation({
      query: ({ id, data }) => ({
        url: `edit-course/${id}`,
        method: "PUT",
        body: data,
        credentials: "include" as const,
      }),
    }),
    getTotalUsers: builder.query({
      query: () => ({
        url: "get-courses",
        method: "GET",
        credentials: "include" as const,
      }),
    }),
    // getCourseDetails: builder.query({
    //   query: (id: any) => ({
    //     url: `get-course/${id}`,
    //     method: "GET",
    //     credentials: "include" as const,
    //   }),
    // }),
    // getCourseContent: builder.query({
    //   query: (id) => ({
    //     url: `get-course-content/${id}`,
    //     method: "GET",
    //     credentials: "include" as const,
    //   }),
    // }),
    // addNewQuestion: builder.mutation({
    //   query: ({ question, courseId, contentId }) => ({
    //     url: "add-question",
    //     body: {
    //       question,
    //       courseId,
    //       contentId,
    //     },
    //     method: "PUT",
    //     credentials: "include" as const,
    //   }),
    // }),
    // addAnswerInQuestion: builder.mutation({
    //   query: ({ answer, courseId, contentId, questionId }) => ({
    //     url: "add-answer",
    //     body: {
    //       answer,
    //       courseId,
    //       contentId,
    //       questionId,
    //     },
    //     method: "PUT",
    //     credentials: "include" as const,
    //   }),
    // }),
    // addReviewInCourse: builder.mutation({
    //   query: ({ review, rating, courseId }: any) => ({
    //     url: `add-review/${courseId}`,
    //     body: {
    //       review,
    //       rating,
    //     },
    //     method: "PUT",
    //     credentials: "include" as const,
    //   }),
    // }),
    // addReplyInReview: builder.mutation({
    //   query: ({ comment, courseId, reviewId }: any) => ({
    //     url: `add-reply`,
    //     body: {
    //       comment, courseId, reviewId
    //     },
    //     method: "PUT",
    //     credentials: "include" as const,
    //   }),
    // }),
  }),
});

export const {

  useGetAllCoursesQuery,
  useDeleteCourseMutation,
  useEditCourseMutation,
} = analyticsApi;
