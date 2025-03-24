Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B382627FC;
	Mon, 24 Mar 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839202; cv=fail; b=lOIcVE8kK4xLiTqyeH28gfsPRTVhpsSXrbs5W7cvhyE1ELWDlmli63KgRNIt6HsOlSm7Q+ADt+NwoFuDMmr4plG6XWZwfKLi3JyX1iFuGjBolTHc6WHULA4KSg2NeJ9oQsHYMu1BroJPuu4qqpxnWd+h+xpBfahT8NRs2wTOYTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839202; c=relaxed/simple;
	bh=36jhuM+s84qBwkczILSX0HPx7y65by5qXk8hpyAZ8b4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQmfbgsUm9fXfsyP+S6Yy/IXelT5GKkMfoOhbHmtB1DW19IPEDU69dFywgeD1EL6BKXDZFNRdRNBmIRVyNX5hUvK5hZc6Le0Bbmdf2odZfnm+ZMRmtIlDMI4DgW4NsjxMwFWNJwfZpPqJttQyCgLP4GKVmaE//Q4OBM6tcxYNeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ohkt4M48; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ohkt4M48"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNXzaa6jYX5hkgzroRIhxdwjwAoJTQd7rkdqyMYvS74Ctx8JMdSXIAN/hz29XzP1IzLQLtirzmzyIr5EqwJp77hmB0aUOMaLQA6IDSwB9v618rnHtJ3Y33hek2IhQLFSMSmdnVWsyydcmc0gbu4IFLbuR9P9MEkJuirvwNT8CXF3LPsB3xKr6CGXii1esoYglOb3gbwi4W2ZuCSeKLc4NO+OFmpVW2+ADQI4E1GzurYAS/L8zxImpDIGpMB8mhdO4Z3gii0eC6IYrwMlCGgyvofUWYs63iXm5UqR+OW8QSm8UFQ0GSgLa/wl0mzEs8RJHsknC+Z80t2KY2rSfwcT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej6iYui4NlHJdMSjb4kue/Yt9bpJhUd3D2yXMv3XNk4=;
 b=I/qzIKIdEUHuhtuaQI9UU5oDz1KU0GHMBuWPtZ49nzivHAMBHzfugQnR1lXei9yrjgeKmHUBFXT3zjgNF+zXYeqS3BfS9nYJ3IYUQMgycCGgLfaA29VB6XY/CrMbljidVs3a/RFXfY62GdkLaE8vCaXsI+XoIOhca675txmHTXJxIM9JSGXrztzSY9EXF4vD7wfvFjuGg/cBPlu4wb6JMdSCByQKB3W14JFjnP1oUSKcLRA6J3kKQrN4bCcmWV/Lji8C0rLambu7+Xqd9cxawQfR41DNpprlfEd0ca1KtFBYbLNbO0z1O21Ff5wBlUAbo3kjO0SVubyjlbGVePjjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej6iYui4NlHJdMSjb4kue/Yt9bpJhUd3D2yXMv3XNk4=;
 b=ohkt4M48+G/UObZn1CoJ/sGsnOrXnmYSS8pQI2C+jPwn8d+BF/GdoLTtUH/XLfRAQ+rWx84t7kGa9OOAWVC0Grse7bTxcuDfE/xD9Drn9dFxqnFgTV7lAHKBj3WVlQblPs9GnM7szLx56ByDh+G9jw6hij0QEJXbAgZINKEVaF/ZDeb3G93bTfE+/UO/PArtBT7ibUfoYzLHkJ1IgW1TSeVfX1vHejy0pnZUj6aKZMLHt66FMyg47gq2/HcOeBN7DQsMb6+Z+S87yFj4Mg6K+pKa/YEcxrao7o+6E4ves5kaTPmH4g2oA62uHUDOx8J4lL4f2yJVPNftOLQSMmZfog==
Received: from SJ0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:a03:2c2::18)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:59:58 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2a) by SJ0PR13CA0043.outlook.office365.com
 (2603:10b6:a03:2c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 17:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 17:59:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 10:59:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 10:59:42 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 10:59:42 -0700
From: Willie Thai <wthai@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <kees@kernel.org>,
	<tony.luck@intel.com>, <gpiccoli@igalia.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
CC: <wthai@nvidia.com>, <leohu@nvidia.com>, <tingkaic@nvidia.com>,
	<dkodihalli@nvidia.com>, Mars Yang <maryang@nvidia.com>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: arm: aspeed: add Nvidia's GB200NVL BMC
Date: Mon, 24 Mar 2025 17:59:24 +0000
Message-ID: <20250324175926.222473-2-wthai@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250324175926.222473-1-wthai@nvidia.com>
References: <20250324175926.222473-1-wthai@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e3255f-74a3-4845-2266-08dd6afdb0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5366zbjD7qJCmCbe5/KmIeOTPwBIBd3cjbCH+vp+2W6tIywHLZ3E5AUWmo6i?=
 =?us-ascii?Q?1/Mp9qwqdxl0FuFzd23N32nNwxGA2Tk2x0TGFNlpEXlbjknGlzaLlMOeVBDf?=
 =?us-ascii?Q?HhuVIFFkMB1f/W8kPT/PPqyXUfUzmaGP0FoWta2NLNIrvPuTHgk+oUVRXnBs?=
 =?us-ascii?Q?WNkUWuRGytYYuBn4LK0LaqJ20v2Ps4Ro36IyUFrgePF4+q0DYhbMASP5CWKt?=
 =?us-ascii?Q?tuudx90ztI46wsSJ/1wE1Jc9QbLSdtLMG5KRAjYhHPw/xoDStyk6SchQhLUw?=
 =?us-ascii?Q?zpNoW7gRxZMy8ElCZC/tp2YM/UXMd8Ida/tbzjk1FhK81ZBabt/OqP+s6D2n?=
 =?us-ascii?Q?HlWRSPK3A9WOF/NUF2r6QmCdvoBcvf5De/Q896tsS7o5bfneb+wCv8f0fFRU?=
 =?us-ascii?Q?XomJOD4pl+aMZnN893ewKLaaQ3E3riehxj86dSHGVju7LIz2rn2260lDVuOP?=
 =?us-ascii?Q?h/Zt6wsHgL5zwjmyNigafQ7d0FDXw4SHV9DeMi1vHlfNu94Ghc999uMpfI3F?=
 =?us-ascii?Q?mhlWF6QDLJzDA7C2TxVbGdwSnSnaMSo9RDWAHO9AOcckGwC4Db3+kU8gmF1n?=
 =?us-ascii?Q?d1F64+eli/ku10rZNKxSWMzyusUqup8gpxlLK49lbEiFtp08V225rl3HtfzB?=
 =?us-ascii?Q?YEnR9npuj21+I8UWqpmAkCyqTSWX0T0CLeVFXzyN1rmTicUDiTRBiyKTTmyM?=
 =?us-ascii?Q?J1hWDpBo16mY1TnYUNqPBXFpKKioLb1IcinMgE1tOv8InEWCK4Y98PbRrkOz?=
 =?us-ascii?Q?sUDa8IS4b7KVrOMsN6dj4pXo4biQFIvM/yCk6pRD9PtL47apawQERN/CjcKQ?=
 =?us-ascii?Q?hTlTeP+Tlsgu4sezmAnAIw6a8rhnIvExhvjRaEOU4tkQ96eDlpJjzN7BRj19?=
 =?us-ascii?Q?Kx0Mtx1ZdlggF/wm2N2vdvfDExkMzwY7xJ89hgoB+rQ0MPLX1+NzAYRW+uLG?=
 =?us-ascii?Q?u0fnHKn9sCJoXuJQgxlneDrmPH2f2RdOH5UgG5maxjp5hASa2IqbzQ8VF04p?=
 =?us-ascii?Q?vBFhBCnyE78pq6fvG+SZoL/EToq0Vox0bDOHdn2AhNXRLvncELwzo67DxjXI?=
 =?us-ascii?Q?OhZ6ObhiPnc15P9eOW19VEswXzSNiEZQkMDAJCM5ZssZhYZo2hLChF7QAbMD?=
 =?us-ascii?Q?wsOIvIgVCrSSsZIgbAPOQ5M5R19pfAq1FhIIY5+dKInXmvIxF4Fn/8RMdMUX?=
 =?us-ascii?Q?qkUde9qDtM1HeFT6TW1lJSrOsa1gN/GXYTKJlaKN7Vth7sB+FA4uQ1UNi/Ry?=
 =?us-ascii?Q?lDrSMrm0jbhD8eKJULuNXIT2Wy/+pkr13eplwsta59NJ6sXV1YWbGSNz1aLm?=
 =?us-ascii?Q?mAySUX0LOiAuSAXviVd6EHZ1DpJZCy/85m3xsUtQ2LJrEPRuc37x76spEgf4?=
 =?us-ascii?Q?HGdh8peAJ/Yx1WSNTLRwZHCRJLiF9Y+QVfxuGjoKc64iwFgxcp9Tap5wS+ml?=
 =?us-ascii?Q?E4O2yi6YWfzbHKN/QANBQaQV9iVJu3/KMM2DLzWwdBnj0utCwkb3Q4KTxNzV?=
 =?us-ascii?Q?nkjAQFROa2FMPCgTr736wd617IvL/SGcna6+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:59:58.3157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e3255f-74a3-4845-2266-08dd6afdb0f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340

Add Nvidia's  GB200NVL BMC board compatible.

Co-developed-by: Mars Yang <maryang@nvidia.com>
Signed-off-by: Mars Yang <maryang@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Willie Thai <wthai@nvidia.com>
---
Changes v3 -> v4:
  - Make the commit message more concise [Krzysztof]
---
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..a3736f134130 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -98,6 +98,7 @@ properties:
               - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
+              - nvidia,gb200nvl-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc
-- 
2.25.1

