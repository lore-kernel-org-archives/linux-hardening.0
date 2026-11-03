Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729720;
	b=S6VQ9fv8YC0lSHiZhXL+R+68g71Mobb5aFY72ggMEfOfGMFmvJWoDYAa0Hc+qdoD9rup
	 YVX+ifb4VghnPrdy8nOW+PyI4Pgxi+eCcwOtuj6/F5TMPq9bw99Eekpr7mHRHUnwwQYcQ
	 r3hXZlsWapJr2Y/IbHduWGnt/t+HS7Q3CLgkqRGNPlO0C1Rbpj0e1atSYu8RkknCiQc7G
	 tzzf5XI0MUtt3sGbXTYZ1ktzXimFsNPU4km/oePiIMcALAURjktITkPrPZG724bdIa7X4
	 pNlssStcFrRLTftU5SwQ2en5luEY6keIV9D2ttoEq3zy0WUlEzU8R2scC6DOcNfet1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729720;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=CH3p52RrmqbXb8j7718xeM2OUydrx3PIe6Yd1ZRi7ho=;
	b=vEnGyJ7kC5sdiHdn8VzOfj1Un08Ck+Ysoj68P02v0V7CVATV6djqCKnexwdg5PR2/lZi
	 PPofPoCODc5JVC1eWzNoNZJO3p+XS0mruE7MtIdgY8aRtrqx8vNfyHvfI+kjxmi/Ue3Tv
	 MNFxgJyPq/AhTDkCF45Dh4KnbOhxtHKFc8bYvfO62/9ufyN77hWAx8zeFo4bmRXILD0KP
	 QEYfGWR5ROWl7ES/GVsuEfidbPFO/jmSuB2fUECyJ4cQC3zI99EETNN/hTHU9ZCQZeF9E
	 4MIh65aVVpY6lku+/r303tj6G4cI0aI5nbmS4lJKBDwr4WRUhZYYDlrLdPN4/DjGnAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AUf8CIya;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.17
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23101606A324;
	Tue,  3 Nov 2026 18:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23101606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AUf8CIya
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR7u+bnbFb95xgmf3+ZSPoCK6+SacBLYsuAP+nfDUGyxCw4Y20bBKH4vK4TTSrlhqih19a7SSuC8/v7GIcahLmTiiGLJm2ciKVKG6FFT2auHUpUQEbiWvzhBBienTa5n2lFg33v9admVpk8oDEsk3RRyBOXonJ4a7i25V3Kcpc2gm5S21wBtgPZEfFQzG40Z2iKLvsGBKyk5sxNebVHyZVlWWfdNrXI3/MbJ8JtxCxUe/Twaj2YL18VSWlIVFPCI03cvihl0NWYn22QnDVjctjZk0XoblU6EJtcexR0U433mkgEbVR+HBDAOY8E931BVAhRopTrTZOPllK2RDpG3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH3p52RrmqbXb8j7718xeM2OUydrx3PIe6Yd1ZRi7ho=;
 b=yW42H6KM0t9F/EjyeeLIsQwafvaPnUSxVKXS3bybr0V5fYVZo2vso38qCNP48KxlMPta/DL5pz4ccVnQ/DxHks12vBKZDtNFOdmzm4msW6CrHy7l69cvDkQ6sKbeYikpOJGUNizfv43wg8Rwhsa6ewBK/SmF+T95cmS0HJTyj8ol6yjzwyUg8idwcAZXpbKVx31hPRXKO8pgv2ueln3K3WMdufbLE2nvX2m3md/LRYtLGTHxnlx4w//QYFRZjT99H7bUXNGMvdNkeQHOg7m3RUNtpfv7BFVyffpA72AKP3sh98xWaimuzgwftTnkGi3tV3t74lCkKmowa8HkR4pRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH3p52RrmqbXb8j7718xeM2OUydrx3PIe6Yd1ZRi7ho=;
 b=AUf8CIyaKYHYYg3trxEDTnxYeBVqlpaggMJyx0QxKFM4PWOUsq1WdazWJq3QGYms4ZfuWte7Tx5MFbUZTqqDwW3Rm80CCnfiOj0jy0BQE9rePOJM/UUYr9QUmKvTnfCD+lVTwYOGdstPUmo1xkVQbg7u4aUnxJuyJLjKslr/DLg=
Received: from MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::22)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:15:14 +0000
Received: from EA8PEPF00000005.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::21) by MW4P222CA0017.outlook.office365.com
 (2603:10b6:303:114::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:15:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000005.mail.protection.outlook.com (10.167.249.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:15:14 +0000
Received: from [192.168.0.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 12:15:09 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 3 Nov 2026 18:14:48 +0000
Subject: [PATCH net-next 3/4] ionic: add an auxiliary device for hardware
 monitoring
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261103-pr46-b4-v1-3-850ab7fbec19@amd.com>
References: <20261103-pr46-b4-v1-0-850ab7fbec19@amd.com>
In-Reply-To: <20261103-pr46-b4-v1-0-850ab7fbec19@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000005:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb98fe5-36ea-4908-ce7d-08df39d66810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|23010399003|36860700016|6133799003|10067099003|22082099003|56012099006|261102123227099003|261102130727099003|18002099003|261009223027099003|11063799006|921020|261021121427099003|261022105027099003|261021135927099003|261026121527099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	zIEmJ8/zo2fWVt96Kr4qliqYsQdgMCNtAtn4NgfXVZ+Otec0fQ8xp0/3B6wOFzNbHz1DV/Ji8acHcm4p63/lBKouREWUAOh32SMg0VrVZWhM+tf+XWOFpcQEtFwWffXzbX+GYSEu5kihFPipDxWJAp27yToq2aFN7Nw+Id5Z1JY/mWgO5ombCsswniKjGZmAQJGDyH4lyaT8WaFg/3Zm/M/q/RBzDlwUk1YE9KZXySvy52Mg5xqP/gZ7I2mfDRgr1HxT4VWVhLSugXsycZ3wV0CgyC4I/LkQwU8unXx5OTlj+JDaNodEk5nNFMwKtPWR/axEJ6MliEIoM1V851LNxHQvSo0HPQpIMPGXRU7pFIqzf5UhvNJRIVbY2ZIPcVji/pDop7Sa15BuGqghmd6WY16Q+X3Ah/qTvkvoaC2pOJk7Y+n7bQiZAbcJdVZuf2+aQuO1l9BRNJFEe4bvnH3e/MIjSbJ+i6dF6HWHbPi/zb6o5FmqmzNAiJtJs6MDKbrV1j0TDTVR+VL2hDmyCMCQ5nAXoLucnQllsHh7VZGaxOThr3IOuXPX7kqXeZML/9pcO4AoNbZNWcWv4cMby8kSoeWJPCmWprPZAGMXVRpwKCqgDgZxNF+quVZMDwstNlxNXe6XzrA626+yFC+y37or2Z5K0Ezg93W0r52Y8H8J0yE5GfpS0WW+FCWHBOQQXdVxjMls1rZeW9+7tFueVKNa6qUeiMD93eM5QqDOshg8QwtjGx45t8B+0lKYs5pzafjH
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(23010399003)(36860700016)(6133799003)(10067099003)(22082099003)(56012099006)(261102123227099003)(261102130727099003)(18002099003)(261009223027099003)(11063799006)(921020)(261021121427099003)(261022105027099003)(261021135927099003)(261026121527099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fqBbCmQwcEl8qtFPxgcMRDoI76eESNuoyfb7LcICinZ/QCMP3fKMpJaj6TseuzyC9z546XpoU9QSK87l3/C0v8Qoqcv9HFtQtxKlhJLBrEqtvvg30Y0gH681RTZb9QUGsMENLweZ0CQnudP7tAbfa7gzOLzfu43tGd3Yxx6SOFebDk6Pfi7xalYdORcJ5tLIvRYaiqJmmcP8RmxoLlPq78kA55CiSN7fHtA+hHRvYKS4j2CQh4a9EIngPym9SNbqWK1SXikMvCynlwyQg16ZkNQT57z6N/iipuN4+sraECvWgaK4XfazbRKtwor8+4b3o+pcUceYVN6y5qHmfdzsBIvAChpcVkkGedM9YNtn5GE/fYjZlNfEVpX05171KFhGd0BZMCur9y03fbRHN3gaeSgut6yp4bpQlMS+yY7Rvj84TzD4G5QHGKNwS7XYsRIj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:15:14.0263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb98fe5-36ea-4908-ce7d-08df39d66810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000005.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817

When the firmware sets IONIC_DEV_CAP_HWMON, create an "hwmon" auxiliary
device so the adapter's sensors can be exposed by a driver in
drivers/hwmon/ rather than by the Ethernet driver.

The GETCAPS response buffer belongs to ionic for the life of the device,
not to the hwmon driver, so a command abandoned on timeout or unbind can
only write into that buffer, never into freed memory.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h     |   2 +
 drivers/net/ethernet/pensando/ionic/ionic_aux.c | 109 ++++++++++++++++++++++++
 drivers/net/ethernet/pensando/ionic/ionic_lif.h |   1 +
 include/linux/ionic/ionic_hwmon.h               |  40 +++++++++
 4 files changed, 152 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 555a77db1b1e..814d70b8623b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -64,6 +64,8 @@ struct ionic {
 	int num_vfs;
 	struct timer_list watchdog_timer;
 	int watchdog_period;
+	void *hwmon_caps_buf;
+	dma_addr_t hwmon_caps_pa;
 };
 
 int ionic_adminq_post(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
index 370a7eff3e28..521f3bd9aee1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_aux.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
@@ -2,6 +2,8 @@
 /* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
 
 #include <linux/kernel.h>
+#include <linux/ionic/ionic_hwmon.h>
+
 #include "ionic.h"
 #include "ionic_lif.h"
 #include "ionic_aux.h"
@@ -17,11 +19,39 @@ static bool ionic_rdma_supported(struct ionic *ionic)
 	return le64_to_cpu(ionic->ident.lif.capabilities) & IONIC_LIF_CAP_RDMA;
 }
 
+static bool ionic_hwmon_supported(struct ionic *ionic)
+{
+	return le64_to_cpu(ionic->ident.dev.capabilities) & IONIC_DEV_CAP_HWMON;
+}
+
+static int ionic_hwmon_prepare(struct ionic *ionic)
+{
+	void *buf;
+
+	if (ionic->hwmon_caps_buf)
+		return 0;
+
+	buf = dmam_alloc_coherent(ionic->dev, IONIC_HWMON_CAPS_BUF_SIZE,
+				  &ionic->hwmon_caps_pa, GFP_KERNEL);
+	if (!buf) {
+		dev_warn(ionic->dev, "Failed to allocate hwmon buffer\n");
+		return -ENOMEM;
+	}
+
+	ionic->hwmon_caps_buf = buf;
+	return 0;
+}
+
 static const struct ionic_aux_type_info ionic_aux_types[IONIC_AUX_MAX] = {
 	[IONIC_AUX_RDMA] = {
 		.name = "rdma",
 		.supported = ionic_rdma_supported,
 	},
+	[IONIC_AUX_HWMON] = {
+		.name = "hwmon",
+		.supported = ionic_hwmon_supported,
+		.prepare = ionic_hwmon_prepare,
+	},
 };
 
 static void ionic_auxbus_release(struct device *dev)
@@ -117,6 +147,85 @@ void ionic_auxbus_unregister(struct ionic_lif *lif)
 	mutex_unlock(&lif->adev_lock);
 }
 
+static struct ionic_lif *ionic_hwmon_lif(struct auxiliary_device *adev)
+{
+	return container_of(adev, struct ionic_aux_dev, adev)->lif;
+}
+
+int ionic_hwmon_get_caps(struct auxiliary_device *adev, u8 max_ver,
+			 const void **buf, size_t *len, u8 *ver)
+{
+	struct ionic_lif *lif = ionic_hwmon_lif(adev);
+	struct ionic *ionic = lif->ionic;
+	struct ionic_admin_ctx ctx = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(ctx.work),
+		.comp.comp.status = IONIC_RC_EIO,
+		.cmd.hwmon_getcaps = {
+			.opcode = IONIC_CMD_HWMON_GETCAPS,
+			.ver = max_ver,
+			.lif_index = cpu_to_le16(lif->index),
+			.resp_buf_len = cpu_to_le32(IONIC_HWMON_CAPS_BUF_SIZE),
+			.resp_dma_addr = cpu_to_le64(ionic->hwmon_caps_pa),
+		},
+	};
+	int err;
+
+	if (!ionic->hwmon_caps_buf)
+		return -ENODEV;
+
+	memset(ionic->hwmon_caps_buf, 0, IONIC_HWMON_CAPS_BUF_SIZE);
+
+	err = ionic_adminq_post_wait_nomsg(lif, &ctx);
+	if (err)
+		return err;
+
+	if (ctx.comp.comp.status)
+		return ionic_error_to_errno(ctx.comp.comp.status);
+
+	*buf = ionic->hwmon_caps_buf;
+	*len = IONIC_HWMON_CAPS_BUF_SIZE;
+	*ver = ctx.comp.hwmon_getcaps.ver;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ionic_hwmon_get_caps, "NET_IONIC");
+
+int ionic_hwmon_get_attr(struct auxiliary_device *adev, u8 type, u8 channel,
+			 u8 attr, u32 *val)
+{
+	struct ionic_lif *lif = ionic_hwmon_lif(adev);
+	struct ionic_admin_ctx ctx = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(ctx.work),
+		.comp.comp.status = IONIC_RC_EIO,
+		.cmd.hwmon_getattr = {
+			.opcode = IONIC_CMD_HWMON_GETATTR,
+			.lif_index = cpu_to_le16(lif->index),
+			.sensor_type = type,
+			.channel = channel,
+			.attr = attr,
+		},
+	};
+	int err;
+
+	err = ionic_adminq_post_wait_nomsg(lif, &ctx);
+	if (err)
+		return err;
+
+	if (ctx.comp.comp.status)
+		return ionic_error_to_errno(ctx.comp.comp.status);
+
+	*val = le32_to_cpu(ctx.comp.hwmon_getattr.attr_value);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ionic_hwmon_get_attr, "NET_IONIC");
+
+struct device *ionic_hwmon_dev(struct auxiliary_device *adev)
+{
+	return ionic_hwmon_lif(adev)->ionic->dev;
+}
+EXPORT_SYMBOL_NS_GPL(ionic_hwmon_dev, "NET_IONIC");
+
 void ionic_request_rdma_reset(struct ionic_lif *lif)
 {
 	struct ionic *ionic = lif->ionic;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index d04503b19c51..95bcfcded562 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -182,6 +182,7 @@ struct ionic_phc;
 
 enum ionic_aux_type {
 	IONIC_AUX_RDMA,
+	IONIC_AUX_HWMON,
 	IONIC_AUX_MAX,
 };
 
diff --git a/include/linux/ionic/ionic_hwmon.h b/include/linux/ionic/ionic_hwmon.h
index 62667e3d7135..bc82f2903386 100644
--- a/include/linux/ionic/ionic_hwmon.h
+++ b/include/linux/ionic/ionic_hwmon.h
@@ -135,4 +135,44 @@ struct ionic_hwmon_caps_hdr {
 	__le16	n_channels[];
 };
 
+struct auxiliary_device;
+struct device;
+
+/**
+ * ionic_hwmon_get_caps - Read the sensor capabilities from the device
+ * @adev:    ionic "hwmon" auxiliary device
+ * @max_ver: highest capabilities buffer layout version the caller parses
+ * @buf:     set to the capabilities buffer
+ * @len:     set to the length of @buf
+ * @ver:     set to the layout version of @buf, as reported by the device
+ *
+ * The buffer belongs to ionic and is overwritten by the next call.
+ *
+ * Return: zero or negative error status
+ */
+int ionic_hwmon_get_caps(struct auxiliary_device *adev, u8 max_ver,
+			 const void **buf, size_t *len, u8 *ver);
+
+/**
+ * ionic_hwmon_get_attr - Read one sensor attribute from the device
+ * @adev:    ionic "hwmon" auxiliary device
+ * @type:    sensor type from enum ionic_hwmon_sensor_type
+ * @channel: channel index within @type
+ * @attr:    attribute ID from the attribute enum for @type
+ * @val:     set to the attribute value, in the units documented for
+ *           struct ionic_hwmon_getattr_comp
+ *
+ * Return: zero or negative error status
+ */
+int ionic_hwmon_get_attr(struct auxiliary_device *adev, u8 type, u8 channel,
+			 u8 attr, u32 *val);
+
+/**
+ * ionic_hwmon_dev - Device to parent the hwmon device to
+ * @adev: ionic "hwmon" auxiliary device
+ *
+ * Return: the PCI function's device
+ */
+struct device *ionic_hwmon_dev(struct auxiliary_device *adev);
+
 #endif /* _LINUX_IONIC_HWMON_H_ */

-- 
2.43.0

