Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729727;
	b=rHNVUn6k4+ZzyIYeA9EEMk8C/noj20kXawEac37cZapPRpvqcT9BN31lS/J4HG0YW922
	 obNjKKTOb9pyZw3nwBGR8UsGFE/LwIWIPLlIk/EuctIJ9v19gYneSDDgT6qkSh72K36ix
	 t/Kno4Hzlwuq3zQzUpii8UhDXRPzp8PodAZl8AKHK1zs2IOunnaDKbRTVgtQ0RCM9/XzD
	 jfMkyvosxR41GOVlcUV7y/A5O9vwMxbMAcsZgFauGdHViPP6ET4LjT7y1y8xDYhJT7heJ
	 3iPWUZJNA5jtuKpFzNMN6JW5sguSCVEDnMiZ3RtzBf1rNEhCHPivh5V3N5Ra1MJNXZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729727;
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
	bh=HOywpAhArP7yN0NXrZ/jQS4dMQ7BX5AdrJO33AvBhdI=;
	b=w5ALNMkI1oG5l5btneqpHV+C8ZQt8alvTSDlhY44PBokxRDpjofIt35lARPr34goO7QX
	 5mGQlPFhSxswN1X+O4cKjr73Vda/fiAfA1VF7oqHuFX07L1AIsXIPOyqvhHAFAFXzBFxz
	 EHIUD8LPfMyEYURGIwmlZTcdE/Tu/P1Z/PymbxfmWdfH9E9zFd/vSYs+1kx3Qw369yi9C
	 iNngiSD1L6DEXC8sT9PDQyMTHEGgcKTs0P7dC1tPf0taADV7biM994EHte66+I6i9lOZ5
	 o3PvPnOcKFZuYsoPciBZmmUtVl6Ny4VaEMzfwThYtCWxfiNbhNuvvqL7Wd3jCtPzvdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LSj1aG6M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.19
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B7606D837;
	Tue,  3 Nov 2026 18:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D29B7606D837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LSj1aG6M
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+bW0fG4mlGn/r5VcY0snFtbnZyqZh5GQdbnJ5DA5GC5HEt6ztRpmMKcA7fxhpv/cI8DmL0cdB84VFTesX8IhGrZuttKKSt0DBG7NIpx545SmRfaZlMHJQk2kZYtsUXwBeldzvMBMSwHo10oiAcv8ugWyoowGj2SmdGTz/RpVBFhkEQ3JItooMEtRXP5DgrXsgKSz5A20dZRUNQ0xfbSWWhrttYgbetssGaHd/bc8M6guphOoi3POq3NPqNbJg4tf8FE84mzyxk1jLNez+lm4GmhKYrFfzmpCWWH2wvmyOkyPKikAWs8uX7dCiUWwE65X/6jX1PFIF3FslG2Ebs3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOywpAhArP7yN0NXrZ/jQS4dMQ7BX5AdrJO33AvBhdI=;
 b=IkVTlSFuk1l+RYWK3tsCEPt3z831DUBOUOBrsYqsve5x0kB105BMhR7ywQgjsYXdWJjfRue9SKSGzohTS+OT7ceqXpXD+2kXiNLRSL06PKQ+wcmYAGSE2AecWfBVNYKV9Bq00Q+2hC0cXBPhnxXawljo/Ev3Gu10U9Bahdov83YIO09eQ3pO1RSYNBTweFuLxj5K0GTmYX4m4lDXoGlXYm5P2wfTunYILkYepsSj4PyIOW+tr+wy1r8NGK4eRJgAndork8Kf88YYjbbZLBmbynWFtrZZMxDk+bMylm34opik2C8ubJhDK+SpuXsrdku6hG7BFM7dXLB8y+PY52UgKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOywpAhArP7yN0NXrZ/jQS4dMQ7BX5AdrJO33AvBhdI=;
 b=LSj1aG6MysMrobX1+zz9WSqR2IxpLDz8zQ6jf2Y70qzFjGUhTd5Mdl21Himeqx5z4K93T8uEIFSBBGvGZwexLpTVNKM4CU4DkVn8Zk4XekWeqJoL5XEZAqa05PeQzV6s3Y39qOI5ptU1KJ5brFAxA6oy9dpenCD3D5NjrkPzrzw=
Received: from ROAP284CA0442.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:147::7) by
 SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 18:15:16 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10d6:10:147:cafe::16) by ROAP284CA0442.outlook.office365.com
 (2603:10d6:10:147::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:15:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:15:14 +0000
Received: from [192.168.0.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 12:15:11 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 3 Nov 2026 18:14:49 +0000
Subject: [PATCH net-next 4/4] hwmon: add AMD Pensando ionic sensor driver
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
Message-ID: <20261103-pr46-b4-v1-4-850ab7fbec19@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c4350f-8d5c-4374-ac5d-08df39d66858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|1800799024|261026140227099003|261026135527099003|261028144727099003|261026121527099003|261026130827099003|261009223027099003|261021121427099003|261022075727099003|261102123227099003|261022113327099003|261021133027099003|261021135927099003|261022105027099003|261022115727099003|261021123027099003|11063799006|261021130227099003|56012099006|6133799003|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	08n0yw5566eQmVbZwTyPz2jRPsBdo95eQTM6TSpG5OShslXoTD3axzFNW3vrYU7v1GFdhxS4bHn1u/IAhU9yHkEWSdPgtwhuhWzxKI6ibvpnb271DzZcyNzBi9gLgU2r4+gfv8vRnwk4DPOKr2LadmHpgFH1U2lZ6WUuP0KX78oqO4JCCicx9ugJ4iKhLKih6zYa/z+O+8RQ8JWUxSfF2EEeWKh5wuJeOyaPdcj37TcReUwBAFW9MUoiUdCeI8PqVwzfh3PADVzD6o7jUu6PNC4Bo5/vpIbCew4FXKwZjT4vCnAHoe9JEPsm41HVwvgL4ikLR2LRfUJTVbRitAC8CONJ4ANE0BMbxVZAi1ppFeC/w5JbT/girWn8aWvxpez8gDlq4jdwUPzG7vIpq11b+m5RtJjwWZzTujoQUWR2kW/HNsmaSraQW30Viw4NdEgk+0+MNxKqItf9IsuggAkS+wKqX6paXnvG2aqINsNUw1GY9IXW6l1BRjiQMwCKzrq39hl3PLUTIDLsY+BTvw5HhB4D1xMduHgQP4TMP5FlkluVwj+Mk6iKTZx4mx3+G36bzXyxMwmguIX9G1UL3IlcKEUJw4E7eMt/DISmiG8P/ejT3Caah99x56kEN2vTEBSYome7uLN3rr5aB/3E4bYBVjpEwjhUjwWsT+I6rWJumBCCTXquMxXkXaFHFrPwGFQYr9I9wcK3qhO1KXUS2oFT4FK18i/QkABEB00VZ1Cu8rXFCv0as7pfjXkkeSZXua7e
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(1800799024)(261026140227099003)(261026135527099003)(261028144727099003)(261026121527099003)(261026130827099003)(261009223027099003)(261021121427099003)(261022075727099003)(261102123227099003)(261022113327099003)(261021133027099003)(261021135927099003)(261022105027099003)(261022115727099003)(261021123027099003)(11063799006)(261021130227099003)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fb+SiPM1eNXCsDB92txNr1R22iuBLkkDdSK4Uckbkc2xM2cOq2j3O3zsl+BKbnKY2adQF7eT/ug77Glz74SpVb5830vaeR6UTOgALoBrg4Ii2tnxsvY5HToIPbGlfT5M1U04VpFOa3vK/aH29tr02Ccwqs35TKAtJtJY6h3WFtGq9NMQo35DK0Mei0OXthCBEPp/7uK9SCHIDHrrrS1GBkwOPF9LO8Nw3cEL4RiTYsTa5EwfzetiNSC6Ocp7xFf/1ZKT3CwHxsOhMZcLCmqGNRilT3ax0t6DmcZ+sDktP57Nvi4Bx5yD/8SPx4+nD74ELRsHv+3ZJ3Z5qPlGmlKkCfeVlG0YXR2x8o5J1/gl1vyiRDtwHXMnHSKbuI5IgsC9HGWfXIh1rjMJWJ35zeuuNgzykd618jEUu5RomJrFK6ySsa6y58YBrHaAZ4RJL4Uz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:15:14.5889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c4350f-8d5c-4374-ac5d-08df39d66858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372

From: Arun Kumar Prakash <ArunKumar.Prakash@amd.com>

Add an auxiliary driver that binds to the "ionic.hwmon" device created
by the ionic Ethernet driver and reports the adapter's temperature,
voltage and power sensors through hwmon.

The sensor set depends on the board and firmware, so the driver reads
it from the device at probe rather than hard-coding it. A sensor type
with a channel the driver does not recognise is skipped as a whole,
since hwmon channel numbers must match the firmware's.

The hwmon device is parented to the adapter's PCI function rather than
to the auxiliary device, so lm-sensors names it by PCI address instead
of as a virtual device.

Signed-off-by: Arun Kumar Prakash <ArunKumar.Prakash@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Co-developed-by: Nikhil P. Rao <nikhil.rao@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 Documentation/hwmon/index.rst       |   1 +
 Documentation/hwmon/ionic-hwmon.rst |  61 +++++
 MAINTAINERS                         |   8 +
 drivers/hwmon/Kconfig               |  13 +
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/ionic-hwmon.c         | 492 ++++++++++++++++++++++++++++++++++++
 6 files changed, 576 insertions(+)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 199ca79621e9..91ecaca9edcd 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -106,6 +106,7 @@ Hardware Monitoring Kernel Drivers
    ina3221
    inspur-ipsps1
    intel-m10-bmc-hwmon
+   ionic-hwmon
    ir35221
    ir38064
    ir36021
diff --git a/Documentation/hwmon/ionic-hwmon.rst b/Documentation/hwmon/ionic-hwmon.rst
new file mode 100644
index 000000000000..23035d617365
--- /dev/null
+++ b/Documentation/hwmon/ionic-hwmon.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: <isonum.txt>
+
+Kernel driver ionic-hwmon
+=========================
+
+Supported chips:
+
+  * AMD Pensando Ethernet adapters whose firmware advertises
+    ``IONIC_DEV_CAP_HWMON``
+
+    Prefix: 'ionic'
+
+Author:
+
+	Arun Kumar Prakash <ArunKumar.Prakash@amd.com>
+
+Description
+-----------
+
+AMD Pensando Ethernet adapters carry on-board sensors that the adapter
+firmware can report.  The ionic Ethernet driver creates an ``ionic.hwmon``
+auxiliary device for adapters whose firmware advertises sensors, and the
+ionic-hwmon driver binds to it and exposes the readings to the Linux hwmon
+subsystem, so userspace utilities such as ``sensors`` can read them.  The
+hwmon device is a child of the adapter's PCI function.
+
+The adapter reports which sensors it has when the hwmon device is created,
+so the files that appear depend on the adapter and its firmware version.
+The hwmon device is removed and re-created across a firmware recovery, and
+the sensors are read again when it is re-created.
+
+The labels are reported once, with the capabilities, and do not change while
+the device is bound.
+
+sysfs interface
+---------------
+
+Attribute files exist only for the channels and attributes the firmware
+reports, within ``/sys/class/hwmon/hwmon[X]``:
+
+========================= ======= =====================================
+Name                      Perm    Description
+========================= ======= =====================================
+``temp[X]_input``         RO      Temperature in millidegrees Celsius
+                                  (m\ |deg|\ C).  May read below zero.
+``temp[X]_label``         RO      Temperature sensor label.
+``temp[X]_crit``          RO      Critical temperature threshold, in
+                                  millidegrees Celsius.
+``temp[X]_crit_alarm``    RO      Critical temperature alarm indicator.
+``in[X]_input``           RO      Voltage in millivolts (mV).
+``in[X]_label``           RO      Voltage sensor label.
+``power[X]_input``        RO      Power in microwatts (uW).
+``power[X]_label``        RO      Power sensor label.
+``power[X]_max``          RO      Maximum power threshold, in
+                                  microwatts.
+========================= ======= =====================================
+
+Labels are strings supplied by the firmware.  A channel that reports an
+empty label has no ``_label`` attribute.
diff --git a/MAINTAINERS b/MAINTAINERS
index 220b26c73b37..a4934e9206e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1276,6 +1276,14 @@ F:	Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
 F:	drivers/net/ethernet/amd/pds_core/
 F:	include/linux/pds/
 
+AMD PENSANDO IONIC HARDWARE MONITORING DRIVER
+M:	Brett Creeley <brett.creeley@amd.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/ionic-hwmon.rst
+F:	drivers/hwmon/ionic-hwmon.c
+F:	include/linux/ionic/ionic_hwmon.h
+
 AMD PENSANDO RDMA DRIVER
 M:	Abhijit Gangurde <abhijit.gangurde@amd.com>
 M:	Allen Hubbe <allen.hubbe@amd.com>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 18c682e1a475..a832eae289f8 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -914,6 +914,19 @@ config SENSORS_IIO_HWMON
 	  for those channels specified in the map.  This map can be provided
 	  either via platform data or the device tree bindings.
 
+config SENSORS_IONIC
+	tristate "AMD Pensando ionic adapter sensors"
+	depends on IONIC
+	help
+	  If you say yes here you get support for the on-board sensors of
+	  AMD Pensando Ethernet adapters, such as temperature, voltage and
+	  power.  The adapter firmware describes which sensors are present,
+	  so the set of attributes varies between adapters and firmware
+	  versions.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called ionic-hwmon.
+
 config SENSORS_I5500
 	tristate "Intel 5500/5520/X58 temperature sensor"
 	depends on X86 && PCI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d4c345ed7261..553e51cb3c9f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -111,6 +111,7 @@ obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
 obj-$(CONFIG_SENSORS_INA238)	+= ina238.o
 obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
 obj-$(CONFIG_SENSORS_INTEL_M10_BMC_HWMON) += intel-m10-bmc-hwmon.o
+obj-$(CONFIG_SENSORS_IONIC)	+= ionic-hwmon.o
 obj-$(CONFIG_SENSORS_ISL28022)	+= isl28022.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
diff --git a/drivers/hwmon/ionic-hwmon.c b/drivers/hwmon/ionic-hwmon.c
new file mode 100644
index 000000000000..78143df75a8f
--- /dev/null
+++ b/drivers/hwmon/ionic-hwmon.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2026 Advanced Micro Devices, Inc */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/ctype.h>
+#include <linux/hwmon.h>
+#include <linux/ionic/ionic_hwmon.h>
+#include <linux/module.h>
+
+struct ionic_hwmon {
+	struct auxiliary_device *adev;
+	struct device *dev;
+	struct hwmon_chip_info chip_info;
+	struct hwmon_channel_info chan_info[IONIC_HWMON_TYPE_MAX];
+	const struct hwmon_channel_info *info[IONIC_HWMON_TYPE_MAX + 1];
+	u16 n_channels[IONIC_HWMON_TYPE_MAX];
+	u16 total_channels;
+	struct ionic_hwmon_chan_caps channels[] __counted_by(total_channels);
+};
+
+static const enum hwmon_sensor_types
+ionic_hwmon_linux_type[IONIC_HWMON_TYPE_MAX] = {
+	[IONIC_HWMON_TYPE_TEMP]		= hwmon_temp,
+	[IONIC_HWMON_TYPE_VOLTAGE]	= hwmon_in,
+	[IONIC_HWMON_TYPE_POWER]	= hwmon_power,
+	[IONIC_HWMON_TYPE_CHIP]		= hwmon_chip,
+	[IONIC_HWMON_TYPE_CURRENT]	= hwmon_curr,
+	[IONIC_HWMON_TYPE_ENERGY]	= hwmon_energy,
+	[IONIC_HWMON_TYPE_HUMIDITY]	= hwmon_humidity,
+	[IONIC_HWMON_TYPE_FAN]		= hwmon_fan,
+	[IONIC_HWMON_TYPE_PWM]		= hwmon_pwm,
+	[IONIC_HWMON_TYPE_INTRUSION]	= hwmon_intrusion,
+};
+
+static const char * const ionic_hwmon_type_name[IONIC_HWMON_TYPE_MAX] = {
+	[IONIC_HWMON_TYPE_TEMP]		= "temp",
+	[IONIC_HWMON_TYPE_VOLTAGE]	= "in",
+	[IONIC_HWMON_TYPE_POWER]	= "power",
+	[IONIC_HWMON_TYPE_CHIP]		= "chip",
+	[IONIC_HWMON_TYPE_CURRENT]	= "curr",
+	[IONIC_HWMON_TYPE_ENERGY]	= "energy",
+	[IONIC_HWMON_TYPE_HUMIDITY]	= "humidity",
+	[IONIC_HWMON_TYPE_FAN]		= "fan",
+	[IONIC_HWMON_TYPE_PWM]		= "pwm",
+	[IONIC_HWMON_TYPE_INTRUSION]	= "intrusion",
+};
+
+static unsigned int ionic_hwmon_sysfs_channel(unsigned int ionic_type,
+					      unsigned int channel)
+{
+	enum hwmon_sensor_types type = ionic_hwmon_linux_type[ionic_type];
+
+	if (type == hwmon_in || type == hwmon_intrusion)
+		return channel;
+
+	return channel + 1;
+}
+
+static unsigned int ionic_hwmon_chan_idx(const struct ionic_hwmon *hwmon,
+					 enum hwmon_sensor_types type,
+					 int channel)
+{
+	unsigned int i, start = 0;
+
+	for (i = 0; i < IONIC_HWMON_TYPE_MAX; i++) {
+		if (ionic_hwmon_linux_type[i] == type)
+			break;
+		start += hwmon->n_channels[i];
+	}
+
+	return start + channel;
+}
+
+struct ionic_hwmon_attr {
+	u8 ionic;
+	u8 hwmon;
+};
+
+struct ionic_hwmon_attr_map {
+	const struct ionic_hwmon_attr *attrs;
+	unsigned int n_attrs;
+};
+
+static const struct ionic_hwmon_attr ionic_hwmon_temp_attr_map[] = {
+	{ IONIC_HWMON_TEMP_ATTR_INPUT,		hwmon_temp_input },
+	{ IONIC_HWMON_TEMP_ATTR_LABEL,		hwmon_temp_label },
+	{ IONIC_HWMON_TEMP_ATTR_CRIT,		hwmon_temp_crit },
+	{ IONIC_HWMON_TEMP_ATTR_CRIT_ALARM,	hwmon_temp_crit_alarm },
+};
+
+static const struct ionic_hwmon_attr ionic_hwmon_voltage_attr_map[] = {
+	{ IONIC_HWMON_VOLTAGE_ATTR_INPUT,	hwmon_in_input },
+	{ IONIC_HWMON_VOLTAGE_ATTR_LABEL,	hwmon_in_label },
+};
+
+static const struct ionic_hwmon_attr ionic_hwmon_power_attr_map[] = {
+	{ IONIC_HWMON_POWER_ATTR_INPUT,		hwmon_power_input },
+	{ IONIC_HWMON_POWER_ATTR_LABEL,		hwmon_power_label },
+	{ IONIC_HWMON_POWER_ATTR_MAX,		hwmon_power_max },
+};
+
+static const struct ionic_hwmon_attr_map ionic_hwmon_attr_maps[] = {
+	[hwmon_temp]	= { ionic_hwmon_temp_attr_map,
+			    ARRAY_SIZE(ionic_hwmon_temp_attr_map) },
+	[hwmon_in]	= { ionic_hwmon_voltage_attr_map,
+			    ARRAY_SIZE(ionic_hwmon_voltage_attr_map) },
+	[hwmon_power]	= { ionic_hwmon_power_attr_map,
+			    ARRAY_SIZE(ionic_hwmon_power_attr_map) },
+};
+
+static const struct ionic_hwmon_attr_map *
+ionic_hwmon_attr_map(enum hwmon_sensor_types type)
+{
+	if (type >= ARRAY_SIZE(ionic_hwmon_attr_maps) ||
+	    !ionic_hwmon_attr_maps[type].n_attrs)
+		return NULL;
+
+	return &ionic_hwmon_attr_maps[type];
+}
+
+static int ionic_hwmon_attr_to_ionic_attr(enum hwmon_sensor_types type,
+					  u32 attr, unsigned int *ionic_attr)
+{
+	const struct ionic_hwmon_attr_map *map = ionic_hwmon_attr_map(type);
+	unsigned int i;
+
+	if (!map)
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < map->n_attrs; i++) {
+		if (map->attrs[i].hwmon == attr) {
+			*ionic_attr = map->attrs[i].ionic;
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static void ionic_hwmon_check_labels(struct device *dev,
+				     struct ionic_hwmon *hwmon)
+{
+	unsigned int type, j, idx = 0;
+	char *label, *p;
+
+	for (type = 0; type < IONIC_HWMON_TYPE_MAX; type++) {
+		for (j = 0; j < hwmon->n_channels[type]; j++, idx++) {
+			label = hwmon->channels[idx].label;
+			label[sizeof(hwmon->channels[idx].label) - 1] = '\0';
+
+			for (p = label; *p; p++) {
+				if (isascii(*p) && isprint(*p))
+					continue;
+				dev_warn(dev,
+					 "%s%u_label is not printable, ignoring it\n",
+					 ionic_hwmon_type_name[type],
+					 ionic_hwmon_sysfs_channel(type, j));
+				label[0] = '\0';
+				break;
+			}
+		}
+	}
+}
+
+static struct ionic_hwmon *ionic_hwmon_create(struct device *dev,
+					      struct auxiliary_device *adev,
+					      const void *buf, size_t buf_len)
+{
+	unsigned int channels_offset, num_types, total_channels, i;
+	const struct ionic_hwmon_caps_hdr *hdr = buf;
+	u16 chan_counts[IONIC_HWMON_TYPE_MAX];
+	struct ionic_hwmon *hwmon;
+	u16 fw_num_types;
+
+	if (buf_len < sizeof(*hdr))
+		return ERR_PTR(-EINVAL);
+
+	fw_num_types = le16_to_cpu(READ_ONCE(hdr->num_types));
+
+	channels_offset = struct_size(hdr, n_channels, fw_num_types);
+	if (channels_offset > buf_len)
+		return ERR_PTR(-EINVAL);
+
+	num_types = min_t(unsigned int, fw_num_types, IONIC_HWMON_TYPE_MAX);
+
+	total_channels = 0;
+	for (i = 0; i < num_types; i++) {
+		chan_counts[i] = le16_to_cpu(READ_ONCE(hdr->n_channels[i]));
+		total_channels += chan_counts[i];
+	}
+
+	if (total_channels >
+	    (buf_len - channels_offset) / sizeof(struct ionic_hwmon_chan_caps))
+		return ERR_PTR(-EINVAL);
+
+	hwmon = devm_kzalloc(dev, struct_size(hwmon, channels, total_channels),
+			     GFP_KERNEL);
+	if (!hwmon)
+		return ERR_PTR(-ENOMEM);
+
+	hwmon->adev = adev;
+
+	for (i = 0; i < num_types; i++)
+		hwmon->n_channels[i] = chan_counts[i];
+
+	hwmon->total_channels = total_channels;
+	memcpy(hwmon->channels, buf + channels_offset,
+	       flex_array_size(hwmon, channels, total_channels));
+
+	ionic_hwmon_check_labels(dev, hwmon);
+
+	return hwmon;
+}
+
+static umode_t ionic_hwmon_file_mode(u32 mode)
+{
+	if ((mode & ~IONIC_HWMON_MODE_MASK) || !(mode & IONIC_HWMON_MODE_READ))
+		return 0;
+
+	/* No attribute is writable: hwmon refuses to register the device if
+	 * any attribute has write permission without a .write op.
+	 */
+	return 0444;
+}
+
+static bool ionic_hwmon_attr_is_label(enum hwmon_sensor_types type, u32 attr)
+{
+	return (type == hwmon_temp && attr == hwmon_temp_label) ||
+	       (type == hwmon_in && attr == hwmon_in_label) ||
+	       (type == hwmon_power && attr == hwmon_power_label);
+}
+
+static umode_t ionic_hwmon_is_visible(const void *data,
+				      enum hwmon_sensor_types type,
+				      u32 attr, int channel)
+{
+	const struct ionic_hwmon_chan_caps *chan_caps;
+	const struct ionic_hwmon *hwmon = data;
+	unsigned int idx, ionic_attr;
+
+	if (ionic_hwmon_attr_to_ionic_attr(type, attr, &ionic_attr))
+		return 0;
+
+	idx = ionic_hwmon_chan_idx(hwmon, type, channel);
+	chan_caps = &hwmon->channels[idx];
+
+	if (ionic_hwmon_attr_is_label(type, attr) && !chan_caps->label[0])
+		return 0;
+
+	return ionic_hwmon_file_mode(le32_to_cpu(chan_caps->mode[ionic_attr]));
+}
+
+static int ionic_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long *val)
+{
+	struct ionic_hwmon *hwmon = dev_get_drvdata(dev);
+	enum ionic_hwmon_sensor_type sensor_type;
+	unsigned int ionic_attr;
+	u32 data;
+	int err;
+
+	err = ionic_hwmon_attr_to_ionic_attr(type, attr, &ionic_attr);
+	if (err)
+		return err;
+
+	switch (type) {
+	case hwmon_temp:
+		sensor_type = IONIC_HWMON_TYPE_TEMP;
+		break;
+	case hwmon_in:
+		sensor_type = IONIC_HWMON_TYPE_VOLTAGE;
+		break;
+	case hwmon_power:
+		sensor_type = IONIC_HWMON_TYPE_POWER;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	err = ionic_hwmon_get_attr(hwmon->adev, sensor_type, channel,
+				   ionic_attr, &data);
+	if (err)
+		return err;
+
+	/* Temperatures are signed millidegrees Celsius and can read below
+	 * zero, so convert them to s32 rather than doing a zero extension.
+	 */
+	if (type == hwmon_temp) {
+		if (attr == hwmon_temp_crit_alarm)
+			*val = !!data;
+		else
+			*val = (s32)data;
+	} else {
+		*val = data;
+	}
+
+	/* The device reports power in milliwatts, sysfs wants microwatts */
+	if (type == hwmon_power)
+		*val *= 1000;
+
+	return 0;
+}
+
+static int ionic_hwmon_read_label(struct device *dev,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel, const char **str)
+{
+	struct ionic_hwmon *hwmon = dev_get_drvdata(dev);
+	unsigned int idx;
+
+	idx = ionic_hwmon_chan_idx(hwmon, type, channel);
+	*str = hwmon->channels[idx].label;
+
+	return 0;
+}
+
+static const struct hwmon_ops ionic_hwmon_ops = {
+	.is_visible = ionic_hwmon_is_visible,
+	.read = ionic_hwmon_read,
+	.read_string = ionic_hwmon_read_label,
+};
+
+static u32
+ionic_hwmon_attr_caps_to_config(u32 attr_caps,
+				const struct ionic_hwmon_attr_map *map)
+{
+	unsigned int i;
+	u32 config = 0;
+
+	for (i = 0; i < map->n_attrs; i++) {
+		if (attr_caps & BIT(map->attrs[i].ionic))
+			config |= BIT(map->attrs[i].hwmon);
+	}
+
+	return config;
+}
+
+static u32 *
+ionic_hwmon_type_config(struct device *dev, unsigned int ionic_type,
+			const struct ionic_hwmon_attr_map *map,
+			const struct ionic_hwmon_chan_caps *chan_caps,
+			unsigned int n_channels)
+{
+	unsigned int j;
+	u32 *config;
+
+	config = devm_kcalloc(dev, n_channels + 1, sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return ERR_PTR(-ENOMEM);
+
+	for (j = 0; j < n_channels; j++) {
+		u32 attr_caps = le32_to_cpu(chan_caps[j].attr_caps);
+
+		config[j] = ionic_hwmon_attr_caps_to_config(attr_caps, map);
+		if (!config[j]) {
+			dev_warn(dev,
+				 "%s%u has no usable attributes, ignoring all %s channels\n",
+				 ionic_hwmon_type_name[ionic_type],
+				 ionic_hwmon_sysfs_channel(ionic_type, j),
+				 ionic_hwmon_type_name[ionic_type]);
+			devm_kfree(dev, config);
+			return NULL;
+		}
+	}
+
+	return config;
+}
+
+static int ionic_hwmon_build_channel_info(struct device *dev,
+					  struct ionic_hwmon *hwmon)
+{
+	unsigned int i, n_types, chan_idx;
+
+	chan_idx = 0;
+	n_types = 0;
+
+	for (i = 0; i < IONIC_HWMON_TYPE_MAX; i++) {
+		enum hwmon_sensor_types type = ionic_hwmon_linux_type[i];
+		unsigned int n_channels = hwmon->n_channels[i];
+		const struct ionic_hwmon_chan_caps *chan_caps;
+		const struct ionic_hwmon_attr_map *map;
+		struct hwmon_channel_info *chan_info;
+		u32 *config;
+
+		if (!n_channels)
+			continue;
+
+		chan_caps = &hwmon->channels[chan_idx];
+		chan_idx += n_channels;
+
+		map = ionic_hwmon_attr_map(type);
+		if (!map)
+			continue;
+
+		config = ionic_hwmon_type_config(dev, i, map, chan_caps,
+						 n_channels);
+		if (IS_ERR(config))
+			return PTR_ERR(config);
+
+		if (!config)
+			continue;
+
+		chan_info = &hwmon->chan_info[n_types];
+		chan_info->type = type;
+		chan_info->config = config;
+		hwmon->info[n_types++] = chan_info;
+	}
+
+	return n_types ? 0 : -ENODEV;
+}
+
+static int ionic_hwmon_probe(struct auxiliary_device *adev,
+			     const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct ionic_hwmon *hwmon;
+	const void *buf;
+	size_t len;
+	int err;
+	u8 ver;
+
+	err = ionic_hwmon_get_caps(adev, IONIC_HWMON_CAPS_VERSION_0, &buf,
+				   &len, &ver);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "cannot read sensor capabilities\n");
+
+	if (ver != IONIC_HWMON_CAPS_VERSION_0)
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "unsupported capabilities version %u\n",
+				     ver);
+
+	hwmon = ionic_hwmon_create(dev, adev, buf, len);
+	if (IS_ERR(hwmon))
+		return dev_err_probe(dev, PTR_ERR(hwmon),
+				     "invalid sensor capabilities\n");
+
+	err = ionic_hwmon_build_channel_info(dev, hwmon);
+	if (err == -ENODEV) {
+		dev_info(dev, "no sensors this driver supports\n");
+		return err;
+	}
+	if (err)
+		return dev_err_probe(dev, err,
+				     "cannot build sensor configuration\n");
+
+	hwmon->chip_info.ops = &ionic_hwmon_ops;
+	hwmon->chip_info.info = hwmon->info;
+
+	/* The hwmon device is parented to the PCI function, not to adev, so
+	 * userspace finds the sensors by PCI endpoint.  Its chip_info and
+	 * config arrays are devres on adev, so it is unregistered in remove
+	 * rather than through devm.
+	 */
+	hwmon->dev = hwmon_device_register_with_info(ionic_hwmon_dev(adev),
+						     "ionic", hwmon,
+						     &hwmon->chip_info, NULL);
+	if (IS_ERR(hwmon->dev))
+		return dev_err_probe(dev, PTR_ERR(hwmon->dev),
+				     "cannot register hwmon device\n");
+
+	auxiliary_set_drvdata(adev, hwmon);
+
+	return 0;
+}
+
+static void ionic_hwmon_remove(struct auxiliary_device *adev)
+{
+	struct ionic_hwmon *hwmon = auxiliary_get_drvdata(adev);
+
+	/* Unregister before the devres on adev frees chip_info and config */
+	hwmon_device_unregister(hwmon->dev);
+}
+
+static const struct auxiliary_device_id ionic_hwmon_id_table[] = {
+	{ .name = "ionic.hwmon", },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, ionic_hwmon_id_table);
+
+static struct auxiliary_driver ionic_hwmon_driver = {
+	.name = "hwmon",
+	.probe = ionic_hwmon_probe,
+	.remove = ionic_hwmon_remove,
+	.id_table = ionic_hwmon_id_table,
+};
+module_auxiliary_driver(ionic_hwmon_driver);
+
+MODULE_AUTHOR("Arun Kumar Prakash <ArunKumar.Prakash@amd.com>");
+MODULE_DESCRIPTION("AMD Pensando ionic hardware monitoring driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("NET_IONIC");

-- 
2.43.0

