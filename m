Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B419ADBF;
	Wed,  5 Mar 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195938; cv=fail; b=A7gPVVn+ajxPuO6ytk6t6L6U3hL8j+bn2Js/QQEV5YwxV2woXY352PLTJmj8XkIiGHXr3t/UOZXvMZ0POlwl1DGSM+a51nxysguWx2ArvS+ct1Ly0QTCl/wxJaAWjSVSbxvT+CsrxNWnrJk7v8y+VVIegw2D1KAcMEOD/QrIdAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195938; c=relaxed/simple;
	bh=fRFQWRkR0umbWq+t3D6EJBltQu5uNtw0jLt0u6AVWMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=phBjEWzRMQYj3rcTKjGEbY2oFXwp9iITjgBQK4s4xdFsPfn/IfenhRSOr4MYTHLl0Cyq1fSOrwWIaJFdn1hryM75ccDrrKOpg1pgWFHYBTm3zC3Gyp0yPVRURmXJcyvQqRmSLq8/Iz5ZPvYsdcWEQq2lzCo343+WwXiWdJc7/84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h3swScws; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AyJgB7q2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h3swScws";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AyJgB7q2"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525HBfgh019919;
	Wed, 5 Mar 2025 17:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Vn2oLrrzeJwh09YDN0QZYuA3dunYMjo5Hzv1eBssr7Q=; b=
	h3swScwsTwA6VzCO+V0t+opaJ+A8UH8FY0Js+O7LBNuVEYpzXOk/yY8EDZuvqqT+
	3L1DV39P7rQH5GVsEZEuMY3QJiR2kAu0juUuZ5lJxUlYVk8TVrgUUS2ZO48TQSd+
	1VI+UBWnkgiCkMU5FvhAZOFxEuP5umhaBS8F+AfEy18cvgzuqFKxksmHpgJVWPPh
	zkUSHN+kz7P7t1cR+y7AhvuZn7HA+QEzZnH5HDSkAQoUfVWRFlL/qwoVroY3cTe9
	xxlFa0olUgTQT/UG3EswrSXpqou+hBuook+/TpwWgihqZ31B3R88OhOh4Rpq+v8h
	Xg4PGzxrcaagT0ei4Wlzyg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wr3p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 17:32:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525HQTaN040389;
	Wed, 5 Mar 2025 17:32:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpgykd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 17:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQPL4Xy1cGvLajPnXVfuS27vzaSvR+QzWYjqVlpBXZlc+V0nqP7v0NTXlqzrGIM8QR25XXVAIsrzixs5+A3kxVJhxtNIkiczRKTf15WOFTFXcEhsTo/C/2i0yYGVfAtbl6RvDoBfN7gcNQstkExFgrKncJpHQUje5LweC0ueWbOxApjC0ATztbrrm0cHcOPf3kiK/8ypGXU4GFiBZnQM0hg3gFYldJD8gqq959HFwVQNuleIQckZ1FkM/lhtTbJU2PO9lDTOaZ/6pWl2SQLA4wwVr/hbI1fwR28sPrq2cwCeJVGfQLBz/UpfRVoeSBAiDg5qUqwTmIqvEMNteDCuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn2oLrrzeJwh09YDN0QZYuA3dunYMjo5Hzv1eBssr7Q=;
 b=gP/pkUQIXn3w8ZDMgW+mwd0GJ5yAvxFm3IuMU8g9SSt0RK7W9/dCYA7yfoosDoK6Fma6u8X+pyct0oUDOLbRYqkOJHnDmsIZftvRYOnvBh5iYbZo8LKAPBzm+nJy0j5P5chtKOxmJkWpKRO5V5X0SMFWPSLPNh9t1wWfa/jwGq+Xs60FsBIJzauEvqZI2eeCFHSN68le02glIVRVuxSbvdOA+lNTzpK6CYAKzyiPhjg3FRJ4N+hzhgU4Kl81fjVPmkXeXPGJT9yly5t7CZpby8u9wUW32krolPNsZlcenOQTWQmUcsahzwJK5wnTY0ji+ibGLCF69wALg8slUsZe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn2oLrrzeJwh09YDN0QZYuA3dunYMjo5Hzv1eBssr7Q=;
 b=AyJgB7q2OKBne8ReMSPJmSarHaqWAY1f2bG86+LBDiG3oxbOx7EWyXX9Xguu58ApW66/C4t6uhhXc7PGlZfzo+ykL+c+xcxhmat9jtVNRQIPLUNzB05BVSnN72VNx9t+iLaiET6uTewKwLv1oFpU3aZvqmIk0pUA7Qc37SV3jkg=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by SN7PR10MB6978.namprd10.prod.outlook.com (2603:10b6:806:34d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 17:31:57 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47%2]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 17:31:57 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Kees Cook <kees@kernel.org>
CC: Thorsten Blum <thorsten.blum@linux.dev>, Bill Wendling <morbo@google.com>,
        Peter Rosin <peda@axentia.se>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
Thread-Topic: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
Thread-Index: AQHbjYsYPGK9C1ZxfkmpQuuab7QOErNkzdqA
Date: Wed, 5 Mar 2025 17:31:57 +0000
Message-ID: <20C5E493-4FB3-4347-844B-1AFE6B9FCDA4@oracle.com>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
 <202503031040.223DEF2781@keescook>
 <20A47316-D274-45DD-BA15-F66139654D44@linux.dev>
 <202503041935.AE2093CFFA@keescook>
In-Reply-To: <202503041935.AE2093CFFA@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|SN7PR10MB6978:EE_
x-ms-office365-filtering-correlation-id: 948ce914-9ff2-4cd5-2587-08dd5c0ba130
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?er3QLHTlpFwP67hQ8IZjmZRvPDw6fkxVhLY4wHPIz5f4qVvOA9YIwDWht9U+?=
 =?us-ascii?Q?eBZ7VkjfwOTllydaoG1t737XLiVPQHIK357OCPFxkKDFZeEjAR/ZQdvSb2Z3?=
 =?us-ascii?Q?dellrSHUJosgwhhvFGitTNzFNobeg3YohXF8FRhDWU1AbhPTlC/gERiLigqu?=
 =?us-ascii?Q?Td4hrgJloAgvA+7N9c6EdYS5wr/NY7IoIg/i4gDIwDwyW4Mvf6Jd0S+bSLlF?=
 =?us-ascii?Q?Dd0xSxg4PzskHuPn9DZzracLM0GM5DIPqW0HLhaThSjYeLVEQ6wOnv5nRHk7?=
 =?us-ascii?Q?On4gc/fGgskH4+xoPokoJ3DJV6ahNa6RKGg4TxhCvDJnE0aelnD0Rl5AUlvJ?=
 =?us-ascii?Q?04PSKq/EIJz1sSlhbFELjk/1x3yUEX88ewZ/ZdjaxXZIoaV53R5+lLeSs8Zt?=
 =?us-ascii?Q?KphBUrN/CcP4SUbbcgZOIah+gBVmWFWX9a49SKCT/6XO8uHgSjZ0r15UlCev?=
 =?us-ascii?Q?hhd+VKVpp4blWVXdIymgWLseP5OSyPkusRjI4G0tr2LJUxVozC836e/dkOiZ?=
 =?us-ascii?Q?w2z7/ZzPwzOf+m2wC36MYRbQKifp1oLjPNQSb9jTzEfD2EKlcMQPgLDjy6bY?=
 =?us-ascii?Q?0lUSPYuXcOHmBz5SrZ9HZnTJ6pJtKjTQ7lWW/14M2UV4ASUZg7dJBpGLPUmP?=
 =?us-ascii?Q?Wlqi6syxMnU6pQTAcvSGWTKNPzw+swiLVH41P2yv3tOFlA5fpd84au2Rr2zL?=
 =?us-ascii?Q?edDRSC4/RiEZtz7n2rRGP6RNE8czLTNxrwGa+doWRzTv0nO7qJFTqlrU0ruo?=
 =?us-ascii?Q?+1JZPAhXHNOb1qeUawOIPD4A+HhQDZhYpXZ418M3ghOGnV43phZSlQwyCsTF?=
 =?us-ascii?Q?V1RO/7MXTscTuNJMAP9kfSzGs0/sOEktW5KPm3A4zo/O8PZ8lLdUJ869sO3y?=
 =?us-ascii?Q?6ccwnSgxSbYXLAzVOhX5aRjK4Le+Ev73+ygl6MisIaeVVnPCJFyXkKU0T8H6?=
 =?us-ascii?Q?AIOMNhjMA3h0r5Xkzk0xymzmCRxGtaIlQAtw1Ru24gRH8TGsjdGFgwDYXVp5?=
 =?us-ascii?Q?7g5vnxepWDqch1GpaVBUtoc7szs4xB0XziPu89L8crdJvoug1qwZFp8NsCX5?=
 =?us-ascii?Q?0Fd+DpnKNm3dOJ0f9xmBHcNW8idfinek8dxewOKeilaY5s/A3TgU+Mtmk9OP?=
 =?us-ascii?Q?XTSH6TDGr+uM+tyZOFLlTYG2c7wssSU0fV0AjIWo3ZVaq3R5Lr+k/WaLeaG3?=
 =?us-ascii?Q?O+gYUxDZqGM42idxzldSWCV5+rq9Ya1HT80Jqw7llv10E66S6j3vOfd3BmaL?=
 =?us-ascii?Q?qA7XCLQoZS2L8fJz98faJlOYsdEf1VLar0TSJTZylkRF2l/fUG4t09ywqvzV?=
 =?us-ascii?Q?kk6+g1GCC3Ssz+Aw6f3zsaPYDsRLYAVpSmpwGjhGN0GbG5lVxUDnAN/98f0g?=
 =?us-ascii?Q?NVb4gzKCx+mzN6qET3+6dViSaArFIHO1J3D57DYHKFf1TRXCmQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1V7H9HEYQQvNZFWz7ED3owmOvgAd9dF16R27+XoS4GtxCgQMaLfvpHEOao+j?=
 =?us-ascii?Q?krZ2TEjnXQU5W+DuSS6C8easP07rysH8WayloGwEz7tJLZ1RVEgUQhLqMg39?=
 =?us-ascii?Q?bEwer5u5WfzgBb3yutvshjrH2iVLgajy2HDKD9qVC2URcB9EnXrwAsRJnhEe?=
 =?us-ascii?Q?JjVrRGgEQUwoA9k4ZAKaZFIoHX+jr4gRiU1nRLwzVl/DOlrUsafcDhHsYR4S?=
 =?us-ascii?Q?Ii/z5lD62QSMUc/SXEgMhyABnzBQ/OCbNOugWOgi1ax09THKsXWDmWIIyQ3B?=
 =?us-ascii?Q?hs+/VQiJIyRK0UU8EIBBwyoEgkA7iyrhhabwGDljlHVwceJEhM4wVbv8Fdul?=
 =?us-ascii?Q?yREAI5AlIssyXnbnadnGBYS1jS7Un0oDZcrnLoa7GbYUNDJupTFh0pqZcYkw?=
 =?us-ascii?Q?bWdRG6aTOIlYmmZiK6mXYp8fzPpLZhkkPrEo5ZGcEkCDVSRA86O+CzxzJHAh?=
 =?us-ascii?Q?MyNzf6WjdrezKSBIhbNJdwVvoFXKLRtbSmL/9QTHiQww8DOKA9MrN3AbCByt?=
 =?us-ascii?Q?dCBKCAX3/itHG29IeWArypfUK+1oXF31auiMkZzFRcj5GfBDKDUcZVFFHT76?=
 =?us-ascii?Q?vdo6t4JpQJJ4xCz8aszzJmDbSBLQtlhd70TP+mob2HmQMf/S1QpvxEBcycA5?=
 =?us-ascii?Q?Rk1lhorMWne2bFM76Sq1rYsjp1upXVnvTKcJxP7zHJkUIuoKtm/t83pZPxDP?=
 =?us-ascii?Q?S4PiEZQs1U8va3F2iTLH3hsNfLfePi1Lect3dN6Eimjjbi6CS64DxLf5NZ1u?=
 =?us-ascii?Q?idFNkva2pmCbBf2v0e0gnz/wkSaUJXzh7midFeF8LaeIDS+22L14XReijyb7?=
 =?us-ascii?Q?kNQbJPDdlDfZqYz5RnXZwLO9e6F3MkxMQ/DqEzlo0yEZstbz7GiboKHlUFvI?=
 =?us-ascii?Q?l1WZj30hPwkGvv/nQnvCQkty3pUxRz6hj41U13qmo2sssUAK0GNvjjHXLrVJ?=
 =?us-ascii?Q?acIDNND89dps4njk4wy71oHMe8eZCR3TgJjNhaBZ/cKTQ+60GE7JszEtPJGd?=
 =?us-ascii?Q?QJAQDhM5X99Sa4i1NSIBVjB90ZWr0jXTrlUdaxlOHu2NuajtCxobdQoEYTnl?=
 =?us-ascii?Q?PCCTtRCeuNChwsQ42tolzNL3IYz10DuB/746IWwJizlVZVWoC/xHZE0Ywbkz?=
 =?us-ascii?Q?IKi67G7hRcbSpUVWSFPoUUJJ3ib5Z54F13fNUBU0G5Ytjq6xCqeIx9+/qfdf?=
 =?us-ascii?Q?8SYi9yIAYa0GoYJKlrkGkte3WzIg0DsbmqWn2yzU+7RVAU1lN3nMnNFF6vI7?=
 =?us-ascii?Q?MYCC4ro+/cpnMqAwlLVM+Mkib/3zKVw7NH52xVAEoAsx4Xr6pL87zFwCMfOl?=
 =?us-ascii?Q?Oe/L285RsctaSZSzwu42jm3Ya8FMdkuLOL3CXwXLrjj0hZSFL1rw1qRN1W50?=
 =?us-ascii?Q?/bZmHs49Gw2vycR9d3NWQlcYxDDrI7n3AsI+PEaaYmDDOyky1znYNoqJsw/8?=
 =?us-ascii?Q?5AKyxpsKBAPI3RfkiYQ68Zx40ipRTOkryECQl2isOGY12yJMk3AjkTLZTITV?=
 =?us-ascii?Q?trY9MG4n647NchLDKv9K8N3+mKCpPkRY2UxuEo++0hprkdpVCoDWWISrms/O?=
 =?us-ascii?Q?FTtMCxv6zH4HD44bnQcsiC5a4EXk8b8iPeUIPW0O?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C32BDCDE00AFED429005E620531329F2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6ChoCou93n9efu7sTVUSNBZmT2SgadqNYw0FBE9oN/a5qrThxFdHiCbs41jKKeCCfR8TcXfmbCDe3YyHgk3XlQip0ffSjZi2kRLTZmtrsHmyOh2RROX8sBmjFNGkvRBfnRMxxEWkBENE78uuRbmJqoNHjcG8dtcuK5z4FNbdw/kdG6nAsexisnDfPVqgSBb//m4lHOJcT36lgeMprJuKO0/HEtq/Y/cQSWskCUubW26ZYMaDiUHHm5x4mfbPY08peNb7W0JxjgYqGF61qL9jposzK5zRdTY0whvclyyDRKph8m57UM//bSSp8VCwlNVUtjPWTsENK85krXI7oW49Cu/MQXx0iVoqI2rABbj369r18Ux5vTehWhfjAoGfRyemVjXey/s+h5b5GIv0B4OChcynCyG0cy3p1CTa2p9/EABw9YIczKFI7n8jWncutTI6S7tR9PH+pYhiQFLkByiEv2nfHsD7XuJEV5P/rWRvcPKjJiJVIUzJo210iQRr8xW2tRQwgyGamYsQP9RATT1S6QDpqG/UE5pTYUEW7/lP5+/b97d1SsXWE23Fv+J5jjZprTwb9PgNP5DTJSVJDT1B7QcKqnn3VTI93fJV1dfp4g0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948ce914-9ff2-4cd5-2587-08dd5c0ba130
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 17:31:57.4644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Igg3SCze4p5nB3xfXnWstXVRfyt4vlgb2nZUGWeKHlxIuYCX2J34JMvnu7BqediUK/8IwS9b0VL63M0UN9kCsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050134
X-Proofpoint-ORIG-GUID: 3XlOYZkWtFivDsPf_IU4jD3Kf3VIKRMc
X-Proofpoint-GUID: 3XlOYZkWtFivDsPf_IU4jD3Kf3VIKRMc



> On Mar 4, 2025, at 23:57, Kees Cook <kees@kernel.org> wrote:
>=20
> On Tue, Mar 04, 2025 at 09:58:21AM +0100, Thorsten Blum wrote:
>> On 3. Mar 2025, at 19:44, Kees Cook wrote:
>>> On Mon, Mar 03, 2025 at 12:02:22AM +0100, Thorsten Blum wrote:
>>>> Convert mux_control_ops to a flexible array member at the end of the
>>>> mux_chip struct and add the __counted_by() compiler attribute to
>>>> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>>>> CONFIG_FORTIFY_SOURCE.
>>>>=20
>>>> Use struct_size() to calculate the number of bytes to allocate for a n=
ew
>>>> mux chip and to remove the following Coccinelle/coccicheck warning:
>>>>=20
>>>> WARNING: Use struct_size
>>>>=20
>>>> Use size_add() to safely add any extra bytes.
>>>>=20
>>>> Compile-tested only.
>>>=20
>>> I believe this will fail at runtime. Note that sizeof_priv follows the
>>> allocation, so at the very least, you'd need to update:
>>>=20
>>> static inline void *mux_chip_priv(struct mux_chip *mux_chip)
>>> {
>>>      return &mux_chip->mux[mux_chip->controllers];
>>> }
>>>=20
>>> to not use the mux array itself as a location reference because it will
>>> be seen as out of bounds.
>>=20
>> Getting the address doesn't fail at runtime, does it? For this example
>> it works, but maybe I'm missing some compiler flag?
>>=20
>> https://godbolt.org/z/qTEdqn9WW
>=20
> Uhn. I can't explain that. :( We've seen this calculation get tripped
> in the real world, though:
>=20
> https://git.kernel.org/linus/a26a5107bc52
>=20
> But yeah, when I build local test cases, grabbing an integral trips it,
> but taking an address does not, as your godbolt shows. This makes no
> sense to me at all.
>=20
> Here's my version, doing a direct comparison of int to *(int *) ...
> https://godbolt.org/z/e1bKGz739
>=20
> #include <stdlib.h>
> #include <stdio.h>
>=20
> struct foo {
>    int count;
>    int array[] __attribute__((__counted_by__(count)));
> };
>=20
> int main(int argc, char *argv[]) {
>    int num_elems =3D 2 + argc;
>=20
>    struct foo *p =3D malloc(sizeof(*p) + num_elems * sizeof(*p->array) + =
sizeof(int));
>    p->count =3D num_elems;
>=20
>    // this correctly trips sanitizer:
>    int val =3D p->array[num_elems];
>    printf("%d\n", val);
>=20
>    // this does not?!
>    int *valp =3D &p->array[num_elems];
>    printf("%p %d\n", valp, *valp);
>=20
>    return 0;
> }
>=20
> Qing and Bill, are you able to explain this? If I set p->count =3D 0, 1, =
or
> 2, this trips. Is this somehow an off-by-one error in both GCC and Clang?

This does look like a bug in the compiler, could you please file a bug agai=
nst GCC on this?

thanks.

Qing
>=20
> --=20
> Kees Cook

