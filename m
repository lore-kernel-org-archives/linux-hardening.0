Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8994E7814;
	Wed, 30 Sep 2026 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774318; cv=fail; b=Nloyh58zdTFxKFcZy2Md00Bo9uVI0fe+rGyMfUzB9VneydazCbpQQ1UhMWOyHh0bwCy1sSk+QZagFlcsFPED1MRJVoLmuDgGRntAvrPagb7vynVgU+ck8ieBlxdEqMLdjM50T/cMkKjk3BPa3N0jiWVNkn4L4g6BTqkCt5jjsIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774318; c=relaxed/simple;
	bh=I7MzSX1FfU2ebRx2/VqLl12PufdSO/falu+9lTwAurU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epKek3WkBbtOPpj1UkmCHr2kEtpISGriKIUfz5Z114Rjefs0XRY7EEs8eZxD36GC/Si76EADsX1BayKwom3yUWh/Vt/mfhW+CUVoZCv07fQDHBbnFRhya8NzWETeZnjgGFlJv2Sjhd7oZiLAuxq/G3Qpbf8F8CPmi4BSyoQPN8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8IFWUQgWbQkKGQ3x2iX/afQ431AYto5oBvFGVURjixufs7fR4MdErzxdrmTaCPG/H+vJtfFzcbBkqbyuE20UlTT2StFc6vcsHrneCn8JhokkUGLkUhxAP4lOv26LeYpHwOwqt3BG+696ExoHn/MNjmjhhzHZaSB5TzNTnCh315laFrnLEqnHAscPR72ots9nCS/FsTkt999+qCjD/Pk5qavdkHeg8b/aBcXvj88r2+eHqgdmcevMRlf3Qo+ji11OrvVKXVXrnC8QIwo3NlyzdY7sZAlhH5qBPOxtcbcecsrvsYyGSGjLWdXBWP3ReFnrK4qU+/YWQNgpbHoBHdIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctwYu//NWF9c+L4gnn+ugNwjZyRsf8K/CbyxauIZwgU=;
 b=g/cn3Yryuh9ROjb/5h2TCnwRow1u7p1tlAnXLkmQPVIVpThsniWnxDzaimZhya06DiTd8rlXvp1htE5ofdXUnNyvDeXbxPEnBJDALNGjo11Y3zuKucevf5/LCXTV4TuxtMHpayAmCazf95xMiQQAgkNldliOU0lwNE/X5X+sjno986BAcMXXomLb3UW2HJKf/LzDgpSl01lNEn+763SoUAmzGCiLSI06G59RqEp0x0oJsWdJXaCRtBeY61j9ejjMW33mkBbbKZNEydRtwYEjmErtxnI0TGpkBwjRsGwHg/ngLbY7GT96vsYd7r+lON2ro4UGL9B957saz07y2Affgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:55 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:55 +0000
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
Subject: [PATCH v5 13/23] clk: starfive: Expand the storage of clock parent index
Date: Wed, 30 Sep 2026 05:43:07 -0700
Message-Id: <20260930124317.5648-14-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: c0332bd8-dbd3-442e-58ab-08df1ef07d5f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZBTz1fRJWOuUOjlmRVbwOc0ANxl7VhxpzzcnWPo9/9hOE6I09bUxI9g3ggk1WHVcV2qlfLbima8m3Uomk9oG9BWqVcntTtoY85XQ9LZLcYDHcAL3LeaDmkEA5q0yUEDEFg76KRKuUyIKh00K34GXvai7+7qTynKHGNSCkFRIvE5kjSK9NFsxfCa4SB4ig1uYaSkPym7aNCSrbKHcx35HxGXOR4yZDdXcKbdubdwe9pCg+xro4tS0Ib0psJ9TxmfO671Onk+wwxPnoeynBMFOpG3h4Gsxh18gNC7IB/AXKR1iYq0+96gikl9C6U+WKq9JUfJZM0eVlG32Y72r7o2BCiauDGZEH9eZ+VP8ZH9xkUQcL5VqXxdnyAkCRa41hgQQSTbOlhr7C2CrWzgeqNGZ4OK8feL9zdRUXEbTx+nJ3KwY0z21gBxqpbx+QZ4mx+Q3TTrjRksiWra9tvtksbTbpY1Nu3//z32Gp+bsTA1+JetHOiLlqDhqxNzXeRNCa4OK3zgskYek74UiZ0J0FW3m9+czu7zbqCiURGnPV6cpV3DvgKkq9IzQdjohlhkWSC2Kd1i992CzCh/Kri+3c4y3cA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FPMgrE0PZ9IT9KZkV+tlEq2+5AorzsNJpaXkmVCflVCnaxygRFi1M02OWCX4?=
 =?us-ascii?Q?v71TTs6UwqNeB3m2Hy0wN6ucJRPBrtcE0JHnWrIyJ2ak+yfySzlYhL2f1bdt?=
 =?us-ascii?Q?swJtqdb0FoxnlOVgd5YX+eyDLoAZOQJxUqhZOMdJiKJ0yzlU8X9+mrwkfK6n?=
 =?us-ascii?Q?nrcNeYuzWBAg8ZAT15eKmpO8LawjTFpV0RZ9q7n/oV90dzq701AMHuCgGgst?=
 =?us-ascii?Q?b0XfmXPE5zE8SOKjjEebEdbAT1iUsD4DdNpMBZkFp1jtRearOKUP9Kvd52xt?=
 =?us-ascii?Q?eREspaQFdLO7N2OKo03/CO7Z4O2mCz8AEWryH76wWO0fmScWGtxjOHaVssM6?=
 =?us-ascii?Q?nAKgU/rr6cMxt1qrkRTjApATb0Z9SilcZBjEyaD6nDAp9i5B+vz/7BON1I+O?=
 =?us-ascii?Q?lLJBhXu40qxYVOl9D9J15wS2u3h31XtTq/aIsfCtWs7kgSYt/+zDDWpYp0ca?=
 =?us-ascii?Q?ojADTVlmjMVRshkNG6gVGsFnUYSKVlkE5fQQkAK4ashGN/Pkx4jSMVVnXKQH?=
 =?us-ascii?Q?dOLTdqxdPHOO4uEGwPunoADmD5BeopETzRdO5Q/F8JgE9KaG7iTT4xUDlwjb?=
 =?us-ascii?Q?83tz3ualOosnHb2TmCMrbomLuouEU8BIFLPjt31SDEZxqvJup9v+wvWiQ5Ok?=
 =?us-ascii?Q?Fmy97fGvv5EFNOgLzs4tmILevUWuvJybY59rqWIFByv5m2WV1pHfO3tK3GcM?=
 =?us-ascii?Q?jpuy50xhG/WstSEiDK4GUGYbX2RG6RhWAjH12yOQR/5vz1YDjdDVSOaLWKvU?=
 =?us-ascii?Q?9XI+tMh3ntvxJaoWBhhuhnmwmTvkLjsARcj2ZB2Xf0PM1/fS1StkbbPRSjz4?=
 =?us-ascii?Q?os1a6DNOgYIZbbJZIzfOBHQ66fx1EzDpuCek+i22EMl2XuQtS3uGwR7vv17g?=
 =?us-ascii?Q?4rTGOiarTHk+W2yN40jnpLXENKN4I9x+oiWFRB6L6ntAO4dvLizhXQCgbQ/O?=
 =?us-ascii?Q?5HLBmHl75Myz44n5xOst5mETTDuxIF7sYzrS22sn30tvy5IVYr6o8oA6sV/D?=
 =?us-ascii?Q?JFccwJYUXopbhM1on9Z9cLE3XtWTddlK0KuMRCC3Z4annfQS3HWPwdCWxXDL?=
 =?us-ascii?Q?out5nLvqE3DbYHdfWDjT/xhJMuJtMIX1sndI40VkTi+jh2Ez8SJoaEq26zsq?=
 =?us-ascii?Q?rWhdPpVY4ySJdT6OeT6NBzL2EOTwLgQRiYjKIRYCR80L2WDpF/qmSBwkJey2?=
 =?us-ascii?Q?aMZ7QXA79jxOOwMys+TYiyx1ctbcukGKD2dxBO90bw4GWVod3IybbqW+t0nv?=
 =?us-ascii?Q?JphdktJtKJGey4ooIxNgV1w+lkUPQcg0iRAH3bhm8ko5wWCsMo9rz19eAp2N?=
 =?us-ascii?Q?MSidyaJbyr3kHe1DY2XMk9zKp/r1HpjG8v6njRvAgHBry+pfTHA8Q4+txESv?=
 =?us-ascii?Q?JD76MtiJxJ05oxUsZMoBY/rERAUsS+Oj5XrZlIm+hqyvcwVW3OWAHWnUBZUf?=
 =?us-ascii?Q?0qIZ9sfT+xUTZ0UA5qX5zeu7S5SDBrLmUE0A5D5H8/AhOflcOUZEJ8vzifWL?=
 =?us-ascii?Q?uGNGExi09hoJ1d5vAvV16yeQ+6V5ZC6fzNl5sxcv3j2Kqop4W3OB6OUm9Eu7?=
 =?us-ascii?Q?LP4rThQ1aswUb9LyH0s4GmA7WzbVe3tGyORTaCDY/5rSIjqbG95Siq7NnAIv?=
 =?us-ascii?Q?v/x4lJ/5NSpng/4v6q5Nhn9AxAcDeUXQYMu3oHINTDlmd4on6hyFqKdoeqjp?=
 =?us-ascii?Q?ursY32m0RO4OoltAA8Cf8vYMonXSYw/TTMZr0DVIiDQAEPuLl7Gc1BpPFriG?=
 =?us-ascii?Q?cT2BGt2V0La9gOLtJxtBxrs3rqS9AjNYuOWxFQF7m0CK1gk0ZoQi?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0332bd8-dbd3-442e-58ab-08df1ef07d5f
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:55.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSbu0Arp+gkVzvU/IqbPo34TV/vsH6Zy1zyB6YEEooR8vIUd/f+TsRjDWDFtvmIp8PlsjZ4ozF7s/DRl03/wuubU4bAyqLILbAjc8jsoCK7MJhLx+jAhJLHxKayhl9Gf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

Expand the storage of clock parent index for per0 domain, which parent
index over 255. So change u8 to u16.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-jh71x0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
index 4cb3c2ef9525..198f6d005415 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
@@ -27,7 +27,7 @@ struct jh71x0_clk_data {
 	const char *name;
 	unsigned long flags;
 	u32 max;
-	u8 parents[4];
+	u16 parents[4];
 };
 
 #define JH71X0_GATE(_idx, _name, _flags, _parent)				\
-- 
2.25.1

