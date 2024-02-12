
import Header from '@/components/header/header'
import Sidebar from '@/components/sidebar/sidebar'
import Link from 'next/link'
import React from 'react'

const Home = () => {
  return (
    <div>
        <div className='flex items-center justify-center h-screen'>
          <Link href={"/dashboard"}>Home</Link>
        </div>
    </div>
    
  )
}

export default Home