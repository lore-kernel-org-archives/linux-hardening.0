Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A642C512;
	Wed, 12 Aug 2026 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532149; cv=fail; b=NuhiGWKBuUQNv4IZh9ya3YvARh9VO+4y5lFVccNvYb9sRNUEj3T0BFo1H76POkKkfNjH+U90ulg+mt/mBZlJ7YkR1nl5Rj/S8wIkynjCOqN3OF65OJpLgQIzDxsTYfpj/vNIc2BbMTpJUIrmESYIjaAt7CmrO5q1b8uiy3tGGyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532149; c=relaxed/simple;
	bh=f/09kKx4KNbWyvAbv0WYHFne0IzxTlQiwZgGAyNnk0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UxX/CDsR2V2qm5hgzcFE1GO/cmf7hKwnA//972CthN5+nikykfyvCzO3wuhZljryqzGjV10OLAJyTaEr1ELgW5iyqa2q5df4nWgoZflWeWaoDIFcx9672Hz+CSdn6JBZq991kDRyi3e5sOcAMRu5XiipPZI5jRdgvdpQUsMkUY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fx6anmRA; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fx6anmRA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9fstI3436321;
	Wed, 12 Aug 2026 10:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p9yN5zUQmD5K2smnV0m0CZUJS9bZvf3ivs8JBMcGk3A=; b=fx6anmRAXaONj2o5
	W0fCcJkxjTnfrWho5dEIDUQZi1lulqIRQJQUrYcIGRsikmsHfJgPBAHvYX8qTDT2
	3x1AOVlMcyekMaupM6qg5auuH+NtxEF1yTmTj1t+PB/Enoonp8RgWVwidOOq1ys4
	olcd5dsxu5A2fW2zXt/vDkolt20OrwEceVjKd77Ft8LnLx71sN0N60yx2MzDZETL
	XO/ZggZtnG22dLr02zNeUxeeXA2opGJPeIwX6hAZaq9L8pS7HaZhiiNmK58RvlNW
	qZd7LW1TnwaWBjmRauz1JcbWeROtQwNdpGzrBOpmqOEsYPBDY5H/vsQ4XppDZAyO
	1s+gfA==
Received: from dm5pr08cu004.outbound.protection.outlook.com (mail-dm5pr08cu00404.outbound.protection.outlook.com [40.93.13.100])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2sg5q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:55:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2oHkxYLbJtZPHswjoqEjxINhh7nbs1cSbsWT9jVp/4vSFuBnSX51aUD8bduz10bgbZx30EbhfsR8DlH7yH3m3qSAnD8KNkJJfx89a2DpVnTcU0Ve7gyBwtJ5uIjEBx0SR7po/waw/hLMzvzehPJUYoNeBtSDTdSJYGAvWE0YofQA0BodKVd892FCLhVg7fhvh7cwMjoj3UH83PqUraejQB1p8gh9vvo/y1jzv2TpHfxBlKh6IJHju+g44WQ4nk8EqdQ+vwW2707K8df2ZMxvneUOqTIoGDLYgeZa7us+PzhWGWzeCnKrB3pXc1f2sDteK09fqAmXpuZzvDZWuWhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9yN5zUQmD5K2smnV0m0CZUJS9bZvf3ivs8JBMcGk3A=;
 b=Ukdt2FLyy6zeDop3szMsvJqkcyGzxejNiKJtxgUPCMAF/aknyt6UUl8mvPK6f/XP5uKU+/sJBkWyxcYyAImxU0z+ACn6qsKOjzC7fgoblYGs35A1ZBP4A4No9n0wUuH/HmGZSdOKz3duNKKGgZloTx5oCoftIQwFBOoo2IqEGm99QI7a5HchUWUc5BGscEVdVr8Axnsk8n1s46it91bCaYyGHh8Gk/N6ZaXurHlEujw/rV/kjjWLmEsZph7rxMLVIPerdXjjH/vkI/b5ygnD0TRiCVcENo7VJv07d19SiE1NLkfMRhZB/tVPB8esgFtBSkTWA+2Odfw+9e3pjC9Qnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CY5PR02MB8991.namprd02.prod.outlook.com (2603:10b6:930:38::17)
 by PH0PR02MB7639.namprd02.prod.outlook.com (2603:10b6:510:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 10:55:38 +0000
Received: from CY5PR02MB8991.namprd02.prod.outlook.com
 ([fe80::6c24:88a6:606f:d52]) by CY5PR02MB8991.namprd02.prod.outlook.com
 ([fe80::6c24:88a6:606f:d52%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 10:55:38 +0000
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
CC: "kees@kernel.org" <kees@kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>,
        "gustavoars@kernel.org"
	<gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] scripts: kstack_erase: use relative stackleak plugin
 path
Thread-Topic: [PATCH 1/1] scripts: kstack_erase: use relative stackleak plugin
 path
Thread-Index:
 AQHdGCssV6LViFJIekmJ/hnsw1ANibZ5oUQAgAAqXpCAABzPcIADOoiAgA+T7ICADampoA==
Date: Wed, 12 Aug 2026 10:55:38 +0000
Message-ID:
 <CY5PR02MB89911C30B7E51FE706061818E2DC2@CY5PR02MB8991.namprd02.prod.outlook.com>
References: <20260720093545.3836066-1-jaihindy@qti.qualcomm.com>
 <20260720093545.3836066-2-jaihindy@qti.qualcomm.com>
 <20260722-ubiquitous-stork-of-hail-3ba047@l-nschier-aarch64>
 <BN0PR02MB8128563CD267288E68943157E2C12@BN0PR02MB8128.namprd02.prod.outlook.com>
 <BN0PR02MB81287EC4BD8A7C0D7E6B5E31E2C12@BN0PR02MB8128.namprd02.prod.outlook.com>
 <amPIsTxtNPhbDU-z@levanger> <20260803181217.GB1067866@ax162>
In-Reply-To: <20260803181217.GB1067866@ax162>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR02MB8991:EE_|PH0PR02MB7639:EE_
x-ms-office365-filtering-correlation-id: e0dc4318-1694-4b44-0092-08def8603e87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|6133799003|10067099003|11063799006|3023799007|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 j33TFpwEhSZftPHLJoHB+f49EdC04KYjfY5bdiCe7yUf5aMHkIGDJlZ+1xacyr/1FFxAo7p20W8Ato9ucGAr6DCiogmrQzftAGnII4SZFWRGW+K/so00bN/gG27HOuMj6XW+VbfBcPmdhtafzRC/rHyZT0Kkv92q6xAYttD2wmsJmqa9nyQuPcZCzHzD96xtSH9BkHzAuHnFC38jxZaeuIPugvWX44OelhtdUZT0zQAczwCzm92fYpZSO+lvOl/Tfj5DI0qau+ybCal1Emr3n/I//8tutkkWqE9UOaLJONewd5G55C98i1boymZwIAy6IAr3Q3sgDeFdPM9lt5wSY5o3p8kk3dLta1bI0cejTODSf4Yu2QKiaCc+HbjZ1E90VLoT0H1DJGq/8JNVgljK8CqH1wCxwHR9QmErRWI585PGeW1A/8iMq2nH6ECMVmMfKVRxc86nu/BtG8ntaPpOctcXu6qWdzmbpc6WUOcNxEfWaECqDgxZ3fvWj1vhaXJxkmi8mT/Xtl8fpZj/5+dbVUjyWoOz/sD+MMkPDLui+a1pTMEv5svTHdf78j6UE7KzCvtoaIdFAXbK+6EX6cDeDf6jMwpOIYDlV1owN0/3Nzt2ESNh3p8IJ2kW+7gnD2qLcj2SL5rzqB/1AxC8BfGc76+UIn0CPb3HBurRHYhdqqvKudJudwLFp+55tnHZQOEhIQv9VE2p3HzVoCjyVcW5soE2hYkSzafTezKXDTUIidc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR02MB8991.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(6133799003)(10067099003)(11063799006)(3023799007)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1oyl9QM+qiV4NxUqbBhafP5pSPFDPGKWPyKYe77UYkjZmU/hPxWq4GGs08n3?=
 =?us-ascii?Q?9ciTLVl4QpNLDpyCsBp3ChFxE5Rv/UTd5M3dZ60BMSx1ph2l++qPVpcObDHa?=
 =?us-ascii?Q?KMkOVeRdQpuKEcLFuxJD1WCur4+IFG78YlTQnr3XB+bWyP4Pb6y/eVWcUCZt?=
 =?us-ascii?Q?DO4Wq7UtGZIeuDEWoKPoL4D6vn2V/VNtv5QmwkDFyYJQxTFMsSDa3pGmmO0g?=
 =?us-ascii?Q?ZnrX68mfVbNpuWGr2nUokY0y4Cw/jzP+ErLVlrE0SHTiu6a6rinEF5nxhJ7B?=
 =?us-ascii?Q?+xk49I71YtnQdXAnbLpL6wrvi2B9wZ18YtMXKLpEx117Q1Xkgn5iav66w83r?=
 =?us-ascii?Q?rpRhaRBH5e22UQVP41Oyhn+gwwjP45j0S6jzmnFPz+kVXfsRVlnIS66H6sEV?=
 =?us-ascii?Q?MGbJyJ1kMjRLDpFpnQagVRZE/O041xsILgIMDR5Al5ZGLvnUtvBYskVlLaAB?=
 =?us-ascii?Q?Y3Z2Mao7pLcjZ089Ld3FlCmp2RblAlFKfR3BzM4ZY/tmTQ1GInax+Pm+ZKpU?=
 =?us-ascii?Q?riu5hEjiB2VekgMovvFi7k/+hGYfxcTgoGY55HCCd0Tn2hotINtW2SxXl5TP?=
 =?us-ascii?Q?eq5kJ52M31qJwxyD185eaFzzOLMzqndobY2/esDIGOwrnHcBQB6TwzyTtRZU?=
 =?us-ascii?Q?R7L6tfPoGUPohTu75oEemqwawsYtZBTttkpPMqvBvNSvg7BXYgQs947Lmvib?=
 =?us-ascii?Q?l2jN9ysKaQJKQ8U2suT+2Uuduv/ngueGMr13IfV5cHiqDbnOYA8Ye/wkgPo1?=
 =?us-ascii?Q?zxyzK3WVToVNKYnB5EQY99CjuG/Y3HRcWvM9X7c+fyMZZ1UMgIerzfJ+hl/p?=
 =?us-ascii?Q?0nqzP6uSGxGbMjyjcPjI9hV5WjynGH1Lm+Iy2VrI/iq2ERSdDl3ErL8egAsh?=
 =?us-ascii?Q?d/uX3Nn+Igc16eEJH6ZbTJCbfT1/lBHCQ2jFTwgQeVe7WNb7TY//AKvFKzII?=
 =?us-ascii?Q?mQUFbVWDBzfucBbRZbp+zVBRrXnpsKJwV02bQwrObOIB2A/XwPfbzV/2/LfF?=
 =?us-ascii?Q?CcnebnbYKsP7HifRmaDyyK8+TS+L3bL11bL/aaOAvbbm9Gxr4EeapWz+L5fL?=
 =?us-ascii?Q?7TEFMOZ7GlFNRsXZiCBTF9+CvL96IlvFXMzbGY/b7o19m1T3nEZ4LxHqquWa?=
 =?us-ascii?Q?SOKKfTyqdl1eRcgrskvruXWPaRE4tC/9aLzaC8bX/Bg1VggRCvRRhAUbo32Z?=
 =?us-ascii?Q?zpLjbR7Oo/oLwh9Cqdikzg6PvW4MfQ5QrM1gChMaCvv8YQYuM3TxQNTxYufR?=
 =?us-ascii?Q?n0/PwCYij9EVslOEWaOqs++ieXIKOkD1kNsgBUt+BQtXgnvWlsRL3lOYaNmX?=
 =?us-ascii?Q?Uzn2RjY0hW76FonQngIkCBGU8AuDQFEe2XTjBQQth9AWgklpXTB5Qj/MbrGh?=
 =?us-ascii?Q?21VAHd83WhxnoLiWxFz/paSQysrhcRViv/YDZg8cUH4eYKcZiZ/7zmREaRDj?=
 =?us-ascii?Q?rUh22uKLrHDZOGMA4aHIeiYlXbIvsjf7Av3OiezchcvKb4DXAB3fhZ3ddIUP?=
 =?us-ascii?Q?iKnupqJRXtThqIN06omhBE6H6+LiGQrdHME4DyzbImSLPcMTB0K1OFSUhwMa?=
 =?us-ascii?Q?hcVu0vJx/BbVX17aRY1ddJxwdS6qLZOzZNKh8iZlShkyl12NkdaRRclHCRx9?=
 =?us-ascii?Q?fscREjy2DsP6zzW9BuRY5YnXIw2yilGdDyPKjhHBAvwubhR4Qb2E4kZsiIGG?=
 =?us-ascii?Q?fhxb1yikgX7QxTmuIJ6aLv1ltPO06IWr8PyADs7c3AM3mv2N4VdXaLLZNCUI?=
 =?us-ascii?Q?OuBl2xb+fA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YgqXbDGunZqz33tm/czcHsPBDivQV2F2uZvzTtYdD4xZCb9mfK1wO1V3or3/4NSHO/kt5MlXqEyP8hfFraaqkqRFv+esqCCU43oAYxW5F5x9CZGBzfk2sUGvUk9igVSCoTgHaaVAa5VdGCcmSBzIhZo0j2vo4cAq2YO/ltzFzkH8RciMb4r90t++no+oZoSOZGTPw1iU049F5glf5uB0jQCJ5X0O2nCi3uIDdSPQnxu5yel7wJuS7Y+M+2luTxdNB5XeJ5fVHEDeq8q0TyQEP39oUKE+kdEL43Or57gGUmLRC39L84p7GOc9jryTm3f7kPcWf4wqVvKRWgvt7gXDmw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XoP2RkgJ6zeqpwUmuVr/gD+ZPVHMkoY1JXoGZl0vWDxLpslFssIqZ9HNI5I8Ywvp5ytuj0g60CPlpVXAN+j/z/uxSmpVKt37sgEOSoplQd1Fhj/gncc2yTW9NdCmWr4Sm3gQ5/3uVVO+hZohQ9aEuD96vFS07C4yA5jfwqOJB4WpSrKSSiRPaNQRlSvxxISuAsyQCuTWH4+dJVjM5L7vUcqZX91jAPGPHjH8fXJenFUN2J/4/iSk3M0cg1duntbdZ8vvEW3Y2qymoZY1KAL4GVyF0llQxc5WQVt0W4oTsuEcwUGcnb7yVeLoabSpP40yasvZB5dsF2Z17vQ+VOmfYERE4WnMtR2pLht8ggB9O8v/nD+AKuF07TXLGCUAkkFSRq/nK+iOMWoYkZP96d5HjsHa6IAaW8dYhNrb301NbY1ziM+fmQj+ROg6AAviP8Ezg5KsZv59WOARd3csHTQLfJ2+BB2QBAuoT+q3pDbLjgiG322afhjzYCZ0+WuUU/JW3WZYq3KbeKwsSPdDeRP7LeJmrrqXMhzi1WatywIM1G1fwji7txS6UBJ1A1N0+zdKD+14rBaroawlWNVb7DsG0HG1k14Kyr83jMH6r99iUwRtCkYPe9pJa6h8bVMVgWhx
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR02MB8991.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dc4318-1694-4b44-0092-08def8603e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 10:55:38.2428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDA5BA2h9N4YH1qRte6XDSM55yoShU1beK9eCaVFebnygVvw82XEw3KY+p1YNbDaAnzGXInGT6jAD3iF3dx1i91zZZoezrcv/+BpsnIl608=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7639
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c512d cx=c_pps
 a=Gc3eVlh9LBNMAeWdk3HO5w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ADYNd0_kNGylClbKgogA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: FHsVv3iN2w8sosOLxAAS-yBV771_7CbZ
X-Proofpoint-GUID: FHsVv3iN2w8sosOLxAAS-yBV771_7CbZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NyBTYWx0ZWRfX8UQp6995REJ7
 LXc1GHjOJ0q3aCJsfHAU0LTWJlXI4mEE2BjEs4QcBLJ6pvlN1KRoWqTROj8raZ1NAj/hIXLCzM7
 dOtUOAPa67faA2z9hs54h7SXKw8uduQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NyBTYWx0ZWRfX9beHMn38Htf5
 DYKfFHxN0haxaLvW9FuiIJFb3CnjruHl9uLmc9QloxbfDZYCVWcsYQkRHzBRB+kY8vxKDGr9UaI
 DioXU5jiFCPv6hlVn3nnr1sMnTD9j4KjrKStIj27tul1z+ch4tD0XGV/HtP4gMWTF8v8qsfmiBy
 4JTPL9kiQKd2P0vte84SFx+9AX2UZFT4f/vZ/mB+48Pbc2WMp/aAPUuVuVoicIjlX8EA6kU7rvS
 tDW3q1Ydp0ByHYjKjcLUtU2FwmDjixe7Ugdva7XJ9zDxj7LYhNcYJoiPI8trtYUnNrV54rajKjo
 H9fuqydXjfOFuN9WUyxouB0Eba/nFn6/iECrbW5aELSeCF/MLj4NtjKU4sHgCHtHaY2vvvy14WR
 yfQ/d8PI+kBUI41BKqyDaD3Az3fa6PTP+/kArzoU052x1m7u1WFb5Mh760LeLZfWG09m5EdE8Os
 +jEgxh5X8cV+dcE6v2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120087

Hi Nathan And Nicolas ,

Thanks for the feedback.

I took another look at this and experimented with a different approach for =
external modules:

diff --git a/scripts/Makefile.kstack_erase b/scripts/Makefile.kstack_erase
index ee7e4ef7b892..xxxxxxxxxxxx 100644
--- a/scripts/Makefile.kstack_erase
+++ b/scripts/Makefile.kstack_erase
@@ -5,6 +5,10 @@ kstack-erase-cflags-y +=3D -fplugin=3D$(objtree)/scripts/g=
cc-plugins/stackleak_plugin.so
 kstack-erase-cflags-y +=3D -fplugin-arg-stackleak_plugin-track-min-size=3D=
$(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE)
 kstack-erase-cflags-y +=3D -fplugin-arg-stackleak_plugin-arch=3D$(SRCARCH)
 kstack-erase-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) +=3D -fplugin-a=
rg-stackleak_plugin-verbose
+ifneq ($(KBUILD_EXTMOD),)
+# Avoid embedding absolute -fplugin paths into external module DWARF metad=
ata.
+kstack-erase-cflags-y +=3D -gno-record-gcc-switches
+endif
 DISABLE_KSTACK_ERASE :=3D -fplugin-arg-stackleak_plugin-disable
 endif

In my testing, this prevents the absolute stackleak plugin path specified v=
ia

    -fplugin=3D$(objtree)/scripts/gcc-plugins/stackleak_plugin.so

from being recorded in the DWARF information of out-of-tree modules, while =
avoiding the use of platform-specific utilities such as realpath/readlink -=
-relative-to.

I agree this does not solve the broader issue for all GCC plugins, but it a=
ppears to address the specific KSTACK_ERASE case that originally motivated =
the discussion.

Would this direction be more acceptable than the previous relative-path app=
roach, or would suppressing GCC switch recording for external modules be co=
nsidered undesirable from a debugging-information perspective?

Thanks,
Jaihind

-----Original Message-----
From: Nathan Chancellor <nathan@kernel.org>=20
Sent: Monday, August 3, 2026 11:42 PM
To: Nicolas Schier <nsc@kernel.org>
Cc: Jaihind Yadav <jaihindy@qti.qualcomm.com>; kees@kernel.org; linux-kbuil=
d@vger.kernel.org; linux-hardening@vger.kernel.org; gustavoars@kernel.org; =
linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] scripts: kstack_erase: use relative stackleak plug=
in path

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

On Fri, Jul 24, 2026 at 10:18:57PM +0200, Nicolas Schier wrote:
> On Wed, Jul 22, 2026 at 07:00:43PM +0000, Jaihind Yadav wrote:
> >
> > Hi Nicolas Schier,
> >
> > Thanks for the suggestion. I tested the proposed change:
> >
> > -kstack-erase-cflags-y +=3D=20
> > -fplugin=3D$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
> > +kstack-erase-cflags-y +=3D=20
> > +-fplugin=3Dscripts/gcc-plugins/stackleak_plugin.so
> >
> >
> > Unfortunately, it does not work for the out-of-tree module builds in=20
> > my environment.
>
> Thanks for checking; and yes I forgot out-of-tree modules.  When=20
> building them, Kbuild changes to their respective output directory so=20
> my suggestion had to fail for oot kmods.

Technically, this is only a problem for out of tree kernel modules, right? =
When building in-tree kernel modules, objtree is always '.', so we will nev=
er have the output directory path in the debug information (at least based =
on my brief testing).

> > Given that the proposed relative path breaks out-of-tree module=20
> > builds, could you please take a look at the patch I posted? If the=20
> > approach looks reasonable, I would appreciate your review and=20
> > consideration for merging it.
>
> I am not sure, if we can take your path, as 'readlink --relative-to'=20
> is only available in coreutils/Linux but coreutils are not a=20
> documented requirement for Linux builds (cp.=20
> Documentation/process/changes.rst),
> thus this would probably kill Linux builds on BSDs and Darwin/MacOS.
>
> But let me think about that a few days;  and perhaps someone else=20
> comes up with an idea.

Yeah, I don't really like 'realpath --relative-to' either, it feels a bit l=
ike a hack since it will only avoid including a full path if the module out=
put directory includes part of the build directory. For
example:

  O=3D/mnt/build/kernel
  MO=3D/mnt/build/extmod

$ realpath -m --relative-to /mnt/build/extmod /mnt/build/kernel ../kernel

vs.

  O=3D/home/nathan/build/kernel
  MO=3D/mnt/build/extmod

$ realpath -m --relative-to /mnt/build/extmod /home/nathan/build/kernel ../=
../../home/nathan/build/kernel

Furthermore, this patch only fixes KSTACK_ERASE but we have other GCC plugi=
ns that presumably have the same problem.

I do not have a good solution for this either but since it only affects ext=
ernal kernel modules, I am not particularly inclined to think too hard abou=
t it.

--
Cheers,
Nathan
