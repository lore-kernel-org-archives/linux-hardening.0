Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AE179AA
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016433; cv=none; b=ECpIqLqcxIg5g16frWERqTLoJQEbePRo9jg25NS7+Jm9jkgGrPID5od4KmtHWD/ont53bgYyXtvgn3DfVDWwM3suVmK8777BTKS917uzul5oSIjiO0kp4qeL1fR/K1B3PauXXN/RZdXXjmPiu6bN4MensTkuinRTF45CD44g1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016433; c=relaxed/simple;
	bh=zL/+EDrCOh1hFeESut0JyO1J9+PrUY4m476/aJFjMqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sucD63Iq+Wxm02qSKpwQjevfMB5Fnb21TzK84u7F1QTdyqWni22zuqTG7QVoeIFMV7jeNG7YvEybrAoqflYZfJLeUqnB4T+wbrb9UzXvlYlw3ncN5H/ln+ifQWY+9GN9t+orsDCjgTr0gul2X9u5KIvOR5TK/6iyyQEFicyPmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X3Mg15BDfz1SB6c;
	Wed, 11 Sep 2024 08:59:57 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 232BA1A016C;
	Wed, 11 Sep 2024 09:00:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:26 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 04/10] coccinelle: Add rules to find str_lo{w}_hi{gh}() replacements
Date: Wed, 11 Sep 2024 09:09:21 +0800
Message-ID: <20240911010927.741343-5-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_lo{w}_hi{gh}()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 7c631fd8abe2..e91d4eb30161 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -165,3 +165,41 @@ e << str_high_low_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_high_low(%s)" % e)
+
+@str_lo_hi depends on patch@
+expression E;
+@@
+-      ((E) ? "lo" : "hi")
++      str_lo_hi(E)
+
+@str_lo_hi_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "lo" : "hi")
+
+@script:python depends on report@
+p << str_lo_hi_r.P;
+e << str_lo_hi_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_lo_hi(%s)" % e)
+
+@str_low_high depends on patch@
+expression E;
+@@
+-      ((E) ? "low" : "high")
++      str_low_high(E)
+
+@str_low_high_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "low" : "high")
+
+@script:python depends on report@
+p << str_low_high_r.P;
+e << str_low_high_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_low_high(%s)" % e)
-- 
2.34.1

