Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286B4718E1;
	Wed, 23 Sep 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157076; cv=fail; b=Y9Oo1MQ9frZChGfW9t/vbIyOqqjRBICc3KLWmq+RFgz9PO6ZaaKykjcEfV1gH9e/QeMJjeIpGEvD3RgcX7T4A8sfhFaacSybmWLPlK48fVHfa/oAbp3p/JlzES2XCxNIyUZMzndwdlxVllNbXgcm9Qi9S1CdCYSHFcSL5AOy1PA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157076; c=relaxed/simple;
	bh=yZ2AXOlb6os1ZX935Q0G59RLLtBI4nMBS0Ej6BiYzwY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TdsT1N2V6e9plD8HoRTxz3DGVK/M61LrSNXGcfLxXZetCP1n6CGhxLRlo8Q4SjHL7b35vJT0GBSN4NWzMdzu+xI/vLyT2OMoB3EglzhTTwFByoBUZZFb4mbwzmyYhoMIjy/wNETM4CIMboWkPibTCCUq5/7QWLsMPT6kfnl6zPk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FQgazqZx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FQgazqZx; arc=fail smtp.client-ip=40.107.159.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FQgazqZx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FQgazqZx"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JqlRY4ZZQb3OFJGas+XME5X1N0yJWLOlMO++e2QSVz4MhZyzSx2MpNHQ45Va9Ok6J6s5Y5GMVZQsrXcixFddv1AfE/P6WQ/Bt5rOsLu81QxEa1l71mEUDxuWdNyosfXILTaG/YQIH2OA1z7I8oEPvHlscLumQOE/x9kvRb3UOdBnnEUuGwlWQcCphdwvfx5NZ8PHe7mzSukIsh5IZmOBcaQAjtVDQ4rQK7ljHCJfC8r0SfrwBvC+TWKcGGLcze8dDDhmPKQjfMhjIHDPGAug5NwKTvQowgjbo4D36Dp/SOTDDNxtnHlzc+V8NA3YiVRbfM9PFFJlSH4OUIOds755nA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KaNTlX9FU+epr6GjR21phgJRbalGPA8peFjdpZ3/LY=;
 b=B842NvSXalMweRktFE7NztA8goLjCmJ6TSsdIG1UsWtGXPkqdlKXF7msxrriBzdo4jXHyQxGpyZw/yUAdYANvLWMmkdDAtDQ4I8ZX+wZ7rPWUxJDTau70a8a5jmgd2waopfJ3cI49Uqp2luCV+4S8V32sjIG4AXaw8xNed46BJhEcgsLD5f/erfACRRIr1s9P1v6F7uEIHdKU8JMXPiVdkFd6lhp7nr115rJF/TfcwaU2fJL/MtlqXR0DbtGzmkojHULcM7eWRW+HtLuAiJ7tHn4/xcLPOQPVDqszPUD2mIsYT49Zp1ucjUvKOdSCYCK9hT0RZRDQnmTGXTErKyV6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KaNTlX9FU+epr6GjR21phgJRbalGPA8peFjdpZ3/LY=;
 b=FQgazqZx3zW2DaBSNtOpoicwVVfGzR8IZCnrmqilgCigTO9EIEI7EvPZKaa7/R4ZEeGSaEfmdRztiE49ETiF05EXhgfW/hY4XOM5w4AHlG7H7K+v9fnbhlewQu/BKTt579Wl49PgyvG1iv80lvK6fbNR7ysMoDCNZ+qTGjd1zCQ=
Received: from DU2P251CA0027.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::33)
 by GV2PR08MB9422.eurprd08.prod.outlook.com (2603:10a6:150:dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 09:51:03 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::6c) by DU2P251CA0027.outlook.office365.com
 (2603:10a6:10:230::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 09:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Wed, 23 Sep 2026 09:51:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVlY+jPUn7iSdsmO9FtZZW+2AtWWKB69CM5a50lj7h/SFAKtXUkMVRf+Ud03B+VzIikWjyQ5bJzI9l8VxEvJos3dl4srkdJJUuhhHBgMxwMvLso49fx+/H34ziTw2gmPpb8QFQ/oTGl5/Ykjmo/Ybo6TnsPecr1lUKxQNRJGSqMK9FAW1QobzI0o2s4erE/h/dfeimqTgfHE7DHq80hbcFsZVcpCXWtiWOp2Kj6pd+Gf9Ht5d9vjRtPC0+fYitJ8DBAOkm6NgoMMf8grmfkhTWVK/LzbgqCt5dMN3DdcUEVG5vp8YgFTsGU3n7B1PedBErzTQERQv6hB/Ckywnn4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KaNTlX9FU+epr6GjR21phgJRbalGPA8peFjdpZ3/LY=;
 b=nlp0vW7pCCpFvSBLvO+KAeeCM0j08+GrANX2FdYWVDqTfgAfHmTS6Sxqe3GW6AYeZqLToVBwU9rz2TSoKwhs7EkFpi7ukR1uFvX2DX6E3vZtS/5MQ8hsh99x4JVuoPpL5oVO0ZV/z79K6NKiVPPBMQbkRYyZCriT86ZBZ+8Pbf0ebPi101WB4deo8jb9v0utweJtECm3gcn0n1OU5wTcuI6SFd8LwDHFyI8FfrBnw3GXE8SYzo7HG2wVD++UDd98HpgH4AN2tvoY8Wa+coL0ONeAMZTff3Nlz4SO5iHs3iPIugZe6u8jmgrtSt7Tx8R7CaMvSBgLRHSC4es2q7BM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KaNTlX9FU+epr6GjR21phgJRbalGPA8peFjdpZ3/LY=;
 b=FQgazqZx3zW2DaBSNtOpoicwVVfGzR8IZCnrmqilgCigTO9EIEI7EvPZKaa7/R4ZEeGSaEfmdRztiE49ETiF05EXhgfW/hY4XOM5w4AHlG7H7K+v9fnbhlewQu/BKTt579Wl49PgyvG1iv80lvK6fbNR7ysMoDCNZ+qTGjd1zCQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DUYPR08MB12014.eurprd08.prod.outlook.com (2603:10a6:10:65f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 09:50:30 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 09:50:30 +0000
Message-ID: <8bfd64e2-5201-4eef-a32a-b118b2804fce@arm.com>
Date: Wed, 23 Sep 2026 10:50:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: cti: Add const to con_groups allocation type
To: Kees Cook <kees@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Kees Cook <kees+treewide@kernel.org>, James Clark
 <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, nd@arm.com
References: <20260917211428.i.947-kees@kernel.org>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260917211428.i.947-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0141.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::11) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DUYPR08MB12014:EE_|DB3PEPF0000885D:EE_|GV2PR08MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d45d8ca-dba6-4160-4552-08df19582e07
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 fKwySk98TGr++ZEZAD7xJasd0I6et93gblOIds8gWthr1P8EA3c66x6I9yJrKID40LGJ8HS00N4DebyxjyyM79zXsn9EqSI0SO/sG1xHKOKMdjlLYykfy+KFrpcc5uiACDtCwVV7g3PJf9U5LeWIUyZikAzj2xzNgOvZjoWcXlBM/bjrGwCGY6bg3vUVGuP8vyvBeLh+ueXE9JoZzQy+QKZDYfkdb19S2RToWwgzL5wN1pVZz2rk+WbeWqLCWHe+yhGGZrJ/tnz8bXMFbxw5PirokHVLijlIw9n6Ctmjs/pcnGr37+giH/48HrmyOp2AlpWcYf42rOBz7J1tW6ZKNArgd6CyXSCebHdZM15bpvoBaeGNBOAvg8PNDqlHNdadoW4/YLIhXoa/KXslPzbNk075Ef0uxdj2yTjJi+T9Y2N/AwePvqkEe4Dm3MN9uptnCZn8hJ2mMOOKD274u7kvZfsorvEJ61nKBAgEG43k3uZp+rNKOX0vpinsycO3kRui+XSDrLBQI/yog+26uDyHX+xdu7IBYVlDC4vqcLu6YUkM9AbTl8Nj6Ujs+IyqNgxAYBa9b/6HH9OsgdS6ZduzqCSLjGnOODeer/jxUmHvughtw6FZC/idK3Xdf4At5BEW02+DoTG48a7EwhFALnK8K3CT6/AZbeRM/NQBlddhr4g=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 eNZwg/5mbHXtMhJMVhVqnhicYhgmiRzsD+KcSnoTrQCl+VdmuMSEAGbeR1bIN1eO0a95kAmdEHFpvsH+J5u+7bNzqx9fvwpyaX3ZyYVdaRzOVJzcGD+bEu2RCOsEIAAV3AVN1SqtckG6G0jM8QVe3GbmteXPq7Id0Y9ECX8l+3TqEXuCqc255Fub0Xb06gUTLS3tYm4q7XQRSM5gOK5JsczGdm2HwEH/S+moMK2CSes3ZrX00YbcyTZ1qRG6ggvGDTngzTI8OAwDn7VyG4B96TEpvAu0UiIVYEv6xQkIaIfzSTNWo+0Z5jEf6PuX2EEUeT9CcOiza7c0frgVCuT2ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR08MB12014
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	13c0a9e1-dc60-4a70-fc96-08df19581a40
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|23010399003|36860700016|82310400026|35042699022|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nN1Vb7eSNSJRvefpnYOscglDCKz2abyKw9LYfbuzeRtXriLiD3MrHCuoO+wcuhuJQIrD6EKqwc9UiLp1C1318ms5xH1xAiZfLPx01nbeYPev/gA9fj5gzXquuNO23zeCsxBMntVZpyuHptaghU3it4UsTi6y2zb3uvebj24W4KIuBOsTn82vL2P+oORR99boHyx5F3Q/dtKYxzkZxjEBpMBD7Y6hqspm6a2C4DGnLpRWrmvH1qtIubgimdbZnZx3cgRWgydZrN0ArDyrS61I81/UR4OVnZn5V4qjTY3WUwpotturzfpX/Yc1gafHTDZrgBrmoiMHdxDCl0IoP/Azjp11L++ku94wiCScSm8ZkTNw1gKiBYOg2sJ4fbCFgP0j3+LRAo+FS+SrTNgrCE7WN23LxrP/kePybHQyBvJZQYwzWNUk3XgC/qb0Jlo0XDK/AwGiu0EFd/CgTZWoGfriXA4kRh0KDpkgGQta6Al4gVN5aAzo4DHxei43uvfebAsvM1fAAK3Cfuw3YvdksiK8XJ2WRyoPqq5OcJevfBtsGClcK3P5lur1yKlOYoYID4RePt/gTDKWBBajD92sujcSg4eXAL4BKqK8pgNZUwzdDXuOqXNgaAiW4Ohl2+GhnfEmVl3BXWur9/yMQ1NpNrOMfcPh7r9eL84kTT+6Mlt8yJQ85OOkH43o4bn1Sb7W5pMLhZbhZY35cFY66faf/tdgYQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(23010399003)(36860700016)(82310400026)(35042699022)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lj8STNOhwdEsdnDt0V1QAxLSTshjdImdkA0OYb+A92Cem2Y+G38uVMChobu1GylodTay1VbNF609PK7sQu6nQYE5ka1iAAj/NwJXu+SUcyIHZRoafcJ+dRi62LntMGBqEB/gEumg3S0xWh/c6EFFkDXi0gKSN5ln0iIgJSKCLqj1rjo58awiR5RC24T4AEFxjCWbOMbU7QjDACl49JeWmaFI2Qpf641xf6SBPo/0rfL7yNF9onFHMnlxFMUeNLNrge32E13Jaicz6CtMKJCjXJFVNXs0wUVoRydt5r00tR4Kr9PDMuwzrz3kEia02upDWIppiiwYWzmeUUywPRmBqVrhquCjsw7kDjFYsmDiOeeutKrkE3yLiNxmUSabP+tODmlG6wANm3xcEdN9YhHaygmDPjCw1jvVsyMF3lrBXtKKl1h8dI+wBCg0P9xgavUi
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:51:02.8854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d45d8ca-dba6-4160-4552-08df19582e07
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9422

Reviewed-by: Mike Leach <mike.leach@arm.com>


On 9/17/26 22:14, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type is "const struct attribute_group **", but the
> converted allocation type would be "struct attribute_group **", which is
> the same type without the const qualifier. As there is no general way to
> safely add const qualifiers, take the size from the assignment target
> instead. No change in allocation size results.
> 
> Build tested ARCH=arm64 allmodconfig with GCC aarch64-linux-gnu 16.1.0:
> drivers/hwtracing/coresight/coresight-cti-sysfs.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Leo Yan <leo.yan@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: <coresight@lists.linaro.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> ---
>   drivers/hwtracing/coresight/coresight-cti-sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index 3fe2c916d228..2ed5d8eb1dda 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -1132,7 +1132,7 @@ static int cti_create_cons_groups(struct device *dev, struct cti_device *ctidev)
>   	/* nr groups = dynamic + static + NULL terminator */
>   	nr_groups = ctidev->nr_trig_con + CORESIGHT_CTI_STATIC_GROUPS_MAX;
>   	ctidev->con_groups = devm_kcalloc(dev, nr_groups,
> -					  sizeof(struct attribute_group *),
> +					  sizeof(*ctidev->con_groups),
>   					  GFP_KERNEL);
>   	if (!ctidev->con_groups)
>   		return -ENOMEM;

