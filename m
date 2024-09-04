Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B719D09A
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440798; cv=none; b=s6GRjlvTOQIjE6j7z0NEGWEFTIolUjCphmEMX4dAq5DHH5zDYcl5bMBUZqQT8edkqQ8oMEctQRygo2tajbRmLFEqj2buG5vQ89FWxksyND3QaYjxgs16FwtvGMJHHt9bQM3IKjLZa1a+tXNrvCOykZTo2a2WbGZ2pupCwjTjMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440798; c=relaxed/simple;
	bh=gfUNmLspY9syJXQ6mKQ6GhmGRc6uN93t2aDLD9fu7Nk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+20Zf4k/ogfs3aQSujapCUwGYx+pK/j6bNVE51wOdKNBLtgGWQLNGkdl4BQf3yh/6htoisaD5c7NncqrPTF8ZztyNk7/YpbY0BKcrII0GVm9K24ONr3BcB1eSFMGw0PPE8GFcq/RS1bLzu3PBG+MlCbwiWxDotQGj4zwcSosl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WzGlR11RyzpVDw;
	Wed,  4 Sep 2024 17:04:35 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AF1061800B8;
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
Subject: [PATCH -next v2 3/9] coccinelle: Add rules to find str_hi{gh}_lo{w}() replacements
Date: Wed, 4 Sep 2024 17:14:45 +0800
Message-ID: <20240904091451.3328272-4-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_hi{gh}_lo{w}()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 46 +++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index a1141bd29b3c..67818cd6ee09 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -131,3 +131,49 @@ e << str_false_true_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_false_true(%s)" % e)
+
+@str_hi_lo depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "hi" : "lo")
++      str_hi_lo(E)
+)
+
+@str_hi_lo_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "hi" : "lo")
+)
+
+@script:python depends on report@
+p << str_hi_lo_r.P;
+e << str_hi_lo_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_hi_lo(%s)" % e)
+
+@str_high_low depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "high" : "low")
++      str_high_low(E)
+)
+
+@str_high_low_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "high" : "low")
+)
+
+@script:python depends on report@
+p << str_high_low_r.P;
+e << str_high_low_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_high_low(%s)" % e)
-- 
2.34.1

