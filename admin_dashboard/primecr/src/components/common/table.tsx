import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableFooter,
    TableHead,
    TableHeader,
    TableRow,
  } from "@/components/ui/table"
import { FC } from "react"
import { AiOutlineDelete } from "react-icons/ai"
import UserDeleteAlert from "../Managment/userDeleteDialog"
  
  const users = [
    {
      invoice: "INV001",
      paymentStatus: "Paid",
      totalAmount: "$250.00",
      paymentMethod: "Credit Card",
    },
  ]
  
type UserManagmentProp = {
    id: string,
    firstName: string,
    middleName: string,
    sirName: string,
    email: string,
    phoneNumber: string,
    gender: string,
    region: string,
}

type UserManagmentTableProp  = {
    rows : UserManagmentProp[],
    handleDelete: () => Promise<void>
}



const TableComponent :FC<UserManagmentTableProp> = ({rows, handleDelete}) =>  {
    return (
      <Table>
        {/* <TableCaption>A list of users</TableCaption> */}
        <TableHeader>
          <TableRow>
            <TableHead>Email</TableHead>
            <TableHead>First Name</TableHead>
            <TableHead>MiddleName</TableHead>
            <TableHead>Sir Name</TableHead>
            <TableHead>Phone Number</TableHead>
            <TableHead>Gender</TableHead>
            <TableHead>Region</TableHead>
            <TableHead>Delete</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {rows.map((row) => (
            <TableRow key={row.id}>
              <TableCell >
               <span className={"p-1.5 text-xs font-medium uppercase tracking-wider text-green-800 bg-green-200 rounded-md bg-opacity-50 "}>{row.email}</span> 
              </TableCell>
              <TableCell>{row.firstName}</TableCell>
              <TableCell>{row.middleName}</TableCell>
              <TableCell >{row.sirName}</TableCell>
              <TableCell>{row.phoneNumber}</TableCell>
              <TableCell>{row.gender}</TableCell>
              <TableCell>{row.region}</TableCell>
              <TableCell className="p-3 text-md text-gray-700 whitespace-nowrap cursor-pointer">
                        <UserDeleteAlert userId={row.id} handleUserDelete={handleDelete}/>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
        {/* <TableFooter>
          <TableRow>
            <TableCell colSpan={3}>Total</TableCell>
            <TableCell className="text-right">$2,500.00</TableCell>
          </TableRow>
        </TableFooter> */}
      </Table>
    )
}


export default TableComponent


