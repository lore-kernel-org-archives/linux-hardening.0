Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07947198E7F
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440791; cv=none; b=DAcS1EHNSajd4cm6gAWPj60DL3nfXzYnnIiyEC68rxs5iXE+ouIVduStc7k5vPu5uCKGimjuH8CHUoJz/jxc0rLPi4clXi/VekJy5v7fXGQ2Hf0iwhQB6UFNvvSyHlkz5x4BFpRzptNvOfSMxIXbm18XQ1jXS1F4Lkgqbu9c9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440791; c=relaxed/simple;
	bh=Q1rHAD2z4v1f75mfg2BtbNE9kcDKvP3+crmva8tW2Z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzfbpCszzPMMzZ+hPiL3ytMx4sahwPj49vZibL8M++mvdugHw0uKngsl+96lxWUn1GXp7JVC/IjSRwIx6zelQBkw+bnpjTj7QB64Kn1znCrpao7Fk8/hwtzia1IQhAG8yoIq46EYrgZzeqZY9kWfTLDAUx7ms4aw7pmHYe7ugsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WzGjc3Bsqz1HJ8Y;
	Wed,  4 Sep 2024 17:03:00 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D49061A0188;
	Wed,  4 Sep 2024 17:06:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 17:06:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next v2 4/9] coccinelle: Add rules to find str_lo{w}_hi{gh}() replacements
Date: Wed, 4 Sep 2024 17:14:46 +0800
Message-ID: <20240904091451.3328272-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904091451.3328272-1-lihongbo22@huawei.com>
References: <20240904091451.3328272-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

As other rules done, we add rules for str_lo{w}_hi{gh}()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 46 +++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 67818cd6ee09..53fd34a0fcb4 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -177,3 +177,49 @@ e << str_high_low_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_high_low(%s)" % e)
+
+@str_lo_hi depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "lo" : "hi")
++      str_lo_hi(E)
+)
+
+@str_lo_hi_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "lo" : "hi")
+)
+
+@script:python depends on report@
+p << str_lo_hi_r.P;
+e << str_lo_hi_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_lo_hi(%s)" % e)
+
+@str_low_high depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "low" : "high")
++      str_low_high(E)
+)
+
+@str_low_high_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "low" : "high")
+)
+
+@script:python depends on report@
+p << str_low_high_r.P;
+e << str_low_high_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_low_high(%s)" % e)
-- 
2.34.1

