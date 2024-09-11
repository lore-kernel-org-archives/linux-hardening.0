Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBC15E97
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016431; cv=none; b=bDV+bp0HGgMYH4vtOMlYv6jtzVHDZTRznHhkGoGGE7O+/6eshXyT/c+vw7xcQjaOfE5rpkwM+j8UzolHh47HjaU7zw6RJIeBrxckXpu1kytTVRZg+E3bBJL26hF/GwvJg/Pitgj0bsnj36PG5o51uL+5+FpgXrjDNsIJoqz5u0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016431; c=relaxed/simple;
	bh=icfjwaa59iJXzHh1lW5ITzv5CyJArTejPAfKv5/BtHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F34Q1zdybBzzKRo2dv0CqIMXSqnp169gWkHtFNhZbcDw7A67J+P60ZYrj47d2LDqgBNKh05ZmB65GpV+Xe+XPAJlfErEn37iZVBHIzf4oDKXoufhurLzVPzAGZl+qcQ4CYu0jg1NtNyZhloPc2E+RMs3DeWPwrwAp+02+SbAt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X3MbS1g5hz1HJWW;
	Wed, 11 Sep 2024 08:56:52 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id EB32E1A0170;
	Wed, 11 Sep 2024 09:00:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:26 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 03/10] coccinelle: Add rules to find str_hi{gh}_lo{w}() replacements
Date: Wed, 11 Sep 2024 09:09:20 +0800
Message-ID: <20240911010927.741343-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911010927.741343-1-lihongbo22@huawei.com>
References: <20240911010927.741343-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

As other rules done, we add rules for str_hi{gh}_lo{w}()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 42 +++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index c3c5bc94fab0..7c631fd8abe2 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -123,3 +123,45 @@ e << str_false_true_r.E;
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
+-      ((E) ? "high" : "low")
++      str_high_low(E)
+
+@str_high_low_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "high" : "low")
+
+@script:python depends on report@
+p << str_high_low_r.P;
+e << str_high_low_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_high_low(%s)" % e)
-- 
2.34.1

