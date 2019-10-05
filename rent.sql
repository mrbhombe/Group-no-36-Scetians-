-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 04, 2019 at 11:58 PM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `rent`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `cust_id` int(11) NOT NULL AUTO_INCREMENT,
  `cust_name` text NOT NULL,
  `cust_contact` bigint(20) NOT NULL,
  `cust_address` text NOT NULL,
  `doc_residence` blob NOT NULL,
  `doc_identity` blob NOT NULL,
  `cust_email` text NOT NULL,
  `cust_uname` text NOT NULL,
  `cust_pwd` text NOT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `p_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_name` text NOT NULL,
  `p_price` bigint(20) NOT NULL,
  `p_quantity` int(11) NOT NULL,
  `p_desc` text NOT NULL,
  `p_image` blob NOT NULL,
  `pc_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  PRIMARY KEY (`p_id`),
  KEY `pc_id` (`pc_id`,`seller_id`),
  KEY `seller_id` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE IF NOT EXISTS `product_category` (
  `pc_id` int(11) NOT NULL AUTO_INCREMENT,
  `pc_name` text NOT NULL,
  PRIMARY KEY (`pc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rent_product`
--

CREATE TABLE IF NOT EXISTS `rent_product` (
  `rent_id` int(11) NOT NULL AUTO_INCREMENT,
  `return_day` int(11) NOT NULL,
  `price_for_owner` bigint(20) NOT NULL,
  `p_id` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  PRIMARY KEY (`rent_id`),
  KEY `p_id` (`p_id`,`cust_id`,`seller_id`),
  KEY `seller_id` (`seller_id`),
  KEY `cust_id` (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `return_delay`
--

CREATE TABLE IF NOT EXISTS `return_delay` (
  `rd_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_id` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  PRIMARY KEY (`rd_id`),
  KEY `p_id` (`p_id`,`cust_id`),
  KEY `cust_id` (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `seller`
--

CREATE TABLE IF NOT EXISTS `seller` (
  `seller_id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_name` text NOT NULL,
  `seller_type` tinyint(1) NOT NULL,
  `seller_contact` bigint(20) NOT NULL,
  `seller_uname` text NOT NULL,
  `seller_pwd` text NOT NULL,
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `seller`
--

INSERT INTO `seller` (`seller_id`, `seller_name`, `seller_type`, `seller_contact`, `seller_uname`, `seller_pwd`) VALUES
(1, 'Harshal Patil', 1, 9106501397, 'leonado', 'leo');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`pc_id`) REFERENCES `product_category` (`pc_id`),
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`seller_id`);

--
-- Constraints for table `rent_product`
--
ALTER TABLE `rent_product`
  ADD CONSTRAINT `rent_product_ibfk_8` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`seller_id`),
  ADD CONSTRAINT `rent_product_ibfk_6` FOREIGN KEY (`p_id`) REFERENCES `product` (`p_id`),
  ADD CONSTRAINT `rent_product_ibfk_7` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`);

--
-- Constraints for table `return_delay`
--
ALTER TABLE `return_delay`
  ADD CONSTRAINT `return_delay_ibfk_2` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`),
  ADD CONSTRAINT `return_delay_ibfk_1` FOREIGN KEY (`p_id`) REFERENCES `product` (`p_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
