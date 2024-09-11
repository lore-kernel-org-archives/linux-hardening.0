Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEFD17BD9
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016431; cv=none; b=uT3RdjKD0vorXIjR2dp+icu1MiBdTSGIY7DZpV0xD4VMhr/1uGB41wg5YkcXJVPQgQPrfEtSBknsZYNGto0xwMcB78K2q6UNbOw2tnTR8JE08Ssh4Ch4kreU/yR+fQlpZypAmN08EZlXSvdBOCYpleQVHz+p9XWUwXzlHDNa0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016431; c=relaxed/simple;
	bh=PTEtn+azkKxqbQZ4569HJqxAIFYcS+DqnOe65xqoKQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ijl+iFVVxPHlr6hQGCy0f+8coBUQTZim69b+Aupz1FF0iRocx7LAbyzw+eDcko5WGXP6kom0I5Azr2Hos0Yl6sKYmXrSn4LmDF/cgHS3oyUHCfncZCEc0o/LXEV34cFveLwnn/wCZl1HcfJhNh6oo3P4GRb5y4oTFOY97laVJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X3MbT2ly2z1HJS8;
	Wed, 11 Sep 2024 08:56:53 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C28B1402E1;
	Wed, 11 Sep 2024 09:00:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 10/10] coccinelle: Remove unnecessary parentheses for only one possible change.
Date: Wed, 11 Sep 2024 09:09:27 +0800
Message-ID: <20240911010927.741343-11-lihongbo22@huawei.com>
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

The parentheses are only needed if there is a disjunction, ie a
set of possible changes. If there is only one pattern, we can
remove these parentheses. Just like the format:

  -  x
  +  y

not:

  (
  -  x
  +  y
  )

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/coccinelle/api/string_choices.cocci | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 96dc7090395d..95e9a3b31f86 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -43,18 +43,14 @@ coccilib.report.print_report(p[0], "opportunity for str_plural(%s)" % e)
 @str_up_down depends on patch@
 expression E;
 @@
-(
 -	((E) ? "up" : "down")
 +	str_up_down(E)
-)
 
 @str_up_down_r depends on !patch exists@
 expression E;
 position P;
 @@
-(
 *	((E@P) ? "up" : "down")
-)
 
 @script:python depends on report@
 p << str_up_down_r.P;
@@ -66,18 +62,14 @@ coccilib.report.print_report(p[0], "opportunity for str_up_down(%s)" % e)
 @str_down_up depends on patch@
 expression E;
 @@
-(
 -      ((E) ? "down" : "up")
 +      str_down_up(E)
-)
 
 @str_down_up_r depends on !patch exists@
 expression E;
 position P;
 @@
-(
 *      ((E@P) ? "down" : "up")
-)
 
 @script:python depends on report@
 p << str_down_up_r.P;
-- 
2.34.1

