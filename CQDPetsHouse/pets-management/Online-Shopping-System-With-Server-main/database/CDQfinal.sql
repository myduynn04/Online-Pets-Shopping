USE[CDQ2]
GO

ALTER DATABASE CDQ2 SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE CDQ2 SET ANSI_NULLS ON 
GO
ALTER DATABASE CDQ2 SET ANSI_PADDING ON 
GO
ALTER DATABASE CDQ2 SET AUTO_CLOSE ON 
GO
ALTER DATABASE CDQ2 SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE CDQ2 SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE CDQ2 SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE CDQ2 SET  MULTI_USER 
GO
SET QUOTED_IDENTIFIER ON
GO


/*Object:  admin_info*/
CREATE TABLE admin_info(
	admin_id int IDENTITY(1,1) NOT NULL,
	admin_name varchar(100) NOT NULL,
	admin_email varchar(300) NOT NULL,
	admin_password varchar(300) NOT NULL,
 CONSTRAINT PK_admin_info_admin_id PRIMARY KEY CLUSTERED 
(
	admin_id ASC
)
) ON [PRIMARY]


/*Object: Brands*/
CREATE TABLE brands(
	brand_id int IDENTITY(1,1) NOT NULL,
	brand_title varchar(max) NOT NULL,
 CONSTRAINT PK_brands_brand_id PRIMARY KEY CLUSTERED 
(
	brand_id ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/*Object: Cart*/
CREATE TABLE cart(
	id int IDENTITY(1,1) NOT NULL,
	p_id int NOT NULL,
	ip_add varchar(250) NOT NULL,
	user_id int NULL DEFAULT (NULL),
	qty int NOT NULL,
 CONSTRAINT PK_cart_id PRIMARY KEY CLUSTERED 
(
	id ASC
)
) ON [PRIMARY]


/*Object: Categories*/
CREATE TABLE categories(
	cat_id int IDENTITY(1,1) NOT NULL,
	cat_title varchar(max) NOT NULL,
 CONSTRAINT PK_categories_cat_id PRIMARY KEY CLUSTERED 
(
	cat_id ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/*Object: Email_info*/
CREATE TABLE email_info(
	email_id int IDENTITY(1,1) NOT NULL,
	email varchar(max) NOT NULL,
 CONSTRAINT PK_email_info_email_id PRIMARY KEY CLUSTERED 
(
	email_id ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]




/*Object: Order_Products*/
CREATE TABLE order_products(
	order_pro_id int IDENTITY(1,1) NOT NULL,
	order_id int NOT NULL,
	product_id int NOT NULL,
	qty int NULL DEFAULT (NULL),
	amt int NULL DEFAULT (NULL),
 CONSTRAINT PK_order_products_order_pro_id PRIMARY KEY CLUSTERED 
(
	order_pro_id ASC
)
) ON [PRIMARY]

ALTER TABLE order_products
DROP CONSTRAINT PK_order_products_order_pro_id;

ALTER TABLE order_products
ADD CONSTRAINT PK_order_products
PRIMARY KEY (order_pro_id,order_id, product_id);


/*Object: Orders*/
CREATE TABLE orders(
	order_id int IDENTITY(1,1) NOT NULL,
	user_id int NOT NULL,
	product_id int NOT NULL,
	qty int NOT NULL,
	trx_id varchar(255) NOT NULL,
	p_status varchar(20) NOT NULL,
 CONSTRAINT PK_orders_order_id PRIMARY KEY CLUSTERED 
(
	order_id ASC
)
) ON [PRIMARY]


/*Object: Orders_info*/
CREATE TABLE orders_info(
	order_id int IDENTITY(1,1) NOT NULL,
	user_id int NOT NULL,
	f_name varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	address varchar(255) NOT NULL,
	city varchar(255) NOT NULL,
	state varchar(255) NOT NULL,
	zip int NOT NULL,
	cardname varchar(255) NOT NULL,
	cardnumber varchar(20) NOT NULL,
	expdate varchar(255) NOT NULL,
	prod_count int NULL DEFAULT (NULL),
	total_amt int NULL DEFAULT (NULL),
	cvv int NOT NULL,
 CONSTRAINT PK_orders_info_order_id PRIMARY KEY CLUSTERED 
(
	order_id ASC
)
) ON [PRIMARY]

ALTER TABLE orders_info
DROP CONSTRAINT PK_orders_info_order_id;

ALTER TABLE orders_info
ADD CONSTRAINT PK_orders_info
PRIMARY KEY (order_id, user_id);
/*Object: Products*/
CREATE TABLE products(
	product_id int IDENTITY(1,1) NOT NULL,
	product_cat int NOT NULL,
	product_brand int NOT NULL,
	product_title varchar(255) NOT NULL,
	product_price int NOT NULL,
	product_desc varchar(max) NOT NULL,
	product_image varchar(max) NOT NULL,
	product_keywords varchar(max) NOT NULL,
 CONSTRAINT PK_products_product_id PRIMARY KEY CLUSTERED 
(
	product_id ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/*Object: user_info*/
CREATE TABLE user_info(
	user_id int IDENTITY(1,1) NOT NULL,
	first_name varchar(100) NOT NULL,
	last_name varchar(100) NOT NULL,
	email varchar(300) NOT NULL,
	password varchar(300) NOT NULL,
	mobile varchar(10) NOT NULL,
	address1 varchar(300) NOT NULL,
	address2 varchar(11) NOT NULL,
 CONSTRAINT PK_user_info_user_id PRIMARY KEY CLUSTERED 
(
	user_id ASC
)
) ON [PRIMARY] 



SET IDENTITY_INSERT admin_info ON 
INSERT admin_info (admin_id, admin_name, admin_email, admin_password) VALUES 
(1, N'admin1', N'cdq@gmail.com', N'Cdq@123321');

SET IDENTITY_INSERT admin_info OFF


SET IDENTITY_INSERT brands ON 
INSERT INTO brands (brand_id, brand_title)
VALUES 
    (1, N'For Dog'),
    (2, N'For Cat'),
    (3, N'For Bird'),
    (4, N'For Fish');
SET IDENTITY_INSERT brands OFF


SET IDENTITY_INSERT cart ON 
INSERT INTO cart (id, p_id, ip_add, user_id, qty) 
VALUES 
    (6, 26, N'::1', 4, 1),
    (9, 10, N'::1', 7, 1),
    (10, 11, N'::1', 7, 1),
    (11, 45, N'::1', 7, 1),
    (44, 5, N'::1', 3, 0),
    (46, 2, N'::1', 3, 0),
    (48, 72, N'::1', 3, 0),
    (49, 60, N'::1', 8, 1),
    (50, 61, N'::1', 8, 1),
    (51, 1, N'::1', 8, 1),
    (52, 5, N'::1', 9, 1),
    (53, 2, N'::1', 14, 1),
    (54, 3, N'::1', 14, 1),
    (55, 5, N'::1', 14, 1),
    (56, 1, N'::1', 9, 1),
    (57, 2, N'::1', 9, 1),
    (71, 61, N'127.0.0.1', -1, 1);
SET IDENTITY_INSERT cart OFF


SET IDENTITY_INSERT categories ON 
INSERT INTO categories (cat_id, cat_title)
VALUES 
    (1, N'Accessories'),
    (2, N'Clothes'),
    (3, N'Food'),
    (4, N'Healthcare'),
    (5, N'Housing'),
    (6, N'Spa'),
    (7, N'Toy');
SET IDENTITY_INSERT categories OFF


SET IDENTITY_INSERT email_info ON 
INSERT INTO email_info (email_id, email)
VALUES 
    (3, N'admin@cdq.com'),
    (4, N'help.duyen@gmail.com'),
    (5, N'info.duyen@yahoo.com');
SET IDENTITY_INSERT email_info OFF


SET IDENTITY_INSERT order_products ON 
INSERT INTO order_products (order_pro_id, order_id, product_id, qty, amt)
VALUES 
    (73, 1, 1, 1, 5000),
    (74, 1, 4, 2, 64000),
    (75, 1, 8, 1, 40000);
SET IDENTITY_INSERT order_products OFF


SET IDENTITY_INSERT orders ON
INSERT INTO orders (order_id, user_id, product_id, qty, trx_id, p_status)
VALUES 
    (1, 12, 7, 1, N'07M47684BS5725041', N'Completed'),
    (2, 14, 2, 1, N'07M47684BS5725041', N'Completed');
SET IDENTITY_INSERT orders OFF

SET IDENTITY_INSERT orders_info ON 
INSERT orders_info (order_id, user_id, f_name, email, address, city, state, zip, cardname, cardnumber, expdate, prod_count, total_amt, cvv) VALUES 
(2, 13, N'BK', N'help.bk@gmail.com', N'BachKhoa, HaiBaTrung, HaNoi', N'BK', N'BK', 560074, N'pokjhgfcxc', N'4321 2345 6788 7654', N'12/90', 3, 77000, 1234)
SET IDENTITY_INSERT orders_info OFF


SET IDENTITY_INSERT products ON 
INSERT INTO products (product_id, product_cat, product_brand, product_title, product_price, product_desc, product_image, product_keywords)VALUES 
    (1, 1, 2, N'Pink hat', 4, N'A cute pink hat for your cat', N'A1.jpg', N'hat pink cat'),
    (2, 1, 2, N'Cat leash', 7, N'A green leash to control', N'A2.jpg', N'leash cat green'),
    (3, 1, 2, N'Panda hat', 4, N'A cute panda hat for your cat', N'A3.jpg', N'hat panda cat'),
    (4, 1, 1, N'Harnesses', 3, N'A beautiful accessories choice for your dog', N'A4.jpg', N'dog harnesses'),
    (5, 1, 1, N'Dog leash', 7, N'A grey leash to control', N'A5.jpg', N'leash dog grey'),
    (6, 1, 1, N'Dog carrier', 15, N'Carrier for you to bring you dog with', N'A6.jpg', N'carrier dog backpack'),
    (7, 1, 1, N'Mini backpack', 4, N'A cute accessories for dog', N'A7.jpg', N'backpack brown mini dog'),
    (8, 2, 1, N'Flag sweater', 10, N'Keep warm for your dog', N'C1.jpg', N'flag sweater dog'),
    (9, 2, 1, N'Cherry-colored sweater', 10, N'Keep warm for your dog', N'C2.jpg', N'red sweater dog'),
    (10, 2, 1, N'Grey sweater', 10, N'Keep warm for your dog', N'C3.jpg', N'grey sweater dog'),
    (11, 2, 1, N'Striped red sweater', 20, N'Keep warm for your dog', N'C4.jpg', N'red sweater dog'),
    (12, 2, 2, N'Pyjamas', 9, N'Sleep clothes for cats', N'C5.jpg', N'pyjamas cat'),
    (13, 2, 2, N'Supreme hoodies', 17, N'A cool hoodies in winter', N'C6.jpg', N'supreme hoodies cat'),
    (14, 2, 2, N'Dinosaur hoodies', 25, N'A cute dinosaur mascot for cat', N'C7.jpg', N'dinosaur hoodies cat'),
    (15, 2, 2, N'Rabbit hoodies', 18, N'A cute hoodies for cat', N'C8.jpg', N'rabbit hoodies cat'),
    (16, 3, 1, N'Dried food for puppy&dog', 15, N'Nutrition in dried-form for dog', N'A1.jpg', N'dried food dog puppy'),
    (17, 3, 1, N'King pet pate', 25, N'gents formal look', N'A2.jpg', N'pate pet king wet'),
    (18, 3, 1, N'Dried food (only for adult)', 10, N'Nutrition in dried-form, only for adult dog', N'F3.jpg', N'dried food dog adult'),
	(19, 3, 2, N'Dried food (for indoor cat)',15, N'Nutrition in dried-form for indoor cat', N'F4.jpg', N'dried food indoor cat'),
    (20, 3, 2, N'Dried food (for kitten)', 20, N'Nutrition in dried-form for kitten', N'F5.jpg', N'dried food kitten cat'),
    (21, 3, 3, N'Wild bird seed', 30, N'Nutrition seed and food for wild bird', N'F6.jpg', N'seed wild bird'),
    (22, 3, 3, N'Wild bird care', 30, N'More nutrition seed and food for wild bird', N'F7.jpg', N'food wild bird care'),
    (23, 3, 4, N'Nutrition fish feed', 35, N'Nutrition feed for your aquarium', N'F8.jpg', N'feed fish nutrition aquarium'),
    (24, 4, 2, N'Eye drops', 20, N'Eye cleanser for pets', N'He1.jpg', N'eye drop cleanser cat'),
    (25, 4, 1, N'Eye drops', 20, N'Eye cleanser for pets', N'He1.jpg', N'eye drop cleanser dog'),
    (26, 4, 1, N'Calming solutions', 45, N'Prevent for pets from bad emotions', N'He2.jpg', N'bad emotion remove calming solution'),
    (27, 4, 1, N'Multi-vitamin paste', 15, N'Adding more vital vitamin for pets', N'He3.jpg', N'multi vitamin paste'),
    (28, 4, 3, N'NexGard tablets', 20, N'Prevent your pets from louses, bugs', N'He4.jpg', N'louse bug remove tablet pet'),
    (29, 6, 5, N'Forma drops', 17, N'Cleanser for your bird', N'He5.jpg', N'drop bird forma eye'),
    (30, 5, 1, N'Giraffe house', 30, N'Housing for dogs', N'Ho1.jpg', N'giraffe house dog'),
    (31, 5, 2, N'Duck house', 30, N'Housing for cats', N'Ho2.jpg', N'duck house cat'),
    (32, 5, 2, N'Rabbit house', 30, N'Housing for cats', N'Ho4.jpg', N'rabbit house cat'),
    (33, 5, 3, N'Aviary', 50, N'Housing for birds', N'Ho5.jpg', N'aviary bird house'),
    (34, 5, 4, N'Medium aquarium', 60, N'Water-filled space for fish and others', N'Ho6.jpg', N'aquarium fish'),
    (35, 6, 1, N'Oatmeal shampoo', 15, N'Oatmeal flavor for dog', N'S1.png', N'oatmeal shampoo'),
    (36, 6, 1, N'Lavender oatmeal shampoo', 17, N'Adding lavender for long-last fragance', N'S2.png', N'lavender shampoo'),
    (37, 6, 2, N'Faint shampoo', 19, N'Soft and delicate aroma shampoo for cats', N'S3.png', N'faint delicare soft shampoo cat'),
    (38, 6, 1, N'Anti-mange shampoo', 20, N'Cleaning and anti-bug, louse onto dog', N'S4.png', N'anti bug louse shampoo'),
    (39, 6, 2, N'Furminator comb', 25, N'Remove cat fur', N'S5.png', N'remove cat fur comb'),
    (40, 7, 1, N'Cuddly bone', 7, N'Yellow stuffed bone for your dog', N'T1.jpg', N'Stuffed bone dog'),
    (41, 7, 1, N'Soft turkey', 7, N'Brown stuffed delicious turkey for your dog', N'T2.jpg', N'stuffed turkey dog'),
    (42, 7, 2, N'Rod with fur', 2, N'Control and play with your cat', N'T3.jpg', N'rod cat fur'),
    (43, 7, 2, N'Aliens UFO', 3, N'Aliens UFO with balls for cat curiosity', N'T4.jpg', N'Aliens ufo cat balls'),
    (44, 7, 2, N'Cat Scratch Poll', 12, N'Cat paw scratch poll and seats ', N'T5.jpg', N'paw cat scratch poll cotton'),
    (45, 7, 3, N'Mini basketball', 6, N'Basketball for your parrot', N'T6.jpg', N'basketball game bird'),
    (46, 7, 3, N'Rings and poll', 4, N'Hoop-la games for your bird and others', N'T7.jpg', N'rings poll bird game');

SET IDENTITY_INSERT products OFF


/*Object:  Index order_products*/

CREATE NONCLUSTERED INDEX order_products ON order_products
(
	order_id ASC
)
GO


/*Object:  Index product_id*/
CREATE NONCLUSTERED INDEX product_id ON order_products
(
	product_id ASC
)
GO


/*Object:  Index user_id*/
CREATE NONCLUSTERED INDEX user_id ON orders_info
(
   user_id ASC
)
GO



ALTER TABLE order_products  WITH NOCHECK ADD  CONSTRAINT orders$order_products FOREIGN KEY(order_id)  
REFERENCES orders (order_id)
ON UPDATE CASCADE
GO

ALTER TABLE order_products CHECK CONSTRAINT orders$order_products
GO

ALTER TABLE order_products  WITH NOCHECK ADD  CONSTRAINT order_products$product_id FOREIGN KEY(product_id)
REFERENCES products (product_id)
GO

ALTER TABLE order_products CHECK CONSTRAINT order_products$product_id
GO

ALTER TABLE orders_info  WITH NOCHECK ADD  CONSTRAINT orders_info$user_id FOREIGN KEY(user_id)
REFERENCES user_info (user_id)
GO
ALTER TABLE orders_info CHECK CONSTRAINT orders_info$user_id
GO

ALTER TABLE orders_info WITH NOCHECK ADD  CONSTRAINT orders$orders_info FOREIGN KEY(order_id)
REFERENCES orders (order_id)
GO 

ALTER TABLE orders_info CHECK CONSTRAINT orders$orders_info
GO

ALTER TABLE user_info_backup  WITH NOCHECK ADD  CONSTRAINT user_info_backup$user_info FOREIGN KEY(user_id)
REFERENCES user_info (user_id)
GO

ALTER TABLE user_info_backup CHECK CONSTRAINT user_info_backup$user_info
GO

ALTER TABLE products  WITH NOCHECK ADD  CONSTRAINT product_cat$cat_id FOREIGN KEY(product_cat)
REFERENCES  categories (cat_id)
GO

ALTER TABLE products CHECK CONSTRAINT product_cat$cat_id
GO

ALTER TABLE products  WITH NOCHECK ADD  CONSTRAINT product_brand$brand_id FOREIGN KEY(product_brand)
REFERENCES  brands (brand_id)
GO

ALTER TABLE products CHECK CONSTRAINT product_brand$brand_id
GO

ALTER TABLE cart  WITH NOCHECK ADD  CONSTRAINT cart$user_info FOREIGN KEY(user_id)
REFERENCES user_info (user_id)
GO

ALTER TABLE cart  CHECK CONSTRAINT cart$user_info
GO

ALTER TABLE email_info
ADD user_id int,
FOREIGN KEY (user_id) REFERENCES user_info(user_id);


CREATE PROCEDURE getcat  
   @cid int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT categories.cat_id, categories.cat_title
      FROM categories
      WHERE categories.cat_id = @cid

   END

   select * from products



drop table user_info_backup

























   /*ALTER TABLE order_products  WITH NOCHECK ADD  CONSTRAINT order_products$order_products FOREIGN KEY(order_id)  
REFERENCES orders_info (order_id)
ON UPDATE CASCADE
GO

ALTER TABLE order_products CHECK CONSTRAINT order_products$order_products
GO*/