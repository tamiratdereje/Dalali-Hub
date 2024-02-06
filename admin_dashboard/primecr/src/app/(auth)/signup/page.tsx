"use client";
import * as z from "zod";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import {
  SelectValue,
  SelectTrigger,
  SelectContent,
  SelectItem,
  Select,
} from "@/components/ui/select";

const formSchema = z
  .object({
    firstName: z.string().min(3),
    middleName: z.string().min(3),
    sirName: z.string().min(3),
    email: z.string().email(),
    phoneNumber: z.string().min(10),
    gender: z.enum(["male", "female"]),
    region: z.string().min(3),
    // photo as a file
    photo: z.string(),
    password: z.string().min(3),
    passwordConfirm: z.string().min(3),
    // isVerified: z.boolean(),
    role: z.enum(["admin", "customer", "broker"]),
  })
  .refine(
    (data) => {
      return data.password === data.passwordConfirm;
    },
    {
      message: "Passwords do not match",
      path: ["passwordConfirm"],
    }
  );

export default function SignUp() {
  //   firstName: string;
  //   middleName: string;
  //   sirName: string;
  //   email: string;
  //   phoneNumber: string;
  //   gender: Gender;
  //   region: string;
  //   photos: mongoose.Types.ObjectId[];
  //   password: string;
  //   isVerified: boolean;
  //   role: Role;

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      firstName: "",
      middleName: "",
      sirName: "",
      email: "",
      phoneNumber: "",
      region: "",
      gender: "male",
      role: "customer",
      // photos: [],
      password: "",
      passwordConfirm: "",
    },
  });

  const handleSubmit = (values: z.infer<typeof formSchema>) => {
    console.log({ values });
  };

  return (
    <div className="flex min-h-screen flex-col items-center justify-between p-24">
      <Form {...form}>
        <form
          onSubmit={form.handleSubmit(handleSubmit)}
          className="max-w-md w-full flex flex-col gap-4 items-center"
        >
          <div className="flex flex-row gap-16">
            <div className="flex flex-col gap-4">
              <FormField
                control={form.control}
                name="firstName"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>FirstName</FormLabel>
                      <FormControl>
                        <Input placeholder="FirstName" type="text" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />
              <FormField
                control={form.control}
                name="sirName"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>sirName</FormLabel>
                      <FormControl>
                        <Input placeholder="sirName" type="text" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />
              <FormField
                control={form.control}
                name="phoneNumber"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>Phone number</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="Phone number"
                          type="tel"
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />

              <FormField
                control={form.control}
                name="region"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>region</FormLabel>
                      <FormControl>
                        <Input placeholder="region" type="text" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />
              <FormField
                control={form.control}
                name="gender"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>Gender</FormLabel>
                      <Select onValueChange={field.onChange}>
                        <FormControl>
                          <SelectTrigger>
                            <SelectValue placeholder="Select your gender" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                          <SelectItem value="male">Male</SelectItem>
                          <SelectItem value="female">Female</SelectItem>
                        </SelectContent>
                      </Select>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />

              <FormField
                control={form.control}
                name="password"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>Password</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="Password"
                          type="password"
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />
            </div>

            <div className="flex flex-col gap-4">
              <FormField
                control={form.control}
                name="middleName"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>middleName</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="middleName"
                          type="text"
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />

              <FormField
                control={form.control}
                name="email"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>Email address</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="Email address"
                          type="email"
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />

              <FormField
                control={form.control}
                name="photo"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>photo</FormLabel>
                      <FormControl>
                        <Input placeholder="photos" type="file" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />

              <FormField
                control={form.control}
                name="role"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>Role</FormLabel>
                      <Select onValueChange={field.onChange}>
                        <FormControl>
                          <SelectTrigger>
                            <SelectValue placeholder="Select your gender" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                          <SelectItem value="admin">Admin</SelectItem>
                          <SelectItem value="customer">Customer</SelectItem>
                          <SelectItem value="provider">Provider</SelectItem>
                        </SelectContent>
                      </Select>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />

              <FormField
                control={form.control}
                name="passwordConfirm"
                render={({ field }) => {
                  return (
                    <FormItem>
                      <FormLabel>Password confirm</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="Password confirm"
                          type="password"
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  );
                }}
              />
            </div>
          </div>
          <Button type="submit" className="w-1/2 z-10">
            Submit
          </Button>
        </form>
      </Form>
    </div>
  );
}
