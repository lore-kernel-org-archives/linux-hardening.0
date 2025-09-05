Received: from mx0b-009a6c02.pphosted.com (mx0b-009a6c02.pphosted.com [148.163.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D131EB5D6;
	Fri,  5 Sep 2025 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.141.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038170; cv=fail; b=QB6SEHuwokN3U+oXY0DBuKNaf4ThuJFmtnPlikF75z8yXAx1YU/98EWBp6jnclz5t2WRAioBZMI5Fd2q4QcRHZzeVY24cTke+tFDb8TZZ7m9naZYDuYWL5smtZt++58ZvtPR1GLkz93Ief5bIDEvHapf//5sYKUFiRPhMD94uDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038170; c=relaxed/simple;
	bh=4IHRZ8qvHIu2Noa9wK7Vhx23B6FQ459V/rC3Zq7qqw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lNbWD1eQ3vM+J+io8BhRGdzCmypGoTHTVcjr5Em3hBghdvFVLKYjdPyVHMsN4t79UlOpb/9YXBlfJN/6Rr6ZJ++hovyWiG85MH3AKFMzIEI/qK4uM/4LmBfa3CQP45iq+PxQkeJ80CFEFOgj+z/AffOZpjEZwZUqDwCRxgdyFSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=T5ZrztYE; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=X4rWOAcR; arc=fail smtp.client-ip=148.163.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="T5ZrztYE";
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="X4rWOAcR"
Received: from pps.filterd (m0462407.ppops.net [127.0.0.1])
	by mx0b-009a6c02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5849CYoR3839883;
	Fri, 5 Sep 2025 09:40:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=20250420; bh=80pCGVxn6pJdDwZd8pUgDpC
	hvW+OWSY3LIOSTwlrlgA=; b=T5ZrztYEQD9kKgzj2CLD0FecK03ioZvn0R1wtAY
	b5Jmy+olSCRAOcyG/1xPZBlaUfXAvukB/5whwyxwqw/gXDT+ZlzvrMEcrYeRVxR/
	BXrBYgoq9U3E0aTI7WtDKxQclerCk4Z5fPwrKq8cup5e8nL1UpPisDFAU86rKsNy
	EmRh4Y5/yVRJlxniGLt8nevOk1p/8MVDV6TIVHvn5ca0WjexcmMzqygUx6VhC6IR
	Pnquixv9UdSPyNnvQgeeor8hEgegpJ1l6FLlpGUW2/1IqjG6CfgY/c0ghfja9M7v
	xmJPdA0aysB3PxNXw1IkhZYqEJdb12Q6qBuU7oV6BI8DDIg==
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012018.outbound.protection.outlook.com [52.101.126.18])
	by mx0b-009a6c02.pphosted.com (PPS) with ESMTPS id 48y7m98xgx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 09:40:35 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLfmsOd6PsEoqk3JqJSTfJ24LWVvfTZ2l1xuQsiowYj1WLsZYQCCLr4/2JjvDfu69T3dAtR+YdA8y+PXuOjjIVT8PzmrgeF8ndKv8WafTieGLkdqXCaWpwI3U8qprZ4uhvtZ/NrRzoP4GFw7yO5jtoh3haN4s6L1nbifr/xoWbabYzfLHeTOtqpu/LjKTA3+NwLWYCGszN9prE7wyYrmz49++5rZWZXORhsmIwCPyfwgSLDBTIdLZYKPMi+K1qjjKxLhZJDkfdU8uivk/FPbiE57ovtNOMp3ZBiW4bvG2gYdAHMubZIOFTyX0mNBOIXFhjPllDDDCLBjFbj3hNJM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80pCGVxn6pJdDwZd8pUgDpChvW+OWSY3LIOSTwlrlgA=;
 b=XHI3On3LcUMkkJF8+ygKsXvwFdEUQUkH45/xIco9wR/6odS1f2zDZxgL6rcgaTKQYYZu5lsOCNLK29CRSJVz851MJf2V7Vu4Iv/MK2/alDG2iL4X91ggYsyKhVutt9BKylGh6O/wG6NYkmlmKPevRB+8yuYfhlWbP+elUHsIeZFTBVytdYnj5BOoBhdnyAjkYWoBxwNBSSW5E9RbrY19wIlmPJ80hn5hunUMUerhQQEYpzX4n3kjjh3a5sBcrHwtiDCM9feysZv0e+HEGko2dfRR88YmMGI5fmfJyyNhkGn+LMAn046WaXRSQDDMwNXkLZpIxpX0xKif1tISwVyZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80pCGVxn6pJdDwZd8pUgDpChvW+OWSY3LIOSTwlrlgA=;
 b=X4rWOAcRI40ybESCfDllIClu5gbhCha1x5x9i3CwFs0eSEMf6W6aVFl12NvgJeC9WuYJZw9SfO0U40u07utxXqruNSbRI4r3aFPYrqVWvWc/k4PhTg3/wH7UEqZh47b++uf99UccxYu9m9YhznHWV5M6+SK7KK8Oleb7mhlDsx+qw2UOSiAUicDqn1M8ncajx/lsGJ4vKpC5mkfS8excv9nMkEWZeqDMl6q9z0GBeBo8afld0BXhN2ub7XE78OhklCAaUOSfhcpwhf3xxyhvy28nYKWNEctM/aAyryNqsEMi7d7sb8ukJVMQ4KdVGhDNANgCi6jL4g1sKmvCJofpeg==
Received: from SE2P216CA0018.KORP216.PROD.OUTLOOK.COM (2603:1096:101:114::17)
 by TY0PR04MB5959.apcprd04.prod.outlook.com (2603:1096:400:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Fri, 5 Sep
 2025 01:40:32 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:101:114:cafe::56) by SE2P216CA0018.outlook.office365.com
 (2603:1096:101:114::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 01:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server id 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 01:40:31
 +0000
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
Date: Fri,  5 Sep 2025 09:40:08 +0800
Message-Id: <20250905014009.588269-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|TY0PR04MB5959:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8a37c6de-88b8-4ed8-a825-08ddec1d33b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a23jDdnTNxl/btUIx7j3+yUDZo93gYgkHtFd84RFOgxCgdB5L2SglrOSLumY?=
 =?us-ascii?Q?bRX+1xLHaMxgbpfcgIeJI7aT7QbCxIveb6N6yr5ST0e//6wyeRZ26DC6UYsh?=
 =?us-ascii?Q?uOTPaMWJ+X+c9x5zk384JelUiK/i+U343+RWYtfVOm/SIWt5WkX2sbXRovNb?=
 =?us-ascii?Q?tlKO5bmqEMNHa0neEOtAt6KGdAgbeBGqNYawI3AoSOnsstzpvq7JPnhk/z94?=
 =?us-ascii?Q?ikK7Iek15ehvs8EMt6QfXzj8UIKWHnH+ERpZQ++9NS+UH765wF0PWdmusX2F?=
 =?us-ascii?Q?raritw+raRqq4/vgHg5XdMAkdzv1vFhEhgK6gNzO7qzA/KcQh6J0B/YCX1XI?=
 =?us-ascii?Q?eSDkktQuOIhsHvdS55TBWz98D6m2kI3VIw1BPGBSyo7z6EIiRq4qvt4HUZkN?=
 =?us-ascii?Q?+B/67YzRSAHfw4+xs/6P5ZWdiL7a3V4JSs9371Gx0RIC2FJarjz0ucXAz6Wa?=
 =?us-ascii?Q?Fcjy3DMwqVZ92yOFqBF1YETVFfIGhkUYEL4SRj+GU+YSLTIJ4rYDaufpC7N3?=
 =?us-ascii?Q?OA4riVeAwJWoifhfP6F3I4VSWSx2jJrXy7DZGGnPoccRAxluAqrUatnSyw3B?=
 =?us-ascii?Q?cr1E77N4nE/C8pKlqAyeKWA86MjEyz6ySqtcUi67S7Xdgd0LoVgd+h11Tkt+?=
 =?us-ascii?Q?E4sAch8suz8sI2TkDVaY9eEszAW+O0+sdTkJ2oHMxZzFnmntcsem+ePZoNSd?=
 =?us-ascii?Q?IduKuo14xR/cK7vBDz8bpTaveMsWlrKon97DkvIRhpgRXKbWVkzAaPznOALE?=
 =?us-ascii?Q?xzIQS8VEs4DatUETdaryI/ycRUlA1UDC7F723D4UL+1spf+ZUPB0LcICeqtL?=
 =?us-ascii?Q?is+oNhZyCZahGoeNpr9fvbdboX41/mDBFW3bZA5JqsFSi12JWjb8mCkHusNK?=
 =?us-ascii?Q?kE/2IadGVsmzJYrbf05gf4dbggkw+VUKA9gO1sDWYGVYTHGxeKgB8a0opRYQ?=
 =?us-ascii?Q?iom+CKF8mhVcfI9J199EOxJ3FH/8pZfK2SMsf7Xf5gYZMOVR2h0DvHzfl/mk?=
 =?us-ascii?Q?zLMoio6T/x5fMD+FZ3zyA1esgVuLTcSa4GZ/bmd7xYajolWZxW+yxlcKLqR8?=
 =?us-ascii?Q?ZYheASNEHOiMRPL0t9RbymAEhhkci8V1UMZwZg70MOsoprUFJQ5FHalRVU3K?=
 =?us-ascii?Q?7Hhp6eFWzSAJZnSr8me+v8bwTFE9WRtszq4G6COzzhnHf2RCXmNAu0N0r4M8?=
 =?us-ascii?Q?YGJ7Nc7v0WBRI7/QZbclXdAm4E+MQWAfiwaFq6HEdqW1kxvKoyMdRVP/yLAI?=
 =?us-ascii?Q?xrbZwz98G79yk4hCWo1wxrLzijJcx3IwdQRuANHPgkTWtxQbZQNTbaLxehF2?=
 =?us-ascii?Q?w5UtQBslsX8qOM7mPuuuIFwoIKOJRavCsVeGyNscg/0i3cFgqWmWe43Cn7y1?=
 =?us-ascii?Q?ItETWiktG8wkcPN9vRNEBpJm5TuMjYy5J4a5X4yNnH5qlocGYI7JrObYPP9P?=
 =?us-ascii?Q?loiVs0m29T9CthwFLvICY8rxQ0vxfro9dyBDqwmST+b/cKJw7Kb8n+Zwa1/b?=
 =?us-ascii?Q?qDBcufRhcoZ02oRkjj9RAz6whdGdtH4Oggd/?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oZyBLmX/US+jrfbKsmwV7pXi1+qVYqJsRFpN4DofuCRrS1ELRT2NyOa0XXRArHpHKarC9WcC4Wxz5hPTvkW0MwD0swnsSqA0T8OZjhEIr+DEdArzipGEiPaEowwz3U+AYGxfVR76r6Q9NEmI5C8GeGUHAGRIFc0kxXE+F3dQnS2F6SLA2yc1u+13f5UBNqmTUOnXCJPgy5LGFL+B4hIG4yWgD9+OF0z90cPsgkDhSA2PaanEybAiPe0jnteiahlRv/gsTGlyOqpQDuih+Pce5u1T+ERpM3QhPAV7Ft6IMggdyU34S1y5FAVMvaTO+FFsrAnEuCxqrqxjRUa0SDlaq2izq1p7rvsFYh2NZvZrmQdBZo6TivrxvsZn3gp5e1wQRWUlbvNB4JrNHFz8KJD2SoB6uPU7pxH69YcZbXAOtDUzw1iC4sa0cNxnfV414sL9PpqCymce4KVZ+ZIN5RLScDApF+q3QvHqEhMe1QeIgX8hOPlYK12nVOtMqbhZ4zfGIRjCHLtAm9+PDF9fzKW8BNtFjb07MYbjRcETO8c3Z6+0a7j2uEcWn3boBIj/4sVQhe14ItfYqWJFr0kjV7gPWsSPTK1Df07d3f3lhq57Ym82Ty0PH5W3Y+wYYu4zrYM1
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 01:40:31.5458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a37c6de-88b8-4ed8-a825-08ddec1d33b6
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5959
X-Proofpoint-ORIG-GUID: d4m5gGRpVl3aj1EA0E0mYY7aY12Q-K9I
X-Proofpoint-GUID: d4m5gGRpVl3aj1EA0E0mYY7aY12Q-K9I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDAxMyBTYWx0ZWRfX/g5+fbh0OOZ6
 XFcLBYmmqUOLKelKb5OnrwJYQpboOFvfvTK6EumTKP1wlN7uiw1z9ttiNp1MYltSRaI4QfDtluW
 yCBnBDDuDOibOQnhZZniWJw9oeUTDd4TZAxpr6YD6tRMB26mUE4v7bmx9QEsOqhm4C7QyBMd9+a
 2+XPmtCHukHBfYQcaGqMxvLZh65tWvUKkSw11GUFXl7DfhnofBldXwKpQtqNfMPuzEZ2aFK4gxy
 PxthagKeS4tZ6e6EeDpF+mcXis8cChtm6mGe6HmzLaKty4tmFiswSJ7ZHTARNDa3fVPWSQs9AXj
 wBLjNSZhPwYyXXGm1kpjik+MXdNKogfMmHWCBSbcs9pWjhbvJqqEibBtmzbkzI=
X-Authority-Analysis: v=2.4 cv=foLcZE4f c=1 sm=1 tr=0 ts=68ba3f93 cx=c_pps
 a=7d2PKIABdNnGHd8yLCgNxw==:117 a=6rDDh2uRNVCE5HFPCIqeAA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=yJojWOMRYYMA:10 a=4AL28aEVfeMA:10
 a=cPYzWk29AAAA:8 a=lEIaToS8ZBCf7mqwG3MA:9 a=oSR2DF9YFqZEN4IGatwP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun

From: Zane Li <zane_li@wiwynn.com>

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

