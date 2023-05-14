DROP TABLE user_country;
DROP TABLE user_;
DROP TABLE country;

CREATE TABLE user_ (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email VARCHAR NOT NULL UNIQUE,
  password VARCHAR NOT NULL,
  created_at timestamp NOT NULL DEFAULT (NOW() AT time zone 'utc')
);

CREATE TABLE country (
  id VARCHAR (6),
  name VARCHAR NOT NULL UNIQUE PRIMARY KEY,
  continent VARCHAR
);


CREATE TABLE user_country (
  user_id UUID,
  country VARCHAR,
  date_of_visit DATE,
  rating SMALLINT, 
  description VARCHAR,
  PRIMARY KEY (user_id, country),
  CONSTRAINT fk_user
      FOREIGN KEY(user_id) 
	    REFERENCES user_(id),
  CONSTRAINT fk_country
      FOREIGN KEY(country) 
	    REFERENCES country(name),
  CONSTRAINT chk_rating CHECK (rating>=0 AND rating<=5)
);

INSERT INTO user_ (email, password) VALUES (
  'johndoe@mail.com',
  crypt('johnspassword', gen_salt('bf'))
);

INSERT INTO country (id, name, continent) VALUES ('ad', 'Andorra', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('ae', 'United Arab Emirates', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('af', 'Afghanistan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('ag', 'Antigua and Barbuda', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('ai', 'Anguilla', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('al', 'Albania', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('am', 'Armenia', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('ao', 'Angola', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ar', 'Argentina', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('as', 'American Samoa', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('at', 'Austria', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('au', 'Australia', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('aw', 'Aruba', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('ax', 'Aland Islands', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('az', 'Azerbaijan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('ba', 'Bosnia and Herzegovina', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('bb', 'Barbados', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('bd', 'Bangladesh', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('be', 'Belgium', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('bf', 'Burkina Faso', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('bg', 'Bulgaria', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('bh', 'Bahrain', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('bi', 'Burundi', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('bj', 'Benin', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('bl', 'Saint Barthelemy', ''); 
INSERT INTO country (id, name, continent) VALUES ('bn', 'Brunei Darussalam', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('bo', 'Bolivia', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('bm', 'Bermuda', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('bq', 'Bonaire,  Saint Eustachius and Saba', ''); 
INSERT INTO country (id, name, continent) VALUES ('br', 'Brazil', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('bs', 'Bahamas', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('bt', 'Bhutan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('bv', 'Bouvet Island', 'Antarctica'); 
INSERT INTO country (id, name, continent) VALUES ('bw', 'Botswana', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('by', 'Belarus', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('bz', 'Belize', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('ca', 'Canada', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('cc', 'Cocos  (Keeling)  Islands', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('cd', 'Democratic Republic of Congo', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('cf', 'Central African Republic', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('cg', 'Republic of Congo', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ch', 'Switzerland', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('ci', 'Côte d''Ivoire', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ck', 'Cook Islands', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('cl', 'Chile', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('cm', 'Cameroon', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('cn', 'China', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('co', 'Colombia', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('cr', 'Costa Rica', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('cu', 'Cuba', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('cv', 'Cape Verde', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('cw', 'Curaçao', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('cx', 'Christmas Island', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('cy', 'Cyprus', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('cz', 'Czech Republic', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('de', 'Germany', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('dj', 'Djibouti', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('dk', 'Denmark', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('dm', 'Dominica', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('do', 'Dominican Republic', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('dz', 'Algeria', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ec', 'Ecuador', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('eg', 'Egypt', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ee', 'Estonia', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('eh', 'Western Sahara', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('er', 'Eritrea', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('es', 'Spain', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('et', 'Ethiopia', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('fi', 'Finland', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('fj', 'Fiji', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('fk', 'Falkland Islands', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('fm', 'Federated States of Micronesia', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('fo', 'Faroe Islands', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('fr', 'France', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('ga', 'Gabon', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('gb', 'United Kingdom', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('ge', 'Georgia', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('gd', 'Grenada', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('gf', 'French Guiana', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('gg', 'Guernsey', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('gh', 'Ghana', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('gi', 'Gibraltar', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('gl', 'Greenland', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('gm', 'Gambia', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('gn', 'Guinea', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('go', 'Glorioso Islands', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('gp', 'Guadeloupe', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('gq', 'Equatorial Guinea', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('gr', 'Greece', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('gs', 'South Georgia and South Sandwich Islands', ''); 
INSERT INTO country (id, name, continent) VALUES ('gt', 'Guatemala', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('gu', 'Guam', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('gw', 'Guinea-Bissau', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('gy', 'Guyana', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('hk', 'Hong Kong', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('hm', 'Heard Island and McDonald Islands', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('hn', 'Honduras', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('hr', 'Croatia', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('ht', 'Haiti', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('hu', 'Hungary', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('id', 'Indonesia', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('ie', 'Ireland', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('il', 'Israel', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('im', 'Isle of Man', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('in', 'India', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('io', 'British Indian Ocean Territory', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('iq', 'Iraq', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('ir', 'Iran', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('is', 'Iceland', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('it', 'Italy', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('je', 'Jersey', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('jm', 'Jamaica', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('jo', 'Jordan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('jp', 'Japan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('ju', 'Juan De Nova Island', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ke', 'Kenya', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('kg', 'Kyrgyzstan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('kh', 'Cambodia', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('ki', 'Kiribati', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('km', 'Comoros', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('kn', 'Saint Kitts and Nevis', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('kp', 'North Korea', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('kr', 'South Korea', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('xk', 'Kosovo', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('kw', 'Kuwait', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('ky', 'Cayman Islands', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('kz', 'Kazakhstan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('la', 'Lao People''s Democratic Republic', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('lb', 'Lebanon', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('lc', 'Saint Lucia', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('li', 'Liechtenstein', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('lk', 'Sri Lanka', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('lr', 'Liberia', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ls', 'Lesotho', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('lt', 'Lithuania', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('lu', 'Luxembourg', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('lv', 'Latvia', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('ly', 'Libya', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ma', 'Morocco', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('mc', 'Monaco', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('md', 'Moldova', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('mg', 'Madagascar', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('me', 'Montenegro', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('mf', 'Saint Martin', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('mh', 'Marshall Islands', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('mk', 'Macedonia', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('ml', 'Mali', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('mo', 'Macau', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('mm', 'Myanmar', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('mn', 'Mongolia', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('mp', 'Northern Mariana Islands', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('mq', 'Martinique', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('mr', 'Mauritania', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ms', 'Montserrat', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('mt', 'Malta', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('mu', 'Mauritius', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('mv', 'Maldives', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('mw', 'Malawi', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('mx', 'Mexico', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('my', 'Malaysia', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('mz', 'Mozambique', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('na', 'Namibia', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('nc', 'New Caledonia', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('ne', 'Niger', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('nf', 'Norfolk Island', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('ng', 'Nigeria', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ni', 'Nicaragua', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('nl', 'Netherlands', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('no', 'Norway', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('np', 'Nepal', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('nr', 'Nauru', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('nu', 'Niue', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('nz', 'New Zealand', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('om', 'Oman', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('pa', 'Panama', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('pe', 'Peru', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('pf', 'French Polynesia', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('pg', 'Papua New Guinea', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('ph', 'Philippines', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('pk', 'Pakistan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('pl', 'Poland', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('pm', 'Saint Pierre and Miquelon', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('pn', 'Pitcairn Islands', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('pr', 'Puerto Rico', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('ps', 'Palestinian Territories', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('pt', 'Portugal', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('pw', 'Palau', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('py', 'Paraguay', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('qa', 'Qatar', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('re', 'Reunion', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ro', 'Romania', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('rs', 'Serbia', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('ru', 'Russia', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('rw', 'Rwanda', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('sa', 'Saudi Arabia', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('sb', 'Solomon Islands', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('sc', 'Seychelles', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('sd', 'Sudan', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('se', 'Sweden', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('sg', 'Singapore', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('sh', 'Saint Helena', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('si', 'Slovenia', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('sj', 'Svalbard and Jan Mayen', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('sk', 'Slovakia', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('sl', 'Sierra Leone', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('sm', 'San Marino', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('sn', 'Senegal', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('so', 'Somalia', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('sr', 'Suriname', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('ss', 'South Sudan', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('st', 'Sao Tome and Principe', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('sv', 'El Salvador', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('sy', 'Syria', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('sz', 'Swaziland', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('tc', 'Turks and Caicos Islands', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('td', 'Chad', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('tf', 'French Southern and Antarctic Lands', 'Antarctica'); 
INSERT INTO country (id, name, continent) VALUES ('tg', 'Togo', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('th', 'Thailand', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('tj', 'Tajikistan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('tk', 'Tokelau', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('tl', 'Timor-Leste', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('tm', 'Turkmenistan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('tn', 'Tunisia', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('to', 'Tonga', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('tr', 'Turkey', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('tt', 'Trinidad and Tobago', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('tv', 'Tuvalu', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('tw', 'Taiwan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('tz', 'Tanzania', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('ua', 'Ukraine', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('ug', 'Uganda', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('um-dq', 'Jarvis Island', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('um-fq', 'Baker Island', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('um-hq', 'Howland Island', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('us', 'United States', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('uy', 'Uruguay', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('uz', 'Uzbekistan', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('va', 'Vatican City', 'Europe'); 
INSERT INTO country (id, name, continent) VALUES ('vc', 'Saint Vincent and the Grenadines', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('ve', 'Venezuela', 'South America'); 
INSERT INTO country (id, name, continent) VALUES ('vg', 'British Virgin Islands', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('vi', 'US Virgin Islands', 'North America'); 
INSERT INTO country (id, name, continent) VALUES ('vn', 'Vietnam', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('vu', 'Vanuatu', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('wf', 'Wallis and Futuna', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('ws', 'Samoa', 'Oceania'); 
INSERT INTO country (id, name, continent) VALUES ('ye', 'Yemen', 'Asia'); 
INSERT INTO country (id, name, continent) VALUES ('yt', 'Mayotte', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('za', 'South Africa', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('zm', 'Zambia', 'Africa'); 
INSERT INTO country (id, name, continent) VALUES ('zw', 'Zimbabwe', 'Africa'); 


INSERT INTO user_country (user_id, country, 
date_of_visit, rating, description)
VALUES ('a3e6e6f0-7f25-4df7-a890-a5ad1aa678c7', 'Russia', CURRENT_DATE, 5, 'Loved it!');

INSERT INTO user_country (user_id, country, 
date_of_visit, rating, description)
VALUES ('a3e6e6f0-7f25-4df7-a890-a5ad1aa678c7', 'Germany',CURRENT_DATE, 5, 'Loved it!');

-- SELECT id 
--   FROM user_
--  WHERE email = 'johndoe@mail.com' 
--    AND password = crypt('johnspassword', password);

