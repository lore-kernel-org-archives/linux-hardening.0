Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3FE204855;
	Tue,  1 Apr 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522029; cv=fail; b=iVNqhQ37nxnl1FeLFFIJDLctMGGIh4qv0vt19CdjpzcD2UNOplMLUbmU51NL530LowV9XGvYbaTyHfl/2/mI1ttfoJKEyC/fCILsBmQDotfd4llg/piR+tRK8LNqp9AddL/RK9EHhrHPusDE/wnmJ6QZZMYHEb87f+Is+WXGQWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522029; c=relaxed/simple;
	bh=09NomOV+yhYY2LpzFfNhfgZfQAQgRuZEr7jdA75KPSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHaJHxsgKTauIJelD7GatjfZMFJHb7Ehtpxtil+HfhHvstBHAGUpblD+GfSf6IDt+Z5pNJQaBqWNxG5gzuMFEq2R/gtTioi1l/YoViKa7GrSwu54Be/e/tZceHV8MmhLZcpqfqg77+mFrAT8AVAD/E/YK2UJF7ulzTRqo9dvkQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vdd2r7c7; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vdd2r7c7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sB/v0pHg6IvWJaVWnWDz58Lp3EptPsu17xOv4E+fYigzcXx3gzsqeNHkmSpOLX2E1nkVc0lEe7qLNzdxwqsWto7m1w4eUFBmavQQHqnInyAfRdNUEthsWZS2adtDbbs+HuEkdeXRbuBSob3xC8zTrnGXAEbyRKCa287f6vC+mV0SwCzndrdPkDq3zw244P8K97FQYm7Ol1X87Z1VA7inJmduTpnhIESz/eqmnLxA+I0c8gQth/ycUtzFoTFqNBqlMt3cqIfAE/IevpV5/5/Pcg/Zwu/Hh9a9/PDOCATn5/3+tAcJnyWW4Hz19R3H0+zTrAiAocoPsJRPiUCppHKXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHxT46Xs/tSjkzzopSMfZ5ko8uuGjVLEterA3N6YKuA=;
 b=El6ZqrqQqP+lCHVJn1JoCasvlr8jyspPrL0wrgoLsOOg2cKM0ikITnJBgzrE/iHh3fsHehnUWzKh/sUosxfVryQstHcV17TH8MQZmduThzK2ianWMGO8rOfI4t++i7NrNacbEnVBq7kVAPiOKPYviX+ADG5UDYo3ZGYpGI4AyU92deOq3Xc2UWIZCKuuKbhM6+zKbrUWZgzq80F+k/D6dQJchc2LZXnItD5aBONc2KTTcvtFaiiSJnxWRSKZsbhqMwiyS6r6aB2O/lsjqp62O6ehvvcKMKD2JIdrbEbV0ZINemeeOXKiPpnRJqR436RukF5zeiGjhiKytC/r1ZyWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHxT46Xs/tSjkzzopSMfZ5ko8uuGjVLEterA3N6YKuA=;
 b=Vdd2r7c73oOjzqnGeCefvvY+MAVQVA4jAx4drP+iuhPcyUDSGKi8wT3EXNg59q5MTftbb2Un6PHxJlkVEy+vT+uD+hZ4wGeL+f9LL8b7fooQw7fjFRno/Rhz2xp+6WrdSnBPOuF9PK3t7huljWczPvazLbyUSsMEE7ea2De2fSlb3AibaNvfSeYANpQhwcQcVBqVRPlv/jHQ6HywXTtt7AMG36vk4MornRdhVUZkbCb4jowwg9uWNlcI4wbzKNURao31Y7WxH9vRuVKBr4/uCrEizLuxcpNbrUkYKFT3Ltqv0BIEJkr77W1foBWx8FOQKeZQTh6uB1A9jdH35uLdTg==
Received: from MW4PR03CA0335.namprd03.prod.outlook.com (2603:10b6:303:dc::10)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Tue, 1 Apr
 2025 15:40:24 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::dc) by MW4PR03CA0335.outlook.office365.com
 (2603:10b6:303:dc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 15:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 15:40:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Apr 2025
 08:40:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Apr
 2025 08:40:05 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 1 Apr 2025 08:40:04 -0700
From: Willie Thai <wthai@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <kees@kernel.org>,
	<tony.luck@intel.com>, <gpiccoli@igalia.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
CC: <wthai@nvidia.com>, <leohu@nvidia.com>, <tingkaic@nvidia.com>,
	<dkodihalli@nvidia.com>, Mars Yang <maryang@nvidia.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Paul Menzel
	<pmenzel@molgen.mpg.de>
Subject: [PATCH v5 0/2] Add device tree for Nvidia's GB200NVL BMC
Date: Tue, 1 Apr 2025 15:39:53 +0000
Message-ID: <20250401153955.314860-1-wthai@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: 705f76d3-cff0-4c6b-020b-08dd713384c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j2jcsx7SFo1gM4ruhTXl6lDPn/l1c+ZHqTWDMbjO7L3ZdW/q6b8lyf2NRe5T?=
 =?us-ascii?Q?QEiDd/w5kl6XR8dBXVg/w8m64dyoIhpb7zTFOCBQOT/VYegPSAjMrJdhn6RI?=
 =?us-ascii?Q?anMj3u+uHIuTtcaj7qrAuVpBth6CDKP3lh8VXe4O2Jlgcy3wL/JySpWSApXK?=
 =?us-ascii?Q?bPOErZ0hEPyE085bil5UH8TtCcQJ7L9z7Z3CEj54z3fDDie5pVokZNY+JDwU?=
 =?us-ascii?Q?nCRUwWdT1JeOST5kat1dRrig5nxVi6dX3VHbN1cYS8AYh3/JLu/xdeXlLy8x?=
 =?us-ascii?Q?j6kusACCnIyBBAu2aGOUUfX68AkuliWAmpeoI7PlHttAi+3HSH3A5JD1VcMG?=
 =?us-ascii?Q?LVBZyr0uyD1M8dphrnvTfZqA9FhcgKZ7Pl+WmkB9ynUc2xTc93WwX7+ua6DX?=
 =?us-ascii?Q?eiD6u58Paatdk8kp2Ji21R7JgnZlziDjQsC9AYwMam4z/E0ecpmGEZL1HlHj?=
 =?us-ascii?Q?hPSn8lGQ5RlcbBWtG23LhI2pJwzrLvr/tAYQdBI5OVfi1ZKKatgxzIRO+DzP?=
 =?us-ascii?Q?ZnbOcx6UvQlyYCWhsYEyl/b6RZk9f20mXyBerkNHWx1A0gdDIfcgok2GKjqm?=
 =?us-ascii?Q?TSAWRO+qv54WPafBFvUD/SfpXf8cM1ONPujfy3G0jQzEUZpbjv2Hdyc9uaeL?=
 =?us-ascii?Q?t9Gblhw4+r1fYZ7JRpzSAqFCCD9BJ3YkdYHzdK/SrsyzHeDlBcBx+5yVLphv?=
 =?us-ascii?Q?AgHiTCLsLvakFfzfDQTlBrRKW/6f6LHeL6pXa6FliUkPA5m9se8hy7f55r5Q?=
 =?us-ascii?Q?sTPBW8JXTXgSCODXjrSg+cMyQRRBgwA/4YPYLjqw0To82aDxX9SQKSkALDZJ?=
 =?us-ascii?Q?PNrbimlDY0q/GrKvFf9X9CrRQA2KZCeBAA1bzjC6xag2o17HRmaJCOiPVP4L?=
 =?us-ascii?Q?Eji8B6Chcst6pTfdMJ05cKnQhgA9bneL1AauXNgY/FLI6n0CmX1BJlEWUDna?=
 =?us-ascii?Q?ln2SQbuTynstwc+sz4FB/Ho2YAZVAsqHYKPLLr8eqXT+LmCfIUZjIedQ9nb6?=
 =?us-ascii?Q?grbtHVESvXkm9M0JTPzNX4W/deHVJo6MPVh8QUpPC2UfUXL5U9IhmLshOylU?=
 =?us-ascii?Q?lG2OqJXv6oKi/oZgEJxnhvSN58sReqkwtDmS8QrOSm1j/v5UJ3cAITTCDGYx?=
 =?us-ascii?Q?10mxbBueuNfczhw8iTd/uXSrKEoM8r4hYlB98yIGnjt5yBpFyt7Q68b2gLNw?=
 =?us-ascii?Q?JVwhaTTWyhDn0+KPhqOv+E8qFntFP/HEztm9KSKFc6ifs1CCBY3TQ3AQdNW2?=
 =?us-ascii?Q?lScSM6Y16cPw6Xao17q/+zPM/vQYFW9TmHzP/Aa5GVtrv156D5xInu+47mkh?=
 =?us-ascii?Q?iyCLjRdnF4tGQYDsuPuEM3fdpYVhhHe1xEiTFmCuNfIH95WZFalsR6StmBLQ?=
 =?us-ascii?Q?NgEpet4zMOi5Y/hvZEh1AqECX7pbOk3EayEFWH31VJPPGziS/Yx3hWLcWoEm?=
 =?us-ascii?Q?ZdiCa2L8Cil2t0n50Wy5ZGjJpuwuuLC8W5j7E5bYD7IeqJvkZYzngxNq4/C4?=
 =?us-ascii?Q?LGkAhAP4fEVQ34LllorgMqtwwJh3pBaadT+d?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 15:40:23.9821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705f76d3-cff0-4c6b-020b-08dd713384c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211

The GB200NVL BMC is an Aspeed Ast2600 based BMC
for Nvidia Blackwell GB200NVL platform.
Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Co-developed-by: Mars Yang <maryang@nvidia.com>
Signed-off-by: Mars Yang <maryang@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
Signed-off-by: Willie Thai <wthai@nvidia.com>
---
Changes v1 -> v2:
  - Fix the SOB name [Krzysztof]
  - Fix warnings from scripts/checkpatch.pl run [Krzysztof]
  - Fix DTS coding style [Krzysztof]
  - Move pinctrl override to the bottom [Krzysztof]
  - Drop bootargs [Krzysztof]
  - Follow DTS coding style and change naming for leds node [Krzysztof]
  - Change flash 0 status property [Krzysztof]
  - Change the phy-mode to rgmii [Andrew]
  - Remove the max-speed in mac0 [Andrew]
  - Put gpio line name in one line per group of 8 gpios, but keep some b/c they can exceed length limit [Paul]
Changes v2 -> v3:
  - Fix missing new line [Krzysztof]
  - Fix missing binding define, adding it in the patch no.1 of this patch set v3 [Krzysztof, Rob]
  - Fix DTS coding style [Krzysztof]
  - Modify nodes name to generic name for: i2c expander pca9546, gpio expander pca9555, power monitor lm5066i, fan controller max31790 [Krzysztof]
  - Skip mac setting and wait till the delay issue in phy-mode fix from Aspeed SOC vendor side [Andrew]
  - Remove i2c-scl-clk-low-timeout-us which is Apseed proprietary property [Mars]
Changes v3 -> v4:
  - Order binding patch first in the patch set [Andrew Jeffery]
  - Make the commit message more concise [Krzysztof]
  - Remove stray blank lines [Krzysztof]
  - Remove unnecessary comments [Krzysztof]
  - Remove underscore, repalce by dash symbol in node name [Krzysztof]
  - Remove disable-master property in i2c as it is downstream added property [Rob, Andrew Jeffery]
  - Remove #address-cells, #size-cells in nxp,pca9555 and maxim,max31790 as they are no longer defined [Rob, Andrew Jeffery]
Changes v4 -> v5:
  - Drop emmc node for now as it requires specific pin configuration [Andrew Jeffery]
---

Willie Thai (2):
  dt-bindings: arm: aspeed: add Nvidia's GB200NVL BMC
  ARM: dts: aspeed: Add device tree for Nvidia's GB200NVL BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts | 1128 +++++++++++++++++
 3 files changed, 1130 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts

-- 
2.25.1

