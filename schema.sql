drop database if exists pycoders;
create database pycoders;
use pycoders;

drop table if exists user;
create table users (
  id int primary key auto_increment,
  username varchar(15) unique not null,
  password text not null,
  email varchar(100) not null
);

drop table if exists products;
create table products(
	pid int primary key auto_increment,
    pName text not null,
    price float not null,
    sold enum('1','0') not null,
    category varchar(25) not null,
    pCode text not null,
    pdate timestamp not null default current_timestamp,
    pdescription text not null
);

insert into products (pName, price, sold, category, pCode, pdate, pdescription) 
values 
('Red T-shirt : Clipart', 2.1, '0', 'tshirt', 'apparel-162192.png', '2018-09-20 07:10:40' , 'Care Instructions: Machine Wash\nFit Type: Regular Fit\nOccasion : Casual\nFit : Regular Fit\nMaterial : 60% Cotton and 40% Polyester\nNeck : Crew Neck\nPattern : Solid'),
('Blue T-shirt : Clipart', 2.3, '0', 'tshirt', 'apparel-162180.png', '2018-10-20 07:10:40', 'Care Instructions: Machine Wash\nFit Type: Regular Fit\nOccasion : Casual\nFit : Regular Fit\nMaterial : 60% Cotton and 40% Polyester\nNeck : Crew Neck\nPattern : Solid'),
('Plain Black T-shirt : Homemade', 1.99, '0', 'tshirt', 'blank-g1c2f06939_1920.png', '2020-03-10 07:10:40', 'Fit Type: Regular Fit\nFabric: Cotton\nStyle: Regular\nNeck Style: Round Neck\nPattern: Striped\nSleeve Type: Half Sleeve'),
('Plain White T-shirt : Homemade', 2.0, '0', 'tshirt', 'blank-g5a8301ddd_1920.png', '2020-03-10 08:50:30', 'Super combed Cotton Rich fabric\nRibbed round neck to prevent sagging\nRegular fit\nLabel free for all day comfort'),
('Plain Red T-shirt : Homemade', 1.5, '1', 'tshirt', 'blank-gc67a9941c_1920.png', '2019-07-10 07:10:40', 'Care Instructions: Machine Wash\nFit Type: Regular Fit\nColor Name: Red\n100% Cotton\nMachine wash\nPlain\nHalf sleeve\nRound neck'),
('NIVIA Air Strike Football', 10, '0', 'football' , 'alphabet-word-images-1295331_1280.png', '2019-07-10 07:10:40', 'Foamed PVC Stitched\nBUTYL BLADDER\n32 Panel Universal Design\nHobby Playing Ball\nSuitable For Grassy Grounds\nRecommended For Under 12 Years Age Group'),
('Nivia Trainer Synthetic Football', 20.28, '0', 'football' , 'ball-306073_1280.png', '2021-07-10 07:10:40', 'Included Components : 1 Football | Color : White/Blue | Size : 5\nSuitable For: All Conditions | Ideal For: Training/Match\nMaterial : Rubber | Core/Bladder Material : Butyl | Construction Type: Hand Stitched | Number of Panel : 32| Waterproof: Yes\nSuitable for: Hard Ground without Grass, Wet & Grassy Ground, Artificail Turf\nMaterial: Rubberized Hand Stitched.'),
('Volatility Russia Hand Stich Football Size-05 (2022 New Multicolour A)', 50.25, '1', 'football' , 'football-157930.png', '2023-05-10 07:10:40', '2022 Football with Pump Outdoor Football - Size: 5 2022 Trending Football\nStitching Type Hand Stitched\nThe Football Is Good For Training And Recreational Purposes. With High-Resolution Graphics. Suitable For All Age Groups.\nfootball full size-5'),
('Vector X Street Soccer Rubber Moulded Football, Size 5', 35.25, '0', 'football' , 'football-157931_1280.png', '2022-05-10 07:10:40', 'Rubberized moulded ball, Texture surface single piece rubber moulded 32 panel ball.\nExcellent for hard & rough surface\nHigh durability.\nExcels in all weather conditions.\nWeight – 400 – 450 gms, Circumference – 69.00 – 70.00 CM, Diameter – 22.00 Cm'),
('Vector X NEO Rubber Moulded Football, Size 5 (White-Red-Black)', 30.25, '0', 'football' , 'soccer-25768.png', '2022-05-10 07:10:40', 'Suitable for Hard Ground without Grass, Wet & Grassy Ground & Artificial Turf.\nSize- 5 Diameter : 219mm and Synthetic Rubber\nRubber Moulded with Weight : 410-450g\nSuperior thread hand Stitched ball Specially engineered shiny Surface .\nBalanced configuration for total ball control, low water uptake\nIdeal for : Training & Recreation use or specially for children under 16 Yrs age.'),
('ZAFEX Hand Stiched Multicolour Football Size 5 (White Russi)', 25.13, '0', 'football' , 'soccer-7647528_1280.png', '2016-05-10 07:10:40', 'Fine & Furnished Quality.\nPackage Content :1 Piece Football with 1 pump\nEnsures Good Performance.\nOur Moto Is Provide Better Quality To Our Customers.\nThe Ball Is Meant For Very Light Play And Not For Playing On Rough Ground.'),
('Lenovo E41-55', 200.13, '0', 'laptop' , 'laptop-1836990_1920.jpg', '2020-12-10 07:10:40', 'Lenovo E41-55 AMD 14-inch (35.56cm) HD Thin and Light Laptop\nProcessor:- AMD Athlon Pro A3050U\nConfiguration:- 8GB RAM/ 256 SSD\nOs:- Windows 11 HSL With Lifetime Validity\nIntegrated AMD Radeon Graphics'),
('HP 15s', 333, '0', 'laptop' , 'laptop-5673901_1920.jpg', '2023-06-10 07:10:40', 'Processor:Intel Core i3-1115G4(up to 4.1 GHz with Intel Turbo Boost Technology(2g), 6 MB L3 cache, 2 cores)|Memory: 8 GB DDR4-3200 MHz RAM (1 x 8 GB) Upto 16 GB DDR4-3200 MHz RAM (2 x 8 GB)| Storage: 1 TB 5400 rpm SATA HDD, 256 GB PCIe NVMe TLC M.2 SSD\nDisplay & Graphics : 39.6 cm (15.6") diagonal, FHD, 250 nits, 141 ppi, 45%NTSC, Screen Resolution: 1920 x 1080|Graphics: Intel UHD Graphics\nOperating System & Preinstalled Software: Windows 11 Home 64 Plus Single Language | Microsoft Office Home & Student 2021| McAfee LiveSafe (30 days free trial as default) |Pre-installed Alexa built-in- Your life simplified with Alexa. Just ask Alexa to check your calendar, create to-do lists, shopping lists, play music, set reminders, get latest news and control smart home.\nPorts & Networking: 1 SuperSpeed USB Type-C 5Gbps signaling rate, 2 SuperSpeed USB Type-A 5Gbps signaling rate, 1 headphone/microphone combo, 1 AC smart pin, 1 HDMI 1.4b| Networking: Integrated 10/100/1000 GbE LAN, Realtek RTL8822CE 802.11a/b/g/n/ac (2x2) Wi-Fi and Bluetooth 5 combo\nOther Features: Webcam: HP TrueVision 720p HD Camera with Integrated dual array digital Microphones|Audio: Dual speakers|Keyboard: Full-size,jet black keyboard with numeric keypad,Touchpad with multi-touch gesture support| Battery: Support battery fast charge|'),
('Apple 2020 MacBook Air Laptop', 500, '0', 'laptop' , 'macbook-562499.png', '2021-06-10 07:10:40', 'All-Day Battery Life – Go longer than ever with up to 18 hours of battery life.\nPowerful Performance – Take on everything from professional-quality editing to action-packed gaming with ease. The Apple M1 chip with an 8-core CPU delivers up to 3.5x faster performance than the previous generation while using way less power.\nSuperfast Memory – 8GB of unified memory makes your entire system speedy and responsive. That way it can support tasks like memory-hogging multitab browsing and opening a huge graphic file quickly and easily.\nStunning Display – With a 13.3-inch/33.74 cm Retina display, images come alive with new levels of realism. Text is sharp and clear, and colors are more vibrant.\nWhy Mac – Easy to learn. Easy to set up. Astoundingly'),
('Apple 2023 MacBook Pro Laptop', 800, '0', 'laptop' , 'macbook-1999639_1920.png', '2023-04-10 07:10:40', 'Brand	Apple\nModel Name	MacBook Pro\nScreen Size	16 Inches\nColour	Silver\nHard Disk Size	1000 GB\nCPU Model	Unknown\nRAM Memory Installed Size	32 GB\nOperating System	Mac OS\nGraphics Card Description	Integrated\nGraphics Coprocessor	Apple M2 Max');

