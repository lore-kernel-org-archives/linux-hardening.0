Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99A1A727F
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440797; cv=none; b=kFXbxbinTCze101VjHcKMg8MdkFmraecN2rcx/aQd8KaEG+O34NVIAGcnAaDLZ/eeKkhpqVquMT6RKTBh+egYy26EKX4SJab4sXriVSBd9TaFMWRGUYh5sJHXB3gLmFM4IqEj4ZtOMBYvSvOmdP8SrYtyqm1SNtyze5aEg4QlCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440797; c=relaxed/simple;
	bh=jc/6avPNtWWIdeO5+r/j5FjmPpxKjBbm497J2ACaN/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZE+4qqP4nPdeSgStK4YcZEbMYfhbW2wuD42oDkgmcey1jkU4AM5FND9cDFd80tgjcsqEYAc/pXVLoB3RDeZ1LLLT1IVXE1LlSUy3RmY9UjoXrFDxA59WJuRJxjnHrSow9Ovz89MKV+mVqiD3qAOeEGyu2KarjO+XuHOynWwVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WzGlR6Sz2zpVFH;
	Wed,  4 Sep 2024 17:04:35 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 72785140137;
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
Subject: [PATCH -next v2 8/9] coccinelle: Add rules to find str_on_off() replacements
Date: Wed, 4 Sep 2024 17:14:50 +0800
Message-ID: <20240904091451.3328272-9-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_on_off()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 3ef7309164f4..bb09076e5f58 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -315,3 +315,26 @@ e << str_write_read_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_write_read(%s)" % e)
+
+@str_on_off depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "on" : "off")
++      str_on_off(E)
+)
+
+@str_on_off_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "on" : "off")
+)
+
+@script:python depends on report@
+p << str_on_off_r.P;
+e << str_on_off_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_on_off(%s)" % e)
-- 
2.34.1

