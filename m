Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA11A3032
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440797; cv=none; b=kG129WmV/aHeylvOF0Hc1dmw04Z6Gef44P+s2KDFbyS00Rqau9KBN0x8yCoxP6wM9WFR8k+1rEQTfWNCRhpOlE2mxRSPd9eETgq8Z7Jr+A/ZwoYELnYst1k5xaE2VM6r4nNBMIc9fGb+1weqRd/PEth+Ge3zyCgVOh7o4Yyec0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440797; c=relaxed/simple;
	bh=NRwT4tirGvmE3tun4fOBCMFt/WcV9MjiIVpMXNRpIvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U31zGWUdxqJl8fQaPi3Kofwy6NtwJrXCdeurjejzjfR4xPYX9cE91pREnfthFUXOVVoz0DkIYnP2krbnTz+/0R0JCE8ovMuyog96rD0XUQdNR37+n2io8YEVb74p0eWenINGRxq98/9e3+U2QqGzYfGHqCE0MQ7OPpX+mmfefRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WzGl930jkzgYwH;
	Wed,  4 Sep 2024 17:04:21 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C267180105;
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
Subject: [PATCH -next v2 9/9] coccinelle: Add rules to find str_yes_no() replacements
Date: Wed, 4 Sep 2024 17:14:51 +0800
Message-ID: <20240904091451.3328272-10-lihongbo22@huawei.com>
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

As other rules done, we add rules for str_yes_no()
to check the relative opportunities.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index bb09076e5f58..7b00d0450b17 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -338,3 +338,26 @@ e << str_on_off_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_on_off(%s)" % e)
+
+@str_yes_no depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "yes" : "no")
++      str_yes_no(E)
+)
+
+@str_yes_no_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "yes" : "no")
+)
+
+@script:python depends on report@
+p << str_yes_no_r.P;
+e << str_yes_no_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_yes_no(%s)" % e)
-- 
2.34.1

