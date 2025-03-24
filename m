Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A7263F47;
	Mon, 24 Mar 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839210; cv=fail; b=PPsRpYO0WpuhA6hFZ1mzyI2IwSQXIkSzS328Xrm8IeneMo+yaCRCys7s1vLyem3YQwiGBdenGevXtzN6qyxdbE2B+UE+94fxVfc467s12qEBpaT8fhmr/pWM0HpxeX8cDy9Y27t9nrcmGGJ31H2+EGo9aE1W23lyVcFuKvsIZxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839210; c=relaxed/simple;
	bh=wYqak+3vtaOWhhsmotIbYYaZM/nwpND+Hkys/Do6tww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYdmZEKyQZgR24x4H8dWPl3Aq0S4YXq3Ty0cheVrl1GDVLgxGn0yvYvRKcci/j4EzVaiad9faFyXfX3HB3KaARvAe/tQ+tbk80239b4ffV7cSGX7M5x8Wu4hVaQz8xM1w95JaIlkNy5psUqWXuATFVwRZgQ3LJpF4mNpajiu8b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XXfh2GSQ; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XXfh2GSQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzv60xOGdlVC+osQOnDzFBEPJssAiFGa2LyGe8Wpixit++e+O66AnfX9g694j2+1ziRHrsQy1TIZdCHEFtq67jLgyywHKqRqPjNuA93bKk+oEdoOdBx5ruJbT6xWWlDyzSCROkIGmzMCeCxSJKjmEuIP09KDipFTzyGycg6mGndHFlJBFnlLMvaInrVk2qzQoHFlu8gFJqa/yulFk5pSmWf4gUaxiA4Gfjs+Kl75MI/z+G8eAfP6CIFJpnTh/4UeqRlri0xmcpISQgu4X36ZNSqA7hGZpyM//Ak4YnwQiyvevGvpvJV6qE+A09OeTCY7Iepb/F1uMfRPeEcBpbYOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh7mulpSEp//J8Nt/5HDZJnD4mmSHpOlaCmq/LbMp+s=;
 b=bVlp0haBQYD8HOv8CY+W/wBF3JrBGqBbBkqs8kIKQvd7oENArnOo+O8k7Mogbh0OPOvKpVB+NeaZ/lcNkGHQL5cP68KYNbCi2bPfCh2ro3YFvqUqgdxfkb9mLDoTmp7f6fJo6CH0WxIUlToqc/5VJaFcr5g6cLqaWboLKnxpiZmsJ/6rjcJb9VrCHhdex4xXQPX8absHjVS/Avas8WdzLexf+J9dRmFgi3b8yO428ql+1rPxpfqs6HJKnm7vE9/rGT7E4t3HQFNXhe+1vGRizVqIWKFo2MtyqhDkRq5+Om3OSdw0TiwUeCLFTltqxITDJm6q5tm70drr0N3LayIa2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh7mulpSEp//J8Nt/5HDZJnD4mmSHpOlaCmq/LbMp+s=;
 b=XXfh2GSQLORssSlnaWuUBlRnHcfSmqBVDeMT18GUbHEGobZo3smsdjtNJ2BxmQqNjlAJyLpcNfoOWAX2GqKWcWX2udt+cLzoTXq5jtI4LoBm/8GHVNKqS6sujMfcSOMa7MhzmbBfkvfO+8Kv1QWkJy/NRek/hgzcICUAUyMm38LQsR6pkbJM5iOJnGJtA2ozu0H4dnFi6eaKWEPaYsdQVq6izCdsTW6XhgblBPJY+P6n8Exc31mKQF4j09nAf4a0FL3K/4Kzy5mEIk+kpT55PgCktV6Dly/sadIedDIjVHczlseJtdYLmruxwGFTn4bSn2ToGPe9WJJrbiT1lJw/2A==
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 18:00:01 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::10) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 18:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 18:00:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 10:59:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 10:59:44 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 10:59:44 -0700
From: Willie Thai <wthai@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <kees@kernel.org>,
	<tony.luck@intel.com>, <gpiccoli@igalia.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
CC: <wthai@nvidia.com>, <leohu@nvidia.com>, <tingkaic@nvidia.com>,
	<dkodihalli@nvidia.com>
Subject: [PATCH v4 2/3] dt-bindings: pinctrl: aspeed,ast2600-pinctrl
Date: Mon, 24 Mar 2025 17:59:25 +0000
Message-ID: <20250324175926.222473-3-wthai@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 3661aa81-91b8-4975-e438-08dd6afdb266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Babr6yrKC8F3MA9R0ZpDK4rMR3/bHTp4w5rUffsGeDhqXNfOV9WML7ijn3v5?=
 =?us-ascii?Q?XUnLOoBC21X4/Oe32vS//iYR59DnVduqk/tntvCmCfeB5KRwGX+ggh0ogpV7?=
 =?us-ascii?Q?c2MFT+goOJ15bUNF8ZW9NYvIWRaZV2mOUzGbfwvPw4JO65Hd9gO6NhimcZ0f?=
 =?us-ascii?Q?6Ev2QWLKdXC6zEgEPmrATZVCd1CA6xpfiHh4ZYkO1O5YWGECyLSl0u+YMrr0?=
 =?us-ascii?Q?yplxhYaNr5Dcz7sZsPvJCPGH00bGQ/lxTWr+hKg9DiytGgnAi9PUiYUZXAWF?=
 =?us-ascii?Q?vywaByAfp8144pJkTfKNMcdPxTVVthYwUB5Rf6UuQz3xBSABCU2wX8xKzN0y?=
 =?us-ascii?Q?XlvjgY2pKXFeGB8HcX7npmUcua6PNuNUmJYecMAX7TyDgy5ghihhadoPAiBk?=
 =?us-ascii?Q?Fc/M8VfJKpWn079FBNyqyQzMk4uwKLj8340Ip3cXJ1UMW+E7bktfislBvrwu?=
 =?us-ascii?Q?LMoM9iJzOe2o7PgEKfj0hIoPWBMOu7JpffVdYtSDQu2tBUtkShaD9bVZSMw1?=
 =?us-ascii?Q?yYPstycDnDMnTGYC6f9x+pSHzBypyCUHYFuO1+6gLCEy+mMCXEpJT6v7gLOJ?=
 =?us-ascii?Q?dJFQgPGh84VXaQUR6mku/8YBY2v8LgM8DtAaNoAVU/lZCpIo6qCDyCtA195C?=
 =?us-ascii?Q?LwPjqDYKHp3Gxpe89wsPUnHpLYYnhYvfIxOStmYDM+kLyojG6GKgqayc251Y?=
 =?us-ascii?Q?kTHOJsEfgBqvP/rOt3vs8lIQWD4txO8km0kIGSA/PntEmEd1K5KkcmrUAAvz?=
 =?us-ascii?Q?6lRgn/gj+nJV74NIu3kQUWuZLFK8cb/gYssnYeJZhuAu+n5gFagRIR77P6Vb?=
 =?us-ascii?Q?w2MVXiTZ4hRwEXD9hz+fwY6sLssUpSPi/cwrpFyqhj4n6oOukR7j5Ji6oiZP?=
 =?us-ascii?Q?/diujCuTfx3qZ983IFiGLUwWjhiEJ2ZFxx1vw0BG4xg05KHFpo2bEuEQ6me+?=
 =?us-ascii?Q?PtytnxM7Ky/SK8duP8BEFm7qCD89hz/NwAityvgJKDMuNGF/XWluUN7d1cya?=
 =?us-ascii?Q?nyjH68UnlO6Omnt8qQaexLaKKKV1ksfTyqofnI36bgoV6qFDeEH2hFJ658f9?=
 =?us-ascii?Q?MRZnG/Ju4Z4D1dQUmRsKbVyG4Y9tc0Fh1XfrI2xG08nrU1f/FYFLJOqEEWsg?=
 =?us-ascii?Q?5QZSN1z65lyNST1LdULwRjIi+GCHCdBKAMmZiEmiRncS8SwSewDCJ6oXfknp?=
 =?us-ascii?Q?aKmNzWy8Tbl8u2OO56QaPoi294dQBUagIi2YBx+SKJRSIn4nyL3GEuCO60nM?=
 =?us-ascii?Q?qLVWCCqbBU7M7Hg2vgw662ipgQqe5PuNN1uY5TEpgHmfgGfsaFTvUiL4qhOS?=
 =?us-ascii?Q?APjyMNep48omJVTskSju3XkxY4kI6x+GPh0yqlC6SchvuLVjh5hj8YgjPUgg?=
 =?us-ascii?Q?ZxAscUa1lGtDwfiCGw89JxBq4pOyh8x2C6pV8a9BBjNAHioSngua4lpPXJso?=
 =?us-ascii?Q?lsQBkWtXpzCwNU/29OECtqupqOaxZSt2L5TqeR9SjeCFS5jeIkYB4KxUN38A?=
 =?us-ascii?Q?FgrdQvTH0roiW5EihB2bgiXhTLnknme63mwP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 18:00:00.7586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3661aa81-91b8-4975-e438-08dd6afdb266
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658

Add EMMCG5 enum to compatible list of pinctrl binding for emmc enabling.

Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Willie Thai <wthai@nvidia.com>
---
 .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index 80974c46f3ef..cb75e979f5e0 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -276,6 +276,7 @@ additionalProperties:
         - BMCINT
         - EMMCG1
         - EMMCG4
+        - EMMCG5
         - EMMCG8
         - ESPI
         - ESPIALT
-- 
2.25.1

