Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729718;
	b=pjDYtdkXZZciooMwZu4E+xvXl9rrphw5qntHeuPqVNwCQ2Mx0GSZ27yKuEmnarqFS2s9
	 eRZ1XgA11b3MOvmuXJ42Wu+JkqqL2Hto4Lwy7JX1NnsOTqELcrh3l3wk9RTjZqgRI0oPp
	 JueuqSLLZNvDl10gXYsQyUhVHV4DtNPFq75rhnaPQ+nVsDCBd3yqOgWvfh3X6RnXM7i93
	 I27mkxHNq79S3GXrffsu6LlwcWZTIbH9xWcCsO8V1b/i81abpT6Ro7686K8Z9ZZLwt0OT
	 KW6Ohc+O4L96mdmqOuGaCa0ohpli8MAPogMmWETL4sqNq4pcPmU6SXqfgIWGLz0d6Gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729718;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=b3ekbjHPxdDb9Yk2Silc+emQjC7AxPzcij9QnI0h4sQ=;
	b=4sP9KLLzhcltq7JhXs5FWg9hI/SGl+mgoZweS3HgB2BkmnwqfUtnsxoPNBNOPwYaIjpB
	 iVRkv0vemO6VYRzRXtLh2+htsle5Kkru1ujrSAl/ftRWeYiueIFqy/1ThPQPFbriroTq3
	 FCmmcQKbBVu5NFXyH2aV7RZZIaDcqYa5/FxHMm7TKN+8RtI30MdEbEqvXPdP226KLd+aS
	 38vDua9xDPHPZjfyzAA35GfEUdkWrYjljxO+A1tVyab1jiAunVh5rTvJOUmoW6FsU4JCx
	 u8gH+3EEZXu9VNgb2WV8R8fRHpu+LLhdK2MqVQiJzTnNYiy++dpOOj2Gua9ahxXEZzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CMeNLQPN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.55
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13894606A31B;
	Tue,  3 Nov 2026 18:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13894606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CMeNLQPN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKB5kaC/7HQdDBuRzhgIztv4USiDyay8AlDXucanZaRjtuUSgtHfzV3iiLAADnwZKHtndyEYXIgLQMARt01aoXXJFvjqsI5EWfcwTl9SeoElflfnqKr/1yzg7+eifZEmA6lznV3qLh26MhrIb+nj3qeV65NkXF9UFOVJsEBPZNoHa9K529r9dtfi2n5idarRJuWvp+vhehhKUgTZNEiWVhtxBfTwS7z0ydj2IYgFKEYV8b5ZPCk7yzq3Q8dE0fIcTLI0vCDwc6+CoYmWS1JCb0/+Z+jPsOIFub9CyUNE0QSUdJlthSUN85U9fPA7JpFKFAbMYITuSRoqwc95prbvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3ekbjHPxdDb9Yk2Silc+emQjC7AxPzcij9QnI0h4sQ=;
 b=FZoFawzlQoeoF3zGauQXTdKu3ewf1xatkAJ5oNoupjawb4hKDDhWeUIXcO9OEjB8gZsZQPaFOWKjSMKsQnusr3aifQ8CfdAq9NYYkkQySwP1rehK8ZwfG7D+CZ3JhpIN+QVCOZUW0ww0rUC7xJl5HWl2UX3SEVil+zkOR7aSBH5EmhCLVYlYS9BfMBu1tiTbYIOgt9qYz5Ib+dvKw1Jfsvrvj+3QGdTI0Oc8p2BPnZW+qF2xvQwqQGVFX1eEwSv8AciqsFadsD9dN6MPEVxGp7nl6Jpl6QsprdAkhPrIBOYQjnncttKL9EZJWBy5XC1tz1Bc4oLWWEpCi6Lk+NzB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3ekbjHPxdDb9Yk2Silc+emQjC7AxPzcij9QnI0h4sQ=;
 b=CMeNLQPNnXoS453wGmMZ8jLDW9ocF2uHGpY8eUN4kH9KPuFOIM17uGxhersUvn7EcUOKaAhqh1b2+lsF1qOuV2OFGejFt+Tt5toZmOn3/XoNFDBjI2ccNB5t9XmfPU8+sj5aK4d5P0ChWKPqLGuqPE8Qhv49RfyuYpduLNNKCNw=
Received: from MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::31)
 by LVUPR12MB999138.namprd12.prod.outlook.com (2603:10b6:408:39e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:15:11 +0000
Received: from EA8PEPF00000005.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::6d) by MW4P222CA0026.outlook.office365.com
 (2603:10b6:303:114::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:15:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000005.mail.protection.outlook.com (10.167.249.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:15:11 +0000
Received: from [192.168.0.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 12:15:05 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net-next 0/4] ionic: report on-board sensors through an
 hwmon auxiliary driver
Date: Tue, 3 Nov 2026 18:14:45 +0000
Message-ID: <20261103-pr46-b4-v1-0-850ab7fbec19@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAJUk6moC/yWMzQqDMBAGX0W+cxdMDLH6KqUHfza6PURJUhHEd
 2+sx2GGORA5CEe0xYHAm0RZfAb1KDDMnZ+YZMwMXWqrVKlpDcZSb8g0tnbq6caq08j1GtjJ/j+
 94DmR5z3hfZv47T88pGuE8/wB3Ns0BnUAAAA=
X-Change-ID: 20261102-pr46-b4-4967f18fd3a2
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
	<abhijit.gangurde@amd.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>, "Arun Kumar
 Prakash" <ArunKumar.Prakash@amd.com>, Eric Joyner <eric.joyner@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000005:EE_|LVUPR12MB999138:EE_
X-MS-Office365-Filtering-Correlation-Id: efb5aef2-6f16-4784-49f9-08df39d6665b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|23010399003|6133799003|18002099003|261102123227099003|261102130727099003|3023799007|13003099007|56012099006|10067099003|261009223027099003|921020|261022105027099003|261021121427099003|261021123027099003|261021135927099003|261022075727099003|11063799006|261026121527099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	q7MlA6njeXLkgR/jLEVirfVhcyJUijrePCNsJdYOGy1mCy8oydKFUsY9FflBBIYAshA0wXnN2larMJIiodcJTc3FDMY/46wb4TN3tNnRoO2EWTyaexBEmRmMrQBSD4QnV8+P4o7vrj+HlQtZz/08lMPdHD44tsJIzTuTxvrHeHe+I9yQdYNwV4Jhu6IFXtPoi1E8nhfIh56ekrbeKXCLNLBhiZN6wEcKxh/UiPp2C6rSpNS+ezq0HXcwpYFV8K8mJlbldP3BcWk52KLb4/pV/G2bFeANF72BOlT81qPBipCbF24kmvwcK84ffdpYa5yjeddWtTGz6rcDZMSrF6QUoVoMs9n5QpdURveAIzC/UsZD8nxo/+5l9IcfpAEJTZkC8DtNVpSBA8ra0JWyNaVETf17sWL0Xqhq36fM628p5nWKKVfKlRudAMu0rNU2gH7Hz9cPIQU2bDNxVvd06sWYf0uZg3qWGpDz45v6y6ZvvNb6Yg5xTVq3gReM2UCIC1D+e781VRK640dZB8Ew+tD7gDLb8afHtFZUvYzPozkhfQlEcpndTETfYHZMBSqSZhF+nEw2vSlLbkCR8EI7n16I7XuvXVbdLTd9TBaYyHK4CvB9hJvTqcYymeN4ahF+Kif7K6rD53dqRFphSr3eJgtUtXLiisRueD8FN/XMpZrYCXsAJzUqW6NNsyFX4YEYPhyA78yUMx/j+E7ruNMdKpXS7g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(23010399003)(6133799003)(18002099003)(261102123227099003)(261102130727099003)(3023799007)(13003099007)(56012099006)(10067099003)(261009223027099003)(921020)(261022105027099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022075727099003)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CbSgzNQsExhc4ZFlvntuR9NLzc2eLVHd5c6Yi5DpFlIW10C1rrdRrTv5GIQEsTh7FK41I7IjoD4bwpf6les5F5NpyS4U/3tAQy/sHqzoqfdc/63jm8n7SpEi3FZOrFROAcNMk4FopuPDLyg2NACMlgpYzR6YZynx0VP+IuElT9SStA3ZVJke3lG14xwwan0w0YoPuPke1UgAACrBaY81TRi/PTvBwQ4S3vh8vrO+ElZobRo3uu+RKg/MSKq/g467ajq6V+dXywnfxKnt/Df6KFSpqzdGuiHURRxHik0yGzOZWSA7tWhunQsc/r8kB1JEACQQ1PgMFVEl/x5AFwhIUDGtWgswIwqrl4gB/jqIQrUhpZV8FsC4UrqZiuiCmG+9lrCnwWJbwds2SoXrR18/NIqVVjWUIlWwYMBbZcHJcys9r9sNg9/5iVufXlC6lfe4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:15:11.1595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb5aef2-6f16-4784-49f9-08df39d6665b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000005.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999138

AMD Pensando adapters can report board and ASIC sensors (temperature,
voltage and power) through the device firmware. This series exposes
them through hwmon.

Following the discussion in [1], ionic creates an "ionic.hwmon"
auxiliary device and a new driver in drivers/hwmon/ binds to it.
Guenter suggested taking the series through net-next with his Ack on
the hwmon driver, and agreed to his off-list reply being quoted here:

  > For b), an Ack from me and applying it through the network
  > subsystem would probably be the easiest approach, but I am open to
  > anything.

The set of sensors depends on the board and the firmware, so firmware
describes it at runtime:

 - Patch 1 registers ionic's auxiliary devices from a table of device
   types, so a second type can be added next to the RDMA device.
 - Patch 2 adds the device interface: a capability bit,
   IONIC_CMD_HWMON_GETCAPS, which returns a buffer describing the sensor
   types, their channels, and each channel's attributes, permissions and
   label, and IONIC_CMD_HWMON_GETATTR, which reads one attribute.
 - Patch 3 creates the "ionic.hwmon" auxiliary device when the firmware
   advertises the capability, and exports the calls the hwmon driver uses
   to issue those commands.
 - Patch 4 adds the ionic-hwmon driver. It parses the capability buffer
   into hwmon channel configuration at probe, and serves each sensor read
   with one GETATTR admin command. Only standard hwmon attributes are
   exposed.

Tested on an AMD Pensando adapter, including driver unbind and PCI
reset with concurrent sensor reads.

This series was developed with the help of an LLM-based coding
assistant (Claude).

[1] https://lore.kernel.org/all/20261009035120.3098398-1-nikhil.rao@amd.com/

---
Arun Kumar Prakash (2):
      ionic: add device interface definitions for hardware monitoring
      hwmon: add AMD Pensando ionic sensor driver

Nikhil P. Rao (2):
      ionic: register auxiliary devices from a table of device types
      ionic: add an auxiliary device for hardware monitoring

 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/ionic-hwmon.rst                |  61 +++
 MAINTAINERS                                        |   9 +
 drivers/hwmon/Kconfig                              |  13 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/ionic-hwmon.c                        | 492 +++++++++++++++++++++
 drivers/net/ethernet/pensando/ionic/ionic.h        |   3 +
 drivers/net/ethernet/pensando/ionic/ionic_aux.c    | 203 +++++++--
 drivers/net/ethernet/pensando/ionic/ionic_aux.h    |   2 +-
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |  14 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   8 +
 drivers/net/ethernet/pensando/ionic/ionic_if.h     | 104 +++++
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |   8 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |   4 +
 include/linux/ionic/ionic_hwmon.h                  | 178 ++++++++
 15 files changed, 1069 insertions(+), 32 deletions(-)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20261102-pr46-b4-4967f18fd3a2

Best regards,
--  
Nikhil P. Rao <nikhil.rao@amd.com>

