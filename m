Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F8339387;
	Fri,  7 Aug 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111323; cv=fail; b=HWWO8tr428QlP9VmVTsCjM3iG8Z7o/XokEkIuJ5owRsiS4++SYU21zu9x9mteDTLPcha1MTUyb2kkIK2TqgK9cJkUWTnlaJt985vYxPMKryS9t1v81Blq0DbLJ2c8J+yY9Utf3wiUYUYoplt94KC/C23KW0OYexS9DtUd16uF84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111323; c=relaxed/simple;
	bh=l09ro+/+6u+MJW8+EYHOhZ6CmlEH1xAM+jR/NJ7S+VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=axq0i9Y2tB+o5AYs4MqK0JYKh0mz02SW83ejYGIur6uCeq3eT4P/RalEM8FoNxnhH+VltCDRRdkHsUy9qYa8PB/gQI5D1Hqo/eMJTKlbNfpU6YxGjBKokMnaQ/0yeIazfet7kX6PmHGLYS4SUdlWdiA5bbm8VSDV3e4uJRXMTwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLLEyI0KWRp0U8vb1/o3++A/0m0WSY7M8nDKw6uWa0wP1u1YonEG3T+kSaW4oEMvbNYH20Og03Reaj9DyKIi47LG6t2pypzIMcCpe/kbdFuS09dWr/YtbwAMI86Bnu7ROP8nWuF4l7js4XLDHIaGwat65+2quWm1hp/AhnXe70uWAW6mlRMvFqvcayBJr6XoDh8IVUWXF17tm/ydJggZzqvkq6TTQMG2FHlDl/Sb2275eWNvQPm4wbFJ48mdLK9Ip6qm9Gj5BgkEEV7tAMo+kr8IAwuZYmvsqHBBOzDkqRw2EJcUyyUGIyYrYIKOSyYYUiOpkmtdMNtqza4iA9FigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COk+zQgAKbai03rhMcSIYzRTspGbv4N3xOu8PjXrC+M=;
 b=R31k4THBZGfrOz+aqbYbwx6QAzWxFJR4My/HWuF6q38Bp7x3nlorByuao51JROv1SnqNmubUaoZJQW/YsR3qM1gfFebJlx5r9nU8C1Auc21xB0smCjed27Cs5Xd60xWnBt+y6efQyprfcHCV155RuIRn5D0AQOT1+JuU41qw5c3Gob9nAnQfjGlbQ02xpYhutJxXqw4RsSfSUG8fE6Pqs8HUi9kcuYJ0DYCYVyKZoR7VeQikQYFxlXGfZtC81ZbS2Kkt2at2EGEqi6HsewZVI3xmAxlO2qJ0HressOeYCyGf8fl+L2fNnopitUx+J6oAX95uBLSrB4eZ3Llxhd25lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:35 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:35 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
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
Subject: [PATCH v3 02/22] reset: starfive: Convert the word "jh71x0" to "starfive"
Date: Fri,  7 Aug 2026 04:29:03 -0700
Message-Id: <20260807112923.191627-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
References: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::19) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1315:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7e759e-9fe5-4d88-cd5c-08def4772867
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fmrScpxIbtzA1sbAMBJF1c9dpt8rp6Y7zhX1yMWeaMforxY2WTI3xe/B8eGzChSNt/b/K0AhDVC3CdVANBI9PRyoBcgCGq5TH5PpJOJf53ebCDgG/gRev+xVSv1XRRGwDkc36oKLcW7j0ayV+zz2+Rzk+If1JxFqOONgbZx3iG4NxGY/UmWCt5O36wgDDa+1gUNazwXx1i/d/Shai9rTWAKOzeJ6FAO/YwI9kNMshQsLvRKKTsr/iGcSJzpSfCIyKmEAKdRZ3XYZgIyeOnvNuj9oCyovahwBHgbgzZMGgcUHpSbJHZZXXcTTEBGi+aTQs6Q8ObC9QqvM9LhB7dVErrBnFsaZgZDO+fWHx4T6XwcQK31lTWPKWgRYXZ0OAuPAz3aYCq63y/CDXibzoHRn/6kCDzn93sevouv0niMImmdxnUAZQfor8Ily61rCFUksVJbfJdp4szl4KOfU3mrccmviS3OhEydad+Gj1pkTZRoa0h7cDPRKrXE6cdob6ALy+idHwcyX9XP3CtzIwI2cO7ttDtbqjIacUVM9xKMaX59BwIptOnuXy+m1TcOLcaR2fGu2uBmMzO5AGXzDPxGy3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bb2tlLoz8PbvIUG58rgFbbsWSKwhP0g8TUNg54ntz2NPrKHMOOPeQSWk16n1?=
 =?us-ascii?Q?zWhtVwAp1lOp2/5AINzA9X51WqP50AkpswjsVWATSZNW5wZuagXeq60E2pMk?=
 =?us-ascii?Q?KqTrgazuWqcMUyc5hRWG0ekxy31+pelEarwocuYlLyL7VfaYniQsJSbBwlcu?=
 =?us-ascii?Q?URx+0zZbUFUslG1W/vtOzWCMa1l0wLdM3sUB32+tuMS7bjGiwB5r4APSrMBF?=
 =?us-ascii?Q?1tmQ6eqTk7LbHTcF3am4g0J8SymFfFYzPb0IdiCurlAMH53Rj3aT8/s4+PNF?=
 =?us-ascii?Q?/eprC/CC9EVHNUVbNIc1L0g7K58H92gcRQ9a7fGWimVVxzYMIOGhRzmj0GRM?=
 =?us-ascii?Q?s0eqjBgZFGogYspvlTk48NbqTW1cS6FRac4hKPj+13kGoApGLeDPDTVIpuH2?=
 =?us-ascii?Q?+8rTKv1xjLZ20h6HA3Yv65mX+C9d1FhPQ967nvOsl1TchNCXrBHXusMa6p3w?=
 =?us-ascii?Q?10E3W2IqptyQP7fv1JfOvA2rr5kHz2JO68fGyKiCUsKp27kfQPbgEI3xM4EN?=
 =?us-ascii?Q?zaNqbP2dTK/EChl5ece46fC6rtQRBdAH5nNKa+z1H26/9LC46eQP9UnwPqZl?=
 =?us-ascii?Q?6Oi2Op5H6HXh5N6bsluYDNODGBQyLWh3aIo+gcFHtriruyyiDmdz3jdb/R3r?=
 =?us-ascii?Q?NTL2HdlM1hqoKPRQs2fF7VoH7nPGo46UUClkhaPpE5H310S6WkHTX65++9UA?=
 =?us-ascii?Q?luN39Ufr/vs+/H5CiYCdKy+4TuMwPNMEIEcJs25C+39ZdFQEePJwh3OCXUJN?=
 =?us-ascii?Q?z6UHYIwfhQRmevTABle+v5BG5DHsKxv1jbLtQBe4C5FfdcTUsFBtPlThwhHs?=
 =?us-ascii?Q?oWhZb7pCo2R3QyfVzWdlmbQDBrM9VTE09QQY4TkQ1eKf241xK4v+H/vkBO4+?=
 =?us-ascii?Q?xJ7law/rvwiWLlMUAtKBICuO4fCJ41zoNwnYK2JJPxcDQO6uk4EEQaWGuttu?=
 =?us-ascii?Q?+9DBLDi6T+zSWdwnY2vXnoQoUpw4bIpLQiXTReXGybjyzIPpkQZQB1GYKTo0?=
 =?us-ascii?Q?S7fsi5tlhHlwvuQQy7oPb50cU2Jv7+3D3+QoiY/g7Sv/PgyJmgSpCthNL0/y?=
 =?us-ascii?Q?SktG/SneIw5HC4aB3b8ZQ81UPTNKU6Wu0Iy8pPF9BdTYB1/BlHkgNFySrIPI?=
 =?us-ascii?Q?toxholnhu7xOWK+SCSpcRQKFmVd0lBlcOzDJ8Gkbn084NWCjkpVv/yimkdSr?=
 =?us-ascii?Q?cBUMVSDIf3+Vr/f+Xnoh7asi7R6lPjEuG1qIjqfnG1dxw6yba6xbe+jneqDR?=
 =?us-ascii?Q?U5hIm06xSpkcJKCvUTJtV/8hVNdBTWQRtkXuZ0eWGy5kMMD5+sabX0m0SXQg?=
 =?us-ascii?Q?kh2BGRllc87paHhttMy0eQh8eL2Z7ikH2dEEBIlQmhRaeGTSIdh9c42H7Y7K?=
 =?us-ascii?Q?+fK6XuTRI8w8XSFFSV+oLcjAioJVVmHBIadI4X+jb6Mhk8w4T3eBmXvaQVwX?=
 =?us-ascii?Q?gQrKhdu4ITsG3xUMjHrVC9gNSrySmgyPNzaEaTL0/WcAdi9mJf8zyVNFiETl?=
 =?us-ascii?Q?A3QrOttmmmspIowAN9IE6opu912J2zqXJKYvckCd1vljSMjrzfNpyDg7uwG8?=
 =?us-ascii?Q?VugB1f4uYB4kJMlPCqG1WgHylQ12Lr4YkML8jFsw7gdLHB3OO+FzBJaLoc5h?=
 =?us-ascii?Q?IsJB5++haUiHjOM0ozylk3GujsXPlYyAcfI2MSpbSSiaYFKLQBT+FQ8m+g7u?=
 =?us-ascii?Q?dZKMB3IhfTcpfOShEqxmKEMJf1CASU7LGicp/Julmw1GrI3CvzmYEjRA1vAd?=
 =?us-ascii?Q?tH5eG0zpPFIueSN0CyxuIHzvBXl3oYOfTOu2AEu77OHyvvAVxA0T?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7e759e-9fe5-4d88-cd5c-08def4772867
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:35.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6t2PBdEKxp334IY2HkknYOnV126IWe2+pqLttKp6qJC1rY3cYdtrS/+pBAaovY1rD1Xx1PAvMhkQgqnVzrPfJwI3OL67pOSkQyJwr7QQXbtOvUsuvszab0W5UwfFJNwi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Function names that consist of the 'jh71x0' naming convention are
renamed to use the 'starfive' wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clk/starfive/clk-starfive-jh7110-sys.c    |  4 +-
 .../reset/starfive/reset-starfive-common.c    | 64 +++++++++----------
 .../reset/starfive/reset-starfive-common.h    |  8 +--
 .../reset/starfive/reset-starfive-jh7100.c    |  2 +-
 .../reset/starfive/reset-starfive-jh7110.c    |  4 +-
 include/soc/starfive/reset-starfive-common.h  |  6 +-
 6 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index edf4c45e6ff0..17fd061ee196 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -334,7 +334,7 @@ static void jh7110_reset_unregister_adev(void *_adev)
 static void jh7110_reset_adev_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
 
 	kfree(rdev);
 }
@@ -343,7 +343,7 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 				     const char *adev_name,
 				     u32 adev_id)
 {
-	struct jh71x0_reset_adev *rdev;
+	struct starfive_reset_adev *rdev;
 	struct auxiliary_device *adev;
 	int ret;
 
diff --git a/drivers/reset/starfive/reset-starfive-common.c b/drivers/reset/starfive/reset-starfive-common.c
index d615c4a68cc0..772bdf6763d1 100644
--- a/drivers/reset/starfive/reset-starfive-common.c
+++ b/drivers/reset/starfive/reset-starfive-common.c
@@ -14,7 +14,7 @@
 
 #include "reset-starfive-common.h"
 
-struct jh71x0_reset {
+struct starfive_reset {
 	struct reset_controller_dev rcdev;
 	/* protect registers against concurrent read-modify-write */
 	spinlock_t lock;
@@ -23,16 +23,16 @@ struct jh71x0_reset {
 	const u32 *asserted;
 };
 
-static inline struct jh71x0_reset *
-jh71x0_reset_from(struct reset_controller_dev *rcdev)
+static inline struct starfive_reset *
+starfive_reset_from(struct reset_controller_dev *rcdev)
 {
-	return container_of(rcdev, struct jh71x0_reset, rcdev);
+	return container_of(rcdev, struct starfive_reset, rcdev);
 }
 
-static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
-			       unsigned long id, bool assert)
+static int starfive_reset_update(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
 {
-	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	unsigned long offset = id / 32;
 	u32 mask = BIT(id % 32);
 	void __iomem *reg_assert = data->assert + offset * sizeof(u32);
@@ -61,34 +61,34 @@ static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
 	return ret;
 }
 
-static int jh71x0_reset_assert(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	return jh71x0_reset_update(rcdev, id, true);
+	return starfive_reset_update(rcdev, id, true);
 }
 
-static int jh71x0_reset_deassert(struct reset_controller_dev *rcdev,
-				 unsigned long id)
+static int starfive_reset_deassert(struct reset_controller_dev *rcdev,
+				   unsigned long id)
 {
-	return jh71x0_reset_update(rcdev, id, false);
+	return starfive_reset_update(rcdev, id, false);
 }
 
-static int jh71x0_reset_reset(struct reset_controller_dev *rcdev,
-			      unsigned long id)
+static int starfive_reset_reset(struct reset_controller_dev *rcdev,
+				unsigned long id)
 {
 	int ret;
 
-	ret = jh71x0_reset_assert(rcdev, id);
+	ret = starfive_reset_assert(rcdev, id);
 	if (ret)
 		return ret;
 
-	return jh71x0_reset_deassert(rcdev, id);
+	return starfive_reset_deassert(rcdev, id);
 }
 
-static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_status(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	unsigned long offset = id / 32;
 	u32 mask = BIT(id % 32);
 	void __iomem *reg_status = data->status + offset * sizeof(u32);
@@ -100,25 +100,25 @@ static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
 	return !((value ^ data->asserted[offset]) & mask);
 }
 
-static const struct reset_control_ops jh71x0_reset_ops = {
-	.assert		= jh71x0_reset_assert,
-	.deassert	= jh71x0_reset_deassert,
-	.reset		= jh71x0_reset_reset,
-	.status		= jh71x0_reset_status,
+static const struct reset_control_ops starfive_reset_ops = {
+	.assert		= starfive_reset_assert,
+	.deassert	= starfive_reset_deassert,
+	.reset		= starfive_reset_reset,
+	.status		= starfive_reset_status,
 };
 
-int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
-				   void __iomem *assert, void __iomem *status,
-				   const u32 *asserted, unsigned int nr_resets,
-				   struct module *owner)
+int reset_starfive_register(struct device *dev, struct device_node *of_node,
+			    void __iomem *assert, void __iomem *status,
+			    const u32 *asserted, unsigned int nr_resets,
+			    struct module *owner)
 {
-	struct jh71x0_reset *data;
+	struct starfive_reset *data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->rcdev.ops = &jh71x0_reset_ops;
+	data->rcdev.ops = &starfive_reset_ops;
 	data->rcdev.owner = owner;
 	data->rcdev.nr_resets = nr_resets;
 	data->rcdev.dev = dev;
@@ -131,4 +131,4 @@ int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_no
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
-EXPORT_SYMBOL_GPL(reset_starfive_jh71x0_register);
+EXPORT_SYMBOL_GPL(reset_starfive_register);
diff --git a/drivers/reset/starfive/reset-starfive-common.h b/drivers/reset/starfive/reset-starfive-common.h
index 266acc4b2caf..83461b22ee55 100644
--- a/drivers/reset/starfive/reset-starfive-common.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -6,9 +6,9 @@
 #ifndef __RESET_STARFIVE_COMMON_H
 #define __RESET_STARFIVE_COMMON_H
 
-int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
-				   void __iomem *assert, void __iomem *status,
-				   const u32 *asserted, unsigned int nr_resets,
-				   struct module *owner);
+int reset_starfive_register(struct device *dev, struct device_node *of_node,
+			    void __iomem *assert, void __iomem *status,
+			    const u32 *asserted, unsigned int nr_resets,
+			    struct module *owner);
 
 #endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
index 2952719fa31a..f904ef8a258b 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -50,7 +50,7 @@ static int __init jh7100_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	return reset_starfive_jh71x0_register(&pdev->dev, pdev->dev.of_node,
+	return reset_starfive_register(&pdev->dev, pdev->dev.of_node,
 					      base + JH7100_RESET_ASSERT0,
 					      base + JH7100_RESET_STATUS0,
 					      jh7100_reset_asserted,
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 87dba01491ae..c4dd21761e53 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -53,13 +53,13 @@ static int jh7110_reset_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
 	struct jh7110_reset_info *info = (struct jh7110_reset_info *)(id->driver_data);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
 	void __iomem *base = rdev->base;
 
 	if (!info || !base)
 		return -ENODEV;
 
-	return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
+	return reset_starfive_register(&adev->dev, adev->dev.parent->of_node,
 					      base + info->assert_offset,
 					      base + info->status_offset,
 					      NULL,
diff --git a/include/soc/starfive/reset-starfive-common.h b/include/soc/starfive/reset-starfive-common.h
index 56d8f413cf18..16df46a074bc 100644
--- a/include/soc/starfive/reset-starfive-common.h
+++ b/include/soc/starfive/reset-starfive-common.h
@@ -6,12 +6,12 @@
 #include <linux/compiler_types.h>
 #include <linux/container_of.h>
 
-struct jh71x0_reset_adev {
+struct starfive_reset_adev {
 	void __iomem *base;
 	struct auxiliary_device adev;
 };
 
-#define to_jh71x0_reset_adev(_adev) \
-	container_of((_adev), struct jh71x0_reset_adev, adev)
+#define to_starfive_reset_adev(_adev) \
+	container_of((_adev), struct starfive_reset_adev, adev)
 
 #endif
-- 
2.25.1

