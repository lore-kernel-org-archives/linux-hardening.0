Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2FA221717;
	Thu, 20 Mar 2025 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489250; cv=fail; b=mDL6FTxdJNElnDlc+p5Z9qifb6kDcJ7r9tnHQqCHGicFKMspe03uIherH6bZGPQ4N21TTdfyfGTBLP8dnR63TCALTjxvegxlpho/NwFhdeyuRwm25Qm5Af/KC5Ume4zg+QtYXeIwFGRQm3d1WgixBz5gORgAOIpUApac6SE4Ugo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489250; c=relaxed/simple;
	bh=0ygIGf2m3sVjT8SES9vxOomwdKS0GV6pXgJi2wSQMfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOnBIxJjRlsTMjlS4FjyIROKFJU3/y3qfBLBh6NGHSNIngWJpNGVJte+fEsEJXOV31NCdehqYT1bqMzhgEVzjIA4Fx4pfvXkDy5XVq1dNGNXbf06YwIe4EH8tbZ3Grzx1gvKKfzOWqI7MX+Yp1tDWPZzMpcieGYpOA1VS6rAPfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i2jXe/E6; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i2jXe/E6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yh5ReJXPoeu3l8gQh0K3o+B+sLeT94jfyri0XOsQ4Rp3YrS//LiFdBpJ9rRY2r1f7u90GAnnNj8wb/fTo8GPZK2qz0O3bW8BbZoITlZX5EtiIHZMz169UcqHuDiQl619qRK6HjPMhvMFXlod94doie5iApz4k3SyyM1QS9TVZg0NRYSALVmO+4RkWL0v20atwV28ddR6/CBtv5ZKfGqDNHRmsXo6n0WeVUkTOnJmTcZyUA5k7c0Iir92SxE+6u2rTsokGBSItIoja0JpjhCH8eNpz+c9E7YJeVQzrJA/0b/nAAdqh5OJ0pXFMoYDZa/ephQ63HW8BuXhhw/oMXqCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGwj1AVsYPOh63OOBdys6u0R2ME5hit3ehrcKRYHRf0=;
 b=IoxuHC7NWaOhKCxnkdkfeBkf7Ty+m6ATsARfpBUfJYuqMJWoOQIUyHJBFsLyYOUxzsa80n6hLTX7neIOH8dwGm6kkT0C2EbU/ZD7FMFm7VM8PiaIuPKXd+0DbF0sFb9SuF22seZWP/IR4tzXEq4a2ZOuouX4FhtCxxnKUQ6bl5YlzQifKAk52tZyW94+WfAVO6spdsdt0iV5KA7p5NsWAJXpnBTwRdy0Hqhpx/dec1eFp9iLU+oBveRZyBNa0vs/A0mJiq49iroGoEOH1iCFUotKuw/aDUTdSLFUhldEh56Ie9EFacP6Wx2K3MuspOnaRlI+ZH/TWTLXi/XixvVTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGwj1AVsYPOh63OOBdys6u0R2ME5hit3ehrcKRYHRf0=;
 b=i2jXe/E61tbhmaGJq/VpSfUIQXSeHc3hGu9zcAogJ8MujLJ3JyyrjvD+JCNly6e3EuajZt5tbczCxaFaDZUXY/vQq+NBlM9RFDon6SVZGFMuxSmazTiXFz8vXS0xHMcxML+Uk3FYEtyP+w1KU9YwKsMqjNYLcHnxMW9r+Zf0CZB6Hrb87s2mwDZ6HB+A2JDwnxYUwjU5OnX/9GGTUQk/JW9xoi8z8FL3ZEDAA55GwPUnXk3y/+BhuNc46zT1wHhtEURbCLJ6Vw6BTQ34E27aTY4SFvVg3+CPDmCbLmRkiEAeyoDD0oWSeEaBqzBLFlLFWMEv2Mn1m+XFrftEFmD4kg==
Received: from SA9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::17)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:47:25 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::7a) by SA9P221CA0012.outlook.office365.com
 (2603:10b6:806:25::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Thu,
 20 Mar 2025 16:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 16:47:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 09:47:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 09:47:13 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 09:47:13 -0700
From: Willie Thai <wthai@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <kees@kernel.org>,
	<tony.luck@intel.com>, <gpiccoli@igalia.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
CC: <wthai@nvidia.com>, <leohu@nvidia.com>, <tingkaic@nvidia.com>,
	<dkodihalli@nvidia.com>, Mars Yang <maryang@nvidia.com>
Subject: [PATCH v3 2/2] dt-bindings: arm: aspeed: add Nvidia's GB200NVL BMC
Date: Thu, 20 Mar 2025 16:46:33 +0000
Message-ID: <20250320164633.101331-3-wthai@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320164633.101331-1-wthai@nvidia.com>
References: <20250320164633.101331-1-wthai@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: dd25bb09-32df-45b1-8a97-08dd67cee47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0T4iF+757M0tYgxLoMGQ5SynBgOj4geMDoRgVd3kJ29k7h/9Ako7amWcAXCy?=
 =?us-ascii?Q?NJhlixJgXdgGiqO1Sy3+3xP6ZNvOmq7C+aHLmoTuvW8O4qSuKXa0YFg7D6hi?=
 =?us-ascii?Q?p6o55C3KlGzjeIq09MCFcWgiceYre36Vm3ScDDBNVPMcQF9GtrO/ffQJTSET?=
 =?us-ascii?Q?ydg3/xgg6HPtHlE9xvHxtlTCAXGAtm2FI8iu5sAPWJfoC3ilxoM2V6cvgc8w?=
 =?us-ascii?Q?47xeVpapQAoSf2F5pKF9wMTB5aENP7Z8L0hL1abHp3xc9Yr+OiObtJOIPDPK?=
 =?us-ascii?Q?CEOxLKDnDoysnGcvx8n9nzcvGOXIyhy/DwwHlQuAyTDXhU91LZbWHaN9JKnU?=
 =?us-ascii?Q?oOCiwzCNU7dCzAgjmvgics/dF27VoEpn5LPOY4iA4tL9C0eXZT5fBz+Bbe9O?=
 =?us-ascii?Q?Vpzl1lusy//oHEiLFvf2+acr8jwvim2FkgmGG8vdklPjyE3N0/9gNzJc7kdA?=
 =?us-ascii?Q?FRYVD+7VfIFjNvXBfLuzGbwvHzDlxy3aOUk9fWATpp7ucrNQExqO/z/rvh4Q?=
 =?us-ascii?Q?kBY8T0Sur3vcK6+WlYcYJFknI5sUBWnEyq1d0rgPLOsEAjlgghuUyPBPnKzx?=
 =?us-ascii?Q?Ze6gHz+dsbN3xXOI6P+TazvD1ommv4yILT0c09cOLvPsDdZdOjaWTdI3aYgg?=
 =?us-ascii?Q?bzy9Y2qdUZhfqcrGYxqhqnXFL8RSUlee7TWtxMPiCDtxUW7lt9/JQuf+SPhI?=
 =?us-ascii?Q?TjkTufuJOfvN4B/L2llz8lHg5R2s6E6JnMQRJVFSj0OpL+enjuW+SSyUA/dH?=
 =?us-ascii?Q?CDUw4HVX9a/BAa5GZBy/jT5IcQ/EB+toW/mxe+K1vYKCrpMDsT58qWFQvFlR?=
 =?us-ascii?Q?jAPdrffRjbSZcPw9tKB9AcfB685sK8gSDBimLDMgSSd29FDk/4RxFZxUboI9?=
 =?us-ascii?Q?kmGv/ff93kjtab2oLC5vp/ZETPMdiF6NUqoEKk332Opv01mWCapiA7KIUDwB?=
 =?us-ascii?Q?JOf5eYEcf0bSh+Nss5e/xt65VhnxpEiHzOXU+lpUYS8x7PxN2U/uKcqmQEHf?=
 =?us-ascii?Q?5o9y1pNxPgmrs8RyCJd3S3eXdw1Q46WQZABfyiQ9uXpy1ggGF/rTCsPbyO2f?=
 =?us-ascii?Q?gcf0f0FTdcA7GZOVSvKdfKw3ZJKohQMqpKWNS2J5LRRK3k7pCKbAaEa1HoRV?=
 =?us-ascii?Q?SnpaT6kfEXkH64DF18AL6JpF3lw9d439GyiGsnYNHAyfqJKUQlmynHnfSKbT?=
 =?us-ascii?Q?2zEbdtGY+rsjTBYS5f6SJxWtPiGuCkvjDo3I6WFGYZou9H6xqVI3ACqE+f1s?=
 =?us-ascii?Q?hHrxAHs1yBGdI7zqonzkWAwEMmnpTP8eVAEcym2direoX9msTTR4wFi4mNmx?=
 =?us-ascii?Q?EkgtReP/eDH8h0Pm289VafejkjasuuPuR5EzVN7cWMh6a8ktQ9oTbLZg6AEl?=
 =?us-ascii?Q?PJDXx9IDE2botrDXsd12WDxbcw6We6CIavj0eHB85m4hOoi/FG9RVBY3CLjW?=
 =?us-ascii?Q?/9TophNT2KYxr66fKpgRL0TJjBcVgcfmk+BAWnfWHM3powQ/XNxyL6HQ3oo2?=
 =?us-ascii?Q?cl8dvtgVWs5j3LM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:47:24.9494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd25bb09-32df-45b1-8a97-08dd67cee47e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248

This patch adds a binding for GB200NVL BMC.

The GB200NVL BMC is an Aspeed Ast2600 based BMC for Nvidia Blackwell GB200NVL platform.
Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Co-developed-by: Mars Yang <maryang@nvidia.com>
Signed-off-by: Mars Yang <maryang@nvidia.com>
Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
Signed-off-by: Willie Thai <wthai@nvidia.com>
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

