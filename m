Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F041241CB6;
	Thu, 27 Nov 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764261460; cv=fail; b=N4t88x8HJF88w7oSnywF8z3V4llR6F0lLGFSHqucI4XfKZiijlLXfE9AoBttoPh2VyzShF5CtDPJPhuJ2LEO3v+uhTabXubR08vfaRwG6VFQqb2OXcgJQggakmqkWcEqoGrp5RfGOO/fsBQ2ixZdmZwGL62e3gSFwyzS0W9xZr4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764261460; c=relaxed/simple;
	bh=BWF04+m+B+9FiKOp2weFSzMRdE6/856z4tSB/4PoM/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JT5Lgt3tVShgJaaBDJn1h85l+UjdOtLw0Tz6c+SsxamrRy2TKadu59nUEVZBuBcCZ8/CkOzVMNEN3hV+WfDSSSgFfn1KWuaAh4DP8YGkqNu8lyTILsKBE7aZ96PbZ+d5yB1O6Slt1zsdYFLPvOPfrD+3p59NBr8eoWQgkNGonho=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oWsQXkWt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oWsQXkWt; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oWsQXkWt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oWsQXkWt"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Y4IJqCgrrJs8Xu4xOSVUROvY0veDjGZHt0/9pyWfdOp6g8l5tUdpGLxlBH7Jwc34IoNDA6vFhowRuAOeMTRf+Ylv+VYg1/MOJpXRy82MchdnxMTT+brsBSaPWAmGKSa+Kouve4ERX2oHhyUwbtTAyY3aISLXlNifP2g7SBgY3K2h9iUnhFsFWzQhxTwgjs+RqiHzHBTg4nR1ajnBoyrd1j7hQCucL/TA/FsWBhNbhpXN1wf58ZIT+pNX1SbG3YCExVvo/+SOPsK5fztZZqf0q2WiI0egyzLgdYXwO/ze65ImjXkHxxHZu+tQW7wT7+J7b3ouE4mJz/6vPFZFFKbwqA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0hPHDioKwazoXmVRGlSo1iLnF4UgDDj53+LGL7tjrY=;
 b=M+8O8Kc5k01f/1fr2vBq+XDHt3nBkXR940v3V8G8PQ2LaAxRBSQuUNJJZI/ZwL0SUXDS1cZZAi7DdH3AXm95SSzjriIZEnMbRbxSKS/uZ3xFJgBwJcQMto5+7lK7JCmN7BJEJlESrGWBEKAX5NSQgXPFwzEqR6NtfrZecdh0VVnbaB+U/A9D1QsZM482/nG9Pfzx0+339Ltb/7279DxJM0XuxJf48JApIQVHvg5smcO/NKLTjKRtbqXRremFe5lwgcd8FoENoZhXJhxoPEkusL4WAT4aI2PARwNzrTYhKJShIh28+gq6PVfI9dUaOvgcAuRnkDwTWmKSHZe7M/4I4w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0hPHDioKwazoXmVRGlSo1iLnF4UgDDj53+LGL7tjrY=;
 b=oWsQXkWtXFrv0RgIdy4tLC+X+j21NHWJIWH3zLY65ZEuuaiTBiavJSL6ai2QOvbgE8LqDCesUv1sz/glGoPeEeR+b+4MDICzwZGry0/lH1DxShsyZdYof3Re1zQ48+6Yq/ZkZ0VMw7qHmTm6L87eKvIunV26fmuo946zH0HoGcQ=
Received: from DUZPR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::9) by GV2PR08MB9880.eurprd08.prod.outlook.com
 (2603:10a6:150:de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 16:37:27 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::4b) by DUZPR01CA0005.outlook.office365.com
 (2603:10a6:10:3c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 16:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7 via
 Frontend Transport; Thu, 27 Nov 2025 16:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHd6IB2Ie7DYzqNUprDp87bnJsLNJ8fm5TEAGkqUUeEAeLmGrzD4uJ7SyGCH7ZC9y6IBuT5djBfEGpmdd1/FXfIV3NxMzPlYlOCr/7tQ3yT+Sd8sIQ7vHKExl5Eg5WtgAeWVMng3jFhUXIDwt488a/PUVj0DsGjkV1lRss6EDtC4Y39vbbXCdLhOIP/jM9We6+eY73OD0/tvcHgDp+q/JFJy1wnCu6MlbbEMPIov/oDogJOOec00qDYiDDLMjvJ3snP84u3wsLfgcXZnLoYTZGU9tEUKLONqFd3rQn723Sc1HAdJw+42olX99rcY2jliLmDpmd4IdfX2GzZm/IniCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0hPHDioKwazoXmVRGlSo1iLnF4UgDDj53+LGL7tjrY=;
 b=erYq9CJZ9omp5cFs9k2aak4YU3nkLjGaKRSMLgfaueSC76hKUOTPr/2Wep1wmbAo/5Cx8uhf9potvfPyqQdoYEtP1NrfYLkdGPHaE5Nj7vD07H8cfMYWh3NZeret5JSgNIeiaVs9G2IoJNiRhwBOB36OOkDLhSdnvnApiCxdHt/ZQyJi7odbl3hQXM7etODaOurit+Gq1Jbwg20oc/oB7nt/J86NQKOR3XWhHZTwVG0CC1IMhIec3CyaYqpt6W5RiYWqez7LDEZ0kP6w1T09OcsEr3y9OXmT4D6LAC9/XF7Pqp572hb0gaTllRjgNqx/i7n+iR8kyqCykFHZpxi+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0hPHDioKwazoXmVRGlSo1iLnF4UgDDj53+LGL7tjrY=;
 b=oWsQXkWtXFrv0RgIdy4tLC+X+j21NHWJIWH3zLY65ZEuuaiTBiavJSL6ai2QOvbgE8LqDCesUv1sz/glGoPeEeR+b+4MDICzwZGry0/lH1DxShsyZdYof3Re1zQ48+6Yq/ZkZ0VMw7qHmTm6L87eKvIunV26fmuo946zH0HoGcQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA6PR08MB10545.eurprd08.prod.outlook.com
 (2603:10a6:102:3d3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 16:36:54 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 16:36:54 +0000
Date: Thu, 27 Nov 2025 16:36:50 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Howells <dhowells@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	x86@kernel.org
Subject: Re: [RFC PATCH v2 3/8] slab: Introduce SLAB_SET_PKEY
Message-ID: <aSh+Ip1XJQ2mMH6q@e129823.arm.com>
References: <20250815090000.2182450-1-kevin.brodsky@arm.com>
 <20250815090000.2182450-4-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815090000.2182450-4-kevin.brodsky@arm.com>
X-ClientProxiedBy: LO4P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PA6PR08MB10545:EE_|DU6PEPF0000A7DD:EE_|GV2PR08MB9880:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f50d5c-9a6b-4fb6-a110-08de2dd33fe0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?2A/hZcowbZDNy9KeVvdpo/K+dm2MQFbB/9hEOaTvcs++nHZD0CjissxlqUMb?=
 =?us-ascii?Q?YB01zxPiUnHi4kT8aT1q0/C1R5Rm5GrCwoopKnXXuLV6sfbyWn40Gbdxbz2L?=
 =?us-ascii?Q?hWPKi1HqwbjAszRIT4dyjcmn2cky+72KavHnxSvCUh1K00em3hBeiEsitGm2?=
 =?us-ascii?Q?ItuO/5Al6KRdhBFu6y7ILhu3scFebId8BeD91j3KE4KCjwF60l3Zn+tPC1BQ?=
 =?us-ascii?Q?ipiEW09wOYZaBWvcBjeCfsa687pCIgow2XIIMdh64BLc7ecfj2WoEeO1By9w?=
 =?us-ascii?Q?6maa3ZmEM4HyDZtc2QHPGE8Ssd9qEX+fpotBbhUJKmCctMaHnqTYiF5Pnjgq?=
 =?us-ascii?Q?Ng3UqEtei9EbW8l4KcSr4aTztoCGI+Z8x6CbSCwdcmLcL0WkUu+8pYSDsc7/?=
 =?us-ascii?Q?YzrbzEdO1LwqpHaUtpD2Qo7mnFCFVW5aXXNGxqHomZ+JmPL/ymDTDcYZjDzG?=
 =?us-ascii?Q?QiZppgPHzz2TvNZNpg5ybmWzNQjfz0mQZjMA5ucHkZXxgjGrn0U96JLUJBrg?=
 =?us-ascii?Q?zz76jlHk6M7zPpQUfbSWdX/lvrr16KvKqhy+lmUTmIvMrsYGs4t2o7rhtDEf?=
 =?us-ascii?Q?YOd7xmi3tiSYd1wGZWwTBnV/YCpUqlRl23zkIFqhcfH1UmwzPJlm8JehXUkh?=
 =?us-ascii?Q?o8VI5RtgR7SfpR1Nybkj5bCzojyCBcYP+MFTL00G5sPzOknDKpU6BuT7P0lT?=
 =?us-ascii?Q?XuwppphDfhsGYyTWpupJuC1xQLK3SrhNQ94rXpmSsER7uJ4aZ7bSFw5epiK4?=
 =?us-ascii?Q?IZlA0LxfCBqtUvuBkEVfuoIkcgyzr9+HV0ZDCBZGjqz8jCGJTOxm1AFNaLFt?=
 =?us-ascii?Q?gcga4YjfdbLxK/5ZuFY1jcAVQCrP9e+W/Y9ZzJn/I5OP0NI4x5f8hw3xTWPn?=
 =?us-ascii?Q?pKd6n0YAsyT4hGoXZjqpcvKZCad2sOtIBJ3W/VySvha2A7mJ/KjXLkdHHRAS?=
 =?us-ascii?Q?/LlfqApNAgt4A+7YAb0J1z94l/imN+7qBWps8RU7+Chk5QESrjg+8O8MhdVJ?=
 =?us-ascii?Q?IQIw+v5081VdDBOx6bpOqIJ9pILdM6x+tA/lsCwoFThUkDIYfhW890JE6EzV?=
 =?us-ascii?Q?yVoT3OeAn7mh+KPSK28axQjO2S9SCYKzCF8efGcJuEJp0r4QXSFAdSA5lGlK?=
 =?us-ascii?Q?5iDF8rdOgmQDGyPY4v8vAxRzhldND4eHb6zz2UZ4EwVyWpIUyLYH9b/UbrrK?=
 =?us-ascii?Q?QqEtxOJF4h3nnWVDOeZtft0AdCMnu92ADHX5yiUpKius3lcWLdGT/70KrDwj?=
 =?us-ascii?Q?p9m7SFvaKYdUXdTBYZTMMYDRlQD3cTwVPVRbmFOhADdl5mwAswhY3/+MiR6r?=
 =?us-ascii?Q?osipxuqaoMCR5jRoPWCzcOY+jhGdR2JkavssyvjhAQgV+AZEJuUD1eVkVVFM?=
 =?us-ascii?Q?x0kBSnfHZBtyM5Yq5I96dOj0/eOfHWVB2tpQIs788glukNlZtsgmEXoMmCUE?=
 =?us-ascii?Q?/BgAp2wc7IpJ6la5s8xR7ehTtoovVtSu?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10545
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1a3f1404-f240-4e50-96c4-08de2dd32c40
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|35042699022|14060799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkWDSyKghZHsjVNAC3NFtzXxgLKtK74M9w6jDAiwNa/P+5jgGsF+fx9zBBIg?=
 =?us-ascii?Q?4UcsIn2bTGtl5zOMaqX7mYYUdzxT29via7mCKZHUB+nffNMGG45Ci5H4J27r?=
 =?us-ascii?Q?sNGxxkiPVZE5oV0q3E9124Xjg6cvhsc780ikbK7Xzc/LXGthDkOxPrGMMAg3?=
 =?us-ascii?Q?ul181ZgV65Xi9Ni8GpjRCr85Hib6hRU8112dD4RIwd9yCwxt7DJc5Q+ug/BX?=
 =?us-ascii?Q?Xma4p61VEPhyfsJaefcRE2Dzz2kZyzik8/TgkcU8trb/VaCi8UR6Vz9fEyxA?=
 =?us-ascii?Q?BT0woF4vfiDraVFGCbHY1FRRm94aRwTx50AbSlKVrjglYEaS8NMo0yAHJ5RU?=
 =?us-ascii?Q?sf3GkD8DyudwA2pXDUWZyGeW8vzIKJoKGUEYrn7M5ENhKK1zRGThP7uygLdd?=
 =?us-ascii?Q?7G9/msCvYnDmcfuJTQRrY4uUeoYDQS8Nec/XL5y8nwwHG59fAnnn7LQsK4tH?=
 =?us-ascii?Q?Kd2lXgP4Vehz2VISqXvqQAXGmE4jIR9uqHJGmrmQv6odFnc9PuxUQmXmV0FT?=
 =?us-ascii?Q?ukCacoL312ArxSPxkEDe5wGl5UtYikwRFEC9smEn5KdH4XZjUJGodFIOC8kY?=
 =?us-ascii?Q?tVndt4i2a9vde9ZDYn8tjT5i8rjlOCWZ7Ays4dbvpAqPs4L92BdCwkUjmT6D?=
 =?us-ascii?Q?UAkkGDCKlThEZF6wXAg2DmcQckEQkuNMFv1OBp3rqvSViystX1RpZ4Ua/zNU?=
 =?us-ascii?Q?ahWRlDyPyGAFLGUYyKahUz+S4gG/gUbbwqG6JNZAevSeGpCoZA7YNqlBKB7U?=
 =?us-ascii?Q?wKLVlN1oFeEWQea8wq9WvEiaMhBBgi/8Zg+2Jqt0EXuPd7y/8X3Tjj1RFE29?=
 =?us-ascii?Q?Rh74GYqWAzaSjhzp7zCTEcjD6iP6jZrYY/d3C8Yu8FPXixOYWZGHi5k8YnPK?=
 =?us-ascii?Q?1quHjzBc6oI3R0iHrEDc5b/G4RUc9MRup2KMgkAAVNaQqhr+9y4+TSMNVz95?=
 =?us-ascii?Q?/mB/RS0Cu5lYL9MhoSS3Sf8LgMEqNuv0ccxgRSrRs+T7N54xSk+1Qn5kEYF6?=
 =?us-ascii?Q?t7eRExQvYMcjTFSJErChliOPEb2XlhAaXDivS63JN2OowWYTrPO3HbgtgEKZ?=
 =?us-ascii?Q?exmXu+BloSPIuSy2BlonZ01ePRi0adq3JO0cyLEIf9wd8FI+5vpig53ZqGCw?=
 =?us-ascii?Q?NteZk8lTsNP44BwyP0q8EYJTCAMeSaXMzshHit1nn2mbK8IQf2jFNK0M8UhN?=
 =?us-ascii?Q?X8I1muUcADelCzweAdJZ+37mHbE6dx2CndinYQ7veoCfinrmE2gsgBgQYay8?=
 =?us-ascii?Q?KpYFDNKVcxpg9imOn/Zmall7y+ncaO4k90mc0M7qtIPREt8/ou1yg+9kbOif?=
 =?us-ascii?Q?H8CjqGkOG3QO8LAEmzWobHQYcuxiKIPuGcRH8wFaqHOWtVAAW+cuvuM1MLIW?=
 =?us-ascii?Q?TVQjR60ga477vgIExCPNhkGE2HXBOmCo/46WuHMmGUKtJl0NnwUf0ADjoXgM?=
 =?us-ascii?Q?pqFFOUINwrJ7LlEL7nBxWZEcMZqP5uU45j1N2jOv1SGdILTnzR82ZQMubmGn?=
 =?us-ascii?Q?IZN4Ro6rY06jGCg/2S1QrehhTREaMIeA1sYe/2A/ApkwZy8hnZEY72X55iso?=
 =?us-ascii?Q?KuWFYZlm/xQqyFQhQA8=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(35042699022)(14060799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 16:37:26.5246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f50d5c-9a6b-4fb6-a110-08de2dd33fe0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9880

Hi Kevin,

[...]
>  static __fastpath_inline
> @@ -4920,6 +4963,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  	/* Zero out spare memory. */
>  	if (want_init_on_alloc(flags)) {
>  		kasan_disable_current();
> +		guard(kpkeys_slab_write)(s);
>  		if (orig_size && orig_size < new_size)
>  			memset(kasan_reset_tag(p) + orig_size, 0, new_size - orig_size);
>  		else

guard(kpkeys_slab_write)(s) will trigger NULL-pointer access
if *p* is allocated via kmalloc_large_noprof()
(no kmem_cache, allocated via page_alloc()).

IOW, "s" could be *NULL* in here.

[...]

Thanks.

--
Sincerely,
Yeoreum Yun
