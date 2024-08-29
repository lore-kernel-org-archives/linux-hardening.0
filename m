Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E114189F58
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930218; cv=none; b=EiAeOcxGGjX8G3S10vLeKTjz+XpGUss357nPGaDJvZ00gl2XgwziXe1Y81GxnH66X1rNGrzh6j9DEKnjEI87u5ppfD7RyneXI21tEtxbQtHUt8yRHM2ORcedaB7Y032J/ui5nkL+giWsEhLpYqm7IUZOsMslhtFk8PhKwUxGN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930218; c=relaxed/simple;
	bh=3QqrD3rq+BwzYNVSJKe9mxLSM7CER/nh7p5DfOAoCgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXOais5D/J0JH/177DDM3dgqCcbblv0WII1dx+qH6Ri53jFzjIUGZdnC3J45Cqw0DmuZNjQh6ESp0Ez+Xj7M7uJTSiHO/atk/WFKfR7jp+go8Mpx+VOnVOd5MsO1wytxH+BvSM8mrBrNCj+jLCnEqAa4Nw2EXvbhj+hk+oigsdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WvdsH6D0ZzQr5c;
	Thu, 29 Aug 2024 19:12:03 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C6F3B1401E0;
	Thu, 29 Aug 2024 19:16:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 19:16:54 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next 2/2] coccinelle: Add rules to find str_false_true() replacements
Date: Thu, 29 Aug 2024 19:24:55 +0800
Message-ID: <20240829112455.232263-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829112455.232263-1-lihongbo22@huawei.com>
References: <20240829112455.232263-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

