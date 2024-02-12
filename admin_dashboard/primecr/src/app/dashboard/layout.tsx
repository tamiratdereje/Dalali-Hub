import Sidebar from '@/components/sidebar/sidebar'
import AdminProtected from '@/hooks/useAdminProtected'
import React from 'react'

export default function RootLayout({
    children,
  }: {
    children: React.ReactNode;
  }) {
    return (


    <div>

    {/* <AdminProtected> */}
        <div className="flex h-screen border-collapse overflow-hidden">
            <Sidebar />
            <main className="flex-1 overflow-y-auto overflow-x-hidden p-8 pt-16 bg-secondary/10 pb-1">
                {children}
            </main>
        </div>
    {/* </AdminProtected> */}
  </div>

  

  )
}
