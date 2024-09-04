Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70C1AAE33
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440797; cv=none; b=GEfpeQjBkAzhwJnHvxpamTco/zB8VYu3+LlDEf+8jCxA0QWR33NzxTRbfz9Xnu++2WcKunx1LjvQyXEVhe2KHH57ozpZNdEqYN8HGwrjI2JOXbkQq2J0Zx/RrFBfSY3FWL6cSs+zddFJajJ3cqEsM+vRTsnf3ydo243N2cVwra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440797; c=relaxed/simple;
	bh=uexWtHFG931q4BLZbSK12Y9wi05Rqz6P+BoAE1n63p8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olbHgV3QKPL4p3O+Y3DMO/ItNh1ytyOVDk7GemzFgJFiK5jf9rZBQol/qJGVR5/lrK11d24jZCyN3PLVZLNx84VHmDKAEpfSmNjImZR5OIpdM+okmcws+pFLWFZvAUaBw1FN4jglff1BCByKcMI/Ion3jys00paCUbb4aypDj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WzGl90k2ZzgYw8;
	Wed,  4 Sep 2024 17:04:21 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DD16180105;
	Wed,  4 Sep 2024 17:06:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 17:06:28 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next v2 7/9] coccinelle: Add rules to find str_write_read() replacements
Date: Wed, 4 Sep 2024 17:14:49 +0800
Message-ID: <20240904091451.3328272-8-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_write_read()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index f9ee0352cc3b..3ef7309164f4 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -292,3 +292,26 @@ e << str_read_write_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_read_write(%s)" % e)
+
+@str_write_read depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "write" : "read")
++      str_write_read(E)
+)
+
+@str_write_read_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "write" : "read")
+)
+
+@script:python depends on report@
+p << str_write_read_r.P;
+e << str_write_read_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_write_read(%s)" % e)
-- 
2.34.1

