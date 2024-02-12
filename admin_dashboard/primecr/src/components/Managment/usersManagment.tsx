// "use client"
// import React, { FC, useEffect, useState } from "react";
// import { AiOutlineDelete, AiOutlineMail } from "react-icons/ai";
// import { useTheme } from "next-themes";
// // import Loader from "../../Loader/Loader";
// // import { format } from "timeago";
// import {
//   useGetAllUsersQuery,
//   useDeleteUserMutation,
//   useUpdateUserRoleMutation,
// } from "@/api/users/userApi";
// import { toast } from "react-hot-toast";
// import { capitalizeString } from "@/lib/utils";
// import TableComponent from "../common/table";
// import { Button } from "../ui/button";
// import { PaginationComponent } from "../common/pagination";
// // import { useApproveRejectAccessMutation } from "@/redux/features/orders/ordersApi";



// const AllUsers: FC = () => {

//   const [page, setpage] = useState(0)
//   const [dir, setdir] = useState(1)

//   const { theme, setTheme } = useTheme();
//   const [active, setActive] = useState(false);
//   const [open, setOpen] = useState(false);
//   const [rowData, setRowData] = useState({"userId":"", "courseId":""});
//   const [newData, setnewData] = useState({"userEmail":"", "courseId":""});

//     const { isLoading, data, refetch } = useGetAllUsersQuery(
//       {page: page, dir:dir},
//       { refetchOnMountOrArgChange: true }
//       );
//       const [deleteUser, { isSuccess: deleteSuccess, error: deleteError }] =
//       useDeleteUserMutation({});
      
//       useEffect(() => {

//         refetch()
        
//         if (deleteSuccess) {
//           refetch();
//           toast.success("Users Account Deleted successfully!");
//           setOpen(false);
//         }
//         if (deleteError) {
//           if ("data" in deleteError) {
//             const errorMessage = deleteError as any;
//             toast.error(errorMessage.data.message);
//           }
//         }
//       }, [deleteSuccess, deleteError, page,dir]);
      
//       const rows: any = [];

//   data &&
//   data?.data?.forEach((user: any) => {
//     rows.push({
//         id:user.id,
//         firstName:capitalizeString(user.firstName),
//         middleName:capitalizeString(user.middleName),
//         sirName:capitalizeString(user.sirName),
//         email:user.email,
//         phoneNumber:user.phoneNumber,
//         gender:user.gender,
//         region:user.region,
//         // photos:user.photos
//     })
//   });

//   // console.log("+============", rows)

//   const handleSubmit = async () => {
//     // addUserHere
//   };
  

//   const handleDelete = async () => {
//     const id = rowData.userId;
//     await deleteUser(id );

//   };

//   return (
//     <div className="h-screen">
//       {/* {isLoading ? (
//         <Loader />
//       ) : ( */}
//         <div className="my-5 h-[80%] flex flex-col justify-between"  >
           
//             <TableComponent rows={rows}/>
//             <div className="w-full flex justify-between"> 
//                 <Button type="submit" className="w-[25%]" >Add User</Button>
//                 <PaginationComponent/>
//             </div> 



   
            
   
          
//           {/* {active && (
//             <Modal
//               open={active}
//               onClose={() => setActive(!active)}
//               aria-labelledby="modal-modal-title"
//               aria-describedby="modal-modal-description"
//             >
//               <Box className="absolute top-[50%] left-[50%] -translate-x-1/2 -translate-y-1/2 w-[450px] bg-white dark:bg-slate-900 rounded-[8px] shadow p-4 outline-none">
//                 <h1 className={`${styles.title}`}>Add New Member</h1>
//                 <div className="mt-4">
//                   <input
//                     type="email"
//                     value={newData.userEmail}
//                     onChange={(e) => setnewData({...newData, userEmail:e.target.value})}
//                     placeholder="Enter email..."
//                     className={`${styles.input}`}
//                   />
//                   <select
//                     name=""
//                     id=""
//                     className={`${styles.input} !mt-6`}
//                     onChange={(e: any) => setnewData({...newData, courseId:e.target.value})
//                     }
//                   >
//                     <option value={"SELECT COURSE"}>"select course</option>
//                   {
//                     courseData&& courseData?.courses.map((course:any, id: number)=>{
//                     return <option key={course._id} value={course._id}>{course.name}</option>
//                     })
                    
//                   }
//                   </select>
//                   <br />
//                   <div
//                     className={`${styles.button} my-6 !h-[30px]`}
//                     onClick={handleSubmit}
//                   >
//                     Submit
//                   </div>
//                 </div>
//               </Box>
//             </Modal>
//           )} */}

//           {/* {open && (
//             <Modal
//               open={open}
//               onClose={() => setOpen(!open)}
//               aria-labelledby="modal-modal-title"
//               aria-describedby="modal-modal-description"
//             >
//               <Box className="absolute top-[50%] left-[50%] -translate-x-1/2 -translate-y-1/2 w-[450px] bg-white dark:bg-slate-900 rounded-[8px] shadow p-4 outline-none">
//                 <h1 className={`${styles.title}`}>
//                   Are you sure you want to remove the course this user?
//                 </h1>
//                 <div className="flex w-full items-center justify-between mb-6 mt-4">
//                   <div
//                     className={`${styles.button} !w-[120px] h-[30px] bg-[#57c7a3]`}
//                     onClick={() => setOpen(!open)}
//                   >
//                     Cancel
//                   </div>
//                   <div
//                     className={`${styles.button} !w-[120px] h-[30px] bg-[#d63f3f]`}
//                     onClick={handleDelete}
//                   >
//                     Remove
//                   </div>
//                 </div>
//               </Box>
//             </Modal>
//           )} */}
//         </div>
//       {/* )} */}
//     </div>
//   );
// };

// export default AllUsers;

"use client"

import React, { FC, useEffect, useState } from "react";
import {
  useDeleteUserMutation,
  useGetAllUsersQuery,
  useUpdateUserRoleMutation,
} from "@/api/users/userApi";
import { toast } from "react-hot-toast";
import { capitalizeString } from "@/lib/utils";
import TableComponent from "../common/table";
import { PaginationComponent } from "../common/pagination";
import { Button } from "../ui/button";



const AllUsers: FC = () => {
  const [active, setActive] = useState(false);
  const [email, setEmail] = useState("");
  const [role, setRole] = useState("admin");
  const [open, setOpen] = useState(false);
  const [userId, setUserId] = useState("");
  const [updateUserRole, { error: updateError, isSuccess }] =
    useUpdateUserRoleMutation();
  const { isLoading, data, refetch } = useGetAllUsersQuery(
    {},
    { refetchOnMountOrArgChange: true }
  );
  const [deleteUser, { isSuccess: deleteSuccess, error: deleteError }] =
    useDeleteUserMutation({});

  useEffect(() => {
    if (updateError) {
      if ("data" in updateError) {
        const errorMessage = updateError as any;
        toast.error(errorMessage.data.message);
      }
    }

    if (isSuccess) {
      refetch();
      toast.success("User role updated successfully");
      setActive(false);
    }
    if (deleteSuccess) {
      refetch();
      toast.success("Delete user successfully!");
      setOpen(false);
    }
    if (deleteError) {
      if ("data" in deleteError) {
        const errorMessage = deleteError as any;
        toast.error(errorMessage.data.message);
      }
    }
  }, [updateError, isSuccess, deleteSuccess, deleteError]);

  

  const rows: any = [];
    data &&
  data?.data?.forEach((user: any) => {
    rows.push({
        id:user.id,
        firstName:capitalizeString(user.firstName),
        middleName:capitalizeString(user.middleName),
        sirName:capitalizeString(user.sirName),
        email:user.email,
        phoneNumber:user.phoneNumber,
        gender:user.gender,
        region:user.region,
        // photos:user.photos
    })
  });


  const handleSubmit = async () => {
    await updateUserRole({ email, role });
  };

  const handleDelete = async () => {
    const id = userId;
    await deleteUser(id);
  };

  return (
    <div className="h-screen">
        <div className="my-5 h-[80%] flex flex-col justify-between"  >
            <TableComponent rows={rows} handleDelete={handleDelete}/>
                <div className="w-full flex justify-between"> 
                    <Button type="submit" className="w-[25%]" >Add User</Button>
                    <PaginationComponent/>
                </div> 
        </div>
    </div>
  );
};

export default AllUsers;






