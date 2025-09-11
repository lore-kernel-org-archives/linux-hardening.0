Received: from mx0a-009a6c02.pphosted.com (mx0a-009a6c02.pphosted.com [148.163.145.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784B4A04;
	Thu, 11 Sep 2025 01:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.145.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757553167; cv=fail; b=LAfrIKRXgVc8R2TKyyBFwjzwvSKpPUpmC9KxANdetO+NvpSnuNF83Xm5Rsgp9p3AJazDn26fE1Ur7XZndxrsFmymrZcS/3z3LEaunlwyRNuBnvLJuT1iK9kqDGWKyn0D2W4eFQc246csKr2FEv0RBteJQSBbs9T8qD1DJd+bN9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757553167; c=relaxed/simple;
	bh=/H0jY6V4wWKrd4oIFNiHqIQSgop34xcW+4/OnyoyT6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sTUsOitPc7e1aaQEvUQ8WVJv5+0Ke4nvHBGF/OMwVpE12e4xzla9sCS6odlQCYy0fcSiO6WHvma4M0oC/C0T9UqBxbP6hubNUkdQxdauMIJURtHKJJ1SZfSOsX6e1KWl0V975o6O6PkN1ahHsHPjw0rm0A1CB/04xiceNuj0lsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=YP2ek7cB; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=XZyZTbjG; arc=fail smtp.client-ip=148.163.145.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="YP2ek7cB";
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="XZyZTbjG"
Received: from pps.filterd (m0462404.ppops.net [127.0.0.1])
	by mx0a-009a6c02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58AIqLOW3388628;
	Thu, 11 Sep 2025 08:50:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=20250420; bh=ZPKQ07RAwabGyk5JJ+I+Ceq
	/mwkbIDQjsLM6juhzhqk=; b=YP2ek7cB7/H2dexp7J+3J7fOi+OlMxOwARBHDgg
	kCFA5ozaIlKAJpgsEkeGsFpJsTn29a8OI3KM5CYPvwCNL5/iosDuiiHieGVV1FiF
	E1rnp5X0l1DFYx32xaEn7yDXFSESjYqqaeLZY4o+SEaJz+ojdJFUUrqEo770tHGY
	s6DHha0xODcas3F3cT+bfwLBOgulz7BRQfG5ooGDamuLakDHnS5Pd5Sd7A3MSWjG
	VfGcsU/A0DtJV+gRtBaR6xl+9xCWD2BHzKnjp0B+qdfxIC10Ub4OgNv1asm4I8KH
	7+ThyRtrcuunuPly5X6sJOQDe0p0IddW6Ytt4OYDmEbMUlw==
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013025.outbound.protection.outlook.com [52.101.127.25])
	by mx0a-009a6c02.pphosted.com (PPS) with ESMTPS id 493f08raee-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 08:50:39 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXVAJ1jOnIF+uvhPqSSgDzIsTi7WvFYtL+vOMWcwowoZWWBQWUB7/qY1Ue5jZV8+cbJmsqEyzULk+d+u4aoRVd8q73448flNJkJgigXWYBK5sHnzcoGI8TW9dTPSvxI8cBX3bkW19DJPd2SGTRRNhGI75yiH97QQcYdrkqFiKyWnrkufky6jzY1ZzKgYJ9NTwibHqbg4Rm4IyYsUzlBdtSEqGRJ8311oqb7oi4qNfLZyBlmMPAfqQVQVDq5lEkFulP2gW4wW8RAQWa7ZwCZXHyu4JPUKnTERYrQLXD+e/Itq37+4gOc/HcfsP6zIIV38Oge2nNvjDucLgnQqVCSGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPKQ07RAwabGyk5JJ+I+Ceq/mwkbIDQjsLM6juhzhqk=;
 b=E6NqceHc2ieGyqaZmNyu90vkTC6sCe+4RQIJePnIzlQyEpErg1S9VA955XtojIzaP18AtTSoViWL48T1X/69Y/Dc39NVnjobeSedfRfH9O8zYFb1i4fcwLjWB3YNa5ZO53HM0vcm3mIw/0qegMXm//NgxNlEJks2V++yJJr01640j9M7mSeejliZoARbmPDwfUeiMBQh5r+dU/aDaO5zWkXamxqcw2Q/7pQdBRpbOt4pbKsuqchoByPBhAMQQupxTz/BRmmZwqdxRyJpVv3ym2BI2JYp89TjKaptaw2aXtScOdIcyBcjO/aXvTj9BbiPFT73xTq9MlNVn0URC78d/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPKQ07RAwabGyk5JJ+I+Ceq/mwkbIDQjsLM6juhzhqk=;
 b=XZyZTbjG1Umb/ZCp+KgolqPyXsdl1+ls+0cw9y3shItXQ8aBcorTXQshOoNZRvJxBA14h5BFAMcJ5YYQt9W9yRizvVFE7dFlP/21n+VU6J2ecbwh0SJd/DzfIrGjh4ZmZthCCKkuZ2EVScst6K/n1wEpl8k3brkR/PEnhaWWT9luYt6O6BAnwsp/jSzdiGgWzE6Ex2C7TwdbW0PVS/iusJ8DXzU6WWb4bxO2HgPiaGmQU2By8hGkBWiwUwkJVSLviEpUDhJBp8rWVWWiDxcdrlHfherAilFTYH/ZQhbdRCd7OGPVZ0dMw4J9OhtQoCF/dArZMORUSsbTwfnFjHhkDw==
Received: from SE2P216CA0205.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2c3::12)
 by SG2PR04MB5820.apcprd04.prod.outlook.com (2603:1096:4:1b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 00:50:34 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:101:2c3:cafe::cf) by SE2P216CA0205.outlook.office365.com
 (2603:1096:101:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 00:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025
 00:50:33 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Zane Li <zane_li@wiwynn.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v1 1/1] ARM: dts: aspeed: yosemite4: allocate ramoops for kernel panic
Date: Thu, 11 Sep 2025 08:50:31 +0800
Message-Id: <20250911005031.106393-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|SG2PR04MB5820:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a9026f0-d154-487a-229e-08ddf0cd3720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bHMdwlUfZST3Mp7vyQMFEg0Q1WRw+DFqoMiPE+CfMayMwCJRvqFIzXXfEg08?=
 =?us-ascii?Q?c/EGt1GFfYIT6CGgFWk5Ta430DZG9D/9GGOYtWeOtic4hqsDk9oOE6A3RyX0?=
 =?us-ascii?Q?kJIKe4ccs7svdPtoAup55u7hgzedO0vuGtl+N6GXlUcL1v5UeuWJL7Z7enm/?=
 =?us-ascii?Q?c4E3GcJvwxFPiAa7l1OZXakLxCXMm7E/anjBV95mNHFPmBcaQ3d+mRlYEKqq?=
 =?us-ascii?Q?6pO60N3Me0A6Nz6jZEC+AkXkGyPD+Jt53dTIIai5szNyig5jmrAQy2LWD8iI?=
 =?us-ascii?Q?cirJnb+ywRTVJ1FKQHdxaUVcKcOtK5GweGAyOpwInsf2KM69HZJCbx9uz7sk?=
 =?us-ascii?Q?eGQdpONwGu1uL0CUJT3UiWgESPW/EHVC1QrxnVFLewsJJQBNnIDAxhRqpaYh?=
 =?us-ascii?Q?vknXqoGqPGk6+4uAGKmVfR39CPvxhWikC1JDV8pSnEtukiH5LfHJqKTGW45Y?=
 =?us-ascii?Q?wBJziSEQHqHWpC7qTvSIi+p//xre8aqcuUlNzA8xaJe05UDoAlVi0xYdCkiT?=
 =?us-ascii?Q?cfs8+mFGo2+Ej/ueeVjbrDQEbpoVZQkCFiwLN6tTZ+HoY54LlmGIkTflj9sR?=
 =?us-ascii?Q?RWTMQdWn1eLivAbyJpaDp4cQ+m5M/ka5jq/rHfaOD6QPjZhOW+FGb9xJMR5h?=
 =?us-ascii?Q?1pzE0TOYD94I8nIqWnS4umLyamp8dgcMrpnH0pcjS0W/3bbuXQQUmUEJzjBw?=
 =?us-ascii?Q?enQQ2GD1dyMHcNDYmZgnII3bZAqK5nYKboy+rPUJxovI4j2iqQ4GbqJqt1AR?=
 =?us-ascii?Q?mPUH55ibdThW0yuJqzEoaBQ6fOlsvZgef84tfWUXMo1whuFb86oVc1Pdh7sp?=
 =?us-ascii?Q?xY1Eh2pmK5hnELOUprZoKhY8B19UIqzxGJKJDEIUpKTQKwAOQeDmYUv3uUD3?=
 =?us-ascii?Q?8/AGEhIDlFF2I3e8EtLOrFMQ0j3VC0ouOSdJfXBPZmAfa/qoZWCFM3+q10KD?=
 =?us-ascii?Q?nbt7yWM2mI0xC4ijaaAM/KNFkKfVOOevkT82GFRQSbMJ1NLiJzoVMUiyas/p?=
 =?us-ascii?Q?y8mUwUYQNRlAi0QgzUBXJS1LNLTe1rdK8LIGtQ+pN7xZnjmgH6OKnS/cU5YD?=
 =?us-ascii?Q?KgobMJ+eKWGVPc+xJRg6SsUmbQFCXKB+zYdX9p7pqrcgiILPYMeg8UxDfYu6?=
 =?us-ascii?Q?ZKY5pIb2iFLKhS2TabPdXdt6SlDOb3CoAjjuckQRPHrWH00+Uqswn1Yn+f7e?=
 =?us-ascii?Q?sATjKoz6HNchHqO8D/hReNLUws+hLJAxr+mpeqGSJFEHWCi1hQb9W/hPx33I?=
 =?us-ascii?Q?bsfORaEnXgXxF5/J67X5RqgAExZh8KQKoLc82gmXAx6vP5rDoeS+L7t/uZP7?=
 =?us-ascii?Q?xACi37IHM4PJqtnrJXdB76ac/EAB1H26vG2Qvwi9uMKxhItqiGAVZu1A30im?=
 =?us-ascii?Q?qphMGn/qzF3m/fa9FggJSQtI2rAk516x9QRzPT7U832KtS/5GTSpRgxPUXHW?=
 =?us-ascii?Q?GVLFfpaIdz2dY/BiZrLJCUcMGfIXVKLLdA0WETux+sjDNREEp4tI4cMqoduY?=
 =?us-ascii?Q?I3yz3J9JOsfQ7DFAjBQnmJcBLXkVzZDWsmtD?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rk73RPT87GO6zUHStUJdcQZr0wDrOn2wdL+MlLxxIG9c6zhTV1im8c66+khpo5GUgxpMqBCkxA5lAcjyVTSwbvQttg0UeQg+kFD/M9s4FuotvFK9gIYfm5v80sUTYtfrpzRXCcYEFALE8ThabQMNwZPLiXw/Iq7wauZlXea/DzrSZTZGbRsS+Cbhtgg2dAgP9BKvfl4u5tdi/t3qKs5rXmYhIhK2/089sqbsT6hhNWSmFuSxxl2f6pCNWasJ1uaEXIzkRXaUR5dzDez19+vwYH9yj1vBmuJlZ6n74ZGFXBy4c/iJ4suy35wnGoIi1G/qVU2wmE4lUB144c+jhmkmrAy7q2b5w7QgbJ3pMhPPKwOLhhUJBQhGMfNqIQTscuK4tfH7XCMJjtN51f9YI/a/xZdf6o911QDRr/bxkAUwFjOjxK+cKqBCUnwTnbjXU5G5N13o+zUdy4v+adDZBv5Opyf71mEx72QXju6+HKgyWzmaaMiYBB0IvGyBa7Of0D/rodh8UIBnbR6euYAbjFBd5dF7U+nTi2PRGHS1jDq/26yXP5NS73ewIaooAjlXMdRzK+P9Wmfl5qJYuEZteJLpRzap9b795Tq6icsLFJ+DnfgGCrAttZZEz11uG6+ncNbH
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 00:50:33.4638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9026f0-d154-487a-229e-08ddf0cd3720
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5820
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDAwNSBTYWx0ZWRfX56m4zyTX6y4u
 cTMAm3v9pcvhjG0VyV/svSzQ2x9j96belVoZzS9Fw2h6vRLxfzw1hFpP4KfWNemLA7mfIXX1a30
 F5ucplmfIH1wS4IQrNboE7OHPeZ5dRz4Cv2QldWwwMxOk/VMod6RAXffVRrjmm25utfvpjKPCaU
 2SsszjSxwbAkBGSmowgoAcIhpVp8MXXI3cJDl7VDhViip1ksWLiptbj6pFkIAGhVXO7HqpE+2X9
 3El2nZz/X1214b3NACyFfKRydvThC9mwkkShHgp70au+Mn5jjwdAmET4LfWO7wTU8vLUZPcUURb
 fcr9Jcvh8c4fpgPOZtiJDbyYOs0+i9cLNvjmTqMAJ98fzL6ftQZKkCiS2X/ypw=
X-Proofpoint-ORIG-GUID: An46KwUAR4FalNKCGQNti75L8RY_uJx6
X-Proofpoint-GUID: An46KwUAR4FalNKCGQNti75L8RY_uJx6
X-Authority-Analysis: v=2.4 cv=BPKzrEQG c=1 sm=1 tr=0 ts=68c21cdf cx=c_pps
 a=S6QD7gy098v9jWutmuivGw==:117 a=6rDDh2uRNVCE5HFPCIqeAA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=yJojWOMRYYMA:10 a=4AL28aEVfeMA:10
 a=cPYzWk29AAAA:8 a=EWjN2FjsdnYFZB9OOiMA:9 a=oSR2DF9YFqZEN4IGatwP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

Reserve a ramoops memory region in the Yosemite4 device tree so that
kernel panic logs can be preserved across reboots. This helps with
post-mortem debugging and crash analysis.

Signed-off-by: Zane Li <zane_li@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index aae789854c52..4ec1abae1175 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -49,6 +49,20 @@ memory@80000000 {
 		reg = <0x80000000 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		ramoops@b8dfa000 {
+			compatible = "ramoops";
+			reg = <0xb8dfa000 0x6000>;
+			record-size = <0x2000>;
+			console-size = <0x2000>;
+			pmsg-size = <0x2000>;
+			max-reason = <1>;
+		};
+	};
+
 	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
-- 
2.25.1

