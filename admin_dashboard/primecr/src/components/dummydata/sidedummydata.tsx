import { BookOpenCheck, LayoutDashboard, Activity, Gauge ,FolderKanban, TableProperties, Car, DoorOpen, ListStart } from "lucide-react";

import { type NavItem } from "@/types/general/navLinkTypes";

export const NavItems: NavItem[] = [
  {
    title: "Analytics",
    icon: Activity,
    href: "/dashboard",
    color: "text-sky-500",
  },
  {
    title: "Properties Managment",
    icon: TableProperties,
    href: "/dashboard/properties",
    color: "text-sky-500",
    isChidren: true,
    children: [
      {
        title: "Properties",
        icon: Car,
        color: "text-green-500",
        href: "/dashboard/propertymanagment/properties",
      },
      {
        title: "Catagories",
        icon: DoorOpen,
        color: "text-green-500",
        href: "/dashboard/propertymanagment/catagories",
      },
    ],
  },

  {
    title: "User Managment",
    icon: BookOpenCheck,
    href: "/dashboard/managment",
    color: "text-sky-500",
    isChidren: true,
    children: [
      {
        title: "Users",
        icon: FolderKanban,
        color: "text-green-500",
        href: "/dashboard/usermanagment/users",
      },
      {
        title: "Performance",
        icon: Gauge,
        color: "text-green-500",
        href: "/dashboard/usermanagment/performance",
      },
      {
        title: "Approval Queue",
        icon: ListStart,
        color: "text-green-500",
        href: "/dashboard/usermanagment/approvalqueue",
      },
    ],
  },
  {
    title: "Invoices",
    icon: LayoutDashboard,
    href: "/dashboard/invoices",
    color: "text-sky-500",
  },
];
