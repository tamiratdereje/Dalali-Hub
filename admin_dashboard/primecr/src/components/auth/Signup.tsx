"use client"

import {z} from "zod"
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage, } from "../ui/form";
import { Button } from "../ui/button";
import { Input } from "../ui/input";
import {  useRegisterMutation } from "@/api/auth/authApi";
import React, { useEffect } from "react";
import { toast } from "react-hot-toast";
import  { isStrongPassword } from "validator";
import { Select, SelectContent, SelectLabel, SelectValue, SelectTrigger, SelectGroup, SelectItem } from "../ui/select";
import { PhoneInput } from "../ui/phoneinput";
import { isValidPhoneNumber } from "react-phone-number-input";

export const registerFormSchema = z.object({
    firstName: z.string(),
    middleName: z.string(),
    sirName: z.string(),
    email: z.string().email(),
    phoneNumber: z.string().refine(isValidPhoneNumber),
    password: z.string().min(8).refine(isStrongPassword),
    confirmPassword: z.string().min(8),
    gender: z.string(),
    region: z.string(),
}).superRefine(({ confirmPassword, password }, ctx) => {
  if (confirmPassword !== password) {
    ctx.addIssue({
      code: "custom",
      message: "The passwords did not match"
    });
  }
});


//type

type SignupComponentProps = {
  setRoute: React.Dispatch<React.SetStateAction<string>>;
};

const SignupComponent:React.FC<SignupComponentProps> = ({setRoute}) => {

  const form = useForm<z.infer<typeof registerFormSchema>>({
    resolver: zodResolver(registerFormSchema),
    defaultValues: {
      firstName:"",middleName:"",sirName:"",
      email:"", phoneNumber:"", password:"",
      confirmPassword:"",gender:"", region:""
    },
  })


  const [register,{data,error,isSuccess}] = useRegisterMutation(); 

  useEffect(() => {
   if(isSuccess){
      // const message = data?.message || "Registration successful";
      toast.success("message");
      setRoute("otp");
   }
   if(error){
    if("data" in error){
      const errorData = error as any;
      toast.error(errorData.data.message);
    }
   }
  }, [isSuccess,error]);
  
  


  async function onSubmit(values: z.infer<typeof registerFormSchema>){
    console.log("========< Regsitering >==========")
    await register({  firstName: values.firstName, middleName: values.middleName, sirName: values.sirName,
                      phoneNumber: values.phoneNumber, email: values.email, password: values.password, gender: values.gender, region: values.region
    })
  }


  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">

        <FormField
          control={form.control}
          name="firstName"
          render={({ field }) => (
            <FormItem className="w-full">
              <FormLabel>First Name</FormLabel>
              <FormControl>
                <Input placeholder="First Name" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="middleName"
          render={({ field }) => (
            <FormItem className="w-full">
              <FormLabel>Middle Name</FormLabel>
              <FormControl>
                <Input placeholder="Middle Name" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
             <FormField
          control={form.control}
          name="sirName"
          render={({ field }) => (
            <FormItem className="w-full">
              <FormLabel>Sir Name</FormLabel>
              <FormControl>
                <Input placeholder="Sir Name" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="region"
          render={({ field }) => (
            <FormItem className="w-full">
              <FormLabel>Region</FormLabel>
              <FormControl>
                <Input placeholder="Region " {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="phoneNumber"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Phone Number</FormLabel>
              <FormControl>
                <PhoneInput placeholder="Phone Number" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
         <FormField
          control={form.control}
          name="gender"
          render={({ field }) => (
            <FormItem className="w-full">
              <FormLabel>Gender</FormLabel>
              <FormControl>
                <Select
                    onValueChange={field.onChange}
                    value={field.value}
                  >
                    <SelectTrigger >
                      <SelectValue placeholder="Gender" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectGroup>
                        <SelectLabel>gender</SelectLabel>
                        <SelectItem value="MALE">Male</SelectItem>
                        <SelectItem value="FEMALE">Female</SelectItem>
                      </SelectGroup>
                    </SelectContent>
                  </Select>
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
      

        </div>

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

      




      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">


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
        <FormField
          control={form.control}
          name="confirmPassword"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Confirm Password</FormLabel>
              <FormControl>
                <Input placeholder="Type your password again" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
      </div>

        
        <Button type="submit" className="w-full">Submit</Button>
      </form>
    </Form>
  )
}

export default SignupComponent