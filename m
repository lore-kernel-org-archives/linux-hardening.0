Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F41FC0F3;
	Tue,  1 Apr 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523570; cv=fail; b=pPcuUolXG51uS6WkdjMbfRTG+3RQIPmR8rfdp06ofFXABzblakZ/mdUy7Gt6CcIERRvgTuJ3DKrnoo2KdfH1dzbt/AubS5cgfoAHl4kGd85aqKMwAPoXEX33bftK6Q5j3ddGrau29CFO38q/74FZpIARkmgpqlfeSNdCi/WCWbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523570; c=relaxed/simple;
	bh=upn/wCjFcEZNInzTiQAvaLyJZt6OVX+ehIgEkx2X2rE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O75I6wURZxYV7J6hy3/iaedgq4Q59jYNFQB5scjFRsAUwh0d8qYcyqF+DJCh4+8qHA09k3kBw95N9/+jorwtUNbywpih+0agWdazv4wBEHyzjM3NbUgANd3cdIvzTM+47kZJRP5BrGK7lq6S3arwhWlPTYc8gYfOfPdrnkhLPFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HT+/RRcA; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HT+/RRcA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6bFuTPrB1b0EOKxz4FOGq1Qkzb+zo4LmylRGCAAx7F1e8rYq2PNKHDCQU/vB7t7SmnVOlwibbPTZGZ1Smn+Rg4TG0UZ+pTMWhzezkVrd3wdlWNgsx6IidDTsQ5vhBBhoLKi1CiFWtHn0sBRDCydc/SeZD9BMpPDVzi5ZnAWqEpJYN/T+c8cNtkmYLZnzxudXUHjf8kMRn84fXrLcui2ViLZPDLchAyWL/olCKNDw/Lu/t+5zoFwjDUSdY49VSVIgExTyKQUJOskUv+bZJStDwVEbzS0oQgTihTwt4S02x81p/Uj+sHltDw+8cU+X2G3iV9MMUfyhkwVNHFb8JqLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cexKPN6R9+KKQb6rMvVCqOTaSLaGQSEC1N4bRKEa7S0=;
 b=BivmjUUPTFLDtD/d7dI38Qfz8fFAKx0S2owmo60jv1Xu1jXwM4R7mFoqkqnxvfWWurVBowjAyd+ITmY7ycAib5g+8oCQQc8ZXOVwAPOKNksJFOrMkeDr9nqXxr7QsrJrytajrbjx76+tO1+oxYYdmDBM/wmXWYkrAUTUNiKnQZ2e8MAKzHnHl92O2+xeIVYwHPLk7kgoJY/muK/xh94O4Gd5BP+MzUv7SBcE1TvBKMpX+M1SKBV/wRgzVrY4Hs4OqUtkVYKU7/gPeCUK0/SSEIkwvKSlG/9P2Kc/WBZcfyV1GZTk6SkF+Pfs0F/K953Kv9ybxotPWAB8sIJTx3sAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cexKPN6R9+KKQb6rMvVCqOTaSLaGQSEC1N4bRKEa7S0=;
 b=HT+/RRcAR4aW2f3WcNxv7q1pxGgSDHniAPoRLoyGLkIrJURAm/zCw0BRQW5sedSiv2Yc5B11b7gvd2QRBAXgiXjotEO2TNwqggoZNMIp5DJPGORcpzpTsO+MdAn95Vr6WoRYzzt7PqE0z6DQENdNWoYfA1q6In2egXUwAkfGr6uRtiiXw+kruLBNS18SESgqqJAlAsdVusJc6P1bTLtI7COqXq1v+WWnDNJJmBedhss5J+UnY0BT3qgj7I0x/d5wNTNUwIiuohTb2asEh5jK6kTvDdLBMi01+8ThUx8nXFBrP+fW3HiKyHoLz/WuOlhSM0dK5OEsDk0nPId6P8Wa2w==
Received: from CH0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:33::15)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 16:06:06 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::41) by CH0PR08CA0010.outlook.office365.com
 (2603:10b6:610:33::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.39 via Frontend Transport; Tue,
 1 Apr 2025 16:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 16:06:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Apr 2025
 09:05:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Apr
 2025 09:05:45 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 1 Apr 2025 09:05:45 -0700
From: Willie Thai <wthai@nvidia.com>
To: <krzk@kernel.org>
CC: <andrew@codeconstruct.com.au>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dkodihalli@nvidia.com>, <gpiccoli@igalia.com>,
	<joel@jms.id.au>, <kees@kernel.org>, <krzk+dt@kernel.org>,
	<leohu@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maryang@nvidia.com>,
	<openbmc@lists.ozlabs.org>, <robh@kernel.org>, <tingkaic@nvidia.com>,
	<tony.luck@intel.com>, <wthai@nvidia.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Nvidia's GB200NVL BMC
Date: Tue, 1 Apr 2025 16:05:45 +0000
Message-ID: <20250401160545.315380-1-wthai@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f563b33e-f552-4a3c-bb45-6b7add876fdd@kernel.org>
References: <f563b33e-f552-4a3c-bb45-6b7add876fdd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: ab61b4bd-cbb5-4581-777d-08dd71371bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x+8i5epfxxIVXfs1cxy2q3CbAm5hig3ps8RjuRuTKp//EmQfc6b9o+f4NWMb?=
 =?us-ascii?Q?DGjN1WD6UQBa5EhrdvDDMeuPgaQnaNvxeEC4owfW0R6F1l6j1qYlMxrL5y0S?=
 =?us-ascii?Q?7sI05skPfVG05yHL9hYQiWAjo+WydakENJ/fQYTknKViOKi8dPpouR9VSywd?=
 =?us-ascii?Q?kUanOZ0Ozj4cmQUQ0LfSBfFfj9govo2tLDxo+E1Xt7dk/CkUSKs/H3p8ZX+1?=
 =?us-ascii?Q?Fn4PATEIfWtfKgFn9sw8HyPMe2iXydTxy7GBtabAFJu0QPjbr7s7z/I7732P?=
 =?us-ascii?Q?nPP78KMpFrDGUuboQFsnuNwNPEKuJJfkpJFoINTZw9TT+ssG8MFEc73sVffK?=
 =?us-ascii?Q?qOLE7EWYoONUul+tGbcln/8laJorROLPwVUDM37ffQTGxsGDoXhbUK8ShwpK?=
 =?us-ascii?Q?PwOKrctXRML/J8JnLhx/PHqyLAID9SRzDMTUsLVO6QFpItQdmxrtAdx4JBXJ?=
 =?us-ascii?Q?T8vJkXFxPrJt84hYM9UFkKjNdirIiF4HlwAwK/iJ9FGJdAmesefgnSCpbZPa?=
 =?us-ascii?Q?GXKXnQGBWGUlV+rVfgbures9yEZlo+GZwBeCyK13NC19TKxHfocwuWW99qJ1?=
 =?us-ascii?Q?Ccgw3i8RhBVOF4zD+Xd2s1jwDm6LcH22+ZwahouJhdhm1ix7M8Ljw/QR9qrp?=
 =?us-ascii?Q?qyL4rbxoZidgKnpHrMxsHzv/aTko949i3cwpOpDO+ggXEOyckvdZY3crZv4a?=
 =?us-ascii?Q?UpTGTA9XZop2Dqe8JFLcjKtJk3PsC4wvWwer+Pp5XmRR+c03f1j8CuSdXRhl?=
 =?us-ascii?Q?fRGTmr/K0JfwpXe+0BiZGWX3gmv71AXNwBYKIt0/+13ABMqKGKQYr9otbeB5?=
 =?us-ascii?Q?lfFmt5sX1mEAKA0O7qfCYHMSNqikAq2iuG31vZ7M0Y7Zed7jQ07wGwGIkr0y?=
 =?us-ascii?Q?C+eBx0dTZbZCqpa3BDo8P/4S/oR2GLn3voWI+anhXXomDJMo3ugJYlSlRXSQ?=
 =?us-ascii?Q?AcYcr02hJ/Xoj8vzK3LdDphB+y6LAT120ROUIlna6zCNVe5LFHkoOT+U1Io9?=
 =?us-ascii?Q?yXSuHZA4FY7yrXLdr1Gl2lYlHNHliE/Kw4mgDIdONnu4k7dolG8PdTTZ+M7V?=
 =?us-ascii?Q?Mf77g/rMTi43seTY3cmXnezwIW/HxjkxdPvAf02Y1q5baGwcjvHxaopP1KTV?=
 =?us-ascii?Q?AaBXmAAhOWV6QmhLjRdCuwytYW65bbWn+/pTc6daTFu3tv6ZLkkgVZgqCzoF?=
 =?us-ascii?Q?3H2B5zILuFjr111Wb4wb+wEiGXDQXc8M9uUhKt6O8B/FyL5DS2QAgjL/GR76?=
 =?us-ascii?Q?gSsihxfHZoqFUUmRacYp/mJWselHNLxuty0WymFBZViO1RWl1pl8f2wHKOkw?=
 =?us-ascii?Q?DGCSlIHzg6dBkwVBDcRPKJzwlevDpBmY86x+mc11j2zG2Ttp3FRz/shUj3fj?=
 =?us-ascii?Q?LqL4qYdSGaBOl0X9Mf143T4lH5n6XRyb6UQRnbHZ0WEstXhCBGjiKXwSHPUK?=
 =?us-ascii?Q?uCJJg0e2GWEYFV7eZuZJDPvzW1eSMagJNyk/FUABfzdW9ujRoBI02C4Mdg1j?=
 =?us-ascii?Q?WpGKtzGsvlTmtoM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 16:06:05.8375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab61b4bd-cbb5-4581-777d-08dd71371bcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

> On 01/04/2025 17:39, Willie Thai wrote:
>> Add Nvidia's  GB200NVL BMC board compatible.
>> 
>> Co-developed-by: Mars Yang <maryang@nvidia.com>
>> Signed-off-by: Mars Yang <maryang@nvidia.com>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Why are you faking tags/email addresses? Read carefully submitting patches. I really suggest using b4 instead of manually editing things.
> And if you decide for manual way, you must never, *never* edit people's tag. You can only copy and paste it.
> 

Thanks for the quick response, this is not faking tags/email address, I should have copied your whole ack tag.
