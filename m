Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D5179BD
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016431; cv=none; b=N9TYMN1KIuiyvfTM8YeojGoKcsCJF0QIfRmBP/7Cc7dx2et7yKlMEy5bca+kVrRbatgh3Qdki2JPPqKl7oxYKFVM5zQFYx77mUW8xfFzNNy8hbD7IGUs/OfhA1wiD52n6LFdWRQmM9d6xwx3givhOO3zaYdwmUJ0EXKyJjjO+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016431; c=relaxed/simple;
	bh=ppKSjzLu4SWohLqyVTlCMnOvb6pLIC0AwZu0KgiLk8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElTbeoFyZaBOcHhkGutjGjyQia/dcTahuDcvdus2y0djXgqDDhJIvgbaj7PGQQID6Bv3P5MYbAu+KXvAX+A3A+zFf4zijqIYtQGaI0D2iI9AGpAE8gzgDR4IKYnI+dz9TTCi9SNT/pF7GOWL2eFAb/p0YJn7GPN1p6yd8/qAu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X3Mg1757Tz1SB6w;
	Wed, 11 Sep 2024 08:59:57 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 640111400DA;
	Wed, 11 Sep 2024 09:00:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 06/10] coccinelle: Add rules to find str_read_write() replacements
Date: Wed, 11 Sep 2024 09:09:23 +0800
Message-ID: <20240911010927.741343-7-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_read_write()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index bb6b851ee2aa..29c507d86ffd 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -241,3 +241,22 @@ e << str_enabled_disabled_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_enabled_disabled(%s)" % e)
+
+@str_read_write depends on patch@
+expression E;
+@@
+-      ((E) ? "read" : "write")
++      str_read_write(E)
+
+@str_read_write_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "read" : "write")
+
+@script:python depends on report@
+p << str_read_write_r.P;
+e << str_read_write_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_read_write(%s)" % e)
-- 
2.34.1

