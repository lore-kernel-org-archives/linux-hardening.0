Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB6289E39;
	Tue, 24 Jun 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763101; cv=fail; b=oAUM41NJSIx6s99YV/mgTW0bBiOt6sf8pkoXItx1wK+SY7ILiMghXpUIlD+G1+3Dvm0zajvehrNjxNaj49H5t8HVJZPOUDYzB/XBSOkssp5VMzLA4B6iKAJ12kpg5d8vYvNfBtqF67hu7B/z98T7y4YH2cT6eNDTv+s9yiXYLpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763101; c=relaxed/simple;
	bh=QoeVuH/wTCeVMrjCkA59GoSTXyhJl0PPBBRtZtxrvWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5ZUe6wPgO5I7wfZLI/sWkGRn37IoCv7djweXBgzZ112KZXDjrqBmP36eUL9/bd9lUISfD+Y3K60Unh/ISDC2cteyTEmW5CtFoDZD354wz58j0dz94aDHRh8EEzqzaafOilakRV7DU+M2jtKJhLqidKD22mM2XM5OVWRzs6X6yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=l3oBpnX2; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="l3oBpnX2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUsW3hEfe1blmTDkDW5LrPBwDUHUBJjsrslUCi/fToxbrT76+Egn1VA+7pozDUwPDkyNvo/4EdDb+HcvrgG5CqlmQCu2H5Uxml9XH3f9Dgud3q1tB2PWqUDOpzoSQ7ktscCVDjnZD5oQYpgCX9t/XKHDq5sNcv2F8lZ5XuJ/i6vN3VOdWwQmvSWYlOKYC2kf357TEyFrqCVJyDJzK4r65eC3rnkbQpJTD3ztfdZoowei0EJQCL2Sv4/Hg17CyxITZxFqIQ3KBi/WbkmIC5IkWbKCShY6cckmWxpYCL3dzU7wJhOyILDDuW+ttVUuhn80TUGAcxPAuInDR2ghAgvqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz37444ALJ+0RXHBPGWw19EyxPbmY+y2OlOE1A6Leu8=;
 b=xXEQsSgbaL3Lz3FaPrQ0WAwyd+hH7varOT+/pfBDC6IYAvG2sBzYNRugjJ9dnxXFzK089vuk/1cYXyWZbLkk3qfxZQenAO8zFO2l3bpw3kE82NJVR89q2f7WI5lowrzj+IOjKGQmH7MVeHxaO3zKsaw/cl7sZyaLE1v/9Qyd7RqmTnQquwqRd6P0Ej7tf/w9bKwCwr+DiHnO3bGxoYlLIuc0noe6V8MEhaLi+p8DQtkwBzROE5NyYCz+B2aavPp+vaFrdqeipHM0osr1QmM6b+gA/XaF2xJPpA+quv153z4ztIOtsqUF17k3IKGgHxqOApN0nWDGYqMDrxrsZ5f66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz37444ALJ+0RXHBPGWw19EyxPbmY+y2OlOE1A6Leu8=;
 b=l3oBpnX24avOI051lCG7t26+IPI+yd6gkAsmJwfhG32iNn7GPYyAu24a4O/F7ZgRC5k7/voRvxEwuB9kYEh9iqH8K902QfSQuZO51rfgm8WMtE5KZe7a51NDe9RNzoIPZQJ6yi9wtK68JHbcZidrLy+I5loaGwTu692NfUYxU3P0msh/athK+4sa5+VTczLpxg4zylQJk/TMt2fs3JF7k1NQ291EEa+ZsbLBIrPJ2GZmtbe3u6cxDceg9ataXIhdkuo5Yzyas5qlg0yZBrzMS4NilcGLSkbqbvBn/MMrMu8zHWa+/SF/g0ZnMLg0DfXq3wTTuxTKmOSM6xz56+mB2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VI1PR03MB3856.eurprd03.prod.outlook.com (2603:10a6:803:66::33)
 by GV1PR03MB10728.eurprd03.prod.outlook.com (2603:10a6:150:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 11:04:53 +0000
Received: from VI1PR03MB3856.eurprd03.prod.outlook.com
 ([fe80::e9fe:470f:27e0:b265]) by VI1PR03MB3856.eurprd03.prod.outlook.com
 ([fe80::e9fe:470f:27e0:b265%5]) with mapi id 15.20.8857.016; Tue, 24 Jun 2025
 11:04:53 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wojciech Dubowik <wojciech.dubowik@mt.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Markus Niebel <Markus.Niebel@tq-group.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Michael Walle <mwalle@kernel.org>,
	Heiko Schocher <hs@denx.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Tim Harvey <tharvey@gateworks.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Junhao Xie <bigfoot@classfun.cn>,
	Andre Przywara <andre.przywara@arm.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Kever Yang <kever.yang@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/4] dt-bindings: arm: fsl: Add Mettler-Toledo Snowflake V2 board
Date: Tue, 24 Jun 2025 13:04:00 +0200
Message-ID: <20250624110408.128283-3-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250624110408.128283-1-Wojciech.Dubowik@mt.com>
References: <20250624110408.128283-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::13) To VI1PR03MB3856.eurprd03.prod.outlook.com
 (2603:10a6:803:66::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB3856:EE_|GV1PR03MB10728:EE_
X-MS-Office365-Filtering-Correlation-Id: 9985b2d4-afc3-4861-0a6d-08ddb30ef242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uW81v32ARUvx7LeYhmkN+RjQhi+r2IphW3ISOarvcB4FpJ7PFAH+P2UCtuKK?=
 =?us-ascii?Q?hkzcldZ78zqmoTdq0JVUh2gnmkM5zumSeOVW/dH9g4YXRGLzjbQTAlohk9yR?=
 =?us-ascii?Q?5sg+dnq97bufb/HkV9/YyQdS07HE47uylbGylEGFNrn7rynbmH3K8LsU8BZ9?=
 =?us-ascii?Q?wQuTGxsa5Pqd/100Z5T9z4Dlza9Uf7TUaaRIjAx7yVcV81V+5hogL/Fo6k0F?=
 =?us-ascii?Q?t0Y/1rdO8EqcMyarxyou6h0/TC125z5AL24zO8TjxW1rOACGymTCqZQ4ViKy?=
 =?us-ascii?Q?qOypiwqa7vxM8IMDwyx87MhksoD8z3WWEQ0TkKOGvIycLG4HkwzlsIX+BiOt?=
 =?us-ascii?Q?ki2zw8ZMHjH/Pgyn8pLrqm/w/fgS91G61+z5sTpVdj40pzge1fKpNmV/R7Zw?=
 =?us-ascii?Q?lHrJsQnWKbHcF/u0KfmATD32FJohCogBZ8twnlMM+Mwm2zIQvxE56hKsnB/m?=
 =?us-ascii?Q?dnnkSWX5vvhdeU+j8f/zPSeisDkTLcPPS9DCvH0zFJpRaOfPs+5MEtsMl4h4?=
 =?us-ascii?Q?sSYdttFjB6J8LjC/KoLRGrLP5UaYZlfYwpoyLzWHBXVzOnnk1u2ePb4we8+y?=
 =?us-ascii?Q?UttCNdT/Iclth2bfTXDXgOqGjOTX0iMaqI8wOGb4K0XsrhuS8ptVqsbUUKkc?=
 =?us-ascii?Q?2yZGwxoBuwIxwu5hX6IHGppyyjK407xHhVn9y8fHtVrbIOOH/r3gtF1WISuj?=
 =?us-ascii?Q?vgen2Iwcb2HDQJnSVzdXGW+FTLkXK4Bv4/INLpcpoKiZyK2vrf46qkv/VNLV?=
 =?us-ascii?Q?Az+Q1U9qSIAr7lgUu3JHOO49IC0/HsY77JsFxbWZY+pJ+gKIGS1q+x1THj+c?=
 =?us-ascii?Q?ScLL/fE6u/Uia+gtK+VYvX4ahLGgoL1WX1L8BUlt/LByiP+strYZKxS1wHa5?=
 =?us-ascii?Q?xK0gMI7QiEWZkR/EMBO5/SwrEeEVyHK0kY1sv0SUl8jTllWD+c8cU05WJjMp?=
 =?us-ascii?Q?kHOxhuoTD92yHdj1vxMEFCOzDbwHJzsWm1xsW2ghz7Sf22NufGuDIpXzVGEz?=
 =?us-ascii?Q?fjoCDy0wNfFqcY3/kufkPStrSQz5ZI6LjEj9lVDnA3AZmhHah/WA5TAhGYy/?=
 =?us-ascii?Q?dTGIE6bZ2uWCLSX9tYeYxERfrO+m8lWXufMuH5pzg35jySfp5kK8oOVpKOwR?=
 =?us-ascii?Q?mBYvsJroNvNTwcjDTj0kinGCbEzNvZov9RJY/hbFTW5cIcg0UB/DydHPMxWD?=
 =?us-ascii?Q?WSvYN28icodBwU+wjGUL4+BZKC2ja8kuvN90u+zrfq4ocLLWnDD17IWngpME?=
 =?us-ascii?Q?zvFsZT+I8VnQ/WEO1gvwZb/l2swNh81EPH6T/MYx2IygoDmdQk3sP4FX5guP?=
 =?us-ascii?Q?u7/vwaqx9UohD6ryn9ReGh3z38k8VmWOTLbDh9XatNhCnx0284QSmXueQyYX?=
 =?us-ascii?Q?xfnVynpFA7sdVx84VNd0w/MQI487/MIy2MNVhZYkZkwc3Gj+qceUv1tHlow2?=
 =?us-ascii?Q?muT0Z2FI3btrss6Xi6NUmcCogh6VB/ahLPc1Qi9CjYUdeuv7tibdXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IEys7kR/Y2g9s+22YAiHkbB/jorG4nMhmW5VRm8L4w+EldfrSo51H292V9eZ?=
 =?us-ascii?Q?f9FQZPHaYQo4ezzU/24VparA0B6ZEj167x3JP8/bqMKq7+IWOLk3wZYaHSsF?=
 =?us-ascii?Q?XeGINj4Ku2989rl7y++NxhBHA9KcLzuGksrtnDhVFmyaHPdZfZkKGBXK/pcM?=
 =?us-ascii?Q?0DfYUT8NL2p3X8hsQ4EbwCet6G2NppJWwYyDxS70m5/17bRMCQt3QOdPnIxI?=
 =?us-ascii?Q?2YqMJz8Uophv6KfMk+yn3tRobyFlpxzqFancRpuf7ahrXGwrK3ixECxTLvdU?=
 =?us-ascii?Q?54/LCH6vmY0INp+uy0O9G4s30unfqpx6P92YoT6P5eTQ4AVqLM0NaDtO5E91?=
 =?us-ascii?Q?pqy1TwnOzbJJl3OIG+RuUKvmSmy9dFFDhwJwMFXz32y7GsF27ittfTtBbr0A?=
 =?us-ascii?Q?TTx/siTYhX10o33eDFNPJJf9dFOTkgXnzOr9B1Syaj1NBkuNKx593QovPNeB?=
 =?us-ascii?Q?3wlq5V+FQwtZsFCfDSRpFJZqztVmHUiiSSbCHA+z9iO9UyrH/6RPNA0R1RJz?=
 =?us-ascii?Q?+ZD2DIjKQFJujqjwUddq5iCqHnMIpO2CSJd1bZZ+RIXbOscBLNlXsznlybmM?=
 =?us-ascii?Q?q+aB0EFVfnbDf6EVoO/DPGKP7bFE9XxwAsT+kj4KRJTFet6TAhVqx22O9RNp?=
 =?us-ascii?Q?SZf/EQuca8PoVk2ypkThWCRsFVOo36Q0m1JQWxCOjToSS4jcICHflofeEXYB?=
 =?us-ascii?Q?oV6Qq8GOAokZcy0+tv8Rcb+Yqy+P7h155lEllnJhuLN7z6bY7d1mHW+kAdU/?=
 =?us-ascii?Q?0FcUM6RTvJN1OkR6rx6uVevk+9ibmA/3pGmTq8QlkJ0nHqOh+rqgGcgAIGNt?=
 =?us-ascii?Q?1xrio3f5xt4PjZMtR4590lk9GHTO+X7HhLL9sn+OU33mnKs8seMQnv9TMdK2?=
 =?us-ascii?Q?piNc/oW5AKTWTi6D6i7vhhLm9NVh7Od7NNlfvM5ZgEDShiS4vMjAvx0J+eEb?=
 =?us-ascii?Q?PEYaMSCi4TfLeVF51ZkZn6WqN8/aeipIRGriFdTlKpTjPIu/+HFRMyw75Yso?=
 =?us-ascii?Q?WpSJgxOtaoCqcTVwOUKZDhqcN8FYe36eWj4FPxNd0oNGl7KIu/JVBtTVRydC?=
 =?us-ascii?Q?H5hz0mfN1qUInkzZbRDQ69KvMUOVkRhMCFQoTbpRlMdE4Kd4ot3Notu+xdpm?=
 =?us-ascii?Q?LZNDUyYwQNFMzfS/E+xnq85HMa5LSy6tc2+f+mCaXT3fMHFmOmt+EVq/Dgg0?=
 =?us-ascii?Q?ife1gLa53BzE0Wxcr2LHOt89rFF6+eeqddBwYRBeu6ArE+cedzlGwofCL7Ir?=
 =?us-ascii?Q?uITNXQPvA8qUWoeqS2s0XiEfTv8h4yff8GeZ9UP5SFeuZzcZv4+RhTTd0MtA?=
 =?us-ascii?Q?SN/MovSsRmUg57XSzdoT1kIg8OjQQGbnYjbAtF9kbjA3GLbSwdbTu/0E0atc?=
 =?us-ascii?Q?J8imcnIk9UI/U6SS8+KQGrjs33LWF4tmR6nxCRQnWGSfUNhc2wTTk01MgcgZ?=
 =?us-ascii?Q?K9B7X4Vb3MGYTODd0aJi+ePrhL6yvj+VMjyHZGHFAcPffBSSyEZrGdyITyX5?=
 =?us-ascii?Q?XKOvFqIbOmYoworJmw4y80MAYT1M3FQ1tbhcDsCU5kzqwghLzO/+kcziOp7I?=
 =?us-ascii?Q?pZdJ3fie1CU7GlH49ZfPLCPgBCsOy4IotOUOM9sJ?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9985b2d4-afc3-4861-0a6d-08ddb30ef242
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 11:04:53.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXlm0I0wf+s/+mxERAhPW3LAgl8+fpvVVyVU4KCddIEDqOSyV+VRBwa7NCYKf8R5ieBHnKKHp4SsXP7NkonmTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10728

Add bindings for Mettler-Toledo Snowflake V2 terminal. The board
is using Kontron SL i.MX 8M Mini SoM.
Split the existing Kontron BL i.MX8MM as it uses the same module.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d3b5e6923e41..fe5eeb4355e8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -986,9 +986,11 @@ properties:
           - const: engicam,icore-mx8mm             # i.MX8MM Engicam i.Core MX8M Mini SoM
           - const: fsl,imx8mm
 
-      - description: Kontron BL i.MX8MM (N801X S) Board
+      - description: Kontron i.MX8MM N801X SOM based boards
         items:
-          - const: kontron,imx8mm-bl
+          - enum:
+              - kontron,imx8mm-bl                  # i.MX8MM Kontron BL i.MX8MM (N801X S) Board
+              - mt,imx8mm-snowflake-v2             # i.MX8MM Mettler-Toledo Snowflake V2 Board
           - const: kontron,imx8mm-sl
           - const: fsl,imx8mm
 
-- 
2.47.2

