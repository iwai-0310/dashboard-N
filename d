[33mcommit 7632d79a2ef7e1b59dd4a62f8354e8e9e7a3b224[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mmaster[m[33m)[m
Author: iwai-0310 <chazesingh@gmail.com>
Date:   Sun Jan 28 23:00:16 2024 +0530

    Adds starter files from vercel/dashboard

[1mdiff --git a/.env.example b/.env.example[m
[1mnew file mode 100644[m
[1mindex 0000000..8a85ba7[m
[1m--- /dev/null[m
[1m+++ b/.env.example[m
[36m@@ -0,0 +1,13 @@[m
[32m+[m[32m# Copy from .env.local on the Vercel dashboard[m
[32m+[m[32m# https://nextjs.org/learn/dashboard-app/setting-up-your-database#create-a-postgres-database[m
[32m+[m[32mPOSTGRES_URL=[m
[32m+[m[32mPOSTGRES_PRISMA_URL=[m
[32m+[m[32mPOSTGRES_URL_NON_POOLING=[m
[32m+[m[32mPOSTGRES_USER=[m
[32m+[m[32mPOSTGRES_HOST=[m
[32m+[m[32mPOSTGRES_PASSWORD=[m
[32m+[m[32mPOSTGRES_DATABASE=[m
[32m+[m
[32m+[m[32m# `openssl rand -base64 32`[m
[32m+[m[32mAUTH_SECRET=[m
[32m+[m[32mAUTH_URL=http://localhost:3000/api/auth[m
\ No newline at end of file[m
[1mdiff --git a/.eslintrc.json b/.eslintrc.json[m
[1mnew file mode 100644[m
[1mindex 0000000..bffb357[m
[1m--- /dev/null[m
[1m+++ b/.eslintrc.json[m
[36m@@ -0,0 +1,3 @@[m
[32m+[m[32m{[m
[32m+[m[32m  "extends": "next/core-web-vitals"[m
[32m+[m[32m}[m
[1mdiff --git a/.gitignore b/.gitignore[m
[1mnew file mode 100644[m
[1mindex 0000000..45c1abc[m
[1m--- /dev/null[m
[1m+++ b/.gitignore[m
[36m@@ -0,0 +1,36 @@[m
[32m+[m[32m# See https://help.github.com/articles/ignoring-files/ for more about ignoring files.[m
[32m+[m
[32m+[m[32m# dependencies[m
[32m+[m[32m/node_modules[m
[32m+[m[32m/.pnp[m
[32m+[m[32m.pnp.js[m
[32m+[m
[32m+[m[32m# testing[m
[32m+[m[32m/coverage[m
[32m+[m
[32m+[m[32m# next.js[m
[32m+[m[32m/.next/[m
[32m+[m[32m/out/[m
[32m+[m
[32m+[m[32m# production[m
[32m+[m[32m/build[m
[32m+[m
[32m+[m[32m# misc[m
[32m+[m[32m.DS_Store[m
[32m+[m[32m*.pem[m
[32m+[m
[32m+[m[32m# debug[m
[32m+[m[32mnpm-debug.log*[m
[32m+[m[32myarn-debug.log*[m
[32m+[m[32myarn-error.log*[m
[32m+[m
[32m+[m[32m# local env files[m
[32m+[m[32m.env*.local[m
[32m+[m[32m.env[m
[32m+[m
[32m+[m[32m# vercel[m
[32m+[m[32m.vercel[m
[32m+[m
[32m+[m[32m# typescript[m
[32m+[m[32m*.tsbuildinfo[m
[32m+[m[32mnext-env.d.ts[m
[1mdiff --git a/.nvmrc b/.nvmrc[m
[1mnew file mode 100644[m
[1mindex 0000000..3c03207[m
[1m--- /dev/null[m
[1m+++ b/.nvmrc[m
[36m@@ -0,0 +1 @@[m
[32m+[m[32m18[m
[1mdiff --git a/README.md b/README.md[m
[1mnew file mode 100644[m
[1mindex 0000000..6a520de[m
[1m--- /dev/null[m
[1m+++ b/README.md[m
[36m@@ -0,0 +1,5 @@[m
[32m+[m[32m## Next.js App Router Course - Starter[m
[32m+[m
[32m+[m[32mThis is the starter template for the Next.js App Router Course. It contains the starting code for the dashboard application.[m
[32m+[m
[32m+[m[32mFor more information, see the [course curriculum](https://nextjs.org/learn) on the Next.js Website.[m
[1mdiff --git a/app/layout.tsx b/app/layout.tsx[m
[1mnew file mode 100644[m
[1mindex 0000000..225b603[m
[1m--- /dev/null[m
[1m+++ b/app/layout.tsx[m
[36m@@ -0,0 +1,11 @@[m
[32m+[m[32mexport default function RootLayout({[m
[32m+[m[32m  children,[m
[32m+[m[32m}: {[m
[32m+[m[32m  children: React.ReactNode;[m
[32m+[m[32m}) {[m
[32m+[m[32m  return ([m
[32m+[m[32m    <html lang="en">[m
[32m+[m[32m      <body>{children}</body>[m
[32m+[m[32m    </html>[m
[32m+[m[32m  );[m
[32m+[m[32m}[m
[1mdiff --git a/app/lib/data.ts b/app/lib/data.ts[m
[1mnew file mode 100644[m
[1mindex 0000000..3e32426[m
[1m--- /dev/null[m
[1m+++ b/app/lib/data.ts[m
[36m@@ -0,0 +1,231 @@[m
[32m+[m[32mimport { sql } from '@vercel/postgres';[m
[32m+[m[32mimport {[m
[32m+[m[32m  CustomerField,[m
[32m+[m[32m  CustomersTableType,[m
[32m+[m[32m  InvoiceForm,[m
[32m+[m[32m  InvoicesTable,[m
[32m+[m[32m  LatestInvoiceRaw,[m
[32m+[m[32m  User,[m
[32m+[m[32m  Revenue,[m
[32m+[m[32m} from './definitions';[m
[32m+[m[32mimport { formatCurrency } from './utils';[m
[32m+[m
[32m+[m[32mexport async function fetchRevenue() {[m
[32m+[m[32m  // Add noStore() here to prevent the response from being cached.[m
[32m+[m[32m  // This is equivalent to in fetch(..., {cache: 'no-store'}).[m
[32m+[m
[32m+[m[32m  try {[m
[32m+[m[32m    // Artificially delay a response for demo purposes.[m
[32m+[m[32m    // Don't do this in production :)[m
[32m+[m
[32m+[m[32m    // console.log('Fetching revenue data...');[m
[32m+[m[32m    // await new Promise((resolve) => setTimeout(resolve, 3000));[m
[32m+[m
[32m+[m[32m    const data = await sql<Revenue>`SELECT * FROM revenue`;[m
[32m+[m
[32m+[m[32m    // console.log('Data fetch completed after 3 seconds.');[m
[32m+[m
[32m+[m[32m    return data.rows;[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.error('Database Error:', error);[m
[32m+[m[32m    throw new Error('Failed to fetch revenue data.');[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport async function fetchLatestInvoices() {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const data = await sql<LatestInvoiceRaw>`[m
[32m+[m[32m      SELECT invoices.amount, customers.name, customers.image_url, customers.email, invoices.id[m
[32m+[m[32m      FROM invoices[m
[32m+[m[32m      JOIN customers ON invoices.customer_id = customers.id[m
[32m+[m[32m      ORDER BY invoices.date DESC[m
[32m+[m[32m      LIMIT 5`;[m
[32m+[m
[32m+[m[32m    const latestInvoices = data.rows.map((invoice) => ({[m
[32m+[m[32m      ...invoice,[m
[32m+[m[32m      amount: formatCurrency(invoice.amount),[m
[32m+[m[32m    }));[m
[32m+[m[32m    return latestInvoices;[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.error('Database Error:', error);[m
[32m+[m[32m    throw new Error('Failed to fetch the latest invoices.');[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport async function fetchCardData() {[m
[32m+[m[32m  try {[m
[32m+[m[32m    // You can probably combine these into a single SQL query[m
[32m+[m[32m    // However, we are intentionally splitting them to demonstrate[m
[32m+[m[32m    // how to initialize multiple queries in parallel with JS.[m
[32m+[m[32m    const invoiceCountPromise = sql`SELECT COUNT(*) FROM invoices`;[m
[32m+[m[32m    const customerCountPromise = sql`SELECT COUNT(*) FROM customers`;[m
[32m+[m[32m    const invoiceStatusPromise = sql`SELECT[m
[32m+[m[32m         SUM(CASE WHEN status = 'paid' THEN amount ELSE 0 END) AS "paid",[m
[32m+[m[32m         SUM(CASE WHEN status = 'pending' THEN amount ELSE 0 END) AS "pending"[m
[32m+[m[32m         FROM invoices`;[m
[32m+[m
[32m+[m[32m    const data = await Promise.all([[m
[32m+[m[32m      invoiceCountPromise,[m
[32m+[m[32m      customerCountPromise,[m
[32m+[m[32m      invoiceStatusPromise,[m
[32m+[m[32m    ]);[m
[32m+[m
[32m+[m[32m    const numberOfInvoices = Number(data[0].rows[0].count ?? '0');[m
[32m+[m[32m    const numberOfCustomers = Number(data[1].rows[0].count ?? '0');[m
[32m+[m[32m    const totalPaidInvoices = formatCurrency(data[2].rows[0].paid ?? '0');[m
[32m+[m[32m    const totalPendingInvoices = formatCurrency(data[2].rows[0].pending ?? '0');[m
[32m+[m
[32m+[m[32m    return {[m
[32m+[m[32m      numberOfCustomers,[m
[32m+[m[32m      numberOfInvoices,[m
[32m+[m[32m      totalPaidInvoices,[m
[32m+[m[32m      totalPendingInvoices,[m
[32m+[m[32m    };[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.error('Database Error:', error);[m
[32m+[m[32m    throw new Error('Failed to fetch card data.');[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mconst ITEMS_PER_PAGE = 6;[m
[32m+[m[32mexport async function fetchFilteredInvoices([m
[32m+[m[32m  query: string,[m
[32m+[m[32m  currentPage: number,[m
[32m+[m[32m) {[m
[32m+[m[32m  const offset = (currentPage - 1) * ITEMS_PER_PAGE;[m
[32m+[m
[32m+[m[32m  try {[m
[32m+[m[32m    const invoices = await sql<InvoicesTable>`[m
[32m+[m[32m      SELECT[m
[32m+[m[32m        invoices.id,[m
[32m+[m[32m        invoices.amount,[m
[32m+[m[32m        invoices.date,[m
[32m+[m[32m        invoices.status,[m
[32m+[m[32m        customers.name,[m
[32m+[m[32m        customers.email,[m
[32m+[m[32m        customers.image_url[m
[32m+[m[32m      FROM invoices[m
[32m+[m[32m      JOIN customers ON invoices.customer_id = customers.id[m
[32m+[m[32m      WHERE[m
[32m+[m[32m        customers.name ILIKE ${`%${query}%`} OR[m
[32m+[m[32m        customers.email ILIKE ${`%${query}%`} OR[m
[32m+[m[32m        invoices.amount::text ILIKE ${`%${query}%`} OR[m
[32m+[m[32m        invoices.date::text ILIKE ${`%${query}%`} OR[m
[32m+[m[32m        invoices.status ILIKE ${`%${query}%`}[m
[32m+[m[32m      ORDER BY invoices.date DESC[m
[32m+[m[32m      LIMIT ${ITEMS_PER_PAGE} OFFSET ${offset}[m
[32m+[m[32m    `;[m
[32m+[m
[32m+[m[32m    return invoices.rows;[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.error('Database Error:', error);[m
[32m+[m[32m    throw new Error('Failed to fetch invoices.');[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport async function fetchInvoicesPages(query: string) {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const count = await sql`SELECT COUNT(*)[m
[32m+[m[32m    FROM invoices[m
[32m+[m[32m    JOIN customers ON invoices.customer_id = customers.id[m
[32m+[m[32m    WHERE[m
[32m+[m[32m      customers.name ILIKE ${`%${query}%`} OR[m
[32m+[m[32m      customers.email ILIKE ${`%${query}%`} OR[m
[32m+[m[32m      invoices.amount::text ILIKE ${`%${query}%`} OR[m
[32m+[m[32m      invoices.date::text ILIKE ${`%${query}%`} OR[m
[32m+[m[32m      invoices.status ILIKE ${`%${query}%`}[m
[32m+[m[32m  `;[m
[32m+[m
[32m+[m[32m    const totalPages = Math.ceil(Number(count.rows[0].count) / ITEMS_PER_PAGE);[m
[32m+[m[32m    return totalPages;[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.error('Database Error:', error);[m
[32m+[m[32m    throw new Error('Failed to fetch total number of invoices.');[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport async function fetchInvoiceById(id: string) {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const data = await sql<InvoiceForm>`[m
[32m+[m[32m      SELECT[m
[32m+[m[32m        invoices.id,[m
[32m+[m[32m        invoices.customer_id,[m
[32m+[m[32m        invoices.amount,[m
[32m+[m[32m        invoices.status[m
[32m+[m[32m      FROM invoices[m
[32m+[m[32m      WHERE invoices.id = ${id};[m
[32m+[m[32m    `;[m
[32m+[m
[32m+[m[32m    const invoice = data.rows.map((invoice) => ({[m
[32m+[m[32m      ...invoice,[m
[32m+[m[32m      // Convert amount from cents to dollars[m
[32m+[m[32m      amount: invoice.amount / 100,[m
[32m+[m[32m    }));[m
[32m+[m
[32m+[m[32m    return invoice[0];[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.error('Database Error:', error);[m
[32m+[m[32m    throw new Error('Failed to fetch invoice.');[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport async function fetchCustomers() {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const data = await sql<CustomerField>`[m
[32m+[m[32m      SELECT[m
[32m+[m[32m        id,[m
[32m+[m[32m        name[m
[32m+[m[32m      FROM customers[m
[32m+[m[32m      ORDER BY name ASC[m
[32m+[m[32m    `;[m
[32m+[m
[32m+[m[32m    const customers = data.rows;[m
[32m+[m[32m    return customers;[m
[32m+[m[32m  } catch (err) {[m
[32m+[m[32m    console.error('Database Error:', err);[m
[32m+[m[32m    throw new Error('Failed to fetch all customers.');[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport async function fetchFilteredCustomers(query: string) {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const data = await sql<CustomersTableType>`[m
[32m+[m		[32mSELECT[m
[32m+[m		[32m  customers.id,[m
[32m+[m		[32m  customers.name,[m
[32m+[m		[32m  customers.email,[m
[32m+[m		[32m  customers.image_url,[m
[32m+[m		[32m  COUNT(invoices.id) AS total_invoices,[m
[32m+[m		[32m  SUM(CASE WHEN invoices.status = 'pending' THEN invoices.amount ELSE 0 END) AS total_pending,[m
[32m+[m		[32m  SUM(CASE WHEN invoices.status = 'paid' THEN invoices.amount ELSE 0 END) AS total_paid[m
[32m+[m		[32mFROM customers[m
[32m+[m		[32mLEFT JOIN invoices ON customers.id = invoices.customer_id[m
[32m+[m		[32mWHERE[m
[32m+[m		[32m  customers.name ILIKE ${`%${query}%`} OR[m
[32m+[m[32m        customers.email ILIKE ${`%${query}%`}[m
[32m+[m		[32mGROUP BY customers.id, customers.name, customers.email, customers.image_url[m
[32m+[m		[32mORDER BY customers.name ASC[m
[32m+[m	[32m  `;[m
[32m+[m
[32m+[m[32m    const customers = data.rows.map((customer) => ({[m
[32m+[m[32m      ...customer,[m
[32m+[m[32m      total_pending: formatCurrency(customer.total_pending),[m
[32m+[m[32m      total_paid: formatCurrency(customer.total_paid),[m
[32m+[m[32m    }));[m
[32m+[m
[32m+[m[32m    return customers;[m
[32m+[m[32m  } catch (err) {[m
[32m+[m[32m    console.error('Database Error:', err);[m
[32m+[m[32m    throw new Error('Failed to fetch customer table.');[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport async function getUser(email: string) {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const user = await sql`SELECT * FROM users WHERE email=${email}`;[m
[32m+[m[32m    return user.rows[0] as User;[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.error('Failed to fetch user:', error);[m
[32m+[m[32m    throw new Error('Failed to fetch user.');[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[1mdiff --git a/app/lib/definitions.ts b/app/lib/definitions.ts[m
[1mnew file mode 100644[m
[1mindex 0000000..b1a4fbf[m
[1m--- /dev/null[m
[1m+++ b/app/lib/definitions.ts[m
[36m@@ -0,0 +1,88 @@[m
[32m+[m[32m// This file contains type definitions for your data.[m
[32m+[m[32m// It describes the shape of the data, and what data type each property should accept.[m
[32m+[m[32m// For simplicity of teaching, we're manually defining these types.[m
[32m+[m[32m// However, these types are generated automatically if you're using an ORM such as Prisma.[m
[32m+[m[32mexport type User = {[m
[32m+[m[32m  id: string;[m
[32m+[m[32m  name: string;[m
[32m+[m[32m  email: string;[m
[32m+[m[32m  password: string;[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport type Customer = {[m
[32m+[m[32m  id: string;[m
[32m+[m[32m  name: string;[m
[32m+[m[32m  email: string;[m
[32m+[m[32m  image_url: string;[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport type Invoice = {[m
[32m+[m[32m  id: string;[m
[32m+[m[32m  customer_id: string;[m
[32m+[m[32m  amount: number;[m
[32m+[m[32m  date: string;[m
[32m+[m[32m  // In TypeScript, this is called a string union type.[m
[32m+[m[32m  // It means that the "status" property can only be one of the two strings: 'pending' or 'paid'.[m
[32m+[m[32m  status: 'pending' | 'paid';[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport type Revenue = {[m
[32m+[m[32m  month: string;[m
[32m+[m[32m  revenue: number;[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport type LatestInvoice = {[m
[32m+[m[32m  id: string;[m
[32m+[m[32m  name: string;[m
[32m+[m[32m  image_url: string;[m
[32m+[m[32m  email: string;[m
[32m+[m[32m  amount: string;[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32m// The database returns a number for amount, but we later format it to a string with the formatCurrency function[m
[32m+[m[32mexport type LatestInvoiceRaw = Omit<LatestInvoice, 'amount'> & {[m
[32m+[m[32m  amount: number;[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport type InvoicesTable = {[m
[32m+[m[32m  id: string;[m
[32m+[m[32m  customer_id: string;[m
[32m+[m[32m  name: string;[m
[32m+[m[32m  email: string;[m
[32m+[m[32m  image_url: string;[m
[32m+[m[32m  date: string;[m
[32m+[m[32m  amount: number;[m
[32m+[m[32m  status: 'pending' | 'paid';[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport type CustomersTableType = {[m
[32m+[m[32m  id: string;[m
[32m+[m[32m  name: string;[m
[32m+[m[32m  email: string;[m
[32m+[m[32m  image_url: string;[m
[32m+[m[32m  total_invoices: number;[m
[32m+[m[32m  total_pending: number;[m
[32m+[m[32m  total_paid: number;[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport type FormattedCustomersTable = {[m
[32m+[m[32m  id: string;[m
[32m+[m[32m  name: string;[m
[32m+[m[32m  email: string;[m
[32m+[m[32m  image_url: string;[m
[32m+[m[32m  total_invoices: number;[m
[32m+[m[32m  total_pending: string;[m
[32m+[m[32m  total_paid: string;[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport type CustomerField = {[m
[32m+[m[32m  id: string;[m
[32m+[m[32m  name: string;[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport type InvoiceForm = {[m
[32m+[m[32m  id: string;[m
[32m+[m[32m  customer_id: string;[m
[32m+[m[32m  amount: number;[m
[32m+[m[32m  status: 'pending' | 'paid';[m
[32m+[m[32m};[m
[1mdiff --git a/app/lib/placeholder-data.js b/app/lib/placeholder-data.js[m
[1mnew file mode 100644[m
[1mindex 0000000..15a4156[m
[1m--- /dev/null[m
[1m+++ b/app/lib/placeholder-data.js[m
[36m@@ -0,0 +1,188 @@[m
[32m+[m[32m// This file contains placeholder data that you'll be replacing with real data in the Data Fetching chapter:[m
[32m+[m[32m// https://nextjs.org/learn/dashboard-app/fetching-data[m
[32m+[m[32mconst users = [[m
[32m+[m[32m  {[m
[32m+[m[32m    id: '410544b2-4001-4271-9855-fec4b6a6442a',[m
[32m+[m[32m    name: 'User',[m
[32m+[m[32m    email: 'user@nextmail.com',[m
[32m+[m[32m    password: '123456',[m
[32m+[m[32m  },[m
[32m+[m[32m];[m
[32m+[m
[32m+[m[32mconst customers = [[m
[32m+[m[32m  {[m
[32m+[m[32m    id: '3958dc9e-712f-4377-85e9-fec4b6a6442a',[m
[32m+[m[32m    name: 'Delba de Oliveira',[m
[32m+[m[32m    email: 'delba@oliveira.com',[m
[32m+[m[32m    image_url: '/customers/delba-de-oliveira.png',[m
[32m+[m[32m  },[m
[32m+[m[32m  {[m
[32m+[m[32m    id: '3958dc9e-742f-4377-85e9-fec4b6a6442a',[m
[32m+[m[32m    name: 'Lee Robinson',[m
[32m+[m[32m    email: 'lee@robinson.com',[m
[32m+[m[32m    image_url: '/customers/lee-robinson.png',[m
[32m+[m[32m  },[m
[32m+[m[32m  {[m
[32m+[m[32m    id: '3958dc9e-737f-4377-85e9-fec4b6a6442a',[m
[32m+[m[32m    name: 'Hector Simpson',[m
[32m+[m[32m    email: 'hector@simpson.com',[m
[32m+[m[32m    image_url: '/customers/hector-simpson.png',[m
[32m+[m[32m  },[m
[32m+[m[32m  {[m
[32m+[m[32m    id: '50ca3e18-62cd-11ee-8c99-0242ac120002',[m
[32m+[m[32m    name: 'Steven Tey',[m
[32m+[m[32m    email: 'steven@tey.com',[m
[32m+[m[32m    image_url: '/customers/steven-tey.png',[m
[32m+[m[32m  },[m
[32m+[m[32m  {[m
[32m+[m[32m    id: '3958dc9e-787f-4377-85e9-fec4b6a6442a',[m
[32m+[m[32m    name: 'Steph Dietz',[m
[32m+[m[32m    email: 'steph@dietz.com',[m
[32m+[m[32m    image_url: '/customers/steph-dietz.png',[m
[32m+[m[32m  },[m
[32m+[m[32m  {[m
[32m+[m[32m    id: '76d65c26-f784-44a2-ac19-586678f7c2f2',[m
[32m+[m[32m    name: 'Michael Novotny',[m
[32m+[m[32m    email: 'michael@novotny.com',[m
[32m+[m[32m    image_url: '/customers/michael-novotny.png',[m
[32m+[m[32m  },[m
[32m+[m[32m  {[m
[32m+[m[32m    id: 'd6e15727-9fe1-4961-8c5b-ea44a9bd81aa',[m
[32m+[m[32m    name: 'Evil Rabbit',[m
[32m+[m[32m    email: 'evil@rabbit.com',[m
[32m+[m[32m    image_url: '/customers/evil-rabbit.png',[m
[32m+[m[32m  },[m
[32m+[m[32m  {[m
[32m+[m[32m    id: '126eed9c-c90c-4ef6-a4a8-fcf7408d3c66',[m
[32m+[m[32m    name: 'Emil Kowal