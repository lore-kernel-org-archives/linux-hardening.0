Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5517C68
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016431; cv=none; b=KqTELEzmTeYMmW3OFfBX5C+ttMrWFTYLqtEN9vFqeCPl8FgXiCZE3xWtzO7n/UNKRVkd+C+sjCBwdEI4v+xd3UqsgtoAcLMP1ClIThxA0iaD8ozJBizaVq87r5q0ED1xpoBQQawWRuhdRQlldVAwc/tT3y0JFJiLtZCQpyjejRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016431; c=relaxed/simple;
	bh=NuCebnfpIy7oyqbYlwXAQXKfpGkbP98py1u8iyEwa4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eu3Anirt5PAKJBHcc0mR+pbeftqiN4lNgDFHCWnxfr9OvlS/1OtsvEWzco9+Byws9qCEekVpSI2/lmyfJJitgsVASlozD9/krRvZ0PG6yU6knLMDkyxXd6EUWIqW+oXW7HRFbdnY2pQJVLo7JkXy7ONZIy7KimE4Bp2tJAdyc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X3MdD6ZyLzpVfl;
	Wed, 11 Sep 2024 08:58:24 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 901391402C8;
	Wed, 11 Sep 2024 09:00:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 07/10] coccinelle: Add rules to find str_write_read() replacements
Date: Wed, 11 Sep 2024 09:09:24 +0800
Message-ID: <20240911010927.741343-8-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_write_read()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 29c507d86ffd..64f04da2e9f4 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -260,3 +260,22 @@ e << str_read_write_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_read_write(%s)" % e)
+
+@str_write_read depends on patch@
+expression E;
+@@
+-      ((E) ? "write" : "read")
++      str_write_read(E)
+
+@str_write_read_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "write" : "read")
+
+@script:python depends on report@
+p << str_write_read_r.P;
+e << str_write_read_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_write_read(%s)" % e)
-- 
2.34.1

