import React from 'react'

type SubPropertyProps = {
  params:any
}
const page = ({params}:SubPropertyProps) => {
  const type = params.type
  return (
    <div>I am Property type {type }</div>
  )
}

export default page