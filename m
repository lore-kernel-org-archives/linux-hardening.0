Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA312E7F
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016431; cv=none; b=b4Nkbn07MG9Tjn3hdjQj4O48T/Trf9F/GWeMlFa5L7AzN8qOj0pKNpGwpkbjrEVbveoOXWDpGIF5jaihH6dQ+iVK+WAxKw3Z4VcDTyhPq1NEVGLShQ91nbHdlJBxlhc/WmOpsbzSRsEbqgJ3Lqgyg6bD8cGxjUDtXRs5FdSmCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016431; c=relaxed/simple;
	bh=ZsS1GRm95KYXmzT6L9MeDz2+xcSedcLekQdsZDZxPnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ox4QAtawyM3di8mlikK5fpy4X7ojE8LHCsb2FUb+HUyx68dD55ZeupC4g8MEmdmWnYx85jEzORQmf2Op7eVMoBuZnu4SIV4l5wk9fMSLGbFbP+fDChdiRIKkaYa3strTDivAMc9BHxlvu9x+fMHgrp8kpAWKGfoLSZf1bcVgo1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X3Mg16mVpz1j8PP;
	Wed, 11 Sep 2024 08:59:57 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FFDC180042;
	Wed, 11 Sep 2024 09:00:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:26 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 01/10] coccinelle: Add rules to find str_true_false() replacements
Date: Wed, 11 Sep 2024 09:09:18 +0800
Message-ID: <20240911010927.741343-2-lihongbo22@huawei.com>
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

After str_true_false() has been introduced in the tree,
we can add rules for finding places where str_true_false()
can be used. A simple test can find over 10 locations.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 5e729f187f22..6942ad7c4224 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -85,3 +85,22 @@ e << str_down_up_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
+
+@str_true_false depends on patch@
+expression E;
+@@
+-      ((E) ? "true" : "false")
++      str_true_false(E)
+
+@str_true_false_r depends on !patch exists@
+expression E;
+position P;
+@@
+*      ((E@P) ? "true" : "false")
+
+@script:python depends on report@
+p << str_true_false_r.P;
+e << str_true_false_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
-- 
2.34.1

