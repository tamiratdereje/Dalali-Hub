
'use client'

import { Provider } from 'react-redux'
import { store } from '../../store/index'
import {Props } from '@/types/general/reactNode'

const StateProvider = ({children}:Props) => {
  return (
    <Provider store={store}>
        {children}
    </Provider>
  )
}

export default StateProvider