Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABD1E87B
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016434; cv=none; b=MHKDR5HjqBdyf5om2Vi1oih6MBq8r7WcgnX5zdUrhdy/Q6eXVHAaRsGMrOL/0Q8MkbyiQV7aI0x0QjE30DMZ5YNA3IUmUFHSme5T44ZIO2X/3LPuGLTHOjAiEY+rCPmiyHRJ4tljeFPGhA1t/+hljGMiCRCYI8FBg88VEJknxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016434; c=relaxed/simple;
	bh=Kd4lXIy2RL2T4a29XOujUS5ATR3zbBxoVXTXVRfSiZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDzTiNlqrj46FI5zOPcPS9zBLIfWNrknZs7S5aAetKFZLAE64DwfGefl0uJhAJnR4K2G91PrxsvlkDoS7HFTjANDmJ1EKPSODfHdeB9Jz6Q/BbLxGPsR1Qd0BBs+4QSlmtRqD34bTDW/lk+1AB8NL3gThkILZ5PeUNamQdsNPrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X3MfK6N39z1P9QL;
	Wed, 11 Sep 2024 08:59:21 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id EE3A618006C;
	Wed, 11 Sep 2024 09:00:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 09/10] coccinelle: Add rules to find str_yes_no() replacements
Date: Wed, 11 Sep 2024 09:09:26 +0800
Message-ID: <20240911010927.741343-10-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_yes_no()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 34ff8f48965c..96dc7090395d 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -298,3 +298,22 @@ e << str_on_off_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_on_off(%s)" % e)
+
+@str_yes_no depends on patch@
+expression E;
+@@
+-      ((E) ? "yes" : "no")
++      str_yes_no(E)
+
+@str_yes_no_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "yes" : "no")
+
+@script:python depends on report@
+p << str_yes_no_r.P;
+e << str_yes_no_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_yes_no(%s)" % e)
-- 
2.34.1

