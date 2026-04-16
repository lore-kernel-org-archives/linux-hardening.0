Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013083.outbound.protection.outlook.com [52.103.74.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940337AA78
	for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776321628; cv=fail; b=FZcMPGq0vMAlZaX3e08h2n8TYsKDVaIDAyGNASGSw1DGFbXqNDjta5/P8NASVHB7V+JjJYSbJvT+FfjkbkD6P78LKT+pryFte1+2MpBzLZVKtLgWmuIPinpVUv675Gc5E7Dmt9ONjFKLNh6uue3cU2Achlo4G4ITyQQSD0GRRBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776321628; c=relaxed/simple;
	bh=v4nZnoBYZvROLgF+yjDa8EuvNJncuG4m9zN9jjF+RkI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qGdex5WLK03TpjiG9pus5CNICqGG0cqM1Be8SbubAuhhFz+4wmv/E3zQBPhPeNrC19vp++sRfH/A+t5E2zfFvd6AcHiTXifxwEEdGqxRwQm+ESqZR/EwE4lbDS3dFhC0Rtah0SJGHys4OiGC3+TAIYq6QgWamuvKLzoPjLIdrao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B3A9iJ32; arc=fail smtp.client-ip=52.103.74.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B3A9iJ32"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qL8pZOzsJGQbLYJFnfXsdHzTsI5Dm+5MbOXgFu2ly7m7lGKCRozMuXdEgf+J4EC5TamMtdNCeFydR8lcXBeoa07YVmtoslI44JKq6Fjwdjta/X89oqxAVDnDsQaVXBZawnpEhHbQlAN/IYhJxSPQrxoyzCQKLcKEHUpWB+5v5UUY00Ufl4vCQhwuHYFVoxLimcX0+WHF0JfhxdMPkd+f93KT4MOA7jY8Fpf9kYznMfoLv6ESs/9YttwKB9a13ZBUIxS9tiMVT3aDOR9wwKYC3tFw7EjUb2GuQCmThl3lpJBuFn8k4AkCXYriqxXJmF3UgEbw4k9ULtupVH5LmWITJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4nZnoBYZvROLgF+yjDa8EuvNJncuG4m9zN9jjF+RkI=;
 b=wJaN7Wg7/um6Kh4uNjOVipoy0rKd8z1LOQKj5zbL374BSUdv2nlV+6N0dR5m4TRPCCKbQG8yQ3nB0BTwlFOMcqmFnMI9/IwvRkVMFqKgj7mhIzedyfyPP78U4YefiwKS5ndZKdN3nSJ4ZJcM/aL4YI8yrz4w42XAng7ptlCOttyj0YSblMO+lYZJjapXEI+zTPxMrxEXbJDPqY5H4OJGYzs/zMwiY80/AYfZI894QVlsgY03MfmhM8RP3QxQC4CnW4r4kk4D+U66KmRNjH4CsBfZ0HVvg2MgzCWj+dG103NrUZr+iMcjxFYZ/Li+GneN+3ntbucgTDW1e3K0378JZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4nZnoBYZvROLgF+yjDa8EuvNJncuG4m9zN9jjF+RkI=;
 b=B3A9iJ32AdS5CZB8Kc9i0FZhwfQe9xBs+tiVHe+c2KIyrVGxuT992/R1xj6PEbuVTqNTapVo80nnfgKaw6J5r+VYvu81WGhPgAPiH1+IH1MAvjm6WtUol7VQ6nxrOrR/e22TxvFDUSL3uCyuTOBkomsWcdLJlnG+Xv1CeSrCwqt6f8+KMEjd22xMw538JqGkXw8y4qNKXU57EIYgAlMJNZvzANo8siQgQdKmbyvHNWYSMX79gqV6NE7PcYGwgbuUcrDlaHL7uXxSeWQtulpSTVwGZz2XS+hxqkYXhy1WjSxuB77fa8Mr/S8M9C/AitO9UzPoa3yAxRoYEJ/22GcVkQ==
Received: from JH0PR06MB6632.apcprd06.prod.outlook.com (2603:1096:990:3f::11)
 by TY0PR06MB5683.apcprd06.prod.outlook.com (2603:1096:400:273::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 06:40:22 +0000
Received: from JH0PR06MB6632.apcprd06.prod.outlook.com
 ([fe80::4fa1:706f:f4e0:6bad]) by JH0PR06MB6632.apcprd06.prod.outlook.com
 ([fe80::4fa1:706f:f4e0:6bad%5]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 06:40:22 +0000
From: tejas bharambe <tejas.bharambe@outlook.com>
To: "keescook@chromium.org" <keescook@chromium.org>
CC: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: New kernel contributor interested in KSPP work post-Mythos
Thread-Topic: New kernel contributor interested in KSPP work post-Mythos
Thread-Index: AQHczWtVugOvel6cbUiRd9uABqlWkQ==
Date: Thu, 16 Apr 2026 06:40:22 +0000
Message-ID:
 <JH0PR06MB6632E88F74913DDB0797225989232@JH0PR06MB6632.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR06MB6632:EE_|TY0PR06MB5683:EE_
x-ms-office365-filtering-correlation-id: 35dba731-13d3-4bbc-0e8d-08de9b8308d7
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799006|31061999003|37011999003|19110799012|39105399006|20031999006|12121999013|15080799012|24071999003|8060799015|25031999004|8062599012|461199028|5062599005|1602099012|40105399003|440099028|4302099013|3412199025|10035399007|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?IcbaTDc5+xtFGwuGGtxhJ61PS7T3pwZCmp/gunnh/Rqg/uMO9PicKIBkx2?=
 =?iso-8859-1?Q?zvUTgfAV6PolHVvREIBYGWjtEAtUu3MSBUY7rQ292NZqHZ1gwRBzQ+9YuI?=
 =?iso-8859-1?Q?PNUzVpHET4ZDEWB1g3BV7thHYbU2c5wW7uGoWjTBLm/E/+Lwd2fGzdmcL4?=
 =?iso-8859-1?Q?7JF7uwuYn03Dr77Y0gcibTYDsLvhWEJmFLdWSJzwiMSHUsMF1XCJrKnkdQ?=
 =?iso-8859-1?Q?L7wC9hjtwhXcUAVglNyzaenh95ffQpHva3NtlViUYfyriaJgCi+m78gAoE?=
 =?iso-8859-1?Q?MZAvTyjOn8hqpNjEw8Fl6ALEOUXYWSd48ix+wHOymNOVPdllQCc5iex6bG?=
 =?iso-8859-1?Q?TFEYX7jsEiAnDbrkVsYG7pxloJHDPc1OgjhQQ6rw30Q1YlX2LVQFMBITfm?=
 =?iso-8859-1?Q?jJxVvTQ8uOzfm19b112/lXiQnCtn8YBT2N9+DvwaLSYFs5ZemY1hJKI7r3?=
 =?iso-8859-1?Q?V99qlsdSpzgUr7+9ACRQlnd1q93759RBtbsOe+bOWS7Pf+97+Bmw1jQtuD?=
 =?iso-8859-1?Q?gwoXfR3qBklf7qFiS+FnFhGsusqpe/ccG54YSeh5spJvwzn1COJ6g02j3N?=
 =?iso-8859-1?Q?bbtcj6aZ9l/MaiJYelag2q9tLAOB9l7aOkjEQsOeVXU404LDViyFU59Yz/?=
 =?iso-8859-1?Q?XXaaw4kIbUXDlPxPvbkre9otugC3G2HZjq1wTVH0ho7IeyHIRQkbykKyZF?=
 =?iso-8859-1?Q?2TVXPajeQGX0WG9PhMy21PbzrU9wspCxY3GqEhyunq+Pp0iGDA9gIsR/Ac?=
 =?iso-8859-1?Q?2V5YD95c5/4rYNrk6v50m7aN7IxGPfRH/HecG4e5Vu2XM6+c3ckSnegl18?=
 =?iso-8859-1?Q?Cws7V2E67jmr6t+mWqx479ijZh318QJTbl9zPoFyvwplwtd8tpER2SMTVK?=
 =?iso-8859-1?Q?1gdoZGWxEjCM5bRRXCwTVDZzcc8hnuWICT2KcCV2SG8T8/vcFylYI55d4/?=
 =?iso-8859-1?Q?KVPHH0ETUdsoPZLuyKjOugLBZXhvi0k5yifBVkCpqQhp2637NbZJy35EQD?=
 =?iso-8859-1?Q?E/ETXYZXiwty6UGkKe9jXO3rw4kkrbUHiYu4sJlRq99wVBQAr5SL+Yovyv?=
 =?iso-8859-1?Q?WPLWt2M8Fz0PUUh/qoHpkM73QH6+S27f66KrFGn7nx7tK/ughDH9AiDsTF?=
 =?iso-8859-1?Q?7yWvqqfuFFsHsr6XzUNLYACUZnVd1S71UzR7mPWK51omrNgNyozwpqnZnQ?=
 =?iso-8859-1?Q?nh8MnfKxW7EV36HNUeFVfnkFzoZLui9xqVZvfI7eNJ2JHuZLvyHEOfAy5p?=
 =?iso-8859-1?Q?Qy/aaH44KpHuIXQK+cNxNHBsZlxRJ8i1g4lbQI+mQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IRmfr3hqKZ3uBeQxTMcolh77BbcNvR7f4Ey/gXSWqS6gSZGjrHNs2RdvuW?=
 =?iso-8859-1?Q?A0gvUMFJWHK4Jz7Jfv9k5C4wOjxO5iup8eRfiu2096bP0tD3KHcd3K69x7?=
 =?iso-8859-1?Q?eQy/TmrASLzrZCmXvDPOZvqMVzbVNsRP5hALVR0ogpXKm1Fbzg+6+82EA+?=
 =?iso-8859-1?Q?VQ158QLy2dcOntcd/960WzwN/yzVmGkAYrnE+M1ceRmTofZOLTCRQoYIYK?=
 =?iso-8859-1?Q?nTdlSRaMUeSmTquGzGgBsQMY/JMe6JFYPs5mwO9z6D2Ryxol1XNRE0YYQD?=
 =?iso-8859-1?Q?lx30lqPeqRWA8m0nXZx7zniutTZdrNhjX4QXnjdXDtaEceS+XldCU4t3MT?=
 =?iso-8859-1?Q?w53GaFNcfTklPTUWHZjfvlCZET1sa8NXbPD1nxkQBiSkoW4LEhdXQI9cLP?=
 =?iso-8859-1?Q?B0GgQTQp7l5s08SzbYZbvLlGDiwpA7bwIs+clOpAooJ6qNtlOdsK6BEWrT?=
 =?iso-8859-1?Q?6oVHB4RggCHKu9vR70vTXo//Au4/ufZrG5cepMQ8Awc9Abuz8oOYIYadHC?=
 =?iso-8859-1?Q?lCOCe/Fne5DPG4vlFbFc2QSrx4nMIm9pwseS5D5kQOO5gB5fx3oV/iYD3B?=
 =?iso-8859-1?Q?JddXe0dOX5D3NCynu1bAa6jWjXZuBNglksFGNnbEPwkX7OClS05HXScvMy?=
 =?iso-8859-1?Q?AEUlHiOKPCusJX/uSL1s/Cccsfwv4iERnLPBzBtibhPFeL/ZM4fARZtZ06?=
 =?iso-8859-1?Q?cBIACfXixVfW3JSD+50LZ+U2iW0r5Iy4xTiJYgyogi7Hm2ZkRFQfLlZyb1?=
 =?iso-8859-1?Q?gepfvcTRtgiztT4sSONwFjhcbY9JMPdct4ICg4P7H+fOYx5fNa/RJ8oLrm?=
 =?iso-8859-1?Q?dmov+Yq5CnTIaaQ6DvQx8N+KYLLpAvG4L9bkFTJm7rUrwhd/lw5Yyi6xGt?=
 =?iso-8859-1?Q?+OgtAbtlh1/tM+TVlOz+2FGWoaSfk66csD5KGKyebQkIkmAAfZtBZiUb2h?=
 =?iso-8859-1?Q?F/Z+skjmKDFalEdHpejXLJUO+xUa1/du2kTqAuLhzD0K7UYcVlWjcvVpov?=
 =?iso-8859-1?Q?k8vHASYWiODTrz6S+xVD9dXhmRtRZE4qm3qCwyrxTUM4SxCzxKaRXON2nR?=
 =?iso-8859-1?Q?imDTs8wFWiWe/ypSPPlaL2UUNNqQrKtOCtNhZ/wzUkNCTv2TzWS+JF5U8e?=
 =?iso-8859-1?Q?53IgCSQxBJCzCwjqdYD88ar8+xSanN5Lt11osmaiaASpg7wxcVo5VBXnMi?=
 =?iso-8859-1?Q?imSBUHbSc3G/nzQf2NmBrxbRfjhaaH6SOakIDjXHBLgVC9EUMPL5962srL?=
 =?iso-8859-1?Q?lDj+m2tIB6DQuJFs9Gt80FlhpHrrjsbbnIN9CjWXBxwpSXSNXKsk9kjont?=
 =?iso-8859-1?Q?bs/AvRB3Ra+A/xM46V+lS0sI+EpDziaOwwsHnCxwwCGL9awszTad2XSYv3?=
 =?iso-8859-1?Q?0IcRwX2NtBC4uwqPzqh733/9HYnx9tU83vV6vhq0q4AojsujRLJXsMSkiV?=
 =?iso-8859-1?Q?R/3nac+5uog+NeBQbCJ3ujPwsTWzs8iakKM51Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6632.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dba731-13d3-4bbc-0e8d-08de9b8308d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 06:40:22.4430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5683

Hi Kees,=0A=
=0A=
I'm a Linux kernel contributor. I have two patches in mainline: an ext4 bou=
nds check fix merged in 7.0-rc6, and a race condition use-after-free fix in=
 ocfs2 currently in Andrew Morton's mm tree.=0A=
=0A=
The Mythos announcement has made clear that the class of bugs KSPP is harde=
ning against such as race condition UAFs, bounds overflows and KASLR bypass=
es, are now automatically exploitable at scale. My ocfs2 fix was exactly a =
race condition UAF in the mmap fault path, so I have direct hands-on experi=
ence with this bug class.=0A=
=0A=
I'd like to contribute more systematically to KSPP. Looking at the open iss=
ues on github.com/KSPP/linux, the __counted_by annotation=0A=
work and flexible array member conversions seem like high-impact areas wher=
e I could contribute. Is that where new contributors are=0A=
most needed right now, or is there something more pressing given the curren=
t threat landscape?=0A=
=0A=
Tejas Bharambe=0A=
tejas.bharambe@outlook.com=
