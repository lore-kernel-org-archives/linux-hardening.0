Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCD54763;
	Tue, 28 Jul 2026 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239496; cv=fail; b=T7W2mEaQD/pzjlThzZIcI2scQ/4y9vaf68te9bIqlOcRRiIfVVS3gOj9Cg1oEw7GDBNyOH/E++JOuzPQAccJg8P6R3lJ3oHtGoqyrzPj/B/Y8rYi1FzvFf33gzilH2opGXJvwuyCliekWPheob+5GMkiWfGHISW/1l++k3/j0Ck=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239496; c=relaxed/simple;
	bh=+J5pr5D/gB8e7xqFOcsHgzTUq/tiN78AytMKin9jjs8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AUEllMP8xzz1FLrxZsp6Biif6DeACp0GIpS93nhFy1E4QjxuRhP//LySkS0p8OyQ3wbhHenElLprqQ8rF+SonM37ieF8pXALIWkJv6nVXccnz8ngeDqPMe1FKCTcNU7X/2i2qJLXYpAVxHmT43FwhdSlS0WRU5LS+SpyeNee6rw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lxVArCdv; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lxVArCdv; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lxVArCdv";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lxVArCdv"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mlyBkPGxZn/Ol6QypkQoK6udpQDkgBDpvEYpG3btkcMV7tGVBHIUpuXN+HhlIqtEubWd37hCO6ksmerTI5aDqO4V7fKYKy2Uy28vSscVBvlcStxzTf9EX6rxGOtAobL5aDW5CjQUzL+MPH6Y4XXoPvELDEfGAqvPBRGcs9gXJiSkRJ3f+nM5MpANl6VUQxLZ5kF4B6gkIzdhoGPTde1ZuZPhwEdUhSufr9dEcWIaMpqpZTOn2/eYiKKLNwL0gQKt2KFO8rpF8PirNAY2VrtYqEKeIzwLz5PCA9gDSlxtholq9Hy/y58MJaJmI+5nwbu7JUUNe1tlTEptAMIqclbWRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6G+5Lx5N4ro17zJLu4K+GgTQOO/otpFyeuGP5aHyyg=;
 b=J+hxAuazz2kvvwQjsLge/uCfvrkKYmMeNwhAzLAJG8HKDq1M5C9V0mjogM8V8BL8aDzAf2AzhNEWCouziSfTckCJhHna+aBjl6lOPiXlSfOflhP+dcFTDKELNVqI//KNwdtNFbGUbT1/oqol5FeJ1i5RKdAqzQ/50DsKg1RxH5/9wH5/y/MXEopjg2i4EiFrfifGxPxSBEjMefX4ClRSN84gYs4UMhyVrwjOI6l1xP1Z8a0PJfXkF0ZwG6YGzJKDuQQP5NVdOdv02tK2GbdcPG2dpdjZptTTwWDtSAzmt1ndB6YvTWFsS1tj1cPqOJJkmwCHFeAm0TEEd+HmcIhKRg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6G+5Lx5N4ro17zJLu4K+GgTQOO/otpFyeuGP5aHyyg=;
 b=lxVArCdvMyJsa7eXECx9FIQf+UGDrBEuPt9gSQvA54CkNHZDOj44M2KRXzNUYRyqIFJR8kgD40QV7miNrFPnugnG0t5Nvpy0NuIrgup2XsZdJCknhbVatepjFh6l3ST6XshrTBGnaqUW/dwLpRdfuts0Y1xXVReTItK29R5t+wI=
Received: from DB8PR04CA0016.eurprd04.prod.outlook.com (2603:10a6:10:110::26)
 by MI3PR08MB12007.eurprd08.prod.outlook.com (2603:10a6:290:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:51:29 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::3a) by DB8PR04CA0016.outlook.office365.com
 (2603:10a6:10:110::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 11:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via
 Frontend Transport; Tue, 28 Jul 2026 11:51:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUX3bcIj8zVG9Z5obgtbh7BlolBXjl7oA9LeRB/ktlse9yD/lemxJmkKZJjwAJ/GUjmtmGndplge/2pjmMCW6xRMBM6GP6MVdgXv12vaChmbYMnwUB+zyUQ5xI/LDT3nYx3vd72wLTfWIS3kpvsyySv6T6DeKXa8iukWQ2axhbK6wMJP7juEtRl1biiuXHOyjaP0FQFPCd6DAsc8pRedBRseIGOj5QFBmmRInIVQylIVQPAJz/e7nCglC73gH/nr2NLGK5gcAZoO8JXxGMZMUAw5I744NtYCzLk8iKF7hQE2JKFXHu5EqdAFMjvkw19j/aQPFRRb+FHn+baHO7bzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6G+5Lx5N4ro17zJLu4K+GgTQOO/otpFyeuGP5aHyyg=;
 b=bxJmZXhEFErNailSO0xRcNGr8XWgbsHB0t3VJWVdSqCDdTgxU65G4H0KUaa5kpS09VuqN+e97lX+gVpMFWl2zNnu9F6dRF4nuOvB4UeCvIXOvCp6UPrNJ9X04GFyRVPBjWCTbfrUAGVm7mWvVejVtmtpsba66vRaJqTuxSAaZgsQyHYLq6ucdbAWd1WdoIOgQEziY7UXRqy5FziatPzlDq4LkTP76HTeuj1UgHCAcVgpwmBjzDiwVjwsknxYqSIW/wIO2OP6SDXQxDBZHC+74xGg5v2+OAbYhRbsOs6GT5foYXFuzWZsylFqcGJIT8rGI/9X1GbTkTFo0aTmOFWaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6G+5Lx5N4ro17zJLu4K+GgTQOO/otpFyeuGP5aHyyg=;
 b=lxVArCdvMyJsa7eXECx9FIQf+UGDrBEuPt9gSQvA54CkNHZDOj44M2KRXzNUYRyqIFJR8kgD40QV7miNrFPnugnG0t5Nvpy0NuIrgup2XsZdJCknhbVatepjFh6l3ST6XshrTBGnaqUW/dwLpRdfuts0Y1xXVReTItK29R5t+wI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by DBBPR08MB6010.eurprd08.prod.outlook.com
 (2603:10a6:10:20a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 11:50:26 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:50:26 +0000
From: Bence Csokas <bence.csokas@arm.com>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bence Csokas <bence.csokas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] overflow: Support sub-union members in struct_size()
Date: Tue, 28 Jul 2026 13:49:13 +0200
Message-ID: <20260728114912.122417-3-bence.csokas@arm.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::11) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10455:EE_|DBBPR08MB6010:EE_|DU6PEPF0000A7DF:EE_|MI3PR08MB12007:EE_
X-MS-Office365-Filtering-Correlation-Id: 6898af94-ca24-444b-ce4b-08deec9e8f83
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 /djc7L0Wp8HAOJUQLQGOjFtEMKZtK1bmw/14Q9YnYqVWFfhMeJ5iRA/DifJYGtmpIJWMWqGAhomN5LsFT36YNUfA8NuP+VttgKYDG/j77n5GRh7TArhXXawU1bUTakZoOUM3Be8sCeIdEev2U5zmPkTFSHaVs/7DJWQyJZDw79gmeXUMkDFrHCcwI5Td4s0Ftom6L6HF0acs3dE53fTWBm+ECMSnAETo4NOB+Rko1RETIi47H/YektOCOVvL8/JP6XXXBfBKvg9z65CrKQxEocTuYUTLWSbcBTLAFlaYXWO8hdSSD6c1RVt8iQPn/FBdO6VOESX+AdSYgy6jOjeBPGq/2/DNLBYJucGDsWwwLCAdvR9Lj5OEoOBBncTKCtM7qoTHa1a8ZRJCKb8kwmNo+ckvXN5Eiuo77mJpSF2utDYWKX9urYBHkyn1WWM0H726sOnQa9bonQDKT3q1UECY/myRbHUkvNDWVLMScFLuwLNrhW0PxgRRYUm0LsU5V9aWdWeLWkofPXn+rDw7B7C37wRt7jIRfUekllPC++yQZ9/fbd2rvZlrKquqor0/4NFc0b3EOC1j8AdHt2ZoBvV/OXsrPoC+V2W3jw1hid3R4mlzl2KRz58P8znMm+CEhvMLtQ23pGFup9SsRNo4SymdkIEODfCDCTR+vzC7u4lxSTI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10455.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 TSQvcInXruwWee7BVvUT2SPoLJ0TZrZ/jVFhFsGkuwi4VQ8JZoXVRL1H/P22lpjgQ5c1qNMdaYJnGVVZKbzA5yUAtDgQWQ7oht0RWZmsD4HKBsLSLRyzTwUEpJSDscxnhCqkL9ohpWqKeB9p0q/0vKj58SFLcyEsYQHxvJsKgfAsu9v06y7A65YLBUrHhWRhu2V94yRSbkZC6E5wOLpf0ifio38t9usSeSJ3+KWth/dDbLCctNHCBBLo8Gg078XgYb3QQShFLOdJW8kn4385/8e/fttkxMQ1Yi6xJ8NxaQypH8NJmb5EDdW7Fh0KJqgREGA7gvxH13QYoanWoBPB5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6010
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a412c364-02d5-4bd4-b061-08deec9e6a2e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|35042699022|36860700016|14060799003|376014|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gfYn1fXFcNRZiZMtD7CTp78YWNpregwQ2g7FV3zvqwPIi/gS9Pgjy5JatOwlIX0XQJSeIQowdVnKXJlvMariSQFyEe127mPknxE/e0SZoF+olG8r/66UIB4iBH5z70OcbtniefYLSmuRZfjgsk+4nqGL/8Saqo1K13BDrtc6fm1w7LocETdy23q35tH/iP+qMehOwP8uSlbEL2SNGZEru+JMPGCUrt2laksSkLgTKdqOG92uL4PwuSwEeHzeTGvvq1RKlxMilN3hsXV6pE7IUs6u0tADauJxWeJCw80lGt70iCImB+4ROPrw7P+tqxoDj2CXhXSuZsU9JVmXri2m7VLW/xKnk4bXUuuJrCDSs/Xe2EJnFxks7+HqYQqnE4ND63x35bG4yDacOy8EoJNJa5llGisVcsSdmGhJTQiNrErDkLNrf1lsUmHFnE7Mp3V/qELHMXIXBygGi4rUfdaf98FeSq39qc8DwgbYSQnU6+wfjbX6i6/mgY7n5WFr36X+npxQtFgJhB+og/H/Cq77YM721sbdNJb+lvVeFaRAvRn4gXT326Z8/pjMLQXXRDeV1YCKuzIzo3suPCwf5VEkiCVZmnQlE5w5zc+DDpH67hOLOkd9mJvDzCzMXXWnWBG9B2rdRKFaTChW7+W4bB3GhJZEy4r767SN9QT7VGqc7Fuw4eaYsVcnj+UqokPX2SfimkZOuO/5sKNGT3nLAdU0HA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(35042699022)(36860700016)(14060799003)(376014)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8J0Y0cC2RIk2TZ4A8pRP2VWV8NvdK6tB95Sm6ynxIZWkr2j2xrNcp68/T4vKhDcalNCTZjOiMXVo7CoUMOJyJ5YNM1D8FbjeSaZ2KJWACEP1n5BOZHyfHxiROQTdau+xNYlpxluwhsTFSovilvl828fk3Cf3HTTM3ipNa4lAalQzVIee6xMW1T24wWZHcVYRcNTA7gjO/OnPme5iSf3bzE9Hq2tkRsvHv3gW2SwrEPAKW2xyBpk1d4USLxV86nabId80O6vff2AU2ODkQQt2tmYCLBXPWDeUpMsHz6dKo8zZcV0AwdB5grTLh47T5LRz+f76pq1L2S4E00DUzIBAWa1GZe+ITZiTFttNB5fv2ytGpDWjEkRcyI5eC1grCg6HRJh3xOMOrdd3skKiIUX1OEf0dojK9fmXWNDnuY8NnFOcmiC40V0FlNjI5MydvEBV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:51:28.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6898af94-ca24-444b-ce4b-08deec9e8f83
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR08MB12007

Original definition of struct_size() assumed that the total size of an
object with a flex-array member can be calculated simply by adding the
flex-array size to what sizeof() returns. This is however not the case
if the struct has a union inside it, and `member` refers to a field
inside that sub-union:

  struct my_inner {
    int a;
    char b[];
  };

  struct my_outer {
    char c;
    union {
      struct my_inner inner;
      long l;
    };
  };

  /* This will give the wrong result */
  struct_size_t(struct my_outer, inner.b, n_elems);

Replacing sizeof() by the offsetof() of the member fixes this.

Existing users specifying non-union members should not be affected.

Cc: Mark Rutland <mark.rutland@arm.com>

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 include/linux/overflow.h | 4 ++--
 include/linux/stddef.h   | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index a8cb6319b4fb..a11c1135f617 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -433,8 +433,8 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
  */
 #define struct_size(p, member, count)					\
 	__builtin_choose_expr(__is_constexpr(count),			\
-		sizeof(*(p)) + flex_array_size(p, member, count),	\
-		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
+		offsetofp((p), member) + flex_array_size(p, member, count),	\
+		size_add(offsetofp((p), member), flex_array_size(p, member, count)))
 
 /**
  * struct_size_t() - Calculate size of structure with trailing flexible array
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index e1851c50c89b..b8f0dbd2de55 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -32,6 +32,14 @@ enum {
 #define offsetofend(TYPE, MEMBER) \
 	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
 
+/**
+ * offsetofp() - Get the offset of a struct field from a pointer to the struct
+ *
+ * @P: Pointer to the structure
+ * @MEMBER: The member within the structure to get the end offset of
+ */
+#define offsetofp(P, MEMBER) offsetof(typeof(*(P)), MEMBER)
+
 /**
  * struct_group() - Wrap a set of declarations in a mirrored struct
  *

base-commit: 62cc90241548d5570ee68e01aaba6506964e9811
-- 
2.54.0

