Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75DD1A6803;
	Wed,  2 Sep 2026 05:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788326497; cv=fail; b=DTahmULYLYCts1+xgarTWNklJ3sGCC9V2R/RTj0tkDPpGXuTFaNHoP0rYI+EqQx/QVwscsa+XWecKGBpWiL4jB28ky4cJ/mDnE/kvQMgIEz1PNkyZ/W9qrM5QsvVletu8WJi8oH+EVzbi8az3wW7aV2MUy85mpg0iS2Kf/tKZrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788326497; c=relaxed/simple;
	bh=okYOpJzxn3znsoOlK8kAWTKhcomV9UX310GdCJu7HVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZF/v32WKCeLGZq+s8sW4SGd2Vr17IMqQJ/Hbn4a2KDTrT21J9xYaOB+7wVJpBGoHGKy9fsjMCwlf48eklW2vg7I4UEB/583qDucc/JmUJMZdvoYwXGn+XEMZaYnzwY5jyejHXVnfDs1ULnadJqSjwTQSHzb8vaPnnXC2tzVFL+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kaPW8Kj7; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kaPW8Kj7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68251tnJ3108205;
	Wed, 2 Sep 2026 05:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	okYOpJzxn3znsoOlK8kAWTKhcomV9UX310GdCJu7HVU=; b=kaPW8Kj7PoqMIfAe
	HF+Co+RYKVdICI7gG4dElqUKXkpc0XetVjQH+APKKiZWK/hKGeoFAWFIlVky7IZV
	O3kX6xhAXk5+v9sNkrLdPY30De8GJzFTDBvAqOM79jShmci31ymAeN6TosHVPP2X
	bueKOkW7lttrJywoeNGZTE7yNA7rBT8UtpfrniKrQbTkPzgsvgGkjcx23DtNvBPp
	CN0iPIwZ96+ZXqE0a2VJp/hIw7kaEoLJ7gfzJ+qWH+NLLDAu1755mWjqQYweB7Kw
	hyaBLFVDv1LQPhivhItHqyBp86FnOSTaNmvIVvmCMZck3KaV/IRIljoojbp3M0aA
	XhehXw==
Received: from bn1pr07cu003.outbound.protection.outlook.com (mail-bn1pr07cu00301.outbound.protection.outlook.com [40.93.12.1])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpas3f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 05:21:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgT+9m8J3C0G/MI6bOLhELxXd2bbdi9wNY93UI/DIpJIg0QKiJIfOG548lYWzORZ1oaXV0DmVJfLgg8vSNPm6+yWCKu3KpufVZEOJpI/sp0hnmHmzGup541OeSJMj8jrqAkqG0Q3L84CjkrXoe7fPsJ1TzYTN2WhZJpGHSzxILMcgedwbXkUUO5HOFtB+Jfdhm7jlfmacgEQzj2FDQ3V40euNNOS3SKJTbdLWYzofYLIM8EO2jjSUSZO3TOw2Wsk/vvq7pPDIdUrEj6ry/GY+sn4gvJt3fEOBh2eu4/XjDkguFcJSbXufneirULEgnchFPjN0B0aRv9NSsQ3CKx15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okYOpJzxn3znsoOlK8kAWTKhcomV9UX310GdCJu7HVU=;
 b=Rp2Le09P5cTh9oraQLeO1MMEW8sMNZhfvSOc/jdWrvJiEWsqRrUAsAIFmcB1qLnXgy2rNqO9vhVB7hJi1ZoxpUPIBUHuY4BOPG9r8+yN5zUZ23tWXZZjWSwsACOXjGx62Q0yTvtlfiNOszq100IhXJrwKA/g17ttUMgseamhJHAKMwn1dtW/U+/+Bv9R9hoHkhL5FJ9a6JpE7mJ8i9bUeOQfTrdKfvSIAHgLddLg1FLUf5/n3v7x9bdPGB3LD3RHpinNf/yfMZcdLNsUGqk0Qwt5DbiQmQeLhgmXcxgos+dTe5v+8/Hbk6lfhhF7N0qktf4j7rTA74sCM3aJXvIEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CY5PR02MB8991.namprd02.prod.outlook.com (2603:10b6:930:38::17)
 by SA2PR02MB7532.namprd02.prod.outlook.com (2603:10b6:806:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:21:26 +0000
Received: from CY5PR02MB8991.namprd02.prod.outlook.com
 ([fe80::6c24:88a6:606f:d52]) by CY5PR02MB8991.namprd02.prod.outlook.com
 ([fe80::6c24:88a6:606f:d52%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:21:26 +0000
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: Nathan Chancellor <nathan@kernel.org>, "kees@kernel.org" <kees@kernel.org>
CC: "nsc@kernel.org" <nsc@kernel.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>
Subject: RE: [PATCH v3] scripts/gcc-plugins: suppress recorded GCC switches
 for extmod builds
Thread-Topic: [PATCH v3] scripts/gcc-plugins: suppress recorded GCC switches
 for extmod builds
Thread-Index: AQHdMGlhwtxapd4Y/EqFFmbZzFV09La6bhgAgABjDQA=
Date: Wed, 2 Sep 2026 05:21:25 +0000
Message-ID:
 <CY5PR02MB8991B2B0296C3B328CB75823E2B72@CY5PR02MB8991.namprd02.prod.outlook.com>
References: <20260820060116.786173-1-jaihindy@qti.qualcomm.com>
 <178830439251.3086667.14013595113820949472.b4-ty@b4>
In-Reply-To: <178830439251.3086667.14013595113820949472.b4-ty@b4>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR02MB8991:EE_|SA2PR02MB7532:EE_
x-ms-office365-filtering-correlation-id: fa5395a2-9740-40e7-8807-08df08b2091c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 JDlLI2vsMfUJ+744HaSi9MId3D5KcKpKEsQc/yBK/x8n8q49tZlq856V206cmjVcO9NS4dwBai2mSRep48XJXolrUn1yFcFc7iy6KDX632v0Wcf8gV6wb3RkkYbPavLYcyIyhM8M/ZxBeiA3VgzVcAoOFa7WgvTPfsWnvEZOhV5piz3OqgWjb8ey9k0P2+3iq2k4H1S+vh8M2txtzboNVqfpw8JiukJK4/LEJknf93kySixQLCws36Ffy5LL/31ZnqbJn9ffiFLMRFSYDAgjj5CONR9staXoEfVK+VHzUkZl9D0SapBSbpySFj+BoJwF7M51OvIZfZggnuewVvgFW27wC9lGdBOcP0vnPpicuf+DxcYi4fucISXTYxHkUpepZJ/601bzRK+3QSDaWZoy/shxpjXeQ1yrW4suCc3Q4eJPCH4bannd+l64Biunx47McmI3PTHViaJv985LI+Jf/ao+/jP6YE4xRyxK6dawyXt+hMLzuSNF4A5I5tq6+KN07Yl6/GCZ7KQ00MdPswbkAaZxFlFplWSMEKmwvxfBFJLWkZxbQu5b/6lU2ZB7d4Fpk4B9f1K/bEorgauu2y7glfTjvY6TWOP0PDBXqQtZF5cFT2KIYRQPKYlj2S3VpyhN7mAC0JQDmHsc+G+2KfDj/JZOfMf4QMThucFTFWILgJJO/gGe9hFbAr/ttAUITpfo/F6Hze0VPZEdWqccneNAuHMPdr72a6c0vvtMMzJSShw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR02MB8991.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R00xUkVHRkUwMFZFcXJDd2dqbVR5SVFsK0ZqTGgwckJTRWxmK3ZoUU1kc0V5?=
 =?utf-8?B?SnZGSkZZY2lsUG4wUWtzdG1MODUxRWdXdCtKQXpWZENFMC8ycGE1RXJBV2Jo?=
 =?utf-8?B?aVlZcUJMSGE3dXRnTmxEVTV6cUU1OVJJSmNFZjhPV1RiY1hkYlRjRXY2TW9X?=
 =?utf-8?B?aC9iNGIxL051Mm92eFlOVTFkRFBhZURGOEhGNm1EaEZyOERWV09UTHZSLytz?=
 =?utf-8?B?YWx4WEIvWTAwSWxhRmhqYVVEcStHMzhleUtMSHZ3N01HOHR6TGFnWXRZMEk1?=
 =?utf-8?B?SmMxV28yT01Db0tGVzFPSTRFTTgwcTIwRlU5YVA3VEplcEZyNlkySU9jZkxh?=
 =?utf-8?B?V015M09adVVJR1BqdGFCVHZjSFZ0RUVwS2YwRkhPZyt6Z0ZweWx6ODFhVEg0?=
 =?utf-8?B?UWlGcG8vanFRSFJYL0pVQVFaQVlUVkk1M2dJQ1poUU1jVWQrajlPdE92R2tW?=
 =?utf-8?B?eEFtckE4cVJubHlOSVZRRlN6ZW5TYTNaT1g4WWt1UHBhZlAxemhNZlZ6bmhq?=
 =?utf-8?B?MkNtQ3BwRFUvWGJpTEdBTXdIdE5WR2tDZTNOTTRQTEtpcW9QVjV3MmZIL3R6?=
 =?utf-8?B?cWwraHN4Y0JQY1R5MTEyMXgvdnhDUlp4YmR3aWxmVEpOS2xxcUx5dTQzMkdl?=
 =?utf-8?B?elZCWW5STkV3VHV5TFJmZjBGNFA5SitYM3g4SG5HSlJadm0za3BzTkJyOXFV?=
 =?utf-8?B?Rm55U1h2aGJ6eXFURW5VcDd0NjNadk0yL01zS1I4NXNJSHY1RlFPcE95M0or?=
 =?utf-8?B?c2s4VjAyMGtSTm1pVk1BazN6RVkwSnh6NFEvUjJYb2pHMjc1a0ZsdmZmUVlh?=
 =?utf-8?B?Ym03K1dWem9IQW5vMzRacjFtTGp1OU0zUmduRG42bmhNandsTWltVzdZaEtz?=
 =?utf-8?B?YVhnZ0grcXN4bGViWXNuekdSUTNNS21VNWxoTkQ4UTlaNTE0a3hpTEUzeC95?=
 =?utf-8?B?TWtyTU0rRkN5SXZ2UTZIQmw1ME9lenR2b2EzQ00xSzhoU1lWRUZkS3RYMjNJ?=
 =?utf-8?B?MllLczNza3NyQ0tYVlNlNlJ3SkxTbVZkWUxjbVZQTE1KczFwUWlFWDBpNEsv?=
 =?utf-8?B?VXg4RURVbVFWVmxVei9oc3FVUm5Cb2tkbm5OaFZ4aHZTL1lJTU9kSEJka3NU?=
 =?utf-8?B?aWs5eUJSNzFBOXVBTWQ5MTNuUnpqVEtTaE5kZU9pRjFTMHpRWVRmYVgxZ0Rt?=
 =?utf-8?B?MTZXLy9PellnTjc4ZUd5YndhWXdCTExNRUtTZ004N0R4MEp4ZDZ4RzNmZUE5?=
 =?utf-8?B?ME9LZ29MVGRYWlp6WnFWTG1DZG1hbVhsaDNQTiszeHc1cmhGTGJtcW9hTjhN?=
 =?utf-8?B?VHJOL2Y0OU9nU2hPbEpQWFZrbFplajkwUVJ6L2ZOVmRyYnNnRU1UenhrcHZy?=
 =?utf-8?B?K1gxZUpOa1VGVmphcVVZUUFSMXhDcnZUQXM0NUNQL1RXd1BDeW0yZWgrNEtH?=
 =?utf-8?B?bWNYWjZKUGFaaFlFMVJkS24wcGdnSkpFdlhDQ2lZamFBNXFTc1BSVG9iaUdN?=
 =?utf-8?B?MWpHQzBPSm01bmhoYWJjOXJ2UE5uYjZFeTlrUlhrQTFrblJQNzRkTUtGOGV4?=
 =?utf-8?B?WDR4b1diQUxIMGlGRnlMaGZ4SzJOMVJaMHNrd2xsUEJYRnZ5MXlwMi9zT2J2?=
 =?utf-8?B?N0s0aEFOb3Q1TW9TQm9ScFlXeGJoMHgvbFdsSEVxSnBzK1BSMW0zYWkydndU?=
 =?utf-8?B?SGdwSUJQY252NDhPdnZZdHEzZjBEODRTZXU4RmkzUC8zNlB0d2U2Ti81dnA1?=
 =?utf-8?B?YnJQS3lGSTZZQ2dVcmZZN01nbkFGbWRGQStQQmZ5RnZHeHZrV3BCT0ExbHZh?=
 =?utf-8?B?Qmo1eWsxdzVUSGtRU1F5WGNEY2VyQnI0dnJ2S2g1VU1JdzAvbWFHSnVwM2lC?=
 =?utf-8?B?SVVhek5LUXc5cUh6K2VLZVI2Yi91anp4ZWdrbSt1MXl2UEpvYXdDczhSQXpM?=
 =?utf-8?B?V0NOMmR0SkREQkJVejZONGtTVUl2bWtYN2ZuejY3R2lZb0hPTzRPbGNYUDZv?=
 =?utf-8?B?NWlyazRhU21LS29sTjNna1AwQVhwR1M2Yjk1R002Qk1kK01pSktGWWVZbnM4?=
 =?utf-8?B?dS95dEdVZWMzWmtaNm51YXFEd0VkbXpYSmhWV08wcmdLdXd3ZWxqTTdscU9w?=
 =?utf-8?B?clVGYUQyL05NVU5iTjBja1ZkZ2RRb2VmN0Q3c0hkd2J2M2FOc0JiRnpuQ3hG?=
 =?utf-8?B?RnYrV2tqUnprVDhkMUwweXlBbWlhL0xyMlZHemxnVkkwc2RzK2RvT2hYZDJI?=
 =?utf-8?B?R2t3TGtBTnQyV25TaEkxR3dKcVJmL05XbWl3QitHYlc2V3NpQXBoeFpsNkFV?=
 =?utf-8?B?bmVLcGFOTXRMTVBwR1JpWEUrT2RQUGxUcVE5WkZDRFBZeEo2UVQyQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TaYZYQgDRWCM8KyL/+gtf8YyPkHp0rymVxhAS1fjircNmfP5TCn69iQNRDMQ7F50JoxJI8RyVOYwJ10cNk65fiPKLyUferBi4HvVcqAZt09/2H18AQdEs98fF8AL0MAaACAgPiiEZ5FU9N4OiFGujtH5Z4dYm+lTuSziE8B3m6ZfSBo3twiJoVSDXx+gotU6x8g9cLg1E9yf1Pe8ReauTSO4I9DzlYiKsobUT1twlyXOZs3d77Ixc0LjpMyXQkPGRzZi7u8CnPlyUdu3tjp963T7QCwIoA8T+sHFLwV/1JBS6utCOTWh093CQNFp4Y8aFUiPDMT89VpU1A214yNMoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JVCk0frnPSgYHPleZiaCJGCVPG7uPp29rS0V/pVBEmqzCfij0yunHxcm1RBxcGtwrfy8q4lqvok2vwGNiMbjh3YBdb1OpNFEKV6waBFfbW4vRPFJshl6jFpmj0S096v8T+4JAiMnJXnk0u0/iEReL3DI57uZzMLQmjjsPYIdVY+otgOzqqk/AGF9O/CGK1VnMS5VFusPUApsj9AgXi8MELkrC83yfhlSg7gFZ806fcpsJ/NSFtUVLIPGEuBOptvJRwR++dm6XAj7LkY+7W7Cf8gKFfTglfCbjaeZ79KwpkZH38hgoq0vlKQsyhzV9ogL2q4tJdpCi4xRzecXhoYDBRfucApXo+eI0C+bNZ/zf3hTci8XZfZyCVGzgBD0GXk0s+G+ofHldClmebv0f7D7xNXE32c81lWEZRe58c0XF7zlQlRuljipF2q3XVksPbjaBI7CGB1liRy4SZJJWM9SuTzOhjdOnrCV2+8vA9cvWf0NqVmFzF6906loyqe3ZCx75fKTysjiwo/LN8CfTtPQz3RoXA5AAmDXyCgBanwyJjm2VZvudZHLYTyeQ/JUPk6sjUCVUnX9900MEYZtGcKZM1gjyhxO3qmyS8OtNhOnk2T8JyrloHNMrQBuvDzrpX0F
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR02MB8991.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5395a2-9740-40e7-8807-08df08b2091c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 05:21:25.9649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmDOpwkSPhkiKaA6ZPuTOojEXm8aoo9JopK443K7CynnHwlvgQXbUXx+Sduan/7dDxnOuAwbc0RHhc8Si+yIXURGDebu5vwv35q26qL9xXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7532
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97b25d cx=c_pps
 a=2PuwDH/sRUVuuu0yG26eYQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=CtCw9qNfp4p4r1hkEF4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZKRlX5RGEBIZWAaoZdYZlE-WRZmwQKsW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0NiBTYWx0ZWRfX1gu8MqkbXciu
 ogo3CkRruYE0AF0yXW69W0PieWiGaOfwzorbS2xUgYy9t8dwAkP/BBLhYzXQsj4m3eTvA4bVmll
 wPOGJahuEFnhYbEVIMD5Ou7+34IfXeo=
X-Proofpoint-ORIG-GUID: ZKRlX5RGEBIZWAaoZdYZlE-WRZmwQKsW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0NiBTYWx0ZWRfXz5ZVyDFW0sAa
 IYHB7C2c0s5zbmwwW4zPkI96sRqbQgo09x4riP3TXMpLVIeOQCT9WbGLwTEYuXNWAmv3VHahcul
 d/RANQKSvaJfV+zk7h+1lO4bVArAKRiRzsEy/3OkBx5Q6e2aS7UDgpj9JaktQBfqeJekIIIm0ac
 OCy+muxuiYkzqnVoQOvz75zsSHalXwHkwEylgTw91+O/5dvMI4Vp0Qbz+gWmAy4e9CtO0TbUxKP
 9J7L6WJxqrQ583rd5clRiWBmQnuMy6shWC5mqKfpAadpkLEmYrGgOXykImJJrOv8sRtz1EsxVXF
 orw0TpCPU3ZKJOnczsfQTzyzu6udqMRrwaTfkg2GMHyiJ5D6o5mzrGQ8cJZ4mOYYU8hGSD4QqLQ
 FmuEVdqBLVsWjUjHINDrYxbUnwi+k8SkUQtkqi9UB7VOzmPpBPHjqls2tfkWPzRRUqookQoP4za
 hIS8YN200APAYg4/wkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020046

SGkgTmF0aGFuLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIGZvciBhcHBseWluZyB0aGUg
cGF0Y2guIEknbGwga2VlcCBhbiBleWUgb24gLW5leHQgYW5kIGZvbGxvdyB1cCBpZiBhbnkgcmVn
cmVzc2lvbnMsIGlzc3Vlcywgb3IgYWRkaXRpb25hbCBjb21tZW50cyBhcmlzZS4NCg0KVGhhbmtz
LA0KSmFpaGluZCBZYWRhdg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTmF0
aGFuIENoYW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwub3JnPiANClNlbnQ6IDAyIFNlcHRlbWJlciAy
MDI2IDA0OjQzDQpUbzoga2Vlc0BrZXJuZWwub3JnOyBKYWloaW5kIFlhZGF2IDxqYWloaW5keUBx
dGkucXVhbGNvbW0uY29tPg0KQ2M6IG5zY0BrZXJuZWwub3JnOyBsaW51eC1oYXJkZW5pbmdAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rYnVpbGRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1tb2R1bGVzQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDog
UmU6IFtQQVRDSCB2M10gc2NyaXB0cy9nY2MtcGx1Z2luczogc3VwcHJlc3MgcmVjb3JkZWQgR0ND
IHN3aXRjaGVzIGZvciBleHRtb2QgYnVpbGRzDQoNCldBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2lu
YXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5r
cyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KDQpPbiBUaHUsIDIw
IEF1ZyAyMDI2IDExOjMxOjE2ICswNTMwLCBKYWloaW5kIFlhZGF2IHdyb3RlOg0KPiBzY3JpcHRz
L2djYy1wbHVnaW5zOiBzdXBwcmVzcyByZWNvcmRlZCBHQ0Mgc3dpdGNoZXMgZm9yIGV4dG1vZCBi
dWlsZHMNCg0KQXBwbGllZCB0bw0KDQogIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2tidWlsZC9saW51eC5naXQga2J1aWxkLW5leHQtdW5zdGFibGUNCg0K
VGhhbmtzIQ0KDQpbMS8xXSBzY3JpcHRzL2djYy1wbHVnaW5zOiBzdXBwcmVzcyByZWNvcmRlZCBH
Q0Mgc3dpdGNoZXMgZm9yIGV4dG1vZCBidWlsZHMNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcva2J1aWxkL2MvNTE3OTRiMTA3ZDU0Yg0KDQpQbGVhc2UgbG9vayBvdXQgZm9yIHJlZ3Jlc3Np
b24gb3IgaXNzdWUgcmVwb3J0cyBvciBvdGhlciBmb2xsb3cgdXAgY29tbWVudHMsIGFzIHRoZXkg
bWF5IHJlc3VsdCBpbiB0aGUgcGF0Y2gvc2VyaWVzIGdldHRpbmcgZHJvcHBlZCBvciByZXZlcnRl
ZC4gUGF0Y2hlcyBhcHBsaWVkIHRvIGFuICJ1bnN0YWJsZSIgYnJhbmNoIGFyZSBhY2NlcHRlZCBw
ZW5kaW5nIHdpZGVyIHRlc3RpbmcgaW4gLW5leHQgYW5kIGFueSBwb3N0LWNvbW1pdCByZXZpZXc7
IHRoZXkgd2lsbCBnZW5lcmFsbHkgYmUgbW92ZWQgdG8gdGhlIG1haW4gYnJhbmNoIGluIGEgd2Vl
ayBpZiBubyBpc3N1ZXMgYXJlIGZvdW5kLg0KDQpCZXN0IHJlZ2FyZHMsDQotLQ0KQ2hlZXJzLA0K
TmF0aGFuDQoNCg0K
