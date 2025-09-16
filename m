Received: from mx0b-009a6c02.pphosted.com (mx0b-009a6c02.pphosted.com [148.163.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7ED1E3DF2;
	Tue, 16 Sep 2025 04:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.141.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757995582; cv=fail; b=PIUNW0y9iVgOIQq8yxskTpGLd0suM96LxYNaSTtAktgbraXarzYhcipwbE96e0kmQ+sBWmbWZ4p+vHP4X6gY4IAsCvxhBO6nYHrLg1+VQOWIaPTU9fvAd0pZYmNp7V9iCvftmpVdTXCzXX0R4IRGU92MMlZYq+wSxaTfv5XiVhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757995582; c=relaxed/simple;
	bh=/H0jY6V4wWKrd4oIFNiHqIQSgop34xcW+4/OnyoyT6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MK7CI4vEeOkdCFH2gMyAluAYkLTLrYMs1aSw0+izw4Z5nTrwgI/kreotK/a9cy6WbCjPJlB3SNxmrlSSpJoK96Lm42MvCasFEnDhVo2O88/wmj55Yr/ZOQhsVud6dZQwoF++FgSd5Mdq2pQntT3GmGqXgPiOt+KwVAp7x98B+rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=jE0MymsG; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=IRqZU/Wk; arc=fail smtp.client-ip=148.163.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="jE0MymsG";
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="IRqZU/Wk"
Received: from pps.filterd (m0462407.ppops.net [127.0.0.1])
	by mx0b-009a6c02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58G3SRqF2940147;
	Tue, 16 Sep 2025 11:40:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=20250420; bh=ZPKQ07RAwabGyk5JJ+I+Ceq
	/mwkbIDQjsLM6juhzhqk=; b=jE0MymsGBxewUkO3uCNF7mY8mO7msSljRAf+X1U
	HJ/qKPOe8ksXEMMhBLAbjYykcmb0RxWnuZ3aLuyJJ0cHm1PoPveNxv4RR5W1SwHP
	moV74siaoklyd3D1LkFZbiipcC0r1Eh8kc6U5uHOhjGT/tODB1E7rO81IugHuIg9
	2VOGbDGCKwAIXUU9Y6mx/R/kor3vV88noJcrS/eO66vAbB+CYHNQPVda+FweH7tp
	uzpprPagGScEOYKVydtjKRN37XlBpwGWv/xSJVEgQPzKPJKw9wonOZa3z1HyhKC7
	zLDBfPhmYri5KZzMzCIXY9geMQcb374J03AhRiXiBJ/CiZA==
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012045.outbound.protection.outlook.com [52.101.126.45])
	by mx0b-009a6c02.pphosted.com (PPS) with ESMTPS id 497015g0cj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 11:40:48 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkrDkwwBIDdJ7xfxYmvQpa+cFOAMAZhTKOnX4mEOTx7gMmLjGQJahxEbEd9FyuYX62kwUQR00ZEMhh2FEaVRwQgV8MiGKNqwzjf56SeWndVDpCNhVmJza22zXIquEBPBNvFVQx0UOiVBD1OE5BFy2X50cO+rhXyRPn4eitgjWObPN2T2My+dh7pVH8z7Bq8W/SNH8uSt/0h5d2reu4NVB1N3h0y9nFjQa8s5mH+wl1Z3x/tVr4QWnkGDq1Jy6y5Som9ZhJufpzuVDzWFQNWGxp85aKzF73/oFGQW/3UyDCT0SdU4Ns8rLEavi0s/EzCNDkdzaw2Bk1rPj7KIJMXVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPKQ07RAwabGyk5JJ+I+Ceq/mwkbIDQjsLM6juhzhqk=;
 b=SbgvSgH/+PbTa1Pw+bBsbide9vqPeCba+hiZ8tjy3n0AveLE4DL6ppZCAiC05/8vYOlcuRHg/7/olhtJhvHJ6WNSYGMGlVLy4xjdOazovPVhttFBCWB4e7NFeD7xgSmgdvPmML0Kt90j7+COgKH6P/7aiT34LpXDadX0+ZcdVFB7Tci08WGt34gDj+hMf8COuB5hOfW4hV4GKn77uLcWRGchhLY+5Db6oJUOsm/cDLjQV6hjnj5av/4rO+lyrJMfSh51EuNUUYhSuNvXoBOK1hCsBAPzygm8z5/0hhiQOMIJLntZ1677qxt8FLeq14S01efLPwksHhECeQ2RwM2MMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPKQ07RAwabGyk5JJ+I+Ceq/mwkbIDQjsLM6juhzhqk=;
 b=IRqZU/WkYNfJ2j8SYigLfhtZx7D94Ofu3qqd6YPqVBKQNG58x6t16SZlxWIeBhOrb00BGO8OZMxtS/qxoVeSu4Qsgu3IY/IRLhR3Ij44SiGwp2B6jroRWxMlBYpQYlJAJYNS/qB2U5iEzMThzN5ZEWiyUAlQjX4//EVYXKnWdKHEQ7JUOSjwwapC/WY+ayprqH4VItHBpEmZCfeOJwzTx6a0duLVFAjXbfcJJfcUuy3shJYE8tuN2dk4wjuSAHsC/695PVyjwJk2RwKue5goJBk9un4gKND2GCkwuf0+Zu3eSXlHfZ54BlDR8nsactqxtlehxLEGV14Rp27LNwhpkA==
Received: from SG2PR03CA0115.apcprd03.prod.outlook.com (2603:1096:4:91::19) by
 SEYPR04MB5716.apcprd04.prod.outlook.com (2603:1096:101:89::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.21; Tue, 16 Sep 2025 03:40:40 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:91:cafe::54) by SG2PR03CA0115.outlook.office365.com
 (2603:1096:4:91::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Tue,
 16 Sep 2025 03:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025
 03:40:38 +0000
From: Zane Li <Zane_Li@wiwynn.com>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Zane Li <Zane_Li@wiwynn.com>, Zane Li <zane_li@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v1 1/1] ARM: dts: aspeed: yosemite4: allocate ramoops for kernel panic
Date: Tue, 16 Sep 2025 11:40:35 +0800
Message-Id: <20250916034036.348247-1-Zane_Li@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|SEYPR04MB5716:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1137cf1b-ddbe-46e8-4352-08ddf4d2ce6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jM45QMDd1Wso/Z4THH2ww/qcz3WSWni+8gkjCTtZNVpkcgZokfJyL+ccYPSU?=
 =?us-ascii?Q?ai2ffClBwH4MvMS2jtquVAIxBkCN84RUQhnAETs1lkV8gXIo0/myZGVnWqpL?=
 =?us-ascii?Q?B/Tt+PopfoXuHXNs7sGQTJinx5dP6RKfPUR+QaIeKmGf9cgg+PuV/ioXV68N?=
 =?us-ascii?Q?Wd8nZ8iSOmR6W+78oBzqqHjhsHYrcjb0hDASh/GJJXMCO8fcc2kE/zI0gXOc?=
 =?us-ascii?Q?/c+QLGdVta8/hfn4D1SS91/GIxNYB4JU9KNIEMUKK4n/Wk/Ey7b8/a4ivGVj?=
 =?us-ascii?Q?VN3+07vdkSE3jtb2Hf0rkgJJdXmbYd5xMbWSCqlNpqb7XlpY7HZsRN0+Zc8C?=
 =?us-ascii?Q?F7FNbbta2FIvua7DO0Ss+/CfYBhyJqakmGOKU958idj+ujoUrgPS71KqHugO?=
 =?us-ascii?Q?Pig7W+RMzHt6oLsSymCLdBoJw+D15fci6dmJdGi9qSoBpH9OTVQrxq3elmHh?=
 =?us-ascii?Q?tAJfsHm3lFPLZj2CaEGQagl+DoIHHdqf4cbghrNVsV9DdiHEVzpigoVm6Pxc?=
 =?us-ascii?Q?k3Wzv4+dF75VlSklizZKbTYq460yfLgUu4DXhaCY7PiQoQQBESkgHACEjNDq?=
 =?us-ascii?Q?Qeg8wcJ55syrRbUGeTXljts7eRSq+BfIjh37xNlCJPGJ2giXGsFO9fs2zJ3x?=
 =?us-ascii?Q?7v46YG3nrsapR2zln+o/+tfSsKTdr2aechpYO4/ruftQ0uy67RROQD/ZZc+F?=
 =?us-ascii?Q?nYH0JSzfkMbbRSdqVIJBu/r+jQQbPEOzUaY7hD4alQwnAAAAKVPilc93bXaN?=
 =?us-ascii?Q?aqqW1Fxy/M8BzUxfMiqn1avUjxi9dGdWasy4nyb53vzXwIiBG+IKRGCiz1X5?=
 =?us-ascii?Q?AbW3eBz5vAMj9hKVkEVXSLgrOYkBkoYYoZhwQVLsel77TkoslwZ8cWKClpgF?=
 =?us-ascii?Q?NDTd9uv6287bgD+TfQqU4YYp/DR454ANQGLA+zc61LDxgo/rOneKJKwDlz99?=
 =?us-ascii?Q?EoZudT7QhBR9aXisRk3SgClaWDZo9+yAcPENMj5QT66MzYS+oxLL18Ym6ygY?=
 =?us-ascii?Q?7MO7dy6zvr+PWC8UhwcWz/mpgG9H6RqPDRUkpCyqVpg88Nmvc2GbjzOh/WAb?=
 =?us-ascii?Q?Is/njlAxxf2wR+XvAKmJZ76ggG/GyE7ztina/9UwvicnUgK3H0u76dxvPR9k?=
 =?us-ascii?Q?zDwMo2aMRocboomYFPG8zkcSfkaKalbjoIwA7gk6LilI5dlRfh4CFE14JQSq?=
 =?us-ascii?Q?sc8c8v290MbDozNR6vm2ox0fuE46rlAnRI9KeQhWpTMa3yNTjfJrLsabirjm?=
 =?us-ascii?Q?YA3c/i7ac+QwPJJtyF1Py/bSNKi/uOCy/HtbDqIGn/aLJjs2uiYAzelb+z2y?=
 =?us-ascii?Q?NP29zIdiW45DCpgruTBXJ6pistd/yIvmJ6PLrtPvoz46NLIWsCjipdeM760D?=
 =?us-ascii?Q?Qh9UtpyrFwFHhbw4eza1nYJCO4aSY4QsU0hl0PXuYQJLhuY9mO6AdSnPOQu3?=
 =?us-ascii?Q?q1E+xizBqVCiC6mUizyZ20ch09/uzj3GbPEOmbuctfqI7Vt5ygKNqEv2QDrp?=
 =?us-ascii?Q?uYQg1uqwbEx2LvXFcBhnCEUPbr+FxKPnuHb4?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a7xOfINWCKmD9JbSncTgIfI8nON9EK51PR2bK+4RixsYfBKd3RQVmRQEkkk7wuymGHG4fvu13Br2KXJ3WNV4SMljDMiiLw1kXtGvEzTh5UpLTozf1JdeKA//fg5Hc0aKFBo4h2CG2xbZ9KE+P/QNZH1Ps3ftrh7ltXUb8k6yAPguc8764LDohPiqGmOYGAhrgioNT5HW+C4zwYr9d85B7fJrTN4mAp36I5L7ALRUi7DFDgAkEPBqPXyYeYst2D+b8wAIZRPB46OSssfys88Xn7qlt8V46ko0oXtfm6p7lZ3uhBnjwonbJUmpnGXVoQHfMhd0dqAT6XnY8fvaR9DrHJTt34LpmLyb0wDR8jclC4XkRIpH2ggKXWhw3nnw5raE5G8lKxgRTAjysjJ8NHRRhsH395vecAFpwkz+TN/7VEA53QG3+qnW6R30eXB4pnm7vTewbv8NevrXjpVh3ImGX7P9lrKWEMs5RQW6AfIYm+8A4dJU/cT7Rj5FpXYVhPHQ350v1WNJvMEw4pUuLklbqLwpJKbOwsq63F5RoDIN+NhW458SdL/xCior+6RfNPCY/ALuXx9oFuaZRWLhr4W05VtcJAF04YKbijIYV5ff8VjZXfY4CwkpRD5q97xwzQzW
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 03:40:38.1893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1137cf1b-ddbe-46e8-4352-08ddf4d2ce6c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5716
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAzNSBTYWx0ZWRfXxTZKDz/AxB5X
 Jejs1gzB1iYZJxH02FUdBGkMkeUSFx+1iNoKvI/ePXyCTkoQxJmWcQCYv9PgiVJZ9iyqoKnsQcF
 NbhZvmP7TO0WAf7BdWNiXc3LqcIJtvZ7jbe8tRgJ+XnpwYnL69KKKSwedZxZoaoYQ4puyJrKlZw
 gldBjs1QJ6WjJZ0T75ytsgSbTamqhk3o+a8SJzuYCROQ30NCgwmVqomAaN0NjeMxVtIvP5kefAT
 VyMVhcMYsYeUPJs7egj5Q2Y8iEi7ZCYxpljvr00n0Jgum4TWj2ZwBl6PBnHWOM1XRBwWrmNJxDU
 nvbZzKsuC90JlF9DwdCGtW4ssuor0WmLmKKGtT8EpUpRbwb0XM3W5URE30octQ=
X-Proofpoint-GUID: P060C4-CHIrNVw0ibR-lPzXGu4ofw6mA
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68c8dc40 cx=c_pps
 a=h8E/4LCcHWFDFiW/Oqp/PQ==:117 a=6rDDh2uRNVCE5HFPCIqeAA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=yJojWOMRYYMA:10 a=4AL28aEVfeMA:10
 a=cPYzWk29AAAA:8 a=EWjN2FjsdnYFZB9OOiMA:9 a=oSR2DF9YFqZEN4IGatwP:22
X-Proofpoint-ORIG-GUID: P060C4-CHIrNVw0ibR-lPzXGu4ofw6mA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun

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

