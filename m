Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE652A95C;
	Wed,  5 Mar 2025 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195900; cv=fail; b=ZuPHP5rCjT1mXvoVnB5sWZfamFLv7Xy7WUeU1ZrsElwi7A76OQwvkCfRFuRcEIgzkpkAHqyk3cwee7Ljq4raAS7GFS6Idh9+IcIam7r5ZJG4/yPUG/n1oQ0X8WhfV2xetMt1f1SEtSym+5ZcBYr1adtS3b+ClwLTX9f7eZHdC2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195900; c=relaxed/simple;
	bh=e9JGj6L/rLdPeSIDU07D2axYDG2ns0Ox3hRmX1V9xVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H6rCiYNG37Lbnzr2+HjMxHX+Nhw0wzTKPmGCwdAilA81iq0XoH2ogpzGLXzcXiu4QN+KI1u6wQrQqe41aRpePF9qvd8NDZn/62h+nHEB6oAUJzk1C4ONHTIo1hGaG1yvdS8YGC7WWC0iQ6KBBMaGe4BFwK/creikHKgOOKNr5oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DixyTixQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yNPw93XP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DixyTixQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yNPw93XP"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525HBhHe029976;
	Wed, 5 Mar 2025 17:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pfQzGp/FvibNktuBVPWa2ZEwowBelvlnuRedANc0KQo=; b=
	DixyTixQaIi4k6HnQ44JRy1PnDBj6IV5QJQ6Z8AXf/y5BawrFnc6yy5LEOh/LMIc
	QXNcw6ze0TyzZnDl+d65647w6/lPvo4HCo42zOf7Id+ubIW+is8+WimMqrpxkZ4O
	+CgUUJUW0xfCT0yQ4/eE/b3p8hR9rQlpb/VW15n4bo3QjtrgqqieOiV9UFMMu3TM
	Hg/wudbUxNzGfQ7Sif2X1pYzLUEsQN0u46qCAuq/ySyX9+yNVg2UnxJOnDhv4nxk
	qnrO1IvCWTW2MSkna1hhwl4yjUG5aHQ3eFW0jc4LajhlymXh4TXPryKC3o2B7r31
	z9ZSKgH4mBBk4SA6kG3Qdw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub7865e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 17:31:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525HBWPN015695;
	Wed, 5 Mar 2025 17:31:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbw6gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 17:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKu5iYznF117PtBnj1A5cWw0sHIHWul0sxLy7/XoWyMfyaD2+WAEMc+CteNnjPm2FIybQ3a2fC24idlfUL9/hYQP8peAIJ/kev3XAWqSDgIbjRjACA7gO3tLgZZ2S7XcEi5AqJCgycBp7uehw5K8ylgqGLzrjydlANYCq3ajE/kJ26SNvtB/wccwo4h4JWom3YgUOKDzz3wUGKG61I+zpZ9aKi92vMHOh8CJUqyNqJmbQSPK+JjEWIEYjtpOOsmse8i4ueTPC4ePcKlUtKWc7ZuDQTj0/8MbOLA2CiXwEk3xGSbRxJ4o6E0kuLE+AM7g5L/BysBVhnquvEv+z4ABWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfQzGp/FvibNktuBVPWa2ZEwowBelvlnuRedANc0KQo=;
 b=dULbl2hUmxxvyjPZMRIiND+TfwiJzsPPNknvDQEAcfYZdOVfRaL/hWMDu0bHxlVin86dURcyJI9OCHG1CHnOrWB2vS0pwJYO77Zf7g+PvGIE9LISR3TNzXWLPustfvJsQKz2tG3Kp6TZfBoxLU8h3sM9nmIbWe4uq9XRAC43RjuM2I8W/15aBRkEca8r8hDERfy+HnKfSo5yySU+tMr1WxBeOaE1tJiIPICoS0cpdMPNJQXqPNCEZnncD0Khrty5O9shEmkudKjmqIzff5R2DXCBHMCrOp1YcGLeU7K80fRLEh3iStytriV/wG6GIOjA3s23hHRTRzfKmi3gDXBjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfQzGp/FvibNktuBVPWa2ZEwowBelvlnuRedANc0KQo=;
 b=yNPw93XPhut6nsYANGHeLqkDj+icgaTdoCTg61XS5fmVsiCNj5cgla8i95fs/u8H4JT1L2p6oJEvDj1Pz7+BaxD2nAWlNKMCCbDLeRQQsNindrlNIjFwIckSSIhfLCcHD2qV+gA/7jmOV+mZX+uEcIw3pBr/x54uiOkgyvC2MUw=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by BY5PR10MB4241.namprd10.prod.outlook.com (2603:10b6:a03:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 17:31:13 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47%2]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 17:31:13 +0000
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
Thread-Index: AQHbjYsYPGK9C1ZxfkmpQuuab7QOErNkzaIA
Date: Wed, 5 Mar 2025 17:31:13 +0000
Message-ID: <65DBE926-C9B0-4394-ACD8-D3C71AABD064@oracle.com>
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
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|BY5PR10MB4241:EE_
x-ms-office365-filtering-correlation-id: a5a1d457-06c1-405a-5e35-08dd5c0b86d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5560A9pwtgKc0pRBvS9EkDP6AcyIv7vRzgBBbS0OMH0iufMMrcVUNk+XYL6k?=
 =?us-ascii?Q?xLaQJ3wgbucPHVIp9/QhdYFtkYjYxkNnMytkbzkqf9dM0O28S6P1G1NbeCNt?=
 =?us-ascii?Q?LnazIXxdv+KUqj4cNnHCf5PX3ox/IsdvZDUKDLUSg+S2+/rL8elMaTgDZr42?=
 =?us-ascii?Q?GkQaH6GZ7tUQ1nBAtnivK5xn2FusnVPbH/eROLcQGzZ+c9QSd7yh79ap3h7+?=
 =?us-ascii?Q?0o2czWMJNIqXNqYsPWBMXJKkQwnoljoE7f3cSZZHsB/y7+dQn/T9aClQPalP?=
 =?us-ascii?Q?3X6G0397B2gYvSfyPjrrYcQfG6dcp5026tXe90ux7nI/G9mxhwBMjzf6XaLy?=
 =?us-ascii?Q?pJ7WDWhMObhBrunVeuh8kWz2t9S/m1E5hGQBPZzcoUK6tRInSYggOkKa3Og8?=
 =?us-ascii?Q?V2zCBCrULnrAtF6ga2cBJBD9lJTh7z2Sckwik0s6kvakdnTgiKjeii2DrXw+?=
 =?us-ascii?Q?ZmGnO8nNXX1/3QJXmP0HrRlFPP2F0hCLYlhHYkEJwCo+xfo1zd15Vsd7O2Pm?=
 =?us-ascii?Q?6Fjz/d9Us/QAzDLO6R8JpMKbMCkXBqmpBZPd+blEcviZ0zIqYjsc1DtUTgqF?=
 =?us-ascii?Q?Ry5qD2fAELEuDk8TRTJPS5OQT+3L/6d2LHQsVvw09y1LLsauim5p7bM6IM/g?=
 =?us-ascii?Q?CpANSckR/HmHEhN96y8BTNx2BPo2F8UvAFU7etr83S0j6ZK2q1T0mS+HYX9i?=
 =?us-ascii?Q?B6yVXChyNgIzLNg6l0z0tRfzp0a9FVwiW1OVw3zvkXJAyWIdZF0JJoOUeDCn?=
 =?us-ascii?Q?fzyIqKRFPvaSGNL2ouzrDq6YxIlPF+DqrodqE2M27dN6CjwCw8uKE2SBA2tF?=
 =?us-ascii?Q?xso3ZxYfiPU7CurvqmpPRjQUM4+y6dmlgJJtqOD9XFDJh7GNK66q6QghID7w?=
 =?us-ascii?Q?+/oPoDcEZrhVdl93l/VyvmxmNnOoEYm8/Zb5R31dwZ6tQjwwNkYcNVZdk3gg?=
 =?us-ascii?Q?9A7/dAwo1rvW94aWIm9ShQse64Np326yIFXD0IreJesqRHmKcDxDaqTt5amd?=
 =?us-ascii?Q?8wNlC54NdCckHG37MlEfIZMmoHH3A6MExnzQEzuICjOBnTs1mVEYxJ5WPXWU?=
 =?us-ascii?Q?1In209IMoSLJzPn2LB0XTeec/hXjyqB/FgN2KF9d8tP/2AMmxPHFjCbVppB1?=
 =?us-ascii?Q?ieQM4OsyqU6a2RI4SH5bfA1YKhDRQM2XtjZPuNnBldreMBDv1dNqGCjdJB0B?=
 =?us-ascii?Q?A3Vp9KWXzNOs39gA3wvNZ92K3eXAY76Fl3zdf/rx/OKXrRNLAB2rWTGb0BCk?=
 =?us-ascii?Q?JulW8PrNdvqAhRkSYoY7s4woCThzsnnTlzbEhhVXCGIHBFTUygMejr1CD7vG?=
 =?us-ascii?Q?fYquHqVyQLnkuhY7jQePZfl2eJu9+vD1X4POibhPYyO4gfhkk3xthsz/s29W?=
 =?us-ascii?Q?CURdjRxaRNf2GHRtToLIWfdQuIbThNyimig7e/3aajyp5ewxOsL85DcQ/IqS?=
 =?us-ascii?Q?f7Ce76RkjA0XOccY+BrFo/g+Yu7QftGw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/Pp5mMvwmDe5N4+lFHQdptNLGK8bgBQgkvzeVXtAKBW8O0mep9PMWi00svdV?=
 =?us-ascii?Q?UNWe5rVLZg6m9a9n2nMbMkozsgHVHHMf8QS/xg81OAXIjUinsnw0m6ysTt2b?=
 =?us-ascii?Q?JmETXz4Oz+7CN3l43JjTcMYrhSMZ+d410EsJglvg21P+Ne7Wrts9ypJyb4al?=
 =?us-ascii?Q?+rg5muOKKnK95kofQu3afY1SuP/H/A0TUw7WrWEtblDJqbRJF7R84idMl62R?=
 =?us-ascii?Q?avDihvBtXcA6SAUGPsks/dXmYmgc78tYzyNp21H+42uGkFdDIvFRHwr1OSky?=
 =?us-ascii?Q?FbWVmMjd6Bef/gJoSz4Pc6r0hI5vZFHWZ0qBg6hMP8K6HxGzQWc1JSb60JpM?=
 =?us-ascii?Q?SzAiFkyfQ9QvaZEZDC06F8ERFBqdXDwo2bsHZrqp218I4JVP8rhN4HiWqTtX?=
 =?us-ascii?Q?SlI+Miv39w5/165qLIkFzqtNMlLkmIIJ0z+3ggH1tLE1GRhvM/LORO4jDQao?=
 =?us-ascii?Q?aRRXT3mohWgmaLGYaiIF5w18Mvpq5cu1D9OkaLjXxErcCP0q/2aW0WUzLmHS?=
 =?us-ascii?Q?n08OH8uPs/SfwyOSq4nd78fbALfVrUW0FMlgwiBooUb3dYa2cmQGjfPjp7E3?=
 =?us-ascii?Q?Fj3sRjyshzmdIkT/K1vGKSasrYctox7PeupYrqN2bk9kPFL4lF4kvDz5ItMN?=
 =?us-ascii?Q?pkxXC8WgD+C7X0lNKJiYfRHiNhw+tD7hkzloLs3jXmccNVHPGSl7ubAifmip?=
 =?us-ascii?Q?LVwO22mkvj931Z8rOUsRugOFwOoedVD04b8aV0OAK+H3bvSBoeq+DBU32b5i?=
 =?us-ascii?Q?lmHthEEhUktnq2NqwomdAr59foaOCne+MdKx0HXlfaL1kr9bQgWaTbo88zn6?=
 =?us-ascii?Q?fLiRCYzXdmmam3js4DEeeSN0/+HeFZWEgJ64fZyalJtNPYnTeHA354Ecmkrx?=
 =?us-ascii?Q?jFClRa9p+oqyhLgpm6TyN0Z9hniP/iqrApTTHPJ5qEhc1RBooX9RByw74LLL?=
 =?us-ascii?Q?Kjy9yz3Of9LIQSfRIvUekwSsSy0fEcv5FDuqqUbh3a8l4FYPbIoTRps0SKOz?=
 =?us-ascii?Q?DS2K/Rni+Aew3fCJcf1W54gl2ZVgo1ZXbI3ujV/0mrcjU8xPk3h46ljjWxCC?=
 =?us-ascii?Q?/4ibScHPdX66UuKJaS3ff1CC4Oy4c+CdyJ+HkIKCnvwlHOqz1Gs3R8myyh/v?=
 =?us-ascii?Q?oP9tsGpHf8s697ma+V3bP1sNe1i0MHD69DxunoV1xMKcJGaT9KzesqI+rYh7?=
 =?us-ascii?Q?p3ZA+zp9AH+hduJ32oyhhTiVshsIeQ7B/Dh1LoimlqacM7VTq6VlalXNFs0V?=
 =?us-ascii?Q?lgiQxi158RBJqGG/OnfqwWngy1zEUst+QpBOls9sG4Cams8QSYWDsPovrpI8?=
 =?us-ascii?Q?/HYfSNPd5TvjX87PHN8zKJoeisDkYcaPBHzruaXCdQZVsL6NfIeayAgBY+mN?=
 =?us-ascii?Q?byRleyKA4S0k1+Jk9erzyblsHZtiu8IaM6QUQzQqYQ21E3e7OR2bXFpW7BTs?=
 =?us-ascii?Q?RnCrDeVzpOL+K+Jng0c5yqa/198FY76taw1wjW32/oVn5HyS3bz39fX5UPw5?=
 =?us-ascii?Q?IDatQB/Mvbet0y2FFy/HE/lC+dU0Lk8xABCZu/m7bBjPTHPFxwVt1cm8t2eu?=
 =?us-ascii?Q?4yOiwN4+4DLCjYyl2sG5HWxegLBPFfLV4wB8FPcn?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8898CFD68137B4B9FB843C254636611@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I7eozTDZXrZ3j1eJmc5eGEiNATFDTjcLEkBMe+AdwW1cj0l0uHEviGj7EpZOw+2p5sAlq6P4JRzwNIu3lWFu15HnfBuwG+hRXkQQmUhxEDoUKZaGsaO9WownBjs8MZ8Xv4RckQSrK3mnEWHjBwAYoo7LUB0/OAEeoUgaWH5mHnygKCoORDfb8jhoagyYPDMtHLLQy4qCi2dAT8Olnw5IND2wErPf4vGf+MY/qkNqoTRzPbrdZQ0to6+0KslrKNaXuka6AO8zLhQb7d5/F/SOsFaPjyzIqvMA49xt2dTRYAVyGV7H42lDVGxc6g0qvd0RB/gkCEyRB9NleWn2UUXFEemal4aV3gol8t8GI7zY0sFTpxMtguqD9dXCTOfprFc1h9t5JcXMA+2pRS0e4H7dQDT0yqbg+kTfxzfzS+aYQRdJqFPt4xvhGjHHX5tVgqiylBu/Ft+MzQRLUwdvXX8pEeFPBGzekxrOia8L8k/u8LuS7bxx8HgBvljU8XzCTy0Z7cn70k5TYwwzziJn8iWUcfdc9koWxm1TGKeJmoUIsp1sqNKJJxNG/cDJ14EDkNQPd0nhMAS7NV1ACz2mEsGIrOMLMHoas11B1CYQoBckXZI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a1d457-06c1-405a-5e35-08dd5c0b86d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 17:31:13.2633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70Q+NLio+BIRkO47jRel14KiSi6w4gdpHT7vnkCqv7Oei1kRjMAR00rmZ28o0mic5wHr88XhD+N5nCX+eqjUfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=801 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050134
X-Proofpoint-GUID: xUuOZd_qisd1FMNaQvbCL0HLbZG7v4JF
X-Proofpoint-ORIG-GUID: xUuOZd_qisd1FMNaQvbCL0HLbZG7v4JF



> On Mar 4, 2025, at 23:57, Kees Cook <kees@kernel.org> wrote:
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

