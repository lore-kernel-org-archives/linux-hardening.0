Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729724;
	b=zql0BmtM9CWzxrFWC1XZ8CEYbt9QBKt37HemyPaBykxRlLPcYXx9Vi7P4T4gV0RK8x2E
	 EQpx8LZEkCeiKzrm6YSwnF9NfHJ9kDWm/eDubadruC/tPigblfzhgo4ILY/asD7A/ppit
	 t9bSU3cEEHR1FkedasKz8Rbmvzu15maNo3mpIDmS6T2GmF8+NJzj6TX3aXNKzYywcVJD+
	 +zXxAEWCs2J3+o2yYd2gWjAGUZEwEtNdbTyJQey0mT/P9t/q73qfcs9XMmZS/o1mjj8O9
	 ODa4ychN1oaicI2PHCsHzKbGrGthH9jAoUTxP/hw2ZDQTTSmvpiAXcHpPNbN/CEwHtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729724;
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
	bh=tvSFiv8YXy5gDkYbInS8cGSN/RcKa83Mi//VfKJtWLo=;
	b=qpIPYjAt+Pxje3ZGSK9NBGSvYvsWd+ZSKPPg1gNKBn3t29aAEesaqSkrXZKn6vctZRbb
	 r0FdSXdT452+Hy0q5wvpYc7BdL9+Q8/ZCdlJPTYojOntUuAFoZG+nzSd6DSpc+nIP9nZO
	 RuRZzX3X5sUOxmmMkTjxYLX2cTwsYbSfvbd7RXa0W04pYO4g1F6E9PvIaYZKXPRg/d8Di
	 z62NMXtPphupdgkGJaMKgKx67h3fKo9RQFk1j1DV/pfhnlZs7nfsDYll5uyCHXTY96Czv
	 BLGmLKC8MI2JWlqhjRZpAxMNbnkea0efahMxeIyWvLyZViwHAMPEx7u/cmzOz7xawqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TpT836TQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.48
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54306606A33A;
	Tue,  3 Nov 2026 18:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54306606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TpT836TQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zN8/7/pDYzU4AvtrM0kFzjiDkoPzuvVhYOlTNBch9vYKQ0Q2pCYSVVzWwOKjbnLVMAKJAk8kTbguA3NRlcTyNCmRG8f2Rq5gqifcWepPy+ECABdkWUX4WywZd7RsEdog3TG6mQA2TxVfOm9RQWGHr8lJYLZbtt4hh6XYoZBhUYUeFQEzvOrBpqw+RA8Die3ZzNGyuzCMnWH7vYzH/1r6npAMU7rrYqYl97zFemQ645IuN46hJjTMxa8XF8Lv8rZS2QEWb+eee+QtmqaTAgTW5iLU/hClsW+WZGt76NlFM/k8A0lfnyi3eDApIALvd7kJluS3zsx6y0hsRqVWlTgFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvSFiv8YXy5gDkYbInS8cGSN/RcKa83Mi//VfKJtWLo=;
 b=Ai42mTCqAUUc5aS0daAWtkbRHbYVKpw5pIWHhIQb6N+xZqsqTo4KxmjNdNVTX6OWn3WDgzTEnpSxOMyBHbq8vrSdjPrQMtIb/x/l5+l+WA4lhIp8Sh7idTha3F5HCUzJWAZkOaMQ0dEOF3g4+tKxpQbkMwXVseKlutp+FvBgRcB81kVZMjkiSViYmwD4iWR67BmsPpUJg+yirOFhjNA/XDM8IPj8T8WBVZbpr7jA3aDGIDcJbdeVvwfoyJol/GllTEhGu26g00xRfyPO4seUW+xWbpitSd+Qg0IYIMUjcB2RI7R+HGZMAnlCInmck+HraA9WSCYz47dCte2rGWHWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvSFiv8YXy5gDkYbInS8cGSN/RcKa83Mi//VfKJtWLo=;
 b=TpT836TQh/dFUtgVEpYCrM6+womTbrlyXDvB4+pNxquzEZMv95/npo/qZYFjxUpHYlk1fwAEIZ0DBHzyB3EiaehBWUooUR/PFklFn3TOppjih2LN6UMecFBdlGMFgv/ehYMxQqpZ7vim3jk5bfeM/Bd9imOZepMnKBnB1NL90KQ=
Received: from ROAP284CA0441.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:147::18)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 18:15:14 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10d6:10:147:cafe::6) by ROAP284CA0441.outlook.office365.com
 (2603:10d6:10:147::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:15:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:15:12 +0000
Received: from [192.168.0.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 12:15:08 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 3 Nov 2026 18:14:47 +0000
Subject: [PATCH net-next 2/4] ionic: add device interface definitions for
 hardware monitoring
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
Message-ID: <20261103-pr46-b4-v1-2-850ab7fbec19@amd.com>
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
	<abhijit.gangurde@amd.com>, Arun Kumar Prakash <ArunKumar.Prakash@amd.com>,
	Eric Joyner <eric.joyner@amd.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: cc137034-b13b-477a-9033-08df39d66736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|921020|11063799006|56012099006|261009223027099003|261022105027099003|261102123227099003|261021135927099003|261021121427099003|261021123027099003|261026140227099003|261028144727099003|261026121527099003|10067099003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	iMY5VXET/2zH4B+IbhBnJ6Y8AHie8RgpTg+ldvVILIVE8gKcoUcKU69ky7RZJchbkDYLCzo1LlrESQCYms8OMj0FUeqxVZJn99qsQnNbJX5X+uJ2wwvpxF1JDytGtHyqOYZHjdfstU8a7UftukmR/oOXPJ8H4PZQli8/Nmo7Qkp2VQ3+yxklElc2AdENt2JFZppBv3SyQ5RztvKlnI2oT6Bb5lLNWNj0OPdM7TZeUL3iLvSbvAOAQ/iYI0OHo6MRmA9MsayL0THXR1d5XRHF2Hp6XI70Elp3UKMm/jPho1ypij0HSRkofecPufz5N3wMGKbsWuRPLzDzS1+BXjYixsV0fmN5hng5J2vlvn2YoASs0POb56oRtvIYmuMkzQ9KLiJx2VWgEROfRskktV9nkptcGF5Y/qrzoOmmz7U1kzfuPbdyI+03s6avidG45DaSF/EJwf0mGP4T8Vc1pg1LGwZKQAnSZWADPvvGWmxJZqhGcFv/uqHvpV4njdePyNVYDLar2iDRFIzFwvplBryxNhs2jnFaPMKMuDCGMhRGThF7lPBbe0yxAGwPefKwhlIb5cnM0gOTi2IfHi5hEZJHuskwwhXPyhUoegQYXC665T9zJfw8ceNrXNK432YHuqji3Jm1xbw1CLL12kpEu+K8lLveBoTol6NZUr24lrqE2pzeMpGp+aVE9lEaFldsY+za84NVxw9d7pinuYRT26zj5h2+Vgm5qcMrfvlmyuhsqKXGrqBOqZ1zW2Ned71oSQfQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261102123227099003)(261021135927099003)(261021121427099003)(261021123027099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ms4J3CBM6ymqwUp0iKfZ4ZB7q/7UTm5oig7UsKmyy9xeRQdcsRLtBS9bBv6j5Mw+6XylhktYwzg5K3EwqlOXLiqOYY5ZgtGswGqbr6+VF5KPYys1WyDjyWIOpNUZmQFWpFWqBGikyPz+Si04iTzX20hztqNLNUlnq1RsNYH0lxPR2Z/C5xbA4CsC4IJXh7+5BYFxvmYpOPAo7IMmQ2V/2dc2uKTzmSiYhV5Yn/Af/MNfEIGrcOsxPbcCN52Q62An2/ssEK3jLIxi3oxZUNvyJBDYbkFLmfCzxxRAcWO2LYo+BDutmFMN4LFGSBu+nk2R8javdLjd2SEsJUJErtmgKV7wUIxCfOCVJ8YYWLg1eupD6pnqSgHtDsAFBvBxwUzCuHcLFXxoDwtV2+/dvFKunUSuue4LG7+ZOdf+US/R1NJRWN6WW7LZ1p5qwlF523//
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:15:12.6897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc137034-b13b-477a-9033-08df39d66736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596

From: Arun Kumar Prakash <ArunKumar.Prakash@amd.com>

Add the admin queue commands the device uses to describe and report its
sensors: IONIC_CMD_HWMON_GETCAPS returns a buffer enumerating the sensor
types, their channel counts and per-channel attribute capabilities, and
IONIC_CMD_HWMON_GETATTR reads a single attribute of a single channel.

The capability buffer has a variable layout that depends on the number
of sensor types the firmware supports, so it cannot be expressed as a C
struct and its format is documented in a comment instead.

The sensor types, attribute IDs and capability buffer layout go in a
new public header, include/linux/ionic/ionic_hwmon.h, because the hwmon
driver that parses the buffer lives outside the ionic directory.

Signed-off-by: Arun Kumar Prakash <ArunKumar.Prakash@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Co-developed-by: Nikhil P. Rao <nikhil.rao@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 MAINTAINERS                                      |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.h  |   8 ++
 drivers/net/ethernet/pensando/ionic/ionic_if.h   | 104 +++++++++++++++++
 drivers/net/ethernet/pensando/ionic/ionic_main.c |   4 +
 include/linux/ionic/ionic_hwmon.h                | 138 +++++++++++++++++++++++
 5 files changed, 255 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09713dc4c6a7..220b26c73b37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21804,6 +21804,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
 F:	drivers/net/ethernet/pensando/
+F:	include/linux/ionic/
 
 PER-CPU MEMORY ALLOCATOR
 M:	Dennis Zhou <dennis@kernel.org>
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index db90e39a1442..869adb0a0e0c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -9,6 +9,7 @@
 #include <linux/workqueue.h>
 #include <linux/skbuff.h>
 #include <linux/bpf_trace.h>
+#include <linux/ionic/ionic_hwmon.h>
 
 #include "ionic_if.h"
 #include "ionic_regs.h"
@@ -116,6 +117,13 @@ static_assert(sizeof(ionic_rx_filter_del_comp) == 16);
 static_assert(sizeof(struct ionic_rdma_reset_cmd) == 64);
 static_assert(sizeof(struct ionic_rdma_queue_cmd) == 64);
 
+/* HWMON commands */
+static_assert(sizeof(struct ionic_hwmon_getattr_cmd) == 64);
+static_assert(sizeof(struct ionic_hwmon_getattr_comp) == 16);
+static_assert(sizeof(struct ionic_hwmon_getcaps_cmd) == 64);
+static_assert(sizeof(struct ionic_hwmon_getcaps_comp) == 16);
+static_assert(sizeof(struct ionic_hwmon_chan_caps) == 164);
+
 /* Events */
 static_assert(sizeof(struct ionic_notifyq_cmd) == 4);
 static_assert(sizeof(union ionic_notifyq_comp) == 64);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index e911fad545d6..271731a35d9f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -60,6 +60,10 @@ enum ionic_cmd_opcode {
 	/* CMB command */
 	IONIC_CMD_DISCOVER_CMB			= 80,
 
+	/* Hardware monitoring commands */
+	IONIC_CMD_HWMON_GETATTR			= 110,
+	IONIC_CMD_HWMON_GETCAPS			= 111,
+
 	/* QoS commands */
 	IONIC_CMD_QOS_CLASS_IDENTIFY		= 240,
 	IONIC_CMD_QOS_CLASS_INIT		= 241,
@@ -274,11 +278,13 @@ union ionic_drv_identity {
  * enum ionic_dev_capability - Device capabilities
  * @IONIC_DEV_CAP_VF_CTRL:     Device supports VF ctrl operations
  * @IONIC_DEV_CAP_DISC_CMB:    Device supports CMB discovery operations
+ * @IONIC_DEV_CAP_HWMON:       Device supports hardware monitoring
  * @IONIC_DEV_CAP_EXTRA_STATS: Device supports extra stats schema
  */
 enum ionic_dev_capability {
 	IONIC_DEV_CAP_VF_CTRL        = BIT(0),
 	IONIC_DEV_CAP_DISC_CMB       = BIT(1),
+	IONIC_DEV_CAP_HWMON          = BIT(3),
 	IONIC_DEV_CAP_EXTRA_STATS    = BIT(4),
 };
 
@@ -2526,6 +2532,100 @@ struct ionic_qos_clear_stats_cmd {
 
 typedef struct ionic_admin_comp ionic_qos_reset_comp;
 
+/**
+ * struct ionic_hwmon_getattr_cmd - Hardware monitoring get attribute command
+ * @opcode:      Command opcode (IONIC_CMD_HWMON_GETATTR)
+ * @rsvd:        reserved byte(s)
+ * @lif_index:   LIF index
+ * @sensor_type: Sensor type from enum ionic_hwmon_sensor_type
+ * @channel:     Channel index within the sensor type
+ * @attr:        Attribute ID from sensor-specific attribute enum
+ * @rsvd2:       reserved byte(s)
+ *
+ * A *_ATTR_LABEL attribute ID must never be sent in this command.  The label is
+ * already reported in ionic_hwmon_chan_caps.label; the attr_caps LABEL bit only
+ * signals that a label is present.
+ */
+struct ionic_hwmon_getattr_cmd {
+	u8      opcode;
+	u8      rsvd;
+	__le16  lif_index;
+	u8      sensor_type;
+	u8      channel;
+	u8      attr;
+	u8      rsvd2[57];
+};
+
+/**
+ * struct ionic_hwmon_getattr_comp - Hardware monitor get attribute completion
+ * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
+ * @comp_index: Index in the descriptor ring for which this is the completion
+ * @attr_value: Attribute value
+ * @rsvd2:      reserved byte(s)
+ * @color:      Color bit
+ *
+ * attr_value depends on the (sensor_type, attr) pair being read:
+ *
+ *   temperature INPUT, CRIT   millidegrees Celsius, signed 32-bit
+ *   temperature CRIT_ALARM    0 or 1
+ *   voltage INPUT             millivolts
+ *   power INPUT, MAX          milliwatts
+ */
+struct ionic_hwmon_getattr_comp {
+	u8      status;
+	u8      rsvd;
+	__le16  comp_index;
+	__le32  attr_value;
+	u8      rsvd2[7];
+	u8      color;
+};
+
+/**
+ * struct ionic_hwmon_getcaps_cmd - Hardware monitoring get capabilities command
+ * @opcode:         Command opcode (IONIC_CMD_HWMON_GETCAPS)
+ * @ver:            Highest capability buffer layout version supported by
+ *                  the driver
+ * @lif_index:      LIF index
+ * @resp_buf_len:   Length of response buffer
+ * @resp_dma_addr:  DMA address for response data
+ * @rsvd2:          reserved byte(s)
+ *
+ * The device writes the capability buffer in the highest layout version it
+ * supports that does not exceed @ver, and reports that version in the
+ * completion.  IONIC_HWMON_CAPS_VERSION_0 is the layout documented in
+ * include/linux/ionic/ionic_hwmon.h.
+ */
+struct ionic_hwmon_getcaps_cmd {
+	u8      opcode;
+	u8      ver;
+	__le16  lif_index;
+	__le32  resp_buf_len;
+	__le64  resp_dma_addr;
+	u8      rsvd2[48];
+};
+
+/**
+ * struct ionic_hwmon_getcaps_comp - Hardware monitoring get caps completion
+ * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
+ * @comp_index: Index in the descriptor ring for which this is the completion
+ * @ver:        Layout version of the capability buffer written by the device
+ * @rsvd2:      reserved byte(s)
+ * @color:      Color bit
+ *
+ * Devices that predate @ver leave it zero, which is
+ * IONIC_HWMON_CAPS_VERSION_0.
+ */
+struct ionic_hwmon_getcaps_comp {
+	u8      status;
+	u8      rsvd;
+	__le16  comp_index;
+	u8      ver;
+	u8      rsvd2[10];
+	u8      color;
+};
+
 /**
  * struct ionic_fw_download_cmd - Firmware download command
  * @opcode:	opcode
@@ -3306,6 +3406,8 @@ union ionic_adminq_cmd {
 	struct ionic_rx_filter_del_cmd rx_filter_del;
 	struct ionic_rdma_reset_cmd rdma_reset;
 	struct ionic_rdma_queue_cmd rdma_queue;
+	struct ionic_hwmon_getattr_cmd hwmon_getattr;
+	struct ionic_hwmon_getcaps_cmd hwmon_getcaps;
 	struct ionic_fw_download_cmd fw_download;
 	struct ionic_fw_control_cmd fw_control;
 };
@@ -3319,6 +3421,8 @@ union ionic_adminq_comp {
 	struct ionic_lif_getattr_comp lif_getattr;
 	struct ionic_admin_comp lif_setphc;
 	struct ionic_rx_filter_add_comp rx_filter_add;
+	struct ionic_hwmon_getattr_comp hwmon_getattr;
+	struct ionic_hwmon_getcaps_comp hwmon_getcaps;
 	struct ionic_fw_control_comp fw_control;
 };
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 38b47b959a11..9955ab77d86d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -185,6 +185,10 @@ static const char *ionic_opcode_to_str(enum ionic_cmd_opcode opcode)
 		return "IONIC_CMD_VF_GETATTR";
 	case IONIC_CMD_VF_SETATTR:
 		return "IONIC_CMD_VF_SETATTR";
+	case IONIC_CMD_HWMON_GETATTR:
+		return "IONIC_CMD_HWMON_GETATTR";
+	case IONIC_CMD_HWMON_GETCAPS:
+		return "IONIC_CMD_HWMON_GETCAPS";
 	default:
 		return "DEVCMD_UNKNOWN";
 	}
diff --git a/include/linux/ionic/ionic_hwmon.h b/include/linux/ionic/ionic_hwmon.h
new file mode 100644
index 000000000000..62667e3d7135
--- /dev/null
+++ b/include/linux/ionic/ionic_hwmon.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB) OR BSD-2-Clause */
+/* Copyright(c) 2026 Advanced Micro Devices, Inc */
+
+#ifndef _LINUX_IONIC_HWMON_H_
+#define _LINUX_IONIC_HWMON_H_
+
+#include <linux/types.h>
+
+#define IONIC_HWMON_CAPS_BUF_SIZE	4096
+#define IONIC_HWMON_CAPS_VERSION_0	0
+
+/**
+ * enum ionic_hwmon_sensor_type - Hardware monitoring sensor types
+ * @IONIC_HWMON_TYPE_TEMP:      Temperature sensors
+ * @IONIC_HWMON_TYPE_VOLTAGE:   Voltage sensors
+ * @IONIC_HWMON_TYPE_POWER:     Power sensors
+ * @IONIC_HWMON_TYPE_CHIP:      Chip wide attributes
+ * @IONIC_HWMON_TYPE_CURRENT:   Current sensors
+ * @IONIC_HWMON_TYPE_ENERGY:    Energy sensors
+ * @IONIC_HWMON_TYPE_HUMIDITY:  Humidity sensors
+ * @IONIC_HWMON_TYPE_FAN:       Fan speed sensors
+ * @IONIC_HWMON_TYPE_PWM:       PWM controllers
+ * @IONIC_HWMON_TYPE_INTRUSION: Intrusion detection
+ * @IONIC_HWMON_TYPE_MAX:       Number of sensor types defined by this interface
+ *
+ * These values do not necessarily match enum hwmon_sensor_types.
+ */
+enum ionic_hwmon_sensor_type {
+	IONIC_HWMON_TYPE_TEMP		= 0,
+	IONIC_HWMON_TYPE_VOLTAGE	= 1,
+	IONIC_HWMON_TYPE_POWER		= 2,
+	IONIC_HWMON_TYPE_CHIP		= 3,
+	IONIC_HWMON_TYPE_CURRENT	= 4,
+	IONIC_HWMON_TYPE_ENERGY		= 5,
+	IONIC_HWMON_TYPE_HUMIDITY	= 6,
+	IONIC_HWMON_TYPE_FAN		= 7,
+	IONIC_HWMON_TYPE_PWM		= 8,
+	IONIC_HWMON_TYPE_INTRUSION	= 9,
+	IONIC_HWMON_TYPE_MAX		= 10,
+};
+
+/**
+ * enum ionic_hwmon_temp_attr - Temperature sensor attributes
+ * @IONIC_HWMON_TEMP_ATTR_INPUT:      Temperature input reading
+ * @IONIC_HWMON_TEMP_ATTR_LABEL:      Temperature sensor label
+ * @IONIC_HWMON_TEMP_ATTR_CRIT:       Critical temperature threshold
+ * @IONIC_HWMON_TEMP_ATTR_CRIT_ALARM: Critical temperature alarm status
+ */
+enum ionic_hwmon_temp_attr {
+	IONIC_HWMON_TEMP_ATTR_INPUT		= 0,
+	IONIC_HWMON_TEMP_ATTR_LABEL		= 1,
+	IONIC_HWMON_TEMP_ATTR_CRIT		= 2,
+	IONIC_HWMON_TEMP_ATTR_CRIT_ALARM	= 3,
+};
+
+/**
+ * enum ionic_hwmon_voltage_attr - Voltage sensor attributes
+ * @IONIC_HWMON_VOLTAGE_ATTR_INPUT: Voltage input reading
+ * @IONIC_HWMON_VOLTAGE_ATTR_LABEL: Voltage sensor label
+ */
+enum ionic_hwmon_voltage_attr {
+	IONIC_HWMON_VOLTAGE_ATTR_INPUT	= 0,
+	IONIC_HWMON_VOLTAGE_ATTR_LABEL	= 1,
+};
+
+/**
+ * enum ionic_hwmon_power_attr - Power sensor attributes
+ * @IONIC_HWMON_POWER_ATTR_INPUT: Power input reading
+ * @IONIC_HWMON_POWER_ATTR_LABEL: Power sensor label
+ * @IONIC_HWMON_POWER_ATTR_MAX:   Maximum power threshold
+ */
+enum ionic_hwmon_power_attr {
+	IONIC_HWMON_POWER_ATTR_INPUT	= 0,
+	IONIC_HWMON_POWER_ATTR_LABEL	= 1,
+	IONIC_HWMON_POWER_ATTR_MAX	= 2,
+};
+
+/**
+ * struct ionic_hwmon_chan_caps - Per-channel capability descriptor
+ * @attr_caps:  Attribute bitmask where bit N indicates attribute N is supported
+ *              (use sensor-type-specific attribute enums:
+ *              ionic_hwmon_temp_attr, ionic_hwmon_voltage_attr,
+ *              ionic_hwmon_power_attr)
+ * @mode:       Permissions for attribute N, as a single octal rwx digit
+ *              (4 = readable).  Zero hides the attribute.  Values above 7
+ *              are not a mode and hide the attribute too.
+ * @label:      NUL-terminated channel label string
+ *
+ * Every channel reports at least one attribute that its sensor type defines.
+ * Firmware that adds attributes keeps reporting one that older drivers
+ * recognise, and uses @mode to control what is visible.
+ *
+ * The structure needs to be packed since the size of n_channels in the
+ * capability buffer layout documented below is variable, so the channels
+ * array is not guaranteed to start on a 4 byte boundary.
+ */
+struct ionic_hwmon_chan_caps {
+	__le32	attr_caps;
+	__le32	mode[32];
+	char	label[32];
+} __packed;
+
+#define IONIC_HWMON_MODE_MASK		0x7
+#define IONIC_HWMON_MODE_READ		4
+
+/*
+ * Hardware monitoring capabilities buffer layout
+ *
+ * The buffer is a struct ionic_hwmon_caps_hdr followed by the channel
+ * descriptors, so where the descriptors start depends on num_types:
+ *
+ *   struct ionic_hwmon_caps_buf {
+ *       __le16  num_types;
+ *       __le16  n_channels[num_types];
+ *       struct ionic_hwmon_chan_caps channels[total_channels];
+ *   };
+ *
+ * total_channels is the sum of n_channels, and the channels of each sensor
+ * type are contiguous, in n_channels order.  A driver reads at most
+ * IONIC_HWMON_TYPE_MAX entries of n_channels and ignores the channels of
+ * any further types, which follow the ones it knows.
+ *
+ * num_types and n_channels come from the device, and the completion does not
+ * report how much was written, so a parser checks every offset against the
+ * resp_buf_len sent in IONIC_CMD_HWMON_GETCAPS.
+ */
+
+/**
+ * struct ionic_hwmon_caps_hdr - Start of the capabilities buffer
+ * @num_types:  Number of sensor types described by firmware
+ * @n_channels: Channel count for each sensor type, num_types entries
+ */
+struct ionic_hwmon_caps_hdr {
+	__le16	num_types;
+	__le16	n_channels[];
+};
+
+#endif /* _LINUX_IONIC_HWMON_H_ */

-- 
2.43.0

