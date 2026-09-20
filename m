Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2E442378;
	Sun, 20 Sep 2026 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789906620; cv=fail; b=FpJE8rqr8cbO4UTRE9BPwiHZkTvoiQpXuB6cIYCu56EjiMdrbwRw5ZCYHtpX/nBvUaFCRiik0/RbcGJwF+ty7RIE8ZvyYCjAPCvYE8PswnXyh7k/DzxPE5nK8RCXgCdREcsGNa/1pZz48oHBMewevtvg3ub1rgxF2IiYH0CK3xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789906620; c=relaxed/simple;
	bh=LSqSlSpyxRiyXfetvP/cxt4sCrFmAqQ7QcMO82RZj2o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aSEHEMFvzVHax5YK2NTHQrLzxEUzvoEEYoiIj58FRmCRGQmZjWbfIUGrvr8qpODZx7NU+Bx0XL+s6aEe7IWKZBtc9isoSODwoD5Pea2P5tMLcLZF5wJPjF0YyQRe0f45c6UIhISqI+fCf7KnpxSgv2n+8YnVWiFsd+3rFmTIm6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmqIiDeA+axAHprLagWmD8wjwl0NYQR7k/+qwoX1V/3vrLMdcG41Gl/hZiuGh/ARNytpgy3w1lIIbWnaOvwqb8uRp05K+xUxPmNH6hCY7LXwS6J8Pp3miv429i1Nb6BZPWkjwif/TyV2z7Qh8uO807SIrGwEl4VP8BmuZsn5YHZe+BoD1zWbu/JKXeztYroolBMoLJqXO1P53FSjgTgcgYXBw0XsTStewsG+1zai6qnDmScXTNprU8J2+0iKmnIpOKu9inh08UVVPEScrFKXOH/tJhmkMGKcUA8Ecd08H9P5sR3luLdKfSiG7YpLsAiX9mAJNqcxpqiIaE1dnghLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk/ia0dGav4KWuV9zmiA4SfSPsvwrsU4eT1VYscWnKU=;
 b=O/QTZ2YB+X5tWfrUxuPDURGMcLUKc0Vmlcze5W+ZCnwZs9hnQi5DPL5CUZtSiVv0t3SkvmIS98T5zfHLA33t615VB9UMpsorn6wUmYZgZpLus62O8xJShUqcX0UF5UQbQUtH03JmIWF2Gb8VFZ/gy82+otnY++r5sbqcRpCqnd30pvOazGzDMbjS3xEzcvsOKfoH4P+1IJdVm7uvvNcl76LJAqOGPsV0kb1IeBliRaI4msSo20h/wH/bQiz9dTs3QRfRxcIcHoUzNJ+8w9RgGFH2MiZMjqJGtMi3eSx/Z/sm7kHNwf0JpPnrB0zTgBKHEAhemsZVlbLrJhHo/pEmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:00:51 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:00:51 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v4 00/22] Add basic clocks and resets for JHB100 SoC
Date: Sun, 20 Sep 2026 05:00:22 -0700
Message-Id: <20260920120044.194901-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHXPR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::34) To NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1070:EE_
X-MS-Office365-Filtering-Correlation-Id: adee6707-4a9d-47e0-df1d-08df170ed12c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Wcknt/EelLxw4Yxd/aNoMhDACYwSBegfYWfeKKJIrjQzd2wXR9ac5OFY+ehQ9ME8l7me71bz4CaaS/ekNgZ4z+D8g83nA05N4OLLoO6z2lTaC98z3C6tnpOA26/uZ6yhmz9UFA72cLV7AdE5fMHk2lzmkFrtpV+vIM2x4+WlCxKnp/guVAM4Wa0+Q8h1zYUx4pzpoCJ0/Jt+7Vhs204BqRCD9oTvEM1ELIIGfDBpNTtX8oc8sH26q67d9Xvvg+ap0hbkDl1aDRATjNraMouATKqEhGWRsLG8ot704fqhotWYEmTdIFx16rHRhzUnbeq7/3jPajdORhekoOM1RB26BG8jx3loJIGstPaDn/ru3zfiDYMDHeQyqKG4AXtS/f5jjBAKJf+GfrIBVoQvUx8JSOkmlXswE35AlhAeD0Ot7rWWiY4QHu/s08UaHtr3SKMaAGNfCBXn1Q3ETcaAQwq/P897c5bqwBr6Y2LSEksvyo0upbmAjj9FMPg/MKFeSCZajgyjwVXXrI0vPlwlVjHXwcoT3MfhO7AFY1+3t1GiVTiU2FT18f3iscnXgt9xQb+/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU5sak9hdW5qWmpPRXgyWmczRDdnOEZ3blhEQjhuT2RpVkxuenZmQlJZRjJQ?=
 =?utf-8?B?cytTRFNyOERJOUNheDR1SnAzR1llalFFdXZGZGc5UElHWG4xUmd5b2M0MlV0?=
 =?utf-8?B?SXhwLzE0dGxEa09DbzBhcEEwZmxaKzlrWGplYXhGUVFQNFpNZTloaEVyNkl2?=
 =?utf-8?B?MGxZeXpNQktKYW53c2FsWUdZTWYzblhFZWFReFI0Y2RZU1Y1TTNFbHp5VXpQ?=
 =?utf-8?B?OURJWEF4eTFjNDNmWVlWTk04RXdYT0V6dzlYQ1ZVWVRUeDhmSVZJSmM0ZkM1?=
 =?utf-8?B?ZUZOWnRqMnBDU2JmM21PU2d5cWFPRytvTFk3S1p2VlZUREtWYlgxNEJ6Wm1V?=
 =?utf-8?B?YU0xNjlHdDdONkYydUNrNXFoWDFKUEM0UXFWVG9FeUdMcSs0aUEzbTJNV050?=
 =?utf-8?B?Z25RSnJBVzJGMzFhdWdtdUlGMURlaVhIakJ3ZkxRUHpuTVA4bXQ5VjlmMHBq?=
 =?utf-8?B?ZWkrdlFuZUtlU1dYbk95NDRoNk9yMFBFRmtiVjBNSmQyYUhoTzZGM25PbFJ3?=
 =?utf-8?B?MGJjdHA5T0I2T05raUpRQnF1QmY2SGttNExGUCtkVTdYUHZXemlHd3ZjSGsz?=
 =?utf-8?B?bFh2ZHdzd0wyazNUYm95dXdUTmNqN1hHbXorUVQyUmtRTTZ5VnlxWFU3ck5K?=
 =?utf-8?B?RE53dGxGNExPYWRqQXV4MnlmYjU1YkEzeTJPQ2syVENFMDBoOUNLaWg2VWwv?=
 =?utf-8?B?dFJ0WEJaZnZjTTlaVkc4SGk0TVh5ZE1nZFFUSmw1M0pSdVFIdlZHTlhBK2NQ?=
 =?utf-8?B?SFJVQlAyODJxSVdjU3FUTElnaWN6V3RGZDRpbDVraTdwdFlxMHppOEE1KzQ0?=
 =?utf-8?B?Q0Zta29WWUNVUVFtQjdHNk1nbUQ0djV0OFNEQjhsNHZ4akUyeVlSNURxczZy?=
 =?utf-8?B?S2lha0NMeThSMUZGUHRaVGt4aFc2NXdwVTJGRDY3YXlvQXpwQ0xSWGlRWTFs?=
 =?utf-8?B?U1Z3b09oQ1dTM3E2RHc0bmJPQkJoSDRlRm5GeERqR1FaTDI2VTYrRzJkVWF0?=
 =?utf-8?B?REZQVWdpVW9ubkhSQmg1ZzNrQ3Q5dXFtU3JFb09kMXR0dFY1ZWQrWlI0NjZK?=
 =?utf-8?B?TDBrOXJGR1BSdUttdDdnZ29waERxWU80MG1WT1IxNFhzSnNKSkRwL1o3bmJy?=
 =?utf-8?B?cEZyWFFQQnc2blU0SEZZcHF4b09Cd3EzMVNvZmdVOXUwMmsvdkdFMGkxRVl1?=
 =?utf-8?B?WU9Oc2UwMU1XbGJvdHpYNWhTa1hNbSt6MXkrS3FacnNiaFppU0dJNThNbTNH?=
 =?utf-8?B?dDVXbmh5UEZuamFlRVhhU0E2K1RPc1Z3eGt4VEdqbXhWKzVSY3Z6bml5dXFi?=
 =?utf-8?B?SjFHcU40SVkxWmljZVc2NkFrdk81MC9oaVJLUWNoVlZleGowS2w2VTdQNG41?=
 =?utf-8?B?VFJzMHBab0xBUHBzMjRsbVdPaVFoTU1mR1BCVUtPUmwrZ1hCdjk0WjBwWFNq?=
 =?utf-8?B?WXpKYXhLRUFLcXZZaDRKZldtRWd3azMrSXphYjFpUjloNmpOWm11YzZqZG9M?=
 =?utf-8?B?Sy9ENGF4cDY3cXpweXpvSWNwcXNMSEc3NGlmazU4TlVxOVg0MmNTSGtteVZz?=
 =?utf-8?B?clNyQllGTDUyLzRkU21nYWhWMGtYWGh0b0JBSDdyQ3c0a2dzS2k4c0RkZWhk?=
 =?utf-8?B?eUR1a3VZSEFXejE2WTgwTkVCM1dld0p2Q21WZzI2L1ZWRklmUDFLbzlzZFgy?=
 =?utf-8?B?TDA5RENjUXZETmRxZU5EcmZtK054a1RrRjRPWlN1SHVBS2NtajBpcDVCcjFJ?=
 =?utf-8?B?Yk10d0ZISmRZbG0wNFVHUGxRU0MyMmVwMVJGd1U5c0hhbmpyakYwTTBpV0Zu?=
 =?utf-8?B?cExZRUFadHYzZVBvWllJM25TclJlSWk3cmZBejJZUFEzSlBuM1o4eFBMOU82?=
 =?utf-8?B?TEZibDR0ajE5bmMzNHIwUEFZclpSVG4vZnNCTVJHVWpFODltWXFxRFZKQ0h0?=
 =?utf-8?B?WHdQZnpoMWlZRUtkcWN5NWcwMS93TC9VMDZsbmdWZWFzWmpvdHFKenhIckc5?=
 =?utf-8?B?WlNjd1ExWWs1cEM0Z1dQNTlJK0dLYVJST2hEV0h5bWM2ekMyY0NISDBiOE1o?=
 =?utf-8?B?UzRub1dJdDVsNnRJSG1XN3VjbVIwK0ZGUmMrK1VsT3F3ZS9FTlMydnNHaGli?=
 =?utf-8?B?T0toNnZGRGc5VkJZL2QvTlBoV0M4d2Jlb0FqeWxGcXpBYVZhcnMvUU1GL3h4?=
 =?utf-8?B?NUJSa0dJOWVaeWE4NmphdVE3Nlh1SGZKZUx1VlRLcXpRejVPNEQ4d3YvZm5n?=
 =?utf-8?B?WnlneG5Wd3NyS0JKRldFU2twNTIySXpiWWN5WkRLbHZHTHZJVUI1RU90SDdK?=
 =?utf-8?B?YzFNcThRK1ZjeUttb3BtaEd1M1JFTUIrT28vUUludWxpL0lkQjBYUHoxeHlv?=
 =?utf-8?Q?ukDdX46TTz7oLqdOZNY4rVlMJ0fWrw/vMG89B?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adee6707-4a9d-47e0-df1d-08df170ed12c
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:00:51.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Bvkgr3tksdaeQLWVt7IN9lNlGymrpPUIagTg1uic6v0PdAvDkge4IbQyx9YQxraauDiPllVchErvTPNMVxxXsWW/WlrnDMVv6o+RpVXf5jHDtbmlBev9XbhGNxDSMoZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

The JHB100 SoC includes CRG (Clock and Reset Generator) for multiple
subsystems:

The JHB100 SoC is divided into multiple subsystems, and basically
each subsystem includes a CRG(Clock and Reset Generator):
 - sys0crg/sys1crg/sys2crg/
 - per0crg/per1crg/per2crg/per3crg/
 - voutcrg
 - vcecrg
 - gpu0crg/gpu1crg
 - cpucrg
 - usbcrg
 - host0crg/host1crg
 - pcierpcrg
 - husb0crg/husb1crg
 - husbcmncrg
 - husbd0crg/husbd1crg
 - npucrg

In the current series, we will only add the following CRG:
 - sys0crg/sys1crg/sys2crg/
 - per0crg/per1crg/per2crg/per3crg/

The remaining CRG will be implemented in future series.

This series depends on the series:
https://lore.kernel.org/all/20260806122553.182449-1-changhuang.liang@starfivetech.com/
and it has been tested on the StarFive JHB100 EVB-1.

changes since v2:

PATCH 6:
- Replace of_device_get_match_data() with device_get_match_data().
- Change status from "Maintained" to "Supported".
- Add bounds checking for clock init num_parents field to avoid
  out‑of‑bounds access on local parents buffer.

PATCH 12:
- Update commit messages. No content changes.

patch 21:
- Change status from "Maintained" to "Supported"

v3: https://lore.kernel.org/all/20260807112923.191627-1-changhuang.liang@starfivetech.com/
v2: https://lore.kernel.org/all/20260508053632.818548-1-changhuang.liang@starfivetech.com/
v1: https://lore.kernel.org/all/20260402105523.447523-1-changhuang.liang@starfivetech.com/

Changhuang Liang (18):
  dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset
    generator
  clk: starfive: Add JHB100 System-0 clock generator driver
  dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset
    generator
  clk: starfive: Add JHB100 System-1 clock generator driver
  dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset
    generator
  clk: starfive: Add JHB100 System-2 clock generator driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset
    generator
  clk: starfive: Introduce idiv ops for inverted divider clocks
  clk: starfive: Expand the storage of clock parent index
  clk: starfive: Add StarFive JHB100 Peripheral-0 clock driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset
    generator
  clk: starfive: Add StarFive JHB100 Peripheral-1 clock driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset
    generator
  clk: starfive: Add StarFive JHB100 Peripheral-2 clock driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset
    generator
  clk: starfive: Add StarFive JHB100 Peripheral-3 clock driver
  reset: starfive: Add StarFive JHB100 reset driver
  riscv: dts: starfive: jhb100: Add clocks and resets nodes

Sia Jee Heng (4):
  reset: starfive: Rename file name "jh71x0" to "common"
  reset: starfive: Convert the word "jh71x0" to "starfive"
  clk: starfive: Rename file name "jh71x0" to "common"
  clk: starfive: Convert the word "jh71x0" to "starfive"

 .../clock/starfive,jhb100-per0crg.yaml        |  70 ++
 .../clock/starfive,jhb100-per1crg.yaml        |  70 ++
 .../clock/starfive,jhb100-per2crg.yaml        |  76 +++
 .../clock/starfive,jhb100-per3crg.yaml        |  76 +++
 .../clock/starfive,jhb100-sys0crg.yaml        |  63 ++
 .../clock/starfive,jhb100-sys1crg.yaml        |  71 +++
 .../clock/starfive,jhb100-sys2crg.yaml        |  64 ++
 MAINTAINERS                                   |  13 +
 arch/riscv/boot/dts/starfive/jhb100.dtsi      | 198 +++++-
 drivers/clk/starfive/Kconfig                  |  85 ++-
 drivers/clk/starfive/Makefile                 |  10 +-
 drivers/clk/starfive/clk-starfive-common.c    | 492 ++++++++++++++
 drivers/clk/starfive/clk-starfive-common.h    | 147 +++++
 .../clk/starfive/clk-starfive-jh7100-audio.c  | 127 ++--
 drivers/clk/starfive/clk-starfive-jh7100.c    | 503 +++++++--------
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  62 +-
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  72 +--
 .../clk/starfive/clk-starfive-jh7110-stg.c    |  94 +--
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 525 +++++++--------
 .../clk/starfive/clk-starfive-jh7110-vout.c   |  74 +--
 drivers/clk/starfive/clk-starfive-jh7110.h    |   4 +-
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 339 ----------
 drivers/clk/starfive/clk-starfive-jh71x0.h    | 127 ----
 .../clk/starfive/clk-starfive-jhb100-per0.c   | 599 ++++++++++++++++++
 .../clk/starfive/clk-starfive-jhb100-per1.c   | 149 +++++
 .../clk/starfive/clk-starfive-jhb100-per2.c   | 174 +++++
 .../clk/starfive/clk-starfive-jhb100-per3.c   | 132 ++++
 .../clk/starfive/clk-starfive-jhb100-sys0.c   | 150 +++++
 .../clk/starfive/clk-starfive-jhb100-sys1.c   | 105 +++
 .../clk/starfive/clk-starfive-jhb100-sys2.c   | 129 ++++
 drivers/reset/starfive/Kconfig                |  15 +-
 drivers/reset/starfive/Makefile               |   3 +-
 .../reset/starfive/reset-starfive-common.c    | 211 ++++++
 .../reset/starfive/reset-starfive-common.h    |  33 +
 .../reset/starfive/reset-starfive-jh7100.c    |   4 +-
 .../reset/starfive/reset-starfive-jh7110.c    |   8 +-
 .../reset/starfive/reset-starfive-jh71x0.c    | 134 ----
 .../reset/starfive/reset-starfive-jh71x0.h    |  14 -
 .../reset/starfive/reset-starfive-jhb100.c    | 302 +++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 542 ++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 186 ++++++
 ...rfive-jh71x0.h => reset-starfive-common.h} |  10 +-
 42 files changed, 4900 insertions(+), 1362 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-common.c
 create mode 100644 drivers/clk/starfive/clk-starfive-common.h
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per1.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per2.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per3.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys1.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys2.c
 create mode 100644 drivers/reset/starfive/reset-starfive-common.c
 create mode 100644 drivers/reset/starfive/reset-starfive-common.h
 delete mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.c
 delete mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
 create mode 100644 drivers/reset/starfive/reset-starfive-jhb100.c
 create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h
 rename include/soc/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (50%)

--
2.25.1
