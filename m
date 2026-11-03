Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729719;
	b=cfEV8aPvSbq6uuhQk41TDrPWFekQxv5MADyRbWRMBZoSEgXlC7ElHuWsa/RF1EEYK8xC
	 Qaa3Fdc4WBB0Uyl3o+gicehDTH8xxFve7gqq8XMBSrsamPmt9/Y4G8CLmLHlTo9vczpAx
	 9M5PTnCNUmMS5JnifAY0at3+YczaJuiEFjvCRuHNxGAo+cVCK3wZp5ZJP5KjLAwVU5YX9
	 RmVSWSxlek0m5vYt5kjkw3OIVa86Ymu0rs/S2NnHcqXDr+i5vgicTTGcOu9BBxF0U4Agh
	 JE+nWMgHTR8T0Le1iYlVDolT3k06jmDDN1ridoJSd+mWJbMauO/SwnkUaFNOVd1f/Wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729719;
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
	bh=0wMur5ezFgMpodg0Uj9pTQJlbFS2kb1sZpfhoxPc5CI=;
	b=LyKYeaRz2nuO2wVHnqAnDOoV1C8GwR1HTYik7EVVlbLj14twbEiuZear0Ar3jXcvaR9X
	 mLVsX/wu4SZCHwVnJr+DaB4GPf6vbvymoVPjMRPjV7nZNWzucggnK0j9eTg1q9Vdft3ZL
	 l+8aoVtWrF7YlTvtTucEfQ2jKYZRf/OkH5wVWR7NgKkX0SCj/Gwg03glOFLYq7ZYSRlNQ
	 RyWXOqGY/k91kzV6UdsRibtw3ApsoQ9vanbKa+BwASXpMjyek+NF1agafRrtqmWARBlHx
	 t3eX41dZjZKcB2jkKQ7sv4Of2BqPGh8rMtSBIMrkPa7PkBwvG9iEvXMEph7EI6ZCtgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=35JnaTIp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.30
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B12606A326;
	Tue,  3 Nov 2026 18:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54B12606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=35JnaTIp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICwiQE3BiBpivXCYTO8nMX4+Uv33s1d5Bkyne34X36do4xePCoKitGFQw7oJokqL35lHgc/LUo2y9PQmyaR0rIGH4Xm575wzbvTsr9ccq+mlChF+BjQp1+VqrvAhRvMLU7rFuTlWLXgl2rK7XUYJdXCjdKWtiV83y72mj1iB5tLzmSNkf0+WecoafzCONby6ZJe0RAXYyb//rpr69v5PsgrENzjNDl04aSVIcINQE+zO9+f0voqLsvkDsuxG2qvkDFadbPgQLKfMyK9kzhpmZFUFpJAJ2K9lNlI7XXs1QIvjQPv05tsHFbSapR6OhbWr7OrA4A1W/3yIENw2vDTHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wMur5ezFgMpodg0Uj9pTQJlbFS2kb1sZpfhoxPc5CI=;
 b=JC8h5i3X25Vf1sRICgyVXrKGsYn0gsXQp6+YUjj3iSIKVjmfQC3exZ5VY91EZ+485R6++xz4ioa7lD7384rS+n842lWSCN76ARXPbD3a7oPiPJn/2Aj8WvMkGkf45BY0b62KkXP/4pt8usXlgm7Zx6mqnkr08tLuP4OvEEBbO+QLOxsBsV1wb8IMnd6CY/zzm3VRxKvVdSfUiT35rNv5sCeND3QKdw9+KZWhCtLQ4ei5sU6vh8EJD8COG6GsuwKcOE7vfWfscxXFm10N6zlHeO+KaaEyRNljW1bHlymvbT5+konETBWs2iH87nzZPdg5XHDits5QCdryrdSfInAFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wMur5ezFgMpodg0Uj9pTQJlbFS2kb1sZpfhoxPc5CI=;
 b=35JnaTIp2ZFUNLCidlajRp8ssbjZbkItUIa4o6ZoIbhUBdMRFIRpUf93M6r21tde7icDpg0FzCJeeVf9JV/szY9PdnSR1fRzaAEPDCnt2+LoDFILmSN8a2n4vVoD8lWN3zZ8HWc/LLSWJ03p3KMBeZKhFBwL9imMBasYvutIWfg=
Received: from MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::8)
 by LV1PR12MB999303.namprd12.prod.outlook.com (2603:10b6:408:2cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 18:15:12 +0000
Received: from EA8PEPF00000005.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::83) by MW4P222CA0003.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:15:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000005.mail.protection.outlook.com (10.167.249.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:15:12 +0000
Received: from [192.168.0.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 12:15:06 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 3 Nov 2026 18:14:46 +0000
Subject: [PATCH net-next 1/4] ionic: register auxiliary devices from a
 table of device types
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
Message-ID: <20261103-pr46-b4-v1-1-850ab7fbec19@amd.com>
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
X-MS-TrafficTypeDiagnostic: EA8PEPF00000005:EE_|LV1PR12MB999303:EE_
X-MS-Office365-Filtering-Correlation-Id: ace591af-8854-4903-121c-08df39d6671d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|921020|56012099006|11063799006|261009223027099003|261021121427099003|261026121527099003|261022105027099003|261021135927099003|261102123227099003|261022075727099003|261021123027099003|261028144727099003|261026140227099003|10067099003|6133799003|22082099003|18002099003|9063799003;
X-Microsoft-Antispam-Message-Info:
	RHTDkjZl0yHzUsHpxIFE+r4z15yX+YXIexsSfSfAaK3lhzZckM5+AqB9mE1L+70zoj2TnH6oFOsIrXmLvpHINmgQTy9FqwHA19O8EnUIslrnQFOhm/71XEu6F5ahqVkKKmmnc1Ds7iQa0D6wNZivBGWG+JEuj6zCQV4F3G1NzS+VXLRI5kdtxBsD+gkr4/uEt12NzOKSxBpEFnHk9D5Q7/JdN5VuRGr19MmAI4weo3vUQ5clHz6fTHhZ1E4zKId5kn9ZTzT0FwOrMLoZ1ujTFx3/v77kUxNfxUmFwMQX4c0LLc5c6xW4rSNr5KgSRe6THF8UX2Zl/SHSrlK9PcHbdHWChJBIh0nxocbb6MLScmonjEHPHCr9yEwxsNMbQwAp9UIZXjg1f9aHWWker2QTb4DncdUL6GZjatQc6XZol/Z+T7TQ3pMdbwTzDdBJm9B1WcvqMjp8RBXObDqJJ5YYcpUJa4JkObVKLdksz2eoISu/kZlGYWl6LegW9DbCJ6xQe3vbfTmEfneK18BKf+VnObJNce9egPoG4gHsDeHvvCuHujF/dfGGVxdmTBqHoUvyJ29Pb24xL0WzauM2loisxzGMKJQWHp8Y8csTL+QhdaUc9lBjbMxikCMU9FWQql8Vqnpe0HIz4VRD78hjjxrTNtJMoxbasSTD/QViaVG2Xv3Ct40RKO5QoomKkizMZ2CKAAQ/ChX3ZdqAlf03pxw1mDyVDIOlc6uvCPEnZl8wkYtgxP2G6o1ZHlm2NftKG+k9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(921020)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261026121527099003)(261022105027099003)(261021135927099003)(261102123227099003)(261022075727099003)(261021123027099003)(261028144727099003)(261026140227099003)(10067099003)(6133799003)(22082099003)(18002099003)(9063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E/BYN2+O/0zzdR9BBKG0Vl9Iv6S/ERRm1fgjOVW/LB45csv56jnBnIyXAbjWv6cLjWY3hDdPlZiWEu7h8KoXxVhWEag2qst0QicUEIyrOdSQl5N2gKwUySCtd/3158IBOfwQ7wlGN/25BLsYBFqrRjh4M/q6bx2rxhyorXtujGtWFPnLg+IlzgtxKfW1fdkJgQI4ZCFxMRSeauXI9Y1L+y9jj90MkGRKrlAp0eAm7JwawRDUwVhe1S13Vpld8+ybCm7N8G4F3EYxp3VXPH1tjUufBNQGzMGn1ZJt4NMXq2MwrxGEUPC0VSQy6GnN0IhuUG3rG+mjXo2yI39oyruZCXN6ZIbnmOzYBNPX15AQQVa2RKQFNA/docLqcXHQBWr3JogK1dQ85Iq4tZpBt+RWe+F0utfqijzUeCMYWmIkMo7gMzxjSdFdIlP5vE9YFcIp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:15:12.4541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace591af-8854-4903-121c-08df39d6671d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000005.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999303

A later patch adds a hardware monitoring auxiliary device alongside the
rdma one. Describe the auxiliary device types in a table, so that adding
one takes an enum value and a table entry.

Allocate the auxiliary device id once per ionic device instead of on
every add, so all of a device's auxiliary devices share one id, for
example ionic.rdma.0 and ionic.hwmon.0.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h        |  1 +
 drivers/net/ethernet/pensando/ionic/ionic_aux.c    | 94 +++++++++++++++-------
 drivers/net/ethernet/pensando/ionic/ionic_aux.h    |  2 +-
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    | 14 +++-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |  7 +-
 5 files changed, 86 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 85198e6a806e6..555a77db1b1e7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -49,6 +49,7 @@ struct ionic {
 	struct ionic_identity ident;
 	struct workqueue_struct *wq;
 	struct ionic_lif *lif;
+	int aux_id;
 	unsigned int nnqs_per_lif;
 	unsigned int neqs_per_lif;
 	unsigned int ntxqs_per_lif;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
index 4f193d0ee87ad..370a7eff3e283 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_aux.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
@@ -6,41 +6,47 @@
 #include "ionic_lif.h"
 #include "ionic_aux.h"
 
-static DEFINE_IDA(aux_ida);
+struct ionic_aux_type_info {
+	const char *name;
+	bool (*supported)(struct ionic *ionic);
+	int (*prepare)(struct ionic *ionic);
+};
+
+static bool ionic_rdma_supported(struct ionic *ionic)
+{
+	return le64_to_cpu(ionic->ident.lif.capabilities) & IONIC_LIF_CAP_RDMA;
+}
+
+static const struct ionic_aux_type_info ionic_aux_types[IONIC_AUX_MAX] = {
+	[IONIC_AUX_RDMA] = {
+		.name = "rdma",
+		.supported = ionic_rdma_supported,
+	},
+};
 
 static void ionic_auxbus_release(struct device *dev)
 {
 	struct ionic_aux_dev *ionic_adev;
 
 	ionic_adev = container_of(dev, struct ionic_aux_dev, adev.dev);
-	ida_free(&aux_ida, ionic_adev->adev.id);
 	kfree(ionic_adev);
 }
 
-int ionic_auxbus_register(struct ionic_lif *lif)
+static struct ionic_aux_dev *ionic_auxbus_add(struct ionic_lif *lif,
+					      const char *name)
 {
 	struct ionic_aux_dev *ionic_adev;
 	struct auxiliary_device *aux_dev;
-	int err, id;
-
-	if (!(le64_to_cpu(lif->ionic->ident.lif.capabilities) & IONIC_LIF_CAP_RDMA))
-		return 0;
+	int err;
 
 	ionic_adev = kzalloc_obj(*ionic_adev);
 	if (!ionic_adev)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	aux_dev = &ionic_adev->adev;
 
-	id = ida_alloc(&aux_ida, GFP_KERNEL);
-	if (id < 0) {
-		dev_err(lif->ionic->dev, "Failed to allocate aux id: %d\n", id);
-		kfree(ionic_adev);
-		return id;
-	}
-
-	aux_dev->id = id;
-	aux_dev->name = "rdma";
+	aux_dev->id = lif->ionic->aux_id;
+	aux_dev->name = name;
 	aux_dev->dev.parent = &lif->ionic->pdev->dev;
 	aux_dev->dev.release = ionic_auxbus_release;
 	ionic_adev->lif = lif;
@@ -48,9 +54,8 @@ int ionic_auxbus_register(struct ionic_lif *lif)
 	if (err) {
 		dev_err(lif->ionic->dev, "Failed to initialize %s aux device: %d\n",
 			aux_dev->name, err);
-		ida_free(&aux_ida, id);
 		kfree(ionic_adev);
-		return err;
+		return ERR_PTR(err);
 	}
 
 	err = auxiliary_device_add(aux_dev);
@@ -58,24 +63,57 @@ int ionic_auxbus_register(struct ionic_lif *lif)
 		dev_err(lif->ionic->dev, "Failed to add %s aux device: %d\n",
 			aux_dev->name, err);
 		auxiliary_device_uninit(aux_dev);
-		return err;
+		return ERR_PTR(err);
+	}
+
+	return ionic_adev;
+}
+
+static void ionic_auxbus_del(struct ionic_aux_dev *ionic_adev)
+{
+	auxiliary_device_delete(&ionic_adev->adev);
+	auxiliary_device_uninit(&ionic_adev->adev);
+}
+
+void ionic_auxbus_register(struct ionic_lif *lif)
+{
+	const struct ionic_aux_type_info *type;
+	struct ionic_aux_dev *ionic_adev;
+	int i;
+
+	mutex_lock(&lif->adev_lock);
+
+	for (i = 0; i < IONIC_AUX_MAX; i++) {
+		type = &ionic_aux_types[i];
+
+		if (!type->supported(lif->ionic))
+			continue;
+
+		if (type->prepare && type->prepare(lif->ionic))
+			continue;
+
+		ionic_adev = ionic_auxbus_add(lif, type->name);
+		if (!IS_ERR(ionic_adev))
+			lif->aux_devs[i] = ionic_adev;
 	}
 
-	lif->ionic_adev = ionic_adev;
-	return 0;
+	mutex_unlock(&lif->adev_lock);
 }
 
 void ionic_auxbus_unregister(struct ionic_lif *lif)
 {
+	int i;
+
 	mutex_lock(&lif->adev_lock);
-	if (!lif->ionic_adev)
-		goto out;
 
-	auxiliary_device_delete(&lif->ionic_adev->adev);
-	auxiliary_device_uninit(&lif->ionic_adev->adev);
+	for (i = IONIC_AUX_MAX - 1; i >= 0; i--) {
+		if (!lif->aux_devs[i])
+			continue;
+
+		ionic_auxbus_del(lif->aux_devs[i]);
+		lif->aux_devs[i] = NULL;
+	}
 
-	lif->ionic_adev = NULL;
-out:
 	mutex_unlock(&lif->adev_lock);
 }
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.h b/drivers/net/ethernet/pensando/ionic/ionic_aux.h
index f5528a9f187db..215f2f67646be 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_aux.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.h
@@ -4,7 +4,7 @@
 #ifndef _IONIC_AUX_H_
 #define _IONIC_AUX_H_
 
-int ionic_auxbus_register(struct ionic_lif *lif);
+void ionic_auxbus_register(struct ionic_lif *lif);
 void ionic_auxbus_unregister(struct ionic_lif *lif);
 
 #endif /* _IONIC_AUX_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index ddc2f9770df45..9bedcb7224abc 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -20,6 +20,8 @@ static const struct pci_device_id ionic_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, ionic_id_table);
 
+static DEFINE_IDA(ionic_ida);
+
 int ionic_bus_get_irq(struct ionic *ionic, unsigned int num)
 {
 	return pci_irq_vector(ionic->pdev, num);
@@ -321,12 +323,17 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_drvdata(pdev, ionic);
 	mutex_init(&ionic->dev_cmd_lock);
 
+	err = ida_alloc(&ionic_ida, GFP_KERNEL);
+	if (err < 0)
+		goto err_out;
+	ionic->aux_id = err;
+
 	/* Query system for DMA addressing limitation for the device. */
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(IONIC_ADDR_LEN));
 	if (err) {
 		dev_err(dev, "Unable to obtain 64-bit DMA for consistent allocations, aborting.  err=%d\n",
 			err);
-		goto err_out;
+		goto err_out_free_id;
 	}
 
 #ifdef CONFIG_PPC64
@@ -336,7 +343,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = ionic_setup_one(ionic);
 	if (err)
-		goto err_out;
+		goto err_out_free_id;
 
 	/* Allocate and init the LIF */
 	err = ionic_lif_size(ionic);
@@ -401,6 +408,8 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ionic_dev_teardown(ionic);
 	ionic_clear_pci(ionic);
 	ionic_debugfs_del_dev(ionic);
+err_out_free_id:
+	ida_free(&ionic_ida, ionic->aux_id);
 err_out:
 	mutex_destroy(&ionic->dev_cmd_lock);
 	ionic_devlink_free(ionic);
@@ -437,6 +446,7 @@ static void ionic_remove(struct pci_dev *pdev)
 	ionic_dev_teardown(ionic);
 	ionic_clear_pci(ionic);
 	ionic_debugfs_del_dev(ionic);
+	ida_free(&ionic_ida, ionic->aux_id);
 	mutex_destroy(&ionic->dev_cmd_lock);
 	ionic_devlink_free(ionic);
 }
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index e790f6b9441e2..d04503b19c513 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -180,6 +180,11 @@ struct ionic_qtype_info {
 
 struct ionic_phc;
 
+enum ionic_aux_type {
+	IONIC_AUX_RDMA,
+	IONIC_AUX_MAX,
+};
+
 #define IONIC_LIF_NAME_MAX_SZ		32
 struct ionic_lif {
 	struct net_device *netdev;
@@ -225,7 +230,7 @@ struct ionic_lif {
 	dma_addr_t info_pa;
 	u32 info_sz;
 	struct ionic_qtype_info qtype_info[IONIC_QTYPE_MAX];
-	struct ionic_aux_dev *ionic_adev;
+	struct ionic_aux_dev *aux_devs[IONIC_AUX_MAX];
 	struct mutex adev_lock;	/* lock for aux_dev actions */
 
 	u8 rss_hash_key[IONIC_RSS_HASH_KEY_SIZE];

-- 
2.43.0

