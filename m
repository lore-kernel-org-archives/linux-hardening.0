Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C317BA6
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016431; cv=none; b=qcC5yWTk5L+ltxNEU7J6zdJULMLxlJw9kIrqcowJ5t8UzMo40dNEJ5vSv6qkBMRjExrW1z2rs7A1qJIQ+kAq50NSu2+vvi4Og3RDb6sbIXaKv0ee8XwjLfNkxOEZUIVXf/+ygqNhxlx743aGllKurOlA7Hcf87nNygQ4yzw3wDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016431; c=relaxed/simple;
	bh=p3mFuEVsY01EyxDgtnZ/qI4ULqMDBSyOku0Jm/zQSxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhbNNMwgtyV/AvWTTVwKh9M1Kl2EAuzjWEjhNlS5g6M8Vxcb32Gy+pHTJKVmsFNA2LOjVbB28rW5+U6aewzSbT6x7Yek3bckrHTsIoOPo0OXistAJUR+eXhEiMMHd7YcMlycoEGiJ6jED3xBb2vIgMFMhWOLisqEf5C2TGCAlwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X3Md468cZzfbvb;
	Wed, 11 Sep 2024 08:58:16 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CA4E1400E3;
	Wed, 11 Sep 2024 09:00:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 05/10] coccinelle: Add rules to find str_enable{d}_disable{d}() replacements
Date: Wed, 11 Sep 2024 09:09:22 +0800
Message-ID: <20240911010927.741343-6-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_enable{d}_
disable{d}() to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index e91d4eb30161..bb6b851ee2aa 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -203,3 +203,41 @@ e << str_low_high_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_low_high(%s)" % e)
+
+@str_enable_disable depends on patch@
+expression E;
+@@
+-      ((E) ? "enable" : "disable")
++      str_enable_disable(E)
+
+@str_enable_disable_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "enable" : "disable")
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
+-      ((E) ? "enabled" : "disabled")
++      str_enabled_disabled(E)
+
+@str_enabled_disabled_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "enabled" : "disabled")
+
+@script:python depends on report@
+p << str_enabled_disabled_r.P;
+e << str_enabled_disabled_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_enabled_disabled(%s)" % e)
-- 
2.34.1

