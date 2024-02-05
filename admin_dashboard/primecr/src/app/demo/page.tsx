'use client';
import { Button } from "@/components/ui/button";

export default function ButtonDemo() {
  return (
    <div className="p-4 sm:ml-72 mt-10 h-1/2 bg-blue-500 flex flex-row ">
      <div className="h-1/2 w-2/3 bg-green-500 flex flex-row items-center justify-around ">
        <Button variant="outline">First Button</Button>
        <Button>Button</Button>
        <Button variant="destructive">Destructive</Button>
      </div>
    </div>
  );
}
