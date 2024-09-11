Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB41F9CF
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016431; cv=none; b=R+XQ5r55gnzKnEtR8eO6RY/sVwCxiBYo0vgcnLOLM6FheH0EkBmDI9cbEhVqoLKOiEWo2RjCiDUprHVSwuUH2OV2Bk0l+Cc+n2roCuhygRa3KDjddaTbJiHSCPYcqthq7R4ioIADtNxdqcCubKm92Ej8/0XgipWc1+7Xnb6fY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016431; c=relaxed/simple;
	bh=mmCt9+ZYij911ZP0+PUfxaGGDaXB3UkSsAwMD0cUzhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXHZlnmW+02CC6Vq/iWAuWGAEOtL4weI7T/uKxxn9ymKo1l1zXxBry0cESp2wO4VZvMclAszNgP613/MyqghrfqHumXQaOBzo8NhgRAcf/N3Zn+fXQ5V6VLP9iB192PAIQcWRRriXT+mbFncjt6Un319d6YPqaM54HGHABekYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X3Mfj3fLvzyR8t;
	Wed, 11 Sep 2024 08:59:41 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C88EF1402E2;
	Wed, 11 Sep 2024 09:00:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:26 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 02/10] coccinelle: Add rules to find str_false_true() replacements
Date: Wed, 11 Sep 2024 09:09:19 +0800
Message-ID: <20240911010927.741343-3-lihongbo22@huawei.com>
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

As done with str_true_false(), add checks for str_false_true()
opportunities. A simple test can find over 9 cases currently
exist in the tree.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 6942ad7c4224..c3c5bc94fab0 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -104,3 +104,22 @@ e << str_true_false_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
+
+@str_false_true depends on patch@
+expression E;
+@@
+-      ((E) ? "false" : "true")
++      str_false_true(E)
+
+@str_false_true_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "false" : "true")
+
+@script:python depends on report@
+p << str_false_true_r.P;
+e << str_false_true_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_false_true(%s)" % e)
-- 
2.34.1

