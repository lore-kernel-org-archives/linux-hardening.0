Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C544C662;
	Fri, 14 Aug 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696107; cv=fail; b=d99RCE+cZn7wW6g6NoZFwy2QcHo+Jvc75E7NYjEdP7OezL7iivxYLKUw6aTlY66Zl59J1YDfCE/OV6Ic7nF+5Ay9ex1TNxBjW+0KPuEWEe0XBYJxmfGv/r7kDHG8CBSoMYwfkqWRL8NSpHcILiUzTuYysDue082LfLhJydU8Sg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696107; c=relaxed/simple;
	bh=uw8fIh3E6cORyxF08V5uxkj0uFq3prwGjy+2S2O/m/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PO3usWgj2PAhaRx5KShU67YDSePdjQFMyhDRzBSJ705btWndpOC9HM9al4G+Rcakp2AIC/dJIG0RO3od+g1GEGZx3ho2kvDG6N6RI+VKTxgIDVBSlbV+dFwWJ4OQsPZU6hnCvNkodO2kbuJPbyXsKNgUHrvzCN/vhOZemZfoPWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+1ubZlD; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+1ubZlD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7ffs91100161;
	Fri, 14 Aug 2026 08:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jlEjEMja5PWsQs9oNWktHr+YDdBKN867MZl9DeJ9qfg=; b=T+1ubZlD1/b7qxVf
	5IhUuEEoZv1LR9oQO21dCzq5k5TDA84p/59p6Hun1t26KQL9WaaPIMzYDYjklXVa
	OiOcMmhqPUGMmS9TDMUhRKaWzdIi0m0jdmVnxnwg/opTSd0HVZi0+Ga8NhqRpPRO
	rQQZgpP/jRtyVcwDX0ffCQZwg7eSPcBKjykYwjfxHCuAhYUHONl+V+DL6TV/2Qkq
	/R6dfsE+Px4Ip9bADQEhnpUaxUyj8FDzlA+iwwkZvPrJZ7lQucFULPi9mZ3xK5GT
	nnHs9S6z5E83MWgLnWXX8EX5RdRttMdAChnDfgFQ3WoYqCrMe3aQ2PvDMx5AWhLX
	2cka+A==
Received: from dm5pr08cu004.outbound.protection.outlook.com (mail-dm5pr08cu00401.outbound.protection.outlook.com [40.93.13.97])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h1uuhry-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 08:28:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWtQtrHfkU8WHNuxyU10cpFtxy7H3bP9anCqHZXHBc4xDKu0n7eiA9h9MGZ+6khFlW31WQo9FX9fgg8QQmll4WSZUod3gXcp9ai8OwrQsKozJu0zWwyyAI96v9aXN4Gn81xJ6sFPtPiT/Yg0kMG87kS/cR/dRAczDbJzr1Z790BU8uSISN07//fEbDOcPptWHvrziaR718Ja3fGDYWeGztcfwX1qqWJm+C2o4gwA0b4RV0ZFB4f8dJsLSBa664hq0Yqw+V13cP6msV+XRMsGnW9jHuSXtB89P9GC7/VJDMEGkDUn1rqjKpkJkwLUHDaZ/UlrA800lxb4j4cHEHDmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlEjEMja5PWsQs9oNWktHr+YDdBKN867MZl9DeJ9qfg=;
 b=CdtweGf+qKhF6CdgEW3689Tj1R5HUrhH8tvS8KDMt0m3BeWQNRFN3pAZP2vxjJ+i7BVsMJZ4DINmyacp5S5M1V7I1HNMp/skVrsT4lenIVffNFfT1pQ7XYNHiIRfYb6/oy6LqYk7qnqexpOPTCwwJGfJJSUFbo7eOZAhWidyO1EqJZLq/vWVEO5Cre/HTdF1utX3jQT/PH/Dq702cTwm1nR/2lUhogX8ish/7q/4o9d+AxnMhxjkm/5Mwh7sYj3PgMcK5QMe2atT4PCrxT/i+Ey/BGgVUrCOwnB5o0N6a73mu9UAice7g1/A1JFR5V6oE2xBiodXaq7min5wsql69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CY5PR02MB8991.namprd02.prod.outlook.com (2603:10b6:930:38::17)
 by LV0PR02MB11159.namprd02.prod.outlook.com (2603:10b6:408:330::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 08:27:58 +0000
Received: from CY5PR02MB8991.namprd02.prod.outlook.com
 ([fe80::6c24:88a6:606f:d52]) by CY5PR02MB8991.namprd02.prod.outlook.com
 ([fe80::6c24:88a6:606f:d52%4]) with mapi id 15.21.0315.012; Fri, 14 Aug 2026
 08:27:58 +0000
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: Kees Cook <kees@kernel.org>
CC: "nathan@kernel.org" <nathan@kernel.org>,
        "nsc@kernel.org"
	<nsc@kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for
 external module builds
Thread-Topic: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for
 external module builds
Thread-Index: AQHdKv35rL7DoRisNUSDvIbYNgWT5LacL4gAgAEHwHA=
Date: Fri, 14 Aug 2026 08:27:58 +0000
Message-ID:
 <CY5PR02MB8991D4B48F9391D1849B2CFCE2DA2@CY5PR02MB8991.namprd02.prod.outlook.com>
References: <20260803181217.GB1067866@ax162>
 <20260813082949.1622045-1-jaihindy@qti.qualcomm.com>
 <202608130942.4FFA5AAB9D@keescook>
In-Reply-To: <202608130942.4FFA5AAB9D@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR02MB8991:EE_|LV0PR02MB11159:EE_
x-ms-office365-filtering-correlation-id: b406a3f0-f220-4ef1-533d-08def9ddf24a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 McwKzHiyKlb5F0+QdUs/gnJYJ/IizDivRiw1qDpHUt4v+88CdSIXaxRXUeTZ/eOmkR1xYode49XkNjYd6UmDRW53oFTiVBxV4HDrhLfo+Ufi70fEeNmLdnHXY9LV/Pf97IXqgys++kG4uMOLLv8YJu+dXTWb1T2MiVTJ5ktv85OtMT3oZChBPuzy0b1nTLmqyIdDmr6yL/JlIiKWlMaWD+8EkohovZIfKtEPLaiyhRYyhBjPgXs5IvH2ARi2qpErxBshIHDmHxYsglcI4nVc5VC9CtRBgsbwXjtfxY1Q22HmuwQKCgU3LGA1TNrkpwWcE7DqfmafhL+h7pOvEXvGiUMo+85jHFfYXlpkoJNCZykx3Uk+k0aUyZsJUVZ3ugvBLk8BMDnDPOxD7DzfDC8qpVFOLHLjhBTdhQMKAowO/26UrA41FAqvrLhbiVHEZkurglQocvKALdiX3ptwH4g6Ft/yExlatq72+Ujt3qyi+LzmpJBC05kpyfQFOPDGaO8IKgKajtsH75TwKlXshnkttR2PC6abiU2H0MT64qR+SrxMJfpmNAPShnYMUxn5prMfDdu2ZHeNrS+HFc5hToLX5xJHbhz+eUR3rdF4euMNI7Nk194x1fFtYpOOE0NCU16plY+RY2odE15mz4tMfeG+D7r0Mz7EWKOjP2F5O7Jp1ctyeKzlWpq88CQOnXdLb5XdTUmDdRV+vuhHmUSZxVQp3voDevI84/l4QASU20FpIEU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR02MB8991.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FBC5gaaUcWNOtMt4HicEF5Q73GfZgTVnn9t8dKSziRCGehP/8/VvJrSJguqb?=
 =?us-ascii?Q?hH91P/cIFpFF8X+a1R+p5mCCUNy9b3ReEn44uL0GJnv75F6316YtXIUmOnZC?=
 =?us-ascii?Q?AxD6zQyYrASS8qw7MNK181gm7V0L3Y7ar+l0allD4K8iqihEbmtLlMlwNFTg?=
 =?us-ascii?Q?I0VgXJRx6L+zSZYP5CXU10zcezCGCglBd/jHNRVESG9uOYkgf3qFxBd8OjSN?=
 =?us-ascii?Q?wBvlo2HQpFFOA0+6dAMPBY8+yRUAfxznFd1gXT+R2tT8dCza6ZltlbfUu8ql?=
 =?us-ascii?Q?qGueKCNg7Vs20QGqSqtM/ejLq12VoracPPGlWv3UGtgZ8i+EUb817Za7GrM9?=
 =?us-ascii?Q?NOZWyKwKyYwfzp3wf2b110UdMQ3euP5RbV1UtaNaBGbcTS30fejPJJM2ju+U?=
 =?us-ascii?Q?+dOk2drm+zwkLROl0afbU4C+tgXRZjS9zNe4FiSc81sX2ZwjSVfKlF4PICS/?=
 =?us-ascii?Q?dfboT8ScwT2tmoX/OXR8b0+j0fnL/7a0EvSfloteiytdTKm3ZENmLphnQP/j?=
 =?us-ascii?Q?xvp7U6jjLXZGyfN4+0+mxvvFuvKbBFpfiyGldCMRzzh8sBj3FT6elEpruvsq?=
 =?us-ascii?Q?oc7m/i2uJvzOr1jdjOjPfue+C0TODEPZ7iAwPC88ZqgE05J3H98gTBO1pMJS?=
 =?us-ascii?Q?DaQEKj7VN9hOH/sHxV3EU5Os2S/ehWYWtkje+omS4ReosOeEjw6P5PLnOx17?=
 =?us-ascii?Q?zR9zy/3Lr0l9/wHTxmw/iwswPtzNdHJUeT/wOSaYCbdVQerk6C98kIcpCJnN?=
 =?us-ascii?Q?YOYT5kEOH6nbO+AsijBSysrfCCWDTtbKbvo302wNIkkV5qPyT0K5hoBjNTII?=
 =?us-ascii?Q?jjfz5i2JfX19QwbsDsJdGk8wSNkh43GaMJxzFlUI7PeM2q3mG61WjBaj2GfK?=
 =?us-ascii?Q?xUCYv+9rJ9qhGz/rY4489pWpmNI8RQloi9UGAgh+H35ElvYDbnB3W6i7M3ME?=
 =?us-ascii?Q?MTJCaMV7RBxhnQvKymO3yzygOZimfD9sq0GO6KO5+houL/76B99xHYQE9BHI?=
 =?us-ascii?Q?wW7yAl5BRgI+jkBJ5zVk7bSSPDYkOOWllOOvPumlaHXH6Y+kTm9q4H6si8k0?=
 =?us-ascii?Q?Bt8Rnh1zA+krQjBUhewmG0GSwIUEyVAAdfLPAvLPdFEy+uRJFDs0HHkPAkes?=
 =?us-ascii?Q?23ZHYQOPHC8AWw1HaaGzst6QgYPg7VSehaom0MyOYysZaYnKB5DGU8035VYc?=
 =?us-ascii?Q?klwPwisyCc9Lcqazix4XzFgNz39wGePW5b/taU84jeSje10fN+yyiQ1MFa9m?=
 =?us-ascii?Q?tz1V78EZ+b4EndI8EB+SO0CjIHzpK/j1hTDDOwB5d33s3d4MJCM2z9QQ9OJi?=
 =?us-ascii?Q?hDnp7SIBzSUPV3+7j1E44SOr+NQs5GvfBqHiWR5z4ZG9rNG64YbjVUaA0rPm?=
 =?us-ascii?Q?ijeK8galoe2075nFDZJ2WLs+XKt+uCLrNvfyzsARyWyqFzhlCI/taWunOTK2?=
 =?us-ascii?Q?jRysOQif9N8CS1zr0B4pXNdsGwaQ9O+u93nMr92iev/Kh3miyDVZEBBE4mzD?=
 =?us-ascii?Q?4TFvLe8/shMKkqEAYLGhJyuFRh6tuGRfh/NzLn2fiXGHiOO9+myELHJ9hQcs?=
 =?us-ascii?Q?gLZ/er9oHXW8I9KuCCzHfAiBfLb7DPC6oTQts85CUmZMCBXBxFXsS/c0Sbef?=
 =?us-ascii?Q?amKewTHdKthnb/2rJa+PpTXwzKRwfWO3JVoHUavN8rvH3uEBg2mYpT7yImPS?=
 =?us-ascii?Q?wNhByrBxYmVTlnMYL5uxRkqtIvJ/1mbJjvz/P5EVeX8SGmI2PVDHXDhLhGvb?=
 =?us-ascii?Q?t/wlHY3a+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mOduYzPrr4p64yAOvltWOEj/ToZCHNyI9OoRbZrDwxZ3NOwZCAyC49FPMm8OKBBM67NJ4w1vPwyOD8Kll1E12b0qWzPQufXNBewka+6u7er3zpRF1VB6A8mvEtINqi+8sLrUEuUKoubtAL2AYBfGf+NDhM7Lz517WpLuHrSysM6Hxc6tPRgpf4xza7d1BEF4F/a315rF9caqScc2UT/sTV/pOAXmuVBjiFDTfs/015Y2i/X2iC+Wu1+7aj70eUVFi17JDxQqJV9eD0oBoETdJpiRVHnfxIe7x4mmK8/38aQqQZa0glhRhMpSQLs6GZhzEwaUQ4xKM1UUE5woPeGCtw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ur59t8/6/qKyJNIcezlFikr5pDgk+P8YegDuFW8HiOjcLCoTg32A+t8B+4GUYVRkmRLlhTpQhVuqUzN6f5WZShqTLkWUBKflvHdxox7dVt/QV00llZ5Wc3pIiZX94uQLcKgR5tJYthuPbGqOJszrHh0Y0Gj6gUXARLXXTBdkNynHZTwhkHDV/qqTI+Hs6uASueo1GxLWSuZaOfPjWSM/z/0n3M1fi/TV9n8DqECV9LXelEMXZBUVq/UPhlM0lfoG17bUDf13w1iqhysw/Q91NBN1agF/PiZN+9S5VTZSpm5l4FtiXrgj9ghv8X+aE1XasEhpsEpW3UzAIVOZ3lN3TVKoWCgxwzTJpr1mreojngrrKKNHZe4T1h0m40gsbe0SslyTKzKZM4QPGqjb05Rl7ZaRN3nPTJ2JXLvRWX60AXQsZmHo2vVOdh7yk5wj9ptODiMfiuQhnFAt8Ms2kmW4LImEKNeTvBL0787xh+fPjOjfk+QIIGPk6OLnoU3Pt+xpu5KIQuyMIfaO+1qLYrJ5MIZfIdarGI/K3+ItEmq9/QiUiqooBAshEYRvUpwHxBSZlSSC8MUhyiegRhBnprF78BeU8121cbz5H5rSww9ojQnVg21+1ugUt929GEwCKchF
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR02MB8991.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b406a3f0-f220-4ef1-533d-08def9ddf24a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 08:27:58.0895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45UcVFDBTb/mPutLcFKV+NzXcpTjfjkMS6nByhgbYYRdegT5zFZIIvEpEJivIbrkAMAiSXtj1G1LMc9Cx1P7XLZjy2Ekujhy6vZfev/7QEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11159
X-Proofpoint-GUID: AEBZg_F7RLfpzfnT99VKz3N9GMtvgOJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2NCBTYWx0ZWRfX4LaNWz1JfVdN
 12XaLx2MB/CD/LFo/sCrT0D+0ktCc7frPOLiPPdTFk/przFmSlVuNNh7QXeOh1TGKExcinLOusU
 psxzyHpWATeXh/U+x3bKq3jXRFW6ktyAhYnXC508xXaLe/l0k7NgahwKweLKtwwwFIyZG/182i2
 DYrcbBkdfsRuQm6DaZO0lPL7KcDPfRqjuMOGWggu770qjDlgF8Ua/Mqw5DyKOfIRbGZLSjFbALQ
 62WBHE6brZLlGTFhU2SioR/PGs/YQ2guvitNAOvyrVCyj7v5WIIWRqRgegLUCqdT/gPbWqVZ+3J
 e+NlLEhS/p2I4w1ETj/fzByaH97IsiTxudcSkINTvqFfkQcieNPsaaFZQSK7S2HaXPwn2PMkTla
 NTsATWt/U7UOdgiSgNKD0E84wcw/2QjCpc4pLEGOA3hWaPh1CKHRq7VhCX12KQ2iJn22xdiP/PK
 MobOHMGWolZGcnLn78Q==
X-Proofpoint-ORIG-GUID: AEBZg_F7RLfpzfnT99VKz3N9GMtvgOJs
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=6a7ed190 cx=c_pps
 a=U2xq4UXzvB7Cxu/INNVhVA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=IZvb6aa0AK5pvPtIcL0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2NCBTYWx0ZWRfX5uY+Ru85CjpX
 ggOu4j17iebdf3u8LacPZZXhkFf/HAH8JNdqMJGZmPxzE8qtIQyO0fcUcn7+CM5JrSGrFGd440h
 vQ8jo9DbdrHwKeMEvlEsEtdJNeTCKwE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140064

Hi Kees,

  That's a fair point.

  In my testing, the issue was observed specifically with the STACKLEAK
  plugin path being recorded in DWARF producer strings for KBUILD_EXTMOD
  builds via:

    -fplugin=3D$(objtree)/scripts/gcc-plugins/stackleak_plugin.so

  The motivation for this patch was to address that specific issue with
  the smallest possible change.

  I agree the same behavior may apply to other GCC plugins when their
  -fplugin arguments contain build-specific absolute paths. A more general
  solution may make sense, but I wasn't sure whether disabling recorded
  GCC switches more broadly would be desirable from a debugging
  information perspective.

  Given that, I scoped the change to the kstack_erase use case that
  originally triggered the discussion. If a broader solution is preferred,
  I'm happy to explore that direction as well.

  Nathan, does the scoped approach still look reasonable to you?
  Kees, if this scoped fix looks acceptable, could you please review it for
  merge?

  Thanks,
  Jaihind

-----Original Message-----
From: Kees Cook <kees@kernel.org>=20
Sent: Thursday, August 13, 2026 10:13 PM
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: nathan@kernel.org; nsc@kernel.org; linux-kbuild@vger.kernel.org; linux-=
hardening@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for ex=
ternal module builds

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

On Thu, Aug 13, 2026 at 01:59:49PM +0530, Jaihind Yadav wrote:
> With CONFIG_GCC_PLUGIN_STACKLEAK=3Dy, kstack erase adds:
>
>   -fplugin=3D$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
>
> For KBUILD_EXTMOD builds, recording gcc switches can embed this=20
> host/build specific plugin path into module DWARF producer strings,=20
> which trips QA checks looking for absolute path leakage.

Isn't this a problem for all Linux gcc plugins, though?

-Kees

>
> Disable gcc switch recording only for external modules by adding=20
> -gno-record-gcc-switches to kstack-erase-cflags when KBUILD_EXTMOD is set=
.
>
> This keeps stackleak plugin instrumentation enabled while avoiding=20
> leakage of host-specific paths in external module debug metadata.
>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/all/20260803181217.GB1067866@ax162/
> Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
> ---
>  scripts/Makefile.kstack_erase | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.kstack_erase=20
> b/scripts/Makefile.kstack_erase index ee7e4ef7b892..6f31a3915d24=20
> 100644
> --- a/scripts/Makefile.kstack_erase
> +++ b/scripts/Makefile.kstack_erase
> @@ -5,6 +5,7 @@ kstack-erase-cflags-y +=3D=20
> -fplugin=3D$(objtree)/scripts/gcc-plugins/stackleak_plugi
>  kstack-erase-cflags-y +=3D=20
> -fplugin-arg-stackleak_plugin-track-min-size=3D$(CONFIG_KSTACK_ERASE_TRA
> CK_MIN_SIZE)  kstack-erase-cflags-y +=3D=20
> -fplugin-arg-stackleak_plugin-arch=3D$(SRCARCH)
>  kstack-erase-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) +=3D=20
> -fplugin-arg-stackleak_plugin-verbose
> +kstack-erase-cflags-$(if $(KBUILD_EXTMOD),y) +=3D=20
> +-gno-record-gcc-switches
>  DISABLE_KSTACK_ERASE :=3D -fplugin-arg-stackleak_plugin-disable
>  endif
>
> --
> 2.43.0
>
>

--
Kees Cook
