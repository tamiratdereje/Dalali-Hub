"use client"

import { Button } from "@/components/ui/button"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"

import LoginComponent from "./Login"
import { useState } from "react"
import SignupComponent from "./Signup"
import { Separator } from "@radix-ui/react-dropdown-menu"

export function AuthDialog() {

    const [route, setRoute] = useState<string>("login");
  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button variant="outline" className="rounded-full"></Button>
      </DialogTrigger>
      <DialogContent className={`sm:max-w-[425px]  ${route!=="login" && "md:max-w-[745px]"}`}>
        <DialogHeader>
          <DialogTitle className="my-3 text-center">{route==="login" && "Login" || route==="otp" && "OTP " || "Sign Up" }</DialogTitle>

        </DialogHeader>
        {route==="login" ? <LoginComponent/> :<SignupComponent setRoute={setRoute}/> }
        <Separator/>
        <DialogFooter>
          
          <p className="w-full text-center"> {route==="login" ? "Create new account ": "Already have an account? "  } <span className="font-semibold cursor-pointer"  onClick={()=> setRoute(route==="login" ? "signup" : "login" )}>{route==="login" ? "sign up" : "log in" }</span></p>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  )
}
