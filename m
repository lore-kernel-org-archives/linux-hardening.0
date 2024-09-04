Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9319AD56
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440792; cv=none; b=UY+YIzQzAa0xsp3Hka7pOf43biS0Orq4h2082BDBkoW/ilrmRXnJxpysr5fA0OCPFhcqaiGF7VLbsx5OofYahv6SNOXAEh9LTKAygh/8URtdlm2uadU3MObMYmuL10T4Vy4idxUtlL0z+T1dNanDKEi19dl68GoTHuHJ3JJNq9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440792; c=relaxed/simple;
	bh=fVA4X7cFT3m7GzoI5QwZDoNZJpB3g0fRWQ39lp8KD8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1ltqh1ZpbQYKFIoZpa5RPQjhsKEPVNlM5VH5mY+CvbuX9T2C/HoTnwfSweUhf8stgmJYFiZ6gSN34hXkFDes2CUi4kwzEduWXxXRTrIxidN6862QkGz48TcI/zRAGCPfufmiVcVLSCYTBjWshWaJokN5n11UG1u7TMNWsmVwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WzGgv11j6z20nMt;
	Wed,  4 Sep 2024 17:01:31 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2733F1402CC;
	Wed,  4 Sep 2024 17:06:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 17:06:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next v2 6/9] coccinelle: Add rules to find str_read_write() replacements
Date: Wed, 4 Sep 2024 17:14:48 +0800
Message-ID: <20240904091451.3328272-7-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_read_write()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 7400eafdf040..f9ee0352cc3b 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -269,3 +269,26 @@ e << str_enabled_disabled_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_enabled_disabled(%s)" % e)
+
+@str_read_write depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "read" : "write")
++      str_read_write(E)
+)
+
+@str_read_write_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "read" : "write")
+)
+
+@script:python depends on report@
+p << str_read_write_r.P;
+e << str_read_write_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_read_write(%s)" % e)
-- 
2.34.1

