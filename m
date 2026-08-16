Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBD189B84;
	Sun, 16 Aug 2026 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786867870; cv=fail; b=PuODSINmbS2QdjKbLisb6BCJCxbIdtXQ3HXzdlKzpJFpE32V9A/EiOt0QSzzOg996PPNedQ2w9Kzd59xpiytiyJW2bN0VfMUCPh5yFz7AFK/qN9GrKvkOkas27i6xEGarW28pJgigmWYtBfz5grhZWP1MciactUht6DIWd4qshU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786867870; c=relaxed/simple;
	bh=2P03EjtSbn09yculyIYTp3SK09nrFqoitpkfx9hq9A4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hynRqOfwzQzfI/Ut4hFapLb5Khz1fixBKZaYKaEVM4L3CupsHOA6lVmf6hp5p7luQcWEDD4o8nF8TEfVaq3368uyccZBFhN06OZ4vK47Znta41fPUYuQnqICqaI9spEtjBjx2MJ2gNrM8feecu8HOPlstcBACWg+8sStTD4kcR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWTqG+MV; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWTqG+MV"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67G72Dcs2810821;
	Sun, 16 Aug 2026 08:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iz7+1tFKHy/NoRcd7G64NWzdIrZdXAj9ft1xfk3K69I=; b=bWTqG+MVXm50JD2Y
	zi8uxykdxI6Xh9BKTngvaGkmPbBM3pImTXQ/4knG2o/Yi08Yh24Dc9orC0gxlq0M
	hRbCV+jvKoiHh1TSttZ2NSPDKkmdqWA9ox8VjT63z2DETIeEgdJfnkusfX/GEOml
	/ld8JrRweqw306uy8ameSHsdAaMm2EfPjDX0fCLNd0ZZp/KLM2qLWk8oHx1ox2AP
	uHivRgHkGshByavJppYKqGi7lHr5QZHqQhlawvWOemnHgfSVCL/8tBI1vw/wp8QK
	MzG68W6WJ9fTHZrGwaBk+pSRWYeRqU5Nf/m7j4tiuIe8s3txOYaghxlagm1hzPBe
	unVqcQ==
Received: from ds2pr08cu001.outbound.protection.outlook.com (mail-ds2pr08cu00102.outbound.protection.outlook.com [40.93.13.50])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghek40g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 16 Aug 2026 08:11:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrcSXbIkb+/vKM8HbmFom6WO1XSYDF7ekTAz7X6G/9df68DJcTDtMrfuqBlvLKUv25x4SijTIGgUPwxHKFGmtmcKTdLiasUBnc2JbfhiT0lGY8b+R9k+rCsP6434EDTZVw40D37fMBvjDoizhuVq9Z9ND6Rps3tKpOSrbRUcys6ggWHVP2GxsNEXVSS+XRGhUxFJi02/MIBEAGCP52cJiiP5q3sG3C39Ob/iy3k3kPvXc3d0oIJs32ddRGn9iUtAyZo2RzQ6t+hUfHxR2q6aE/G3Ut/uM7EcqdixDSsGiMdxqBp1t9Evby6JAz49FchAVUQGwF0PRfWCHF61e/GTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz7+1tFKHy/NoRcd7G64NWzdIrZdXAj9ft1xfk3K69I=;
 b=UkMDUyKB97GZgwzQpLJ8U52O/3o5yZBW/DBFkgGIfSg8oEPjsk1NrHoqCvujIkIDe/7HRqbSQ7oXTgKqWJOnj8+DugxdbCz8akwuP8lf6vmabH07iboy9ua8gs8kSkDu2sA4aCAUnGxXflohdFhBry3A2R47uEDN3YOKLrGDFNqbQ2jUOmUCU8gj1U0FZ6RnGdUvGe3d+jjOHrYPO368FCvkCZFRwnwXjquq6KPveXJchup+04XZpHx2LbtY6DjLtWFXHSsAIEwKzhUSN9nduRJqa0yqRPrN86u9BTIKJY4OCy1ezMkDIuFMFr5BRD0mBSIqR4gyae4jtz+oIirCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CY5PR02MB8991.namprd02.prod.outlook.com (2603:10b6:930:38::17)
 by CYYPR02MB9886.namprd02.prod.outlook.com (2603:10b6:930:c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 08:11:02 +0000
Received: from CY5PR02MB8991.namprd02.prod.outlook.com
 ([fe80::6c24:88a6:606f:d52]) by CY5PR02MB8991.namprd02.prod.outlook.com
 ([fe80::6c24:88a6:606f:d52%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 08:11:01 +0000
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
CC: Kees Cook <kees@kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>,
        "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for
 external module builds
Thread-Topic: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for
 external module builds
Thread-Index: AQHdKv35rL7DoRisNUSDvIbYNgWT5LacL4gAgAEHwHCAAKaeAIAASWwAgAIwE1A=
Date: Sun, 16 Aug 2026 08:11:01 +0000
Message-ID:
 <CY5PR02MB8991C91E71C153EEF452972FE2D82@CY5PR02MB8991.namprd02.prod.outlook.com>
References: <20260803181217.GB1067866@ax162>
 <20260813082949.1622045-1-jaihindy@qti.qualcomm.com>
 <202608130942.4FFA5AAB9D@keescook>
 <CY5PR02MB8991D4B48F9391D1849B2CFCE2DA2@CY5PR02MB8991.namprd02.prod.outlook.com>
 <an9dBpYEIb4GWhAC@levanger> <20260814224550.GA3553101@ax162>
In-Reply-To: <20260814224550.GA3553101@ax162>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR02MB8991:EE_|CYYPR02MB9886:EE_
x-ms-office365-filtering-correlation-id: e80193b5-6c7a-4857-c1fe-08defb6de8ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 QClgWqW6ojpZIdzfzIs0FElqwKBs06MvQM7rQNtWn8HIHzxhfPSBLpdNRm3unXPpa2jcwkTQgz1m1UUO8soW6P66agoSuymA5fr1fDkNeuk6Jjb41snFRrzxZgOEY5l27Ch5v80rU5ubMP1ECwHIbHFOKNNIdqFmY+BK7w2h9yv+gXXUVDZf1rx2x02yDN4hmbimkGM3O4D71/+Kxv7p+thAGiMlzDo8ZqxtorD/dTfo2azKwACV0BHqrv8LWu36nDdRXlwK4Bod7Vs1MRDDW7BEPdPcoVJgYGzavHHZ9GCLSIdDPky5PmFjlVqO9vwUekzFieFV8GFH+M7b1wwX4h5m2uJ4FOLiuyr8flA5MM6uJQmOa2kkvj3hXuKkr2NPDrwtgGYPteCsSCQocZBatUK91/Jbon6EAsHWAxXOWDGMQM0ZQgNOhdyTLVjHkjWeUSie0A8VRZzHPFobcYHIXHhjH1hRTU5AGIqzPPZTQQwcs7xdEmk2JhoIsRVt4AMY5oJvCkelnJ6H10kE2txXPFD4HPI8FckM0rlMVAC38ojeCjPWknlKpWqebPlOEFbVn/1zioCGF1wFNlqC7Jn2yaNfnEtAwLjPwUgDiEPHlzmwITf9vAy3FLJnxLkK1VR9H+VXHLokVLG70dq6LqOBy5pZtM02Nrv5TObUIZ0nNAqLx07udUb0/ZU4eBVFTLDwmwcBCiFubHdD0N2dEW9aj4aULSja3aYItQZAB8LQ2ng=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR02MB8991.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m1L+HwaqFUAUa5AAkp1Tq2KXna1VMEkdFU5EWD8N9eMru1eVcatU2R29jrJK?=
 =?us-ascii?Q?ecYjPNjWnZd3UjPE1gJ7+LoYp6ClvqWYiZNobsHJqnBk0psfKUakY08Xwdbe?=
 =?us-ascii?Q?eYkQzCTMWd891CxEtXpW3TubOWi+W10or+iAXj2mrq2SUyGexWP/enZBDBbb?=
 =?us-ascii?Q?Dov/kMaz0uqK/MDExwwWDRhq6ucCjrbMzjJZlV68KgXrWuuR8uyNXFYZCFei?=
 =?us-ascii?Q?YBrIYZh6zZav7DjulCUeXwILTIq77JtRv/n7pS6ngFlyEjqkiGJ/lMlxuwpP?=
 =?us-ascii?Q?tIKPi36mLqynl9oKUDqwCmMXGTFC3B0YY9igmM/Li1Ae5vgyRv25HP+lOfKE?=
 =?us-ascii?Q?ekINuiu/WloxXDPUyVGANHqfR50zGkZ26y9FXieaZKFOGVHcrDGj7PSnIbFr?=
 =?us-ascii?Q?ZFzmYEbihvx7fPYLG6cY+XFyOAZyBTPsvKldEACKH6PpriyBYiaCY8QvdZ8e?=
 =?us-ascii?Q?9sTtFGLl0OpP/xJP8GPQ6Of9BnUojBWsV42eyToA+4slT2lVH/XkXi1yCT9m?=
 =?us-ascii?Q?EKXlQG535+JCwFGWuaOljTKG42g79JsJmLv6y9MWZ8M6KLPnuqovJxE12sZN?=
 =?us-ascii?Q?D/AYHeAYO/jS5HNwJdtLDbVKyrjHeD23e1DV/biWy3mLYmc6EcYKsI5kbRf2?=
 =?us-ascii?Q?JMiSomc6C/53+610Ws1z6ZZlam+kN92dtOn6ZK4waoHur1Yju7PRE1oeLZ27?=
 =?us-ascii?Q?ciXMGfTNyOpK0dVnQ1xEYzmmZXFDAwcD0OVfrQf5ebQwpHiytgQFOj2na+5x?=
 =?us-ascii?Q?d5KvBb3nJ2T4fwS9HHPlAwoQKGsM6kOoDZ6ase6c+gZ71NCPRxzjhaOYVZad?=
 =?us-ascii?Q?bklWAY/ATDP+jcwhc++LYHju40d6okVjjCpISRm4pC+qQaz+9k3Fp3mjYVll?=
 =?us-ascii?Q?8UFq49dqbSsq/ZeYLYWHkSZUSr0kIqr4UVjgU95SnAB/HoVzjKp7C5bXo11f?=
 =?us-ascii?Q?dyPsXFjRbC9xeidrxr17OC36AGBawDDyseeIY5nR/GiStqhiT9Cc6/f3cH26?=
 =?us-ascii?Q?futJVaKqwkA4LcwqFIiF2ix1+EmtuQ/pvCFgVRbKLPvVaJ4PbIRD/VI5Mbq3?=
 =?us-ascii?Q?PDN5/cUVnmBkgSAJfCicBypMo4Fsu7moNYdRtsFk8dCqdgQoZI56NX7wkk9h?=
 =?us-ascii?Q?UdWHVFe7sMou36TknxjS5d8kJXMp/J6RlpY9/U2g88Smg6pbdsgdGdeVFgMN?=
 =?us-ascii?Q?uKr1PvpCdPOW7yLhL0i6DxtFJoDrXUTTikun40iKEyrAJbkhHfGChLVZV3SL?=
 =?us-ascii?Q?Z36RYqp0sZNg7niEkDsOaTJZEkJeQpxNdW13+DLu5385A1htaPqxWybL2SWv?=
 =?us-ascii?Q?MUGTekC0vmUeK5XR3nV/1H7UqlJwc3gx5x/+KyDac4/uTQ2ijpg4z+LY/xVm?=
 =?us-ascii?Q?Gf+n3RWpoPc6Cc7STDwZtrFiGe/SHx4KqZ8+s+QHW7FaH1Oc55bTVBe38/YT?=
 =?us-ascii?Q?cgyE8Heq/8ultqS2IOfK68oV4B5yNxqqmT4oJJplwQ8shDt9VpSAprTc7UxK?=
 =?us-ascii?Q?I+9hvpRJ1QgtBO9FoDGUAbghMxixVlp4nd3nuC9Nl4kS96lkQ4ZzCyQJX93G?=
 =?us-ascii?Q?YQAdgZ5Lhv3qHLzRq64TCU6vzryqnbIIUfUxOz5GgWUDgRdjZjUuMZrOp6bz?=
 =?us-ascii?Q?90EfGKTBEhFURkp2dZnLrcJ8DD3yXPTB1IRdn/EYLCOB8NYfkzBBT2j1dD41?=
 =?us-ascii?Q?SeXrHQb2D6ijq3ySjDBtq/Qr4GMw3PCfaTUSQuljlvlOYIYTKhGa/MDD7r/J?=
 =?us-ascii?Q?ig0V+yMDXg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qPnEp0UhUBjS2pOklh4ILJrNSWt9ZYC/9Q9hx+8ePVnFw8A+MoPzSGI+kS7tHbBtLRzVWmjY5bhUqrTExWxZHW0AT9rfOTyUSHz1tnX1Du3Ey7HW1rLXewLMo3rZCA+iokfcZSaiVEiJaOhFGweAT8vXalifhy4IZpWDrZaBMoeKIfgMnvp+gmnMfWqxUiSD0JdgPipIdLNKMvjmdTNdO33qZbIgI4eTpfDzDKtqMCbGDhAIKw0rGUvfl4QeyXhfV1i2QQ/L4VeFQd7VRJ3ud65ucfj7GpufDn4g3a1Ux9Wrk7XFH0VD8WdDdvxcf2h2s5b16ul3RS8tWecClxiGVg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hcu7RCpuwjdXvCcNN2KlU/zzcoWOiptHYadaaq48h1csca4/zexpyAI+Oz/IG6juj33VUbmSxT+KQbvFuqjxkkHdsP9xk8wiWjVIULP8TrhdlnFfN7UOwx0RR5DS67U5Pb4gn55sTcTK0ZUEveQzt9PoJdw3obwaURrIPcE5mGfisCbYMzDSoNEyozRxQSTKSYajuR0mcEciwSDnf7/dOSo9ZSdWZbNdMDFmHM7Tmg2W0QZXhS6zOxCEawKFTnseRx9BNBEvcAzVNso01/T2z4B0kOWsHRKfyr1rEvuKQnX0gRegzo6bzibqVdOUei8xLy/fjSFtUYLvs5ud102ScIRov6cZT7L95gCGosmotwAJpKXjkYIK9BIud0jL9Wd44QmTSVGSZXI9v6YhTaL9dL/2XJCYHhqPwmvgUTT89/QQVttFKafpVHSSx5QICq8G2ZHD6Pw6pqqvdycj1l40Q+445rU7kLsA5yL8Qnr1peaJ5g4r3zZeJdyYK5zFensO9lHvd7ES/qdEUCTQB8Hw48HnRyGOSVwz5p8iZzZSnWkqAlXAKeldh/f6LQAeRpLTpbGZ5Bmb0XWpzNphmiDSq6xqAqQVmm4jlQC1fKd8MH31vbzY9sUDIg/+KKeVbYmV
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR02MB8991.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80193b5-6c7a-4857-c1fe-08defb6de8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2026 08:11:01.0544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/jZ/lnEf/GxuPhYcx48A9olxcTz7NNFOkYBzjKUrDfb8QMW1PPx6Q8YEYMG1TxWjU5tTuDEPPsKNhKCfv8SaKHoh1+x4gInN4N/7eklhOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9886
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a817099 cx=c_pps
 a=ITiX5wGoaVWtfJBAqtKqhw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Z8vxkzJkRz7waHGfg2oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA1OCBTYWx0ZWRfX8Hs82jqRTPZa
 TGuCjdy6Aj8CxY9RtOhrXAzv6MOKmUQQ3sMnzuQ5LSdGuHM/CZforOkjaAFUTOkMQfDHGY03KGW
 nJMyEVQo9T1pqDJ0cx8sFj0n4oTp/tY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA1OCBTYWx0ZWRfXy1MMPEn/6Tk/
 6afRmiK9Bad54TfVrAUmhoSeuP+Y7pVUDl9XDCc3xGUWEJ3f9VGmp+GCtd2Px4DdHcmaeW9BILW
 ZcW4dWPIf4qHgMO1Gf8mSvbigDlZBtbZdzMk3cALWiNJ1PzJ2ZwY/5iR+J88XI5JKRuPqw76Qto
 vJIY1jJrCxY6jRp2owWHtNy1qlKow5ztxdYF9uDjPBZR1NFG2lVoV683Rxq04s3lgnv1Xc7S9u1
 OHryKOQuQiRVflD97bapzkAaBjExRSPRwfgw75vlpFlfSRWfPW883rGrQT6/Uu5k+fmy+ckoS7d
 eO3ev+aiiCiK8HtJXR+TUwULuSnVSvO+X+97cfYRKAkksMx0NbEKD8h5lXFE81IrYiXqy5nqVGO
 Qp08+7lSYwaHDa1sgznyZPEU7sy7W7L7noZdk3nNhxYTum2jbeJzfhiOVm051PVlGdf/5qAwbOn
 GwZI1LS2nI8ZaFkKp2A==
X-Proofpoint-GUID: sTOEvF7SXFz80fUQl7DApfsGGfInKdeI
X-Proofpoint-ORIG-GUID: sTOEvF7SXFz80fUQl7DApfsGGfInKdeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160058

  Hi Nicolas, Nathan, Kees,

  Thanks for the feedback.

  Would it be acceptable to handle this generically for external modules in
  top-level kbuild (`Makefile`) instead of tying it to kstack_erase? I was
  thinking about adding:

    diff --git a/Makefile b/Makefile
    @@ -1057,6 +1057,10 @@ include $(addprefix $(srctree)/, $(include-y))
     # Do not add $(call cc-option,...) below this line. When you build the=
 kernel
     # from the clean source tree, the GCC plugins do not exist at this poi=
nt.

    +ifneq ($(KBUILD_EXTMOD),)
    +KBUILD_CFLAGS +=3D -gno-record-gcc-switches
    +endif
    +
     # Add user supplied CPPFLAGS, AFLAGS, CFLAGS and RUSTFLAGS as the last=
 assignments

  This would avoid per-module changes and also avoid coupling a generic
  compiler switch-recording behavior to `CONFIG_GCC_PLUGIN_STACKLEAK`.

  If this direction looks reasonable, I can send it as an RFC patch for rev=
iew.

  Thanks,
  Jaihind

-----Original Message-----
From: Nathan Chancellor <nathan@kernel.org>=20
Sent: Saturday, August 15, 2026 4:16 AM
To: Nicolas Schier <nsc@kernel.org>
Cc: Jaihind Yadav <jaihindy@qti.qualcomm.com>; Kees Cook <kees@kernel.org>;=
 linux-kbuild@vger.kernel.org; linux-modules@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for ex=
ternal module builds

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

On Fri, Aug 14, 2026 at 08:23:02PM +0200, Nicolas Schier wrote:
> If there is a need for external kmods to to have
>
>   make modules KCFLAGS=3D-gno-record-gcc-switches

Ah yeah, I forgot about KCFLAGS for the external module build. An external =
module could also include

  ccflags-y :=3D -gno-record-gcc-switches

in its build file as well if this is a requirement of their build setup.
Perhaps we could revisit this within Kbuild if there is enough interest fro=
m various parties.

--
Cheers,
Nathan
