Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F67195FEA
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440792; cv=none; b=b+BkY659yo0Am62F+v63VE+a3jnNMofbvKA2pYyY1km3TKuGIJ7PdEF/3E9MqzA5yJirSFFO/OTQxfAa4xaBFn8/swR3iPJ4UdnbILjPWtJoEMUQaI1Eb3uyAgctOc216wIuThM23YiNXXsmncOkXCJGSM5lFnRB5KKvpoqr2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440792; c=relaxed/simple;
	bh=c0joXO4IQSsJhvGCrRBcVVfUJzc464YTU9KipWZOQBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtCRLfT+5BJ//USHdixwnBFkloMi3ArxsApn3s1cL5UT+P8wMTJ29slgVCaNbFdBAy6VY3v9kQKEAmBkiOfyK/Jx9dDosrEDptQex7y9O6HFJLx/6Y0qrwlwAj4jXF3VfJeM44bZwHcCA3zQVDgCGx4bok2bbR3QceT5Z1wRXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WzGnC6g1Rz1j6km;
	Wed,  4 Sep 2024 17:06:07 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 053A314011D;
	Wed,  4 Sep 2024 17:06:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 17:06:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next v2 5/9] coccinelle: Add rules to find str_enable{d}_disable{d}() replacements
Date: Wed, 4 Sep 2024 17:14:47 +0800
Message-ID: <20240904091451.3328272-6-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_enable{d}_
disable{d}() to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 46 +++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 53fd34a0fcb4..7400eafdf040 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -223,3 +223,49 @@ e << str_low_high_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_low_high(%s)" % e)
+
+@str_enable_disable depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "enable" : "disable")
++      str_enable_disable(E)
+)
+
+@str_enable_disable_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "enable" : "disable")
+)
+
+@script:python depends on report@
+p << str_enable_disable_r.P;
+e << str_enable_disable_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_enable_disable(%s)" % e)
+
+@str_enabled_disabled depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "enabled" : "disabled")
++      str_enabled_disabled(E)
+)
+
+@str_enabled_disabled_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "enabled" : "disabled")
+)
+
+@script:python depends on report@
+p << str_enabled_disabled_r.P;
+e << str_enabled_disabled_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_enabled_disabled(%s)" % e)
-- 
2.34.1

