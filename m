Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793830554;
	b=I3GX2xFCWE2VZ1QsRt1co58yZb7VdeL1HOEmm3aVmSpp+8i52xSsnwF/52ERIH3GFRu6
	 iXigZagoeAuVW3Ktt2/DOOcrvNnpXKlwz+viXePuYFt2CT6YKJ+0bHVKW0etqXB34Donj
	 2PU6x5OKsOSTt1jMo4xlPX9PcYCtgGzKwFnLI0nbfiDNEXCEpJVLb4oKu6PW6wMgIfrn9
	 UigoP4liyOwaYFWBcID+SkKNYaIGRKoVv4ou0S0QeosJsQKDWvpGkYSpnVfA11c6DLwoQ
	 KkTk0WSt+i4zAOALJcTLom3t7yPnPEcX/qffBs98/g9XtXbmrJfUlr82cnT4nGWDezg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830554;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XpZyyPzddIKp+7+bodQBSlP/pYQk+xt8YSz1Sd2IPno=;
	b=itK1F2pjfGCdd+FiDOGKH7sHu0Sk1UOmVN5HwV7GhdkLlB406rkqtAVfXKn0M1VD/Au3
	 qYyKQnJeWVnw3c084z22ZPerW1haFbXxsXJw8f9jsMIrPLiRVtHp7DbUsXu3Ya5qi7Ke8
	 71/29Ig7n4nGi7OUzfJNzz+o6jGe8m6x+UlyVJ8RbMTGnbBn1Glkl7DXh6JJ5kug9RjFG
	 YhGHWK93r1qLx6YmCAwk2kSaxjDnpHzlN2/0GY1F0vvWjAPfvFH47SNYvgwBq0jMwnCdm
	 LtxLcZGJJrtFTiEMBOhauF4yxB3ZrKfzNKpvMT2acAvFtXr7/vaJEVKykZscPSEVttQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t7rsoS2W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.70
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22123606A85E;
	Wed,  4 Nov 2026 22:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22123606A85E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t7rsoS2W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS25jIcanwS/1XaRuP9HmyAYXJIp0vqPY1hin2LBFt8YH+dOhqawsrGGLOniW+POQnQUWLvTbg/M+E6ZoWkpQmk2f+3v8tWxueAzk/gxP4uqBtTJUB3FuWTFIaNHi1OQdYR9g25V0+6NRdBnFSDkZRjdqO/z1LaxN+STRz/WghxvaLt8R22Ao20L2r+OO/gy8F7JtnTj/+K29tvCQdTsgN4LIEC3dGlqpof1Vrg/jEXWbnhRMW3HFsOvEbfvsyOvHPPmxJ1Pjx1P073q9yEWYuy7tuVwA9e2XYlzBHlMGxZLdrN0gCBYsiVEq7PHhsK4Uy+fnHmKT46+8s2mqvKxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpZyyPzddIKp+7+bodQBSlP/pYQk+xt8YSz1Sd2IPno=;
 b=P34NtDs102Kg6VOhSXeN1+axVcck26shPgK7t4xhRBPlUNbeqyiKJdVKF9uieDJgTv4JFO/vEpHQXYkmwNAWY5D4c+t491aIYAU1DR314HQHm97TW6X6HMvVxr9Qv/LmqGacSr6qlS7lf6AHRnMjw/ji+XTC/RGnqL+9G0wxMxi/lJe1b+sTPqpR0soQN9kyerlAP/shHLc07GogEPQ7yqRDHfEKtEoXs7hZd1rAMEDbjDQk+3WVR/AZHryxDlrNsKf8FnG8yVztKOZTFoX6XYwqPlx/UVx0alI54vJJ/SoVl4kfq6xAXUE5rlqIo0aPsGI6hpESWIszBp5rWLw+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpZyyPzddIKp+7+bodQBSlP/pYQk+xt8YSz1Sd2IPno=;
 b=t7rsoS2W93h6VhMx15xHm0Rl8qTP0FpHgANMh+/q77rHhmbmwd+SVwo2CmOdJyF7FL1VEkekqsRlHiTgkggrKA7eDpyetdHvmyZK4bQHpzYRnWNaw8IsQBbuQmpOon+wxcKYhe4K2fUH7rnUSmuFPf7ZZSQsH2mAmZxLjW3rsXg=
Received: from CH2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:610:54::19)
 by IA4PR12MB360382.namprd12.prod.outlook.com (2603:10b6:207:14c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 22:15:50 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::53) by CH2PR11CA0009.outlook.office365.com
 (2603:10b6:610:54::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 22:15:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:15:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:48 -0600
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 16:15:47 -0600
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
	<max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
	<mario.limonciello@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	<linux-hardening@vger.kernel.org>
Subject: [PATCH V1 0/4] accel/amdxdna: Add AIE4 debug buffer support
Date: Wed, 4 Nov 2026 14:15:36 -0800
Message-ID: <20261104221540.631182-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA4PR12MB360382:EE_
X-MS-Office365-Filtering-Correlation-Id: a20bb4e9-7867-4663-507a-08df3ac12e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|11063799006|261022105027099003|261028144727099003|261026140227099003|261021123027099003|261102123227099003|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5AaXW+Y168gMmfUgn4AGaTtQi7xveD3b052Dn1GQqXQJHetKG8/IW39FWUEgN8/bUrMsLF+bU3wwhPakDa5n1WR/SNeNdCLPmyb2jYEkxg0Oc7ZpbICzWC5UbXpWVHJqdk0x5VhWEEgAWcPKA0pkNNcADygA6WY/C5Psz2qt8AWcu/FxFrp+4DPip9MJ3yXwr2x9v1gBiss6KzsKFGRDgXILVA5Wy/MpAo531lt+v4sCX+n5GQk752istWK4bG8MdHzFgFZUoqQVbL59XAVuClnkcZnCFoPXEWnUOXtIzuB9ZgDekAxrsWsvDGnllOSnpt4EOUdtfR6qQaX0Xf6TYik3QUIPavC2pPAWzz/Sg3D0ELIBLbp+HmtjMGzzdK5yVC4BaqSjWpFLurzqOMvO4u60iXQwZhz6alP8I88Id/7zSJQM4krqKQXHh1sr4zW31x6iRCkR1AHL7gXyTvo+u+TGtDD2Zvb17uSnJonRd8yvZaqICoYs+N7yoqRGLI98DFON9C5vUsHybtsypkYchaRAXkHeNLmxd37STxCvEnyrc5umDZuHqW1i0T8hKApMIj3dkGkvgbbum9Wjfm1HYbG9Txcl6g/qy6D2zNCpAI70x/oHdciUm5ckV3imWWbwL3eVW38I3Ij9TBSRy5Kqm1QH/ZLuAx/iT7lbVUsqK+GBpSpoYYP3Ml/qR6FfA2XXH8q0rR2iVM5yN+BPDoPJGg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(261022105027099003)(261028144727099003)(261026140227099003)(261021123027099003)(261102123227099003)(261009223027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o/P8w5aVjGnWivTIYXB84H/O2Ct9dhqQlyn80KgK+Jj6xBv3SBBzhyNxMJjYTTbbhgCI5a7NhVJt/CeOvuvXtIR60/It3nkUxahYADEzKaaFFdvSLtqwf1Oz1Rfcc4Q9HuvgWl1OCFb6uJxQqt3UvXWqL6BzjwEGHw6cMs1QlhKVwUVvPsYY+6ZYKuZyoKpva8yNzmA7W+qb4BU7JapKgVfQjQYf3VG3kNDbG5Lv//p6xz9CKYt1hP8V4gnzBPxos9zZzlwW0E/dKLXuAD3eL+y3JfInnoHGSu+YVPs09Zot4dKwGGBFl7Po6DkVbGps3JCO4Kr4ie8LuZVCAY7IfEWKrnIozamhJm64U7xG+LtaaPtABMTyDkhKXdUzOdxkDCofn3NHVrH2n7kgyCijkAYm+Jgi+AQjnespFvNlmdkkiFMaHqJW6NduEhla5pfK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:15:49.1336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20bb4e9-7867-4663-507a-08df3ac12e6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB360382

This series adds AIE4 debug buffer support, which the xrt-smi validate
gemm test uses to read the per-core results, and the AIE4 CERT firmware
version query.

- Add NPU10 and NPU11 devices.
- Bump the driver version to 1.0.
- Add AIE4 debug buffer support.
- Add AIE4 CERT firmware version query.

This series applies on top of drm-misc-next.

David Zhang (4):
  accel/amdxdna: Add NPU10 and NPU11 devices
  accel/amdxdna: Bump driver version to 1.0
  accel/amdxdna: Add AIE4 debug buffer support
  accel/amdxdna: Add AIE4 CERT firmware version query

 drivers/accel/amdxdna/aie4_ctx.c        | 284 +++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_message.c    |  20 ++
 drivers/accel/amdxdna/aie4_msg_priv.h   |  35 +++
 drivers/accel/amdxdna/aie4_pci.c        |   7 +
 drivers/accel/amdxdna/aie4_pci.h        |  10 +
 drivers/accel/amdxdna/amdxdna_ctx.c     |   4 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  19 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   6 +
 drivers/accel/amdxdna/npu3_regs.c       |  78 +++++++
 include/uapi/drm/amdxdna_accel.h        |  51 +++++
 10 files changed, 510 insertions(+), 4 deletions(-)

-- 
2.34.1

