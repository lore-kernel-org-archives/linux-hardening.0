Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8017578
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016432; cv=none; b=er6u9rGTOspMm3reRpGXwe4uELpk5QvC8oX0UocXizRGHLxJaSnnj0sIFmp0uPmgM36yzwCEROWcl/RAj3n1hPhDKv+OEZYazjnaBETgH+5FUmfesFfoFhh3+4SwvwgxBenWTLP9WQic4ZRLxSMCYbZpncrrSPFAWNIDBxO/nGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016432; c=relaxed/simple;
	bh=Euc26l7o3hHUJcm2Sr8GUaOIn3pH6iIRkcCbI+bFLLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z38pMLUpvyUJ/syelFnFtyGiWFzajCniIAYKJvMCW7sIEy2me9LjnV+RPpAkTPx7tv+8Pk139Ju4NEbo7j1K1O2Q/MCernFVIfN/dwCmHZhCCLLjuN9ofT1m2Ia1cvsgIXMoeJmRMADkP8XE6Fpr1PGgklHJ7rx2gs1OiT4laZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X3Mg310W0z1j8Px;
	Wed, 11 Sep 2024 08:59:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C032C1A0188;
	Wed, 11 Sep 2024 09:00:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 08/10] coccinelle: Add rules to find str_on_off() replacements
Date: Wed, 11 Sep 2024 09:09:25 +0800
Message-ID: <20240911010927.741343-9-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_on_off()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 64f04da2e9f4..34ff8f48965c 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -279,3 +279,22 @@ e << str_write_read_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_write_read(%s)" % e)
+
+@str_on_off depends on patch@
+expression E;
+@@
+-      ((E) ? "on" : "off")
++      str_on_off(E)
+
+@str_on_off_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "on" : "off")
+
+@script:python depends on report@
+p << str_on_off_r.P;
+e << str_on_off_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_on_off(%s)" % e)
-- 
2.34.1

