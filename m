Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4014884C;
	Mon,  9 Dec 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762608; cv=fail; b=X++apb1jdcZDieH1dQObakOJE9UhUIZelq9A40NzzQfrTkd+xr9gnqDzadK3PGc/znZBLXqzg02eE5yag6e15L38VufJl1LC3fyD42yIDIijkl7Rjh8sL2Qps/GkFZPQaTC/XcHzf/ApwAjCOlSn2SYZOnbBdMgub5aOoaAo7N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762608; c=relaxed/simple;
	bh=/z29CnKKokz1XCfeX6xOkqWTgurkc3tS6A44xQjkwjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kbdOUKGeSKXXnUXoU6Ec4k1UHosZh4ocyz28K5BVAWMZdLTE3EU57GpV8JYArOvKPRX3owLJ6pwajlRtO0qrD6EEaqfGhQEuaQZ5AVFcwAkslKZoSGkM56NckVCx8dKRz19O/9yJIAUCC6D8Zw9E/pt7Ib4jk6DNEMVjwxUrXUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFV+egZK; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFV+egZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733762606; x=1765298606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/z29CnKKokz1XCfeX6xOkqWTgurkc3tS6A44xQjkwjk=;
  b=YFV+egZKCDvGZsHXMmxx6i70B1FDpD9Fbvnc0IagShLBCi5YCBrSxUYN
   lzZFJSSeIv8NP5X05wFopkAfnAnyBX7k99HEMIGdl0aUZat2XsSBDNm6B
   KOiPZe7V5puxWhBnVcUZTj9BXMsyUN3sEm+QPkYKRQnNetcF8OYPOItUa
   Eb6IIlnRipBDvi9lAxrFxCIJwxe3vSgmTSkHUpWn3WchSTlU6s9AKBxOU
   edFLwKaPVSh+/zOvLJp8iBQWX4mZdFnXfq0FDaQypvFahYSp0/BezTPJk
   eprTZicRXpf5JZsf0XoXBaX+eo5WITYzYowCGftNK/JToxVGnjpgFmbZQ
   A==;
X-CSE-ConnectionGUID: is8sqjHlSo2vcVoQk7+uSw==
X-CSE-MsgGUID: v9Tm50SkQdWvEQ5GfdbaSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34309126"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34309126"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:43:25 -0800
X-CSE-ConnectionGUID: wC81RM3ERwmWfsVHHgOsCg==
X-CSE-MsgGUID: w3SepXcaTvWcGYt2ci4pjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100156090"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 08:43:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 08:43:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 08:43:24 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 08:43:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCyaoAJ2Hzgu6vyXjsn/KTsaeegOdwvftHs1PX0ASz7uY55OCmY7KDd/ZOTfgs792BGPN1G1ZYdpJWxPSCOSb4rgWtmWHkPhEB/Qq5kYZU/o9VbcWTXk7BYL8SJCcnxailSSH+F2wF3XvIQ6ak8hJrspE8lEHZs8P0dzFU9OR5f7cSn5BTUaOP44EiQ/g3xYz3rshucjiEQUSCk2MHPNZNFEdJAo3jNiwiSimW1UeAfHqCxEEKa/VFbk9ESk5n/DFSOHeuhm6Sro86+jGW62mf5jYbgoeT+mai1XZjOb/1GGpr6VAqUenNBNCVLi31wJTnXPgGVMAKDD3dht6AMf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z29CnKKokz1XCfeX6xOkqWTgurkc3tS6A44xQjkwjk=;
 b=LtDOry8I87hMRGLFDNWhsFPsnM9rGAtMsEsVdocAM/glf1sR/bukd5/8szvRLT3r1rPrxu+xBlM6x9qTo+G/oFoDYuk3sMUjAHGClEM1PdVpcg5iH3edlOuiZ6+Fp3eChx4g94t9o5cNU3ac0GGedA29I1a4WqJoYXnqKdSnXBl8NifN572yBkNJaNEVOB5c1ar2FA88t1ppA3ZdjQH63RZoe3ZM4SZJCGGyyZ8IaUJ7KRySeoCX6Os+LSsBwvEpP4ComH0w6DzWL7PoXc6FDqo9J5aje44EqE6x34q/+IRnoFZzBy5Gkw6htyDY4PXzIKvW12g2B7r1gh4XNG1LBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8590.namprd11.prod.outlook.com (2603:10b6:610:1b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 16:43:22 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8207.017; Mon, 9 Dec 2024
 16:43:22 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
CC: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, Felipe Balbi <balbi@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>, "Hari
 Nagalla" <hnagalla@ti.com>, "linux@ew.tq-group.com" <linux@ew.tq-group.com>
Subject: RE: [PATCH v2 5/5] arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and
 MBa62xx carrier board Device Trees
Thread-Topic: [PATCH v2 5/5] arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and
 MBa62xx carrier board Device Trees
Thread-Index: AQHbSiAnQdSa37dJ0kGwJbAzdBQjAbLd5yKAgAAIooCAAA07AIAAH4QAgAAA7SA=
Date: Mon, 9 Dec 2024 16:43:22 +0000
Message-ID: <SJ1PR11MB60839F37610CEEC55F9E9B4FFC3C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <95ff66ca2c89f69d893c2ce9eed9a0c677633c7b.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
 <c902a56cf34838f60cee67624bb923e91d74e9e0.camel@ew.tq-group.com>
 <d25b1447-c28b-4998-b238-92672434dc28@lunn.ch>
 <Z1ccXClgTg5Guq6R@shell.armlinux.org.uk>
In-Reply-To: <Z1ccXClgTg5Guq6R@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8590:EE_
x-ms-office365-filtering-correlation-id: b0ca6cc0-5e39-4c2f-1954-08dd1870981f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?T03T8Z2GzU7xNE+4aFfZ4Ud8jCJ9l2LHGyo1XR8EmIzAZxHtHJrnHXN5Zbo9?=
 =?us-ascii?Q?xlPVI8vUf+aK3EVndRg543qhtkYBcyrOW5ovuHVtRepyHfkIzeuJqpqIQuPf?=
 =?us-ascii?Q?R6DCJOY0ym734j3DC/D/xOvPTk/dTxOACrptsjVSH+R9PWNPusgaU02JvLyj?=
 =?us-ascii?Q?szRLff9KgQheelVsM8xnEfAlJdvgn61kc91GU4HaHE3f6SdcPdV9UwCRDj7l?=
 =?us-ascii?Q?yABiRrWD9Czd3Qr/Dpr8OiXhkmvfmWqrNCeL8frslDeFrY0/s1pJMajRIRl9?=
 =?us-ascii?Q?hYRsOC4RklYGQtotuD6uGKQ28Swvs3gBAuQInt48N//4PYH02/p4lsA4pzgg?=
 =?us-ascii?Q?sqYgGTHTLlRQgXfbEl35WT0L0nbfHbSmmnaIR7/8CqEouatSVYBcTRgTtUOp?=
 =?us-ascii?Q?WCT/WKlMzLErzXRoBrwphuwuBvc0IOxWIw3kEvR3ZbXmbuBTc5s0/pVjizgT?=
 =?us-ascii?Q?C5DeoXFMztYdN2wB/002/KnmfV3kYVjTLB2VNOLBJXNnKydHJR66CLdsnFmy?=
 =?us-ascii?Q?KmAhUblCgLyPOrCgOB1XlwCoiq+te/ywN7ySrZzw9+7mrBdOvNKcVIshJTNW?=
 =?us-ascii?Q?2PL2+hwrJrp8brl0vEc+luvF+RGvPe+F51XH1qdv7wr/esIyUxMrhyCN628v?=
 =?us-ascii?Q?W87An2xAsVTCITFEd8X3daoskaHI/7E4iWdNZPAnhc1ZrhIcqyluzwac+J+V?=
 =?us-ascii?Q?9nf3cjCnjJcAsDc3tkxF0fwmDc07fKjZl8jCjTs7o6DB6+HWSiA/tYhUNdV5?=
 =?us-ascii?Q?TStPSJImJ3gK8QWKsu79nZ7CkxOxAbFu1gB8IPvJIM5msT4EAynnBK9Gj0E2?=
 =?us-ascii?Q?kA0NVpcuoPOb7+oTvPI0Y3zq2NJWeCzmys8r0v44nDqd7PsCuEqbf5+t3a+f?=
 =?us-ascii?Q?mbhq9nLt1ty4LMV/3yymquk5CpwjqQHk243xvfaSjprvut5D6towWq6zD/Hn?=
 =?us-ascii?Q?QZEKsGsfSoQNj2x5TESERMDuS/FaGj7syOeNqGgjgAeHDZhvE6aSfNU0CpyF?=
 =?us-ascii?Q?S3bdU1Y9HfQonb49taIECdaO2TWvpdYxv9p4R23LnNP5ubBRQvzt1HemJ5aS?=
 =?us-ascii?Q?ED29I3MtpVnVXl+zNnTvhsaoNZtCi9slm94l0xEZttgoiwU79ZLRlpV0UV3P?=
 =?us-ascii?Q?Rf1xzfUEGXJ5OQWO8aqj4ZBfPNvj0GFGSrt0vB1rLsH8EzKBEXFRuCWfRjPA?=
 =?us-ascii?Q?YzD2H8WuyP0Z7g87Ux38329nxydCN+czjp79gzWI3ZGWv9kfavyZI1g98a/9?=
 =?us-ascii?Q?IYFkZAb2/uyK+EtvbjXKt+D2bjjJNdfkhNmy6qBFi7vPUAD9dMM0tIwUtWNb?=
 =?us-ascii?Q?dfJZ5bZtElNz/HYkcmtIyQnOkOlkJ4QMe9xx1RqarX6Iur5X23sBMsfCPJXt?=
 =?us-ascii?Q?is0u/Odonsl+SuXoiqDXVrwwcikObKEZmPd7UKl5vrdB/E4pOw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SXugWrMM0LW1zi5Yqjq/5xb+jAg4XtOGS9Hk427S8yCBJw/6A9VrDPEfRiI/?=
 =?us-ascii?Q?Ibs/PM/mWRe/0C1FEevv8MqKWxmvw/9+fFg77mohKXXmNQKttXG8b+e7WQXE?=
 =?us-ascii?Q?DemGnNrfgEkbbB0I9ERp5YWiV8581hv0aLYxfTqqxiqFZLCF5at3YqYHX2ZI?=
 =?us-ascii?Q?BcZ6gJWj/OyrDZyC84s9ZsV6ZUoPBH6xNOBucj9Qf0wu8GSXoAlJEeT0akaK?=
 =?us-ascii?Q?HhXeAmAKlxaY2PYhD01ecE+vpMRNCunDon1yzW+gBR1apikp95b+4S3/dFF1?=
 =?us-ascii?Q?dBZN+aNModafjyuVkTfpmgkT90s+JsTraQyV76wXB9wPBSoBQCmGXpfKMalY?=
 =?us-ascii?Q?YOLNzluKOPHx+VWorCsVDvbBi3G+DBZ1UulN6QIBACY/dGFVBUxZoogmJfZR?=
 =?us-ascii?Q?XRJVQH2acjbNfBZup7CgCPit0tiHSwnR/xDiRyyiVz0AxWHSRc3Vx8Pc08mD?=
 =?us-ascii?Q?sUMxZHbc68EwCLszpLFrj2mtYuPwhD3SBt2OJIWshJR9RDjswK0Aoy3MJGZx?=
 =?us-ascii?Q?vFHb1zhjz60Pv9H837toQYi5lcE03TK4dU+yqZHBIyzl9hRJUVFdS4mLkH+I?=
 =?us-ascii?Q?9qHKULc76ZOtcI0OdqbYfJCKJTEz7WNN72ReYja+JDK2X4AHT2oWpz5lP6Lg?=
 =?us-ascii?Q?UTAU6ETd6gDEgijalqywvCe8hXvcklyRvJ8kTLU/gayPm6RodQHMjAz01yzU?=
 =?us-ascii?Q?8lCklEX24pY4Puj1vH59Ktq9J3WSZyGWYM+0IgvbO1LFw8rva/9y5AmYSR6u?=
 =?us-ascii?Q?0PzvM2DOCfUKCCF8Omn44w77opQh2N3TCYyqeqm+XchLBrofQEOlX0jKbCZP?=
 =?us-ascii?Q?kFdSCYgHNYCxvrK5axJOO3Nri6h/3GVrFMpSfAWyAWNIJK54XE3+UECGMJBu?=
 =?us-ascii?Q?qNv6uv2KucrTJeerX+1pM28IfKsk43cOqMCFtlE78WuaT3sD8C66OKlC5qdq?=
 =?us-ascii?Q?+5ROFLbfkzX3mATYnv+qKVevd7kFC74FKJm/J2GC7RaSiXoGOX0ycO6QN17q?=
 =?us-ascii?Q?0op9EAIS/mQHS8UtB3JIJ/aT4+OtF2Bu19WnRNpTO2GNAcGaojgSZU4kdq6t?=
 =?us-ascii?Q?q0xtYe/VcUP42t/YOkEkpS4R+fqlnX3M/KnkwZ1HisXFueeaV4RmiMwHoWK6?=
 =?us-ascii?Q?bWE8oCwnrmUVcEp896iDnkvBbza+OyBYRVncfwGng4mAcwzJ4WhYey2g7qGU?=
 =?us-ascii?Q?YDs19QNEha0jbE1BP4BM0lTdvXZzmUTGyvcN4grN//L99Ui4yoonJ1mGeUFf?=
 =?us-ascii?Q?GedWHtZFn+GY0St9nvGVIfVmHnoRu/JLsg9hN5rOLMRCKJM9cmHIAwTsn1ot?=
 =?us-ascii?Q?uNfFz3PACTqjBF259TIESibEXYVd2hCAcsq0p6TN9iY6gO0UvI0vh00Ov/Kw?=
 =?us-ascii?Q?MMM99AKulYVVlLkezoFmDTkYVOxfgLIIheesbZCRlkApS+UM8CE14yICrZL+?=
 =?us-ascii?Q?yecPsIvtDZgr3z88ThzXBnhS9UFLSRFubDDJWMXk/AhCLF2VljJMJte6aZ2u?=
 =?us-ascii?Q?6NHiJTPHC+NEj+sD0E03QTqYkrB4hbVRz2M0WDxW3j0VrjlbFjImlU70hcEO?=
 =?us-ascii?Q?Ze/SD7Im9Rzk8YkbIyq0na2fCqNuo0fZjbsmIswb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ca6cc0-5e39-4c2f-1954-08dd1870981f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 16:43:22.3683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W56lBpuM6wqT88B0x2M/qPd/Ey61I8PspyDgIo4MsGsMSzxlTJv6xhxlCTeKJzTtgqTRyVbwk31+dd/Wifz6rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8590
X-OriginatorOrg: intel.com

> ... which is why we documented it in Documentation/networking/phy.rst,
> but it seems folk who run into RGMII stuff don't read that document.
>
> I'm wondering if we can come up with some kernel-doc compatible way to
> document them in linux/phy.h instead, which may stand an improved
> chance of being read?

Move the relevant text from Documentation/networking/phy.rst into
linux/phy.h as a linux doc format comment.=20

"include" that header file into Documentation/networking/phy.rst
with

.. kernel-doc:: include/linux/phy.h

-Tony

