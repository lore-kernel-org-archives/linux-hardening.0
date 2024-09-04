Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94B19E978
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440797; cv=none; b=jRTVZW+07uaGlzQe3ffD0n4QpEEnP2xgBukHiYH0rxMiipnFUv240T/lQ6IgYPoiqXZ2tQZnvzRJHmqojE7ED+HcrMtmEdgAO5mfh+hYxkx5Y6DEL/ljWnb14EzyZI5Yfv411UHJnR9RdA4M7xolRBqDoGpQa1yBY7af4CcF8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440797; c=relaxed/simple;
	bh=2E1mpyUBjQ3uIGIXWboa+zbLWW2ynCUtsxDkG2lJnAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSvulhIx8EpvoJ67Ay2mJJl6JQfca4ECVg6PvvNVFf9YmYOfpwc4/DmKUcJ/VNHq/FP4A1ZzEprbR+nGIz5F6U7KgkzgYFyRxgb/LEthVVM3WWA8eiK9+9Z+Jf8MVh02MsC1yBGtxxY9lx4OzSu6IlHtMOzPaQpJs1O5r0ZaIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WzGlQ651zzpVDr;
	Wed,  4 Sep 2024 17:04:34 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 63F0C1800B8;
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
Subject: [PATCH -next v2 1/9] coccinelle: Add rules to find str_true_false() replacements
Date: Wed, 4 Sep 2024 17:14:43 +0800
Message-ID: <20240904091451.3328272-2-lihongbo22@huawei.com>
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

After str_true_false() has been introduced in the tree,
we can add rules for finding places where str_true_false()
can be used. A simple test can find over 10 locations.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 5e729f187f22..50329c4c8acd 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -85,3 +85,26 @@ e << str_down_up_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
+
+@str_true_false depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "true" : "false")
++      str_true_false(E)
+)
+
+@str_true_false_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "true" : "false")
+)
+
+@script:python depends on report@
+p << str_true_false_r.P;
+e << str_true_false_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
-- 
2.34.1

