-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 14 apr 2020 om 21:33
-- Serverversie: 10.4.11-MariaDB
-- PHP-versie: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pokerdb`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `game_settings`
--

CREATE TABLE `game_settings` (
  `settings_id` int(11) NOT NULL,
  `B_blind` float NOT NULL DEFAULT 50,
  `S_blind` float NOT NULL DEFAULT 25,
  `tijd` int(11) DEFAULT 300,
  `pot` int(11) NOT NULL DEFAULT 0,
  `settings_fk` int(11) DEFAULT NULL,
  `wit_fiche` float NOT NULL DEFAULT 25,
  `rood_fiche` float NOT NULL DEFAULT 50,
  `groen_fiche` float NOT NULL DEFAULT 100,
  `blauw_fiche` float NOT NULL DEFAULT 200,
  `zwart_fiche` float NOT NULL DEFAULT 500
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `player_data`
--

CREATE TABLE `player_data` (
  `player_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `winnings_total` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `player_game`
--

CREATE TABLE `player_game` (
  `player_game_id` int(11) NOT NULL,
  `rebuy` tinyint(1) DEFAULT 0,
  `game_id` int(11) DEFAULT NULL,
  `winnings_current` int(11) DEFAULT 0,
  `active` tinyint(1) DEFAULT 1,
  `is_host` tinyint(1) NOT NULL DEFAULT 0,
  `tafel` int(11) DEFAULT 0,
  `player_id_fk` int(11) NOT NULL,
  `has_paid` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `session_game`
--

CREATE TABLE `session_game` (
  `session_id` int(11) NOT NULL,
  `host_name` varchar(50) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `game_settings`
--
ALTER TABLE `game_settings`
  ADD PRIMARY KEY (`settings_id`),
  ADD KEY `game_settings_session_game_session_id_fk` (`settings_fk`);

--
-- Indexen voor tabel `player_data`
--
ALTER TABLE `player_data`
  ADD PRIMARY KEY (`player_id`),
  ADD UNIQUE KEY `player_data_name_uindex` (`name`);

--
-- Indexen voor tabel `player_game`
--
ALTER TABLE `player_game`
  ADD PRIMARY KEY (`player_game_id`),
  ADD KEY `player_game_player_data_player_id_fk` (`player_id_fk`),
  ADD KEY `player_game_session_game_session_id_fk` (`game_id`);

--
-- Indexen voor tabel `session_game`
--
ALTER TABLE `session_game`
  ADD UNIQUE KEY `session_game_session_id_uindex` (`session_id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `game_settings`
--
ALTER TABLE `game_settings`
  MODIFY `settings_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT voor een tabel `player_data`
--
ALTER TABLE `player_data`
  MODIFY `player_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT voor een tabel `player_game`
--
ALTER TABLE `player_game`
  MODIFY `player_game_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT voor een tabel `session_game`
--
ALTER TABLE `session_game`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `game_settings`
--
ALTER TABLE `game_settings`
  ADD CONSTRAINT `game_settings_session_game_session_id_fk` FOREIGN KEY (`settings_fk`) REFERENCES `session_game` (`session_id`);

--
-- Beperkingen voor tabel `player_game`
--
ALTER TABLE `player_game`
  ADD CONSTRAINT `player_game_player_data_player_id_fk` FOREIGN KEY (`player_id_fk`) REFERENCES `player_data` (`player_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `player_game_session_game_session_id_fk` FOREIGN KEY (`game_id`) REFERENCES `session_game` (`session_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
