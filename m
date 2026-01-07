Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34454301016;
	Wed,  7 Jan 2026 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786549; cv=fail; b=DfMgSQpNu5Zo1YgJ6IBb0SxOqL3RqNPrmdriZXKBLHh70s4jtHlxgKl4BbNJXcscM2tOYOAkNRxn3r2Yr1RdI4gKHqhABvXPU7k1t4qof/P04Y4YxIYtTq4c20HTsgp+z3BtJ+WsQM9fC0/RRNyyIAFtEXSEGaorVzJ8ekZYK98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786549; c=relaxed/simple;
	bh=ZAjle/Zv3K9aI4f/ax6pxRcIElzPGc9As9JrKTWLE1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O7/0SAKZPOw5feGdPWVl8BWpyKs2OkcN8UwZZvSDrkIent3tVUVpnFlItJXqF1vfNr0tl9oG8fexynu53himtz0XCGb7nPbKd9KuVEFtgZQ58BG/OeP/jl6yuL5aSldBQUvfg+Bxt3ph4lUU0iykuwW2Ys+xVOefBXTYVwzeiJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=bHEPmOIw; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="bHEPmOIw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQwacbrOelBn0BwM/wcvYD8q5yKinN/sxVejYynHIlDdd+RrljRlLbn3FHOM48ResSCf49uF1HZvDwgnsVzxVkcJ4Yibw1Cq8F9hk4ZXL+zIZTP4r8gzgHk5fxk9pC8uLp7jxCafdFRbLJ9uPIROHkzwKpc5imnT7SikM+1ZfmT9HLN2mQZ93U8WCKUh7JzdpMUxAVjHtW21uHmD8M3XMOQCX3pZfPMt0MgG8Vct6qif/73PePDLGB4OidQdvh2Z5dpZGWfAGsHG+3sLFbzdqRjxft6g51uWN42VPkfsdhm8En0qKX2bA6Z67dlDyibPNplSE0zX4n7fy8xc3ql18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LJI9lTv0lnYpcg6iCJdz7YA5sfdYuZ5D0UnYJdd0lw=;
 b=hzO3I69ZoHB9sSshKPY7U6u4SBiSu5balIIEG50DD6Gz7KWPKaxm/KXorQ+0NWrihqwMKnYpzE09Wkc4ld6iXCp4zZ2/wLxUcTtysF5CTYyrEopzqgZ8o1ZyFYjM05XtRBnDjlKH7+rOdfID6Gt0MrHAO7NAqcZ7BwD3qwTCy4nATVM1eHi01qJaNJRbGgUx4oxoqs9sNieTIRtDhG5fJoCu7H8obKhqVgqLFFreHVWu+yVaDfzC4t4V9bO/mEc1L+trYMGTMLgK9JEy2deVNraUFJHvh84xzqqwASb/9X0d4zJcxdOj/+xw1zyr8DriBgWNIO+wLzBur8d0wKAoLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=gmail.com smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LJI9lTv0lnYpcg6iCJdz7YA5sfdYuZ5D0UnYJdd0lw=;
 b=bHEPmOIw1w9vvnJ4+PSBUaxlLzd6fE8huxCRz+O4Goq+QQq3pS7gdnzlpiISCcInlnzeTPunfIDkHBtITMYhgdSJ9qvH3V56LwZA0IJ2O0LeR11S4QVVvRvpY9V224U59kiHJhxclgpjOjN8soj55Rkcl/H6azlUvr8uDGshcUTQNpw02b+7JPQdbujM68jHYEqdmrSPk5N3+BCasPVvBsnAAfm6fNYAhr06gw+utgNcS/Yg8SEN6pit0vn0pGL5dCazV5LrJceJIOP5uIAkfPKB+LNRNY4IXffU7MritMLrGGmVVOb4qbDWw7+oQc6rRWQt5yRuCIq+bmF2rP/QNQ==
Received: from DU2PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:10:234::35)
 by PAXPR07MB7856.eurprd07.prod.outlook.com (2603:10a6:102:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 11:49:02 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::69) by DU2PR04CA0060.outlook.office365.com
 (2603:10a6:10:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed, 7
 Jan 2026 11:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.101 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.101; helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via
 Frontend Transport; Wed, 7 Jan 2026 11:49:02 +0000
Received: from uleclfsdev02.linsee.dyn.nesc.nokia.net.net (uleclfsdev02.linsee.dyn.nesc.nokia.net [10.47.240.2])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5BB271C0030;
	Wed,  7 Jan 2026 13:49:01 +0200 (EET)
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Kees Cook <kees@kernel.org>
Cc: Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH] Kconfig.ubsan: Remove CONFIG_UBSAN_REPORT_FULL from documentation
Date: Wed,  7 Jan 2026 12:48:33 +0100
Message-ID: <20260107114833.2030995-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C0:EE_|PAXPR07MB7856:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c1735e89-9b4a-4f91-90d0-08de4de2c09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NEwMtiXI+xzuv0CVjj1q6V3vx7mqa6NWLNzD+uzpBsLtSVAhmfpH9vUxbOep?=
 =?us-ascii?Q?9guNPI3F4pKMI3joB2j//zNd5TjyUhcpdsuXYn3FkdUFMepzrZxjzZr5tzWe?=
 =?us-ascii?Q?fnNuJLRKj1RIXvS4MO2gPGVgmMqrhNWngtNqDjpgWMOLRfvcRwL2IW333ZWW?=
 =?us-ascii?Q?0fWEzUthJFUKLhLcqbRyX7WU9GYSAoOBQCzo/vR/k/YEmXWR0vFu1wTq7rV/?=
 =?us-ascii?Q?iBfL3m6a6i8qBNJ5+MRewbDh0QReYK+GN8et9w2te6wIBm2paqAn27M3JMfM?=
 =?us-ascii?Q?aVWxxBZHgLTiAkweP9fZy7jF+7viNcB+UIAi8wJfrbf1Yu/H5/A5lHAE1dj/?=
 =?us-ascii?Q?xFLZgOlqoqcfH6HFh0fdY/vLGy0rRsoAd6GytjJr+VEL1HLZ6kdLk0jRZ0i/?=
 =?us-ascii?Q?jUn/uQzlem4cb5FhlphVC6HWyxrZ0hliy2a8i7QXkcRB/tMJbvNysYQ4NoeG?=
 =?us-ascii?Q?ovYsqlvHeU3NBCOgjNsuwLu2WMa9/dC8QGmQ2R9kL9rbRrvkQqzW4rcKELQt?=
 =?us-ascii?Q?Tjk7bVmRLfNBnu4MsdRocds7W7T4nq3cNoyeIvpk/c8DZCCh376BV8NGEy3i?=
 =?us-ascii?Q?M1YDUiHohwi5lek6Q90EqkloFViULVWM3qMm5FXHnYrwbzzTTV8pIrSfJ9Vv?=
 =?us-ascii?Q?tj5ANF52XybWj0vdNio2niAJ+rKc5rn9v1147d7PrYPE/sFwT/HMY1SCjoOc?=
 =?us-ascii?Q?sMc9nXQMO1Z4JsUpVKMLo2Twrqf51VG/BZiv55VPPk7Umg2Xd0eiKwwihBvS?=
 =?us-ascii?Q?0+m5qI8ASZAkcYELlIW7XVa611ZlfrUoso8TzbinZhduFMU3/wyrXJ32a7Dj?=
 =?us-ascii?Q?Vwq4P01DWFNxYiVm0/joxfM0QGLzGEvb45ykLlyC9YcLxCDEbNGtEgO7G+MC?=
 =?us-ascii?Q?gA59uyXKfygc03pdzS2SmJd1jr3074olAL5/i8674zC1EJmWKnFQZu6qbWu7?=
 =?us-ascii?Q?gUD4s/U/zZ/QKp7nqq54BEG73ng75s9B8zbExGlHJsZ1k2NDMknEmNbqtZwj?=
 =?us-ascii?Q?9SwLxxtjGPJklySJrP9MA3DStFWMtJUsxRZyYotXZyKc5G6eJ9+uhaYQfQUh?=
 =?us-ascii?Q?JLj4N+Wm0DZTDrQKvOJT2Fs4v0W8h4j49uOA8M4NHswD9IQkdoJxWkH0I+SY?=
 =?us-ascii?Q?nWLffM0B/T+zQ0Sr6c69bdrmJYG84rYRiFboSPg7GPff93uHTewHFhpA/q6h?=
 =?us-ascii?Q?RCLvYgHLj3Q2gj0SE1UQy9m/apvqGBmFW5xkuE59fifz9v90zkcK5P0PtcQg?=
 =?us-ascii?Q?1fgQvm7xRAkawMhlouDUyieapQZVdhqfiwePIE8MJbTvfbOV98QlrFJk1G10?=
 =?us-ascii?Q?+k57BSZXy7K7KuEFgVjL+hKRa+F9Hf5xWtO/kQ2ylSBAA5e4yCqQIQwL4uss?=
 =?us-ascii?Q?VYBp//d2Xo/qdxDJ/84YgMaYRd6IMCSEb6A/REakmdlmrnhFDxZV7ogy2JuD?=
 =?us-ascii?Q?7Ab0grUxTJJnfsDJp6eUGi6Bigny12Eh8JZA43pWd+zKfuKRyJAPfqpLAMov?=
 =?us-ascii?Q?7D5XSAGNoX96buWuKL3O+4szyExN4RelWkRQUTjyb/kYo/IOZ7yuK1gsIlNE?=
 =?us-ascii?Q?pUgxquNRt9MMa8d2pj4=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 11:49:02.1760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1735e89-9b4a-4f91-90d0-08de4de2c09f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7856

There is no indication in the history that such an option was merged to
mainline.

Fixes: c637693b20da ("ubsan: remove UBSAN_MISC in favor of individual options")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 lib/Kconfig.ubsan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 744121178815..1ecaae7064d2 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -104,7 +104,7 @@ config UBSAN_DIV_ZERO
 	  This option enables -fsanitize=integer-divide-by-zero which checks
 	  for integer division by zero. This is effectively redundant with the
 	  kernel's existing exception handling, though it can provide greater
-	  debugging information under CONFIG_UBSAN_REPORT_FULL.
+	  debugging information.
 
 config UBSAN_UNREACHABLE
 	bool "Perform checking for unreachable code"
-- 
2.42.0

