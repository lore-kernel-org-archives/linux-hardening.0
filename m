Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED53546CC;
	Wed, 30 Sep 2026 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772230; cv=fail; b=nTskRjZIdGZBmx2Sj7N8K6F2TqRoA/qFA5adhgaSRXSfjJu+4jhCVJp3VohuakAM7r+2q/kD1d0ZlmxtQt8+bQLpWEF27Pcv0A2DmUeMYi9Q8fTOt/kNrXtPt104jlshcsqFemmMMVIDrO0nVCZ/8B7PtInShB1V+Ez51322iVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772230; c=relaxed/simple;
	bh=VagWbk58PMEl7yXiusjuhtwrli6FUIiU8xUwdLqe03I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Q8ncA23LG/IQEdgcQZcubqL2EVzCbDau5ukU2BKzvgrFOSpUUKWFi5XCqtNq35cJGNZavAbVLYpCxJk+Jh/j6K358un0YARLlSfWdqXeNydC484Gn26Xg6U0RQFIwFqkfzuHaM2UN2uW5AV4tmJW5Xx2XwBERNONw8CwtIQloew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOv9eta//al7kWEkomlgcpTYc2oRSyDOunmDb2us4kIGGKTdh1nfVCub4BM+QWbHw9hA8IsM3L1jxrhZJ+tfgQbo2viwybML+1wWsFW86VoCHVob310iIsJG/EizfEjcA9FtVv/aAahFq2p3VtLiiB5E9lGHIRLijDWUwb2+6w+PoG399UC/us4mcLnIgpmCusome1dVkLAx+Do1laM/luxuDVELNPhbyh9BfaON0bHbP78zGZHAL6NTo02SuXI0SAGacP9hqaIGpP6fS5Pb/yJcGNNqUSUwFcrOoXVNNOmEAg5j8q0KDmb+UisBnp6e6haX857ZoDbY9dc6NvTj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIE+uWQwyg/GQIvtclyXYDpj36tObYe+WNXIN5fCML4=;
 b=k2ZQvlmUO6MRzKD3Cb98OU3StVn+yduj1BAAfxsR26iASw93tx3J5KqY8hgV+BZhU7wn6r/rDagUdjGdAzxFsV6Q8Q2G0FqlYMZsjjktSqq9RPhdCvQHZ5rH6m+tbmVtiCMGHnKrg3452i4NyQMTNydJGasbF0085o2YpYNCSNWiVanfwfHteDSYztdTBl0OxL46ETtIyw+aPoepiHwviZuv6+9dw4r0FnJ33u6F4qUhEEZAPyTyIBboy6Co6wHjv80iGadMArQ6N3MioNVGhqygk4EV8chXwHQjYzS4j++UsHlicz6rt+iwRmx8sXnhyUc7Pa8nMjaOFW0e+GjGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1297.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:31 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:31 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
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
Subject: [PATCH v5 00/23] Add basic clocks and resets for JHB100 SoC
Date: Wed, 30 Sep 2026 05:42:54 -0700
Message-Id: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::18) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1297:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5e1f0a-47f4-469b-a581-08df1ef06f26
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|52116014|10067099003|56012099006|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	MsxVvim0DCewWWMRT+OTFcGaBXIjUgsSNTHCekJFzJTmQzIE9va/+AaVx/QZNmwva0k3ABLIbqf1IVPNjrFKtmjqQeSBQbm/ksW2/1Fpsponkb+8h8yS+ZfGErQ5ncNhcYLg5wPMeANVsiVNGFmu9qJpZZOAwLpzOgvYS3NKhvTgIykvGDJRpk2BEKL9Q7uyUd7zV+x/f2IFh+g55ogMcu4Lv9Omk4SQghqKrAQxjgnl+DN3TAHEarx3uElrc5EVt5xHT+Jw7kwAYG8nbLSLEO6dgH937AS3IfwEWjtrXzUtq0L/PwbmNNRF9PoAUdjd3JfD+tNK2du4phd4+hryaPqQKlx4b37zMs8S6zB0yMI5fRhArI9tvzo2wuu6dEmfV6h4FpSF9wfOtjGk1B+S3iOmXxOaYq+5rqhPy0JCESJ2hnjwlmcGe10b3bDAvXpswgsG++hnXNRrGoEzzCTQncA3k4wsGqjx0e/Bi7s5+8zQoLQI7L7Qmsj64m9ahPgUqIBSnQNYQ6USUZC0/Hm37h+5bJE47clX10xtHd76bZfQKpaAYxUp7PO/c9xKVRdbIFQ1m+KSujnXY4Zgk72HYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?86NaFDgsLprL4i7mvjQuaDzO2WzF409QFu79IXnqf0gFryFjb3qwFIIXRQUI?=
 =?us-ascii?Q?lcJq2J7lbv4Zb9/oxwY/BcDKsdXN9tL5saekGMDRQu4Dv5L1xwb23ZDLuR96?=
 =?us-ascii?Q?rmamQ+p4U9Q5bGeJu7JO32om2Dz0ZxzdAKd4m39UmsdjnI/6T3gGD/eRGRSY?=
 =?us-ascii?Q?ItHMAPtp6LE80PQ4fpm+GI0WYgy6iUTi5Kp15hZDXD5v5sTcZjq4NOZQ7cpB?=
 =?us-ascii?Q?zseFGVKMfbzYzb7qe05R5EAl0xmqTgLlJCxALMfmx2OxPANQUQ/UKS/t2efo?=
 =?us-ascii?Q?PWgKwRolxsDUujvo1J/eytr3Xmt0xDRx+nXx8JcWFuNPl9DmM1RPhoxmUN6l?=
 =?us-ascii?Q?+4st/1OVGTfM09y8K9oVx1yHoBSBdV0O/Y0TlnWjphadsoGM/EYfgYgydqzv?=
 =?us-ascii?Q?X0Yq8M74k38OBuzktEF/DypfF1daqNVNX8ayv+wfk9U+w4ZLpEDYorwwp3dq?=
 =?us-ascii?Q?QGDmKjBobFjzSaRS4DAgT5DOC4Gu0ifdF1siZG41Z65p88pltn6K1ZygjsU5?=
 =?us-ascii?Q?CmqkxAyMfUqdM5mJ8arSxxlckv5ALsh4WYQOoTRvA8vZNPyeZs3YBDc9wxvT?=
 =?us-ascii?Q?nS4qV3WWARtdrx2/HNYGS04IJupWy5XOIrmUvqbewztKLh+YP2fbzY6e3CHl?=
 =?us-ascii?Q?VQLfqdXlFBCtiYEj9nwNlMkfWpgOqbh5nCcg0BwL1Cfaejpur3ksmckVVbyZ?=
 =?us-ascii?Q?rtoDZsy4OiCxqchiEzXnMfUfaeSFdV0/92nROl9oup85gJsJluD0MbNXqXT3?=
 =?us-ascii?Q?kp9PEQdcCj7jygXNqoPX9V9CY255aIXmjh9vrhfdI5MOubYLymphdQ/RsHkP?=
 =?us-ascii?Q?ivPQbbgru4FEWT10mZDrjIA/ncw+/4nCKqfR78rj2Vt97fwfLhRpQSW3B+Av?=
 =?us-ascii?Q?zUo6ys89Ss6Tz1za4JO95u2xzIr4Fy6M4mOKOX9Z5a4jUmyxs9OI/ter8Za2?=
 =?us-ascii?Q?hIiCdrdSxYiSyHIYrQTgvFfIVyXc/Hic3ap6GJiGldyD1IBn2+ASf2qWykrn?=
 =?us-ascii?Q?SpkVtZD4kbXYvUzbgZuelw3y41oUnKbYBZi2a81kSCVkIv3+jbSShuKnGBJh?=
 =?us-ascii?Q?QHo/IH7GY4C3ZrJTcykhvPoZiBmz3Zq02rQTjqcSuVdXvnBcIHZoZRcO/qkj?=
 =?us-ascii?Q?2ESycZfUde0HuTwfIPkyUc46miNwvColzQWF83aPXHYiiUHe5zPGRcOavKwL?=
 =?us-ascii?Q?lLZAILX5YZmIcYxR5QRBNn29AoNO3saUe5qHRZG1uWmWdPqx0eG1YpTIynoB?=
 =?us-ascii?Q?ZU6L5exDfIh4CS0NmXT3Fm0s2ouj5lfMvmgnNtnlNafWLol6tXHGEYusKfvM?=
 =?us-ascii?Q?E4X+MRV9jMrBb2IjVDvzEYALHZ6AWqbIqexgRCiOudFR/2OyDXcIsPCjomGM?=
 =?us-ascii?Q?HAc/DkyjfKjB4uICdFJTSYT9SUJpOEGs30QwCF7LJKZNmfXs2+P9dUv+PYBj?=
 =?us-ascii?Q?18arwfToZIMmJXlhNEvfy+VAnGJTqZF/Zn5jMbwyeQg+pgjwZBG993Vs1945?=
 =?us-ascii?Q?3x4UizlZmQDoO3RshW4GWNCuX0SGPcV1wS+KwqmRlRIMaY3lPXRooav8LYcq?=
 =?us-ascii?Q?i4PMgwsKeJaM24JrAiL+w9CoaL2uDFnOQaFavFDgaBSS+pnsIdpOsBDox2KD?=
 =?us-ascii?Q?YXCkHwdvRR0T4JKGX4U6bm33+nf5GBoDm3UX3PaiqQkDjV+HA2R3NLS5W+OX?=
 =?us-ascii?Q?ZcUeknPBFq8lGMB5due4Z/gqSm2ftiC6ReGVlQUFZtw6dLXDnpz+P4ov7pxv?=
 =?us-ascii?Q?PrM9musDWb8H1005eILzAzN//nZmvGnqibG46rnKSwv0K8KXKnOi?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5e1f0a-47f4-469b-a581-08df1ef06f26
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:31.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uX09Bg/cd4cjqk20N27oEP4WHGVGOfIQZqFbjPODK3wyXrV5oNdq6c4Yi1vkPMqIZMx4qIDSdCH6lM7ZUlLB/rtkCRL9qstJj1L4G5roHB/8VL71L+YNTwpdSjJ1B4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1297

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

changes since v4:
- Remove patches 1/2/3/4 in v4, and patches 1/2/3 are newly introduced in v5.
- Refactor the shared clock and reset implementation into JH71x0-specific helpers, updating
  the affected drivers (These include patches 4/6/8/10/12/14/16/18/20/21/22 in v5.) to use
  the new interfaces.
- Split patch 6 in v4 into patch 4 and patch 6 in the current v5.
- Split patch 21 in v4 into patch 21 and patch 22 in the current v5.

PATCH 17: (in v5)
- Add Krzysztof's Reviewed-by tag

v4: https://lore.kernel.org/all/20260920120044.194901-1-changhuang.liang@starfivetech.com/
v3: https://lore.kernel.org/all/20260807112923.191627-1-changhuang.liang@starfivetech.com/
v2: https://lore.kernel.org/all/20260508053632.818548-1-changhuang.liang@starfivetech.com/
v1: https://lore.kernel.org/all/20260402105523.447523-1-changhuang.liang@starfivetech.com/

Changhuang Liang (23):
  clk: starfive: jh7110-sys: Fix memory leak in reset controller
    register
  clk: starfive: JH71x0: Move reset controller registration to jh71x0
    common code
  reset: starfive: jh7110: Match auxiliary device names to jh71x0 clk
    driver
  clk: starfive: jh71x0: Add generic CRG probe helper
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
  reset: starfive: jh71x0: Support discontiguous reset IDs
  reset: starfive: Add StarFive JHB100 reset driver
  riscv: dts: starfive: jhb100: Add clocks and resets nodes

 .../clock/starfive,jhb100-per0crg.yaml        |  70 ++
 .../clock/starfive,jhb100-per1crg.yaml        |  70 ++
 .../clock/starfive,jhb100-per2crg.yaml        |  76 +++
 .../clock/starfive,jhb100-per3crg.yaml        |  76 +++
 .../clock/starfive,jhb100-sys0crg.yaml        |  63 ++
 .../clock/starfive,jhb100-sys1crg.yaml        |  71 +++
 .../clock/starfive,jhb100-sys2crg.yaml        |  64 ++
 MAINTAINERS                                   |  13 +
 arch/riscv/boot/dts/starfive/jhb100.dtsi      | 198 +++++-
 drivers/clk/starfive/Kconfig                  |  72 ++-
 drivers/clk/starfive/Makefile                 |   8 +
 .../clk/starfive/clk-starfive-jh7110-aon.c    |   2 +-
 .../clk/starfive/clk-starfive-jh7110-isp.c    |   2 +-
 .../clk/starfive/clk-starfive-jh7110-stg.c    |   2 +-
 .../clk/starfive/clk-starfive-jh7110-sys.c    |  57 +-
 .../clk/starfive/clk-starfive-jh7110-vout.c   |   2 +-
 drivers/clk/starfive/clk-starfive-jh7110.h    |   4 -
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 161 ++++-
 drivers/clk/starfive/clk-starfive-jh71x0.h    |  24 +-
 .../clk/starfive/clk-starfive-jhb100-per0.c   | 599 ++++++++++++++++++
 .../clk/starfive/clk-starfive-jhb100-per1.c   | 149 +++++
 .../clk/starfive/clk-starfive-jhb100-per2.c   | 174 +++++
 .../clk/starfive/clk-starfive-jhb100-per3.c   | 132 ++++
 .../clk/starfive/clk-starfive-jhb100-sys0.c   | 150 +++++
 .../clk/starfive/clk-starfive-jhb100-sys1.c   | 105 +++
 .../clk/starfive/clk-starfive-jhb100-sys2.c   | 129 ++++
 drivers/reset/starfive/Kconfig                |   9 +
 drivers/reset/starfive/Makefile               |   1 +
 .../reset/starfive/reset-starfive-jh7110.c    |  10 +-
 .../reset/starfive/reset-starfive-jh71x0.c    |  99 ++-
 .../reset/starfive/reset-starfive-jh71x0.h    |  19 +
 .../reset/starfive/reset-starfive-jhb100.c    | 302 +++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 542 ++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 186 ++++++
 34 files changed, 3553 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per1.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per2.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per3.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys1.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys2.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jhb100.c
 create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h

--
2.25.1
