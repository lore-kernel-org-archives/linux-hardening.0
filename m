Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20E1DF96F;
	Fri,  6 Dec 2024 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476404; cv=fail; b=sc9WSNVVEN/6WKuoZcZpe+y4A4zdSQhC/a9NTrUmfKvjmqDfAUA2w+0XZpM5kEqNNH08KB+CCFQ7zhVyeGMIH34WVWKOXMPb5Ed/lB9QkTukxLPHgQoe5PTHEbKWJ2c3FG070cmaLWB9PKdMVMhtGdsMOupTNKpDSsMeYQuE6dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476404; c=relaxed/simple;
	bh=dFuIaxmVsFtaCPyRmwYm7f52ShhmqLXvoExWAp0fIl0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nPlMn11oe8tu7ozRy2aRz2iI0KsWGYn7dzVs0mOg7+u/icpriTwh1fq/+UqD0Mpy2WM7bTYpTcVgvCfLLmY06xNlfIOszoe7ciiiwPzhYRjnU+8M03vUTRt19OZf383KE3UW0ryiacHHC/cNx3TouDUExW1bL/MlB5S95YVUfPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hFbWsTt9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zqwIt8u9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hFbWsTt9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zqwIt8u9"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B66s2OF024211;
	Fri, 6 Dec 2024 09:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=86N5JmpLU+qcBjjJEj
	OmlfvqVstQ7eg/GZ1pnMB6lmA=; b=hFbWsTt9KYAxFbpkY1UaPsJyEtBZX+VGKX
	plTFO4jl/s0MRjYrmkdBS+DKPd0N4xT8QBzEBfHvVo0Y3FwAViebXcyUMuVqACl7
	KirWImkKIddOMH8Xrbz2+YSI8qKhZRAdN1Z2mgwFz/9O3Yc/yXzOdWxlat/nX7P1
	FX5/GH6mbBHM1R++BkDzWbw+/VO/o4kG1mbRNEvNCICGufHhnob5oo3XcAR8fBA0
	hvPMGomisyIidGqbvn1TCOi+yCZHDwZnkP+RbwA1uesKa1pBW0NvRcyLiy0/sGkF
	b8eJbfklotV41aX61VF4XxNa4AHxayd7m+xlKc/xG0djACV5x10g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4ccwnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 09:13:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B68deqV020360;
	Fri, 6 Dec 2024 09:13:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjgpeaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 09:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqnyCEzKjgSZXrMPEaP9ZUdDZ0MAnYwz0BAsoTqKi2a4T63uJHKZIoAzKTMSIOLwq5jJen+/sQbrtiPCTx03cCNCohTSACXwqElWO/RqIKZWe4y44yx3l0zrobTZVkhdDBcfYZrmceJgMvbzMBszvHt/1BuQxSWLbSkdHh/2QQOV8U2AlfHYEBOrLggXMLRoblzQegybUE5LqEV0eD+iaIO8jzPRxgSbIcEdMB6x/XvM0f52NJRiiR7ulgjlbYU07EZ6LHUiT9H6Pbko0kpsaI9R8QCmCdOGUBdo8iFwTedyEH1C02dPHNWX7XGsMh4el8ECU/tJAC6xEI1vt3KbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86N5JmpLU+qcBjjJEjOmlfvqVstQ7eg/GZ1pnMB6lmA=;
 b=wSwYm7gcLR6V+0QIpOOv8gwkfCmj4vJnxe3l+g8oPTMZjA6XaWNJovMCyTbFgzkzRTCNuE1mqQqAmcdL3ongNYGG1PzB88rNMNsRiqCluBweKzQLVTILRa11YPSBSzTRtHxQ67m81WfkRsdeamQcizPKsdgclN7bwzuzVWWerT9eMJ39U3xHtnsAJD/W7X+Lash3eoOA1oHtwae6hfK2+3vTXpWTmUrDfdTq7vNp7tYhEYw2ImzvnhRXKM1gHaUlLtJMpT6NnrPI29k/Y1Smzl5TWxV2mxVJgIHwI/Aox3UYx2UOCzOvkVwUERuDe6Utk4mDtY1gJCQL8p1PNUlO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86N5JmpLU+qcBjjJEjOmlfvqVstQ7eg/GZ1pnMB6lmA=;
 b=zqwIt8u9JuVrR9ZqmO7HP/PfKFwwgm7VpbLonUjDexnJpLRs80ACmkC/lWF3GKq4CrSiyrbAa0blFaWVSLxjadRY0DTb6Rzd2JGBzyzJdMAjNDq+/z3AdS0E0ZMXuPnDVoy3Q+vkmuhUWlTcSiOPxyoWwDA6n7F60N2AkeXWgZ8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BN0PR10MB4968.namprd10.prod.outlook.com (2603:10b6:408:12c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 09:13:04 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 09:13:04 +0000
Date: Fri, 6 Dec 2024 09:12:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org,
        akpm@linux-foundation.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org,
        pedro.falcato@gmail.com, rdunlap@infradead.org
Subject: Re: [PATCH v1] mseal: move can_do_mseal to mseal.c
Message-ID: <d710d812-3dc0-406f-ac47-a782673d3d07@lucifer.local>
References: <20241206013934.2782793-1-jeffxu@google.com>
 <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
X-ClientProxiedBy: LO4P123CA0649.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BN0PR10MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: a613421e-792a-464c-3f08-08dd15d63074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4I4vexmw8+Yp9FX2Kv7O5A0Mwa30Vp5D9/7AxU1vrMxb8IVvxcufCd0nZgpk?=
 =?us-ascii?Q?nj7MaHm3tDKdk6ixsOZwK37c1G7mEyWj2iY5hW5nk3wVewssolMo5hsN9cxG?=
 =?us-ascii?Q?XEldXq560xEcCRcnN4ruKLwpdYeFeYuAG0ZS82mviDNU5WCpGDU0STv1OfkY?=
 =?us-ascii?Q?g/gvt4g1Z972QbxVCIZTs4gaH3YD1c/7zr08UhZNOEJvC2th+iBKsRHRG1iN?=
 =?us-ascii?Q?5d0phb4NAPHYvof1IiEO4AG2bsOTdTdO4VwcTpof3CqRvQsT0m0n2W/VBVEH?=
 =?us-ascii?Q?zpypidZ6ZbAZa5pCWrqWnmEcSCuDsqXMOYkQDeBKqpf8NEqZh6l3m6nyFLtF?=
 =?us-ascii?Q?Dre7K7Qd25gmbNri9guVCdpwuqjXmxJnRMAVpO9ul7QzrrhKoxdDUdW8MgNo?=
 =?us-ascii?Q?YbSgqZWZL3sJgRC9a7l1yjcwpCC5LgUEXblNxhXkFrp3B+ZNqVMwpei++eid?=
 =?us-ascii?Q?9RHZ+hNafTfiR1NHQ/hfyajXE9DQd4+IEkgdEgFIRibmmX8HoSYcvpZB9n7H?=
 =?us-ascii?Q?LN2jP5UiUSedbb+LewXiyxYR5wPNZPGtW0Qgq97LY+iBANe1vpAni1Fg/pF+?=
 =?us-ascii?Q?k0pRV7FNSAQaA3AAzGEIdzilGkYYNXaSnyZveWB6oIq0NS/8bUROafihdt9J?=
 =?us-ascii?Q?rCC4c6CAnggG/B136SIu2GyFdwyoup1Ge6fGpRHFzPGiDiok7iAeJqIbIPv1?=
 =?us-ascii?Q?6RClxoMzYPkpPmsU0BWEWkM7svxQLhZPx+8MlSBbfAeYRD0C/XIBdZ6qQeWh?=
 =?us-ascii?Q?EO5p3WxfMpdNvtw+flx9yPt3rcPPBRaFFY1ZEr52a+GBDLV44LWhAjWy2Z9T?=
 =?us-ascii?Q?AhOTt+HMPxPVR77c4YWiOQqY7qAA6d8tX85+UaBmF3JwmIbJrapBh7wynzn+?=
 =?us-ascii?Q?Q+FEFBK6FHAUg6EGmRbPk1XaDvfv4A2MbWtyjixguvuQnCddrQ5dzd64lpR2?=
 =?us-ascii?Q?KCerSbIdBtnhMyixtGg9U3Y4aTve9IOKU5u/Xx/meQt23iln7fEqcE0j8auE?=
 =?us-ascii?Q?g2XXURVVEHIUooLi6oNfmWdbT2VkEpcoKqgi1kEaALSWqiY0LFWT0ZExVhM/?=
 =?us-ascii?Q?7xEj9piyWj41SjN2xtbCXEAxCUsLX+3USuWsSTXVEqCmwmysBBA9XQ9s8vO+?=
 =?us-ascii?Q?GCvcHc/cxYu45G4yLxs5zJWd+bt2kA0L7wzF6Yi/leZkaeyEfm4PEoWSzdsE?=
 =?us-ascii?Q?1OXbLa1pH7bo2JJtf8g3tsODvsL3iL8d+TtD8u4ZHUp5Ey0tS/WenSgKo7Dz?=
 =?us-ascii?Q?IAVgVh5uYO+H8Cibips9GlAP4t4+vXvUtUlnkelHRHkhamBWb2A7E1CMSFdY?=
 =?us-ascii?Q?T5iOO569lzq8/7UV2qBxoA9j7kWZIHG5WXTUftoMsbuKKkfYg6jOujWkAbds?=
 =?us-ascii?Q?howT1Xbrr4pj8oII7ASTU+Jagp5D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ssz2G9gCydB0WRKOf7qRxxT+X/rvvNH9EqEFFSL5sGvhD14TMEDI/bYPCbEX?=
 =?us-ascii?Q?JzhzY7irs6Xj7nYOzkZjmqrPXvybVqfrBhuvK8z1rUYeioKUkFbfiJ+g/eY4?=
 =?us-ascii?Q?KNGrf+QGwee1jgkyLVi3hxsOiCBNxw/poXWnxxF/K9xAPyHweR+h6+fXNMcp?=
 =?us-ascii?Q?wqkE7mq/IYl9sleovrjP9dMs6277lW3xxdrNwp/MvWqy5exG+huA1KD3J6GV?=
 =?us-ascii?Q?TolvBU/mn8sbm2Y91PNXjVwg5suk8N/3S+iU/E1ulPYVoVua+VhJ/herR1LU?=
 =?us-ascii?Q?TnNj2wRYhwi4t+oFgoRuiFUFXjvCyaaTIr7AS8I3qUsQszkT5sH7ye7nrlnb?=
 =?us-ascii?Q?IusUsz66Nb4ArOMFGqb4GggMrvFz/4HKYzQicmnpVO0gtOIAGy5CiGNXPf1H?=
 =?us-ascii?Q?GwR5Qm4VJZ/RwURgr5VDQciuqPAIBNzcJXBYJG5J+J1AbxgnmT2IcSRzFBML?=
 =?us-ascii?Q?HrjMgvcTRpR4euI0c2jrxqb9ISSY39Mh2w2vetmsKmiaoS/LgApc0U2tnpve?=
 =?us-ascii?Q?CaqKGzV/2AbaC5lN9qRs4vYfaK1QakpbKnqhEuhf4W3pFNToJyYbaG3rNRod?=
 =?us-ascii?Q?zpGQCTYw5e+ZVGmGBRrSPXHOyslWOC2u1ORjYU0rR6TrU0ju8V7QPZSm+0mM?=
 =?us-ascii?Q?w3McwiwCPdXMfhOC+Tb6WLW/PzhN2loJlQIh/orAtf4Tq8JO5jxLnl5bqOjC?=
 =?us-ascii?Q?pq9TBI79SVG0/nIwm19ypUJIE/rCU6l62gasMEFnKSCvxoTIca4Fx1oQat11?=
 =?us-ascii?Q?S+wmhy+oolNkX38G1CtL7tJ+RLdJDne31/QGViTUs1n5xsHJn4y4/VqEjez1?=
 =?us-ascii?Q?dzEkTzdHhCkGdWMYPqhozy9p00D68C2NvG6axc06cU5dKVCCspyk5OJjO6+g?=
 =?us-ascii?Q?5amfA8RzbLBtHo8sw3M2hDUiHPEV+w5u4R1sU5WiQ9F+fCHbTcTY/4+lYSjL?=
 =?us-ascii?Q?kF6cL/7NbfYYHdIRQjC3Tx4R3KCLkcGNgduSuxYlZHBJN18iYab+1GQa0quj?=
 =?us-ascii?Q?ZgnnCzMuN6VX3058eTtTPNVyfa46uOQAjj9Y1weFJxqvuWeOQ6ttJ2hqkWYB?=
 =?us-ascii?Q?FGZ28ymBtpkAhAjw5QLSgCc7/eaTsrdlsU5owjk3TXEDlB4b5p0zq115heUB?=
 =?us-ascii?Q?gM8AJmsD6XPsQUdrcBjHk5R3B0Tqs213LkOs2RQo3mJU3o2EqawuxrBR8cnm?=
 =?us-ascii?Q?sT2Yco3MT9w2/iL8fizJOxZZu5smc9PXTCWksS/zpSqJM+B9aCZzjmr9qJHm?=
 =?us-ascii?Q?nbBWMiW7MJTnTEZJepkEcei3/pFg8EqGQ66ng00VkJ3k7x5/B0rbUXiRQCAJ?=
 =?us-ascii?Q?S44ljufU3acO8G9+jTPhY87ywqFd1Fmi0nDFsCvbgLTnqI6Rp3Wfef368ITY?=
 =?us-ascii?Q?bf6eHEggsIav4fAWcc30tTRRLGlIyRTDaWfEFk8/0z/TvIlBAaeR4SRGiXKh?=
 =?us-ascii?Q?t8lqAgpNxZmTZDUi3cJvsTBsc2vJe5CvL99y65aXjslGhHOJMvrLKodskaGC?=
 =?us-ascii?Q?uIYlvYSCjUTFdow3mOJmBWpy8aPaRkM9zmMxYTO9gmemTc/IcHEPgt/gaZpn?=
 =?us-ascii?Q?EurEHzUuDXUpkh8pSnEmEX7IHpbnybIyyNE+x8g1FhBIHo9CIwY2/xShVro4?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ColAjeJGgl24pIy2k/rGDC6wQ1lqlLk+ZBP05dHHlAqm5f9eJxVT3Pawvk+efBvnImSCaTdq+JF1R8QVsy0htInXoWFw6xaMlKSAtH/klJM8Xq1sM/DXpaYoHs9tZVJ4qdWuUBVB0D6rlDxq55EWBVlxTn5MjeSg4xKI06V0uYgdefgo0BfFR1Fv64zXtIOSdlqMwyHkjq1gCIfiD1TZmomFECzVJ+gA9zDl5xBTR2FMECEJxnqY08Knukj14Pcnva1Bn9i+pwPfRkIxHw7D4hnnEcutEQHh0ZKs18L7s86jT1XvXXqlif3bBDjkmQKtIsXCmJSnMoh1Gq17/kuTW1z/YTlXGEsyNGsbCdH3ynFJUC0wroTRrrpubmy8gNfWdH6T8cpWOLz7mZMnGBikQtcMPuDPeIAyWsJs8Uux6jDcwgSDhSTa4rn08p3uQnfEiUpXT5IQBFKomn404JQ894SVJta0S8kA982VVcFEvDrjuwjOPFBNKwyHb9Y/vwj9v3jQxLOwbU8cXolD8oHyJ4hJRJN2cSJ/mKpTlqG9SxCUaTjp9wFbPGrje97e0E1fIE8IjCGQ06go2xJ3qM9mYxbn4BNZgArqomTtGLrdfUc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a613421e-792a-464c-3f08-08dd15d63074
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:13:04.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mC0E3E01biZtvN1k69+43PBAqAGWgt2f4MYS6EhCVwwbE3TXY3X/Kp7BGub+NKbbSyZ+BWYfYAQq8qpvo4RiFhDYTtWV9T6cjRGlsex7tiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_04,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060066
X-Proofpoint-ORIG-GUID: x9l9v247iv9A4wcEXnURKPdMU9YojK-J
X-Proofpoint-GUID: x9l9v247iv9A4wcEXnURKPdMU9YojK-J

On Thu, Dec 05, 2024 at 11:25:43PM -0500, Liam R. Howlett wrote:
> * jeffxu@chromium.org <jeffxu@chromium.org> [241205 20:39]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > No code logic change.
> >
> > can_do_mseal is called exclusively by mseal.c,
> > and mseal.c is compiled only when CONFIG_64BIT flag is
> > set in makefile. Therefore, it is unnecessary to have
> > 32 bit stub function in the header file.
>
> There is no reason to keep this function at all; it is used in one
> place, and that place uses three lines of code as well.
>
> In fact, having it separate from the comment about flags being reserved
> makes the function very puzzling.

I entirely agree. Jeff - please just make this inline to do_mseal():

	...

	/* Flags are reserved. */
	if (flags)
		retrun -EINVAL;

	...

If you do that then cool I'm happy for this patch to be taken.

An aside - I actually think we need to move the bulk of this code to
mm/vma.c - it makes absolutely no sense to keep the internals in this file,
and that way we can userland test mseal functionality.

I may submit a patch to this effect at some point.

Thanks, Lorenzo

>
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  mm/internal.h | 16 ----------------
> >  mm/mseal.c    |  8 ++++++++
> >  2 files changed, 8 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 74dc1c48fa31..5e4ef5ce9c0a 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1457,22 +1457,6 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
> >  unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
> >  			  int priority);
> >
> > -#ifdef CONFIG_64BIT
> > -static inline int can_do_mseal(unsigned long flags)
> > -{
> > -	if (flags)
> > -		return -EINVAL;
> > -
> > -	return 0;
> > -}
> > -
> > -#else
> > -static inline int can_do_mseal(unsigned long flags)
> > -{
> > -	return -EPERM;
> > -}
> > -#endif
> > -
> >  #ifdef CONFIG_SHRINKER_DEBUG
> >  static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
> >  			struct shrinker *shrinker, const char *fmt, va_list ap)
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index 81d6e980e8a9..e167220a0bf0 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -158,6 +158,14 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
> >  	return 0;
> >  }
> >
> > +static inline int can_do_mseal(unsigned long flags)

It makes no sense for this to be inline.

> > +{
> > +	if (flags)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * mseal(2) seals the VM's meta data from
> >   * selected syscalls.
> > --
> > 2.47.0.338.g60cca15819-goog
> >
