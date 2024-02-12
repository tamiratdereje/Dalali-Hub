"use client"

import {z} from "zod"
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "../ui/form";
import { Button } from "../ui/button";
import { Input } from "../ui/input";
import { useLoginMutation } from "@/api/auth/authApi";
import { useEffect } from "react";
import { useLoadUserQuery } from "@/api";
import { toast } from "react-hot-toast";



const loginFormSchema = z.object({
    email: z.string().email(),
    password: z.string().min(8),
  })


const LoginComponent = () => {

  const form = useForm<z.infer<typeof loginFormSchema>>({
    resolver: zodResolver(loginFormSchema),
    defaultValues: {
      email: "",
      password: ""
    },
  })

  const [login, {isLoading, isSuccess, error}] = useLoginMutation()
  const {data:userData,refetch} = useLoadUserQuery(undefined,{});

  useEffect(() => {
    if (isSuccess) {
      toast.success("Login Successfully!");
      refetch();
    }
    if (error) {
      if ("data" in error) {
        const errorData = error as any;
        toast.error(errorData.data.message);
      }
    }
  }, [isSuccess, error]);
  




  async function onSubmit(values: z.infer<typeof loginFormSchema>){
    console.log("========< LOGGING >==========")
    await login({email: values.email, password: values.password})
  }


  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <FormField
          control={form.control}
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input placeholder="email" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
               <FormField
          control={form.control}
          name="password"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Password</FormLabel>
              <FormControl>
                <Input placeholder="password" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <Button type="submit" className="w-full">Submit</Button>
      </form>
    </Form>
  )
}

export default LoginComponent