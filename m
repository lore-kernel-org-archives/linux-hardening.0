Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868719D09A
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440793; cv=none; b=pNBIfsASZBD4jFl9N81H+JfGMf2c6TYOKRRS9jNPqLKE7LwtSY7+Z4n2+7ORFY35/aVVZKz6uFYY3oedvNvuFcygSn8j4vBuKHWih8+jMHenQowidpIcZ0lYgP50MhqkVHujScml6xXPu9ju5P3YQHYT2+WfxbZmuzPvp0BL1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440793; c=relaxed/simple;
	bh=3QqrD3rq+BwzYNVSJKe9mxLSM7CER/nh7p5DfOAoCgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLHuAxtYsveYvJ77teijYZ08fS19ELwizojl4vG+d1UaC9UqP4TDN2eglIqe75wnhU8Zrmc9WoMHsrKDYiaFOjniMlL7OoDhO3zDL2EMUp2SzcT79NvGXdG4oftscR8LiT3uoeTb4GkdwWNVBj+yRbKFqjkb/9NBKxzkh3683u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WzGnC22wPz2DbfW;
	Wed,  4 Sep 2024 17:06:07 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 877021402CC;
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
Subject: [PATCH -next v2 2/9] coccinelle: Add rules to find str_false_true() replacements
Date: Wed, 4 Sep 2024 17:14:44 +0800
Message-ID: <20240904091451.3328272-3-lihongbo22@huawei.com>
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

As done with str_true_false(), add checks for str_false_true()
opportunities. A simple test can find over 9 cases currently
exist in the tree.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 50329c4c8acd..a1141bd29b3c 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -108,3 +108,26 @@ e << str_true_false_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
+
+@str_false_true depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "false" : "true")
++      str_false_true(E)
+)
+
+@str_false_true_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "false" : "true")
+)
+
+@script:python depends on report@
+p << str_false_true_r.P;
+e << str_false_true_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_false_true(%s)" % e)
-- 
2.34.1

