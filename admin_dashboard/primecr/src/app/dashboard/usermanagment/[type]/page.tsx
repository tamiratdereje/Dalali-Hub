import AllUsers from '@/components/Managment/usersManagment'
import React from 'react'

type SubManagmnentProps = {
  params:any
}
const page = ({params}:SubManagmnentProps) => {
  const type = params.type
  return (
    <div>
      {/* <p>I am managment type {type } </p> */}
      {
        type==="users" && <AllUsers/>
      }
    </div>
  )
}

export default page