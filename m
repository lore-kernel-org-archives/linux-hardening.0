Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA63F54B4
	for <linux-hardening@vger.kernel.org>; Wed,  6 May 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061476; cv=none; b=Imh/AFJk5RTeGjJSXHiaXmzNjeW+N6lBy/TQyFY7SLG1aX6BtFcFnWGraU18z8Lh3Vj+KrTk6uNBZpnMdEvZKx8GTwLz2HqvPmL3Dqbt0Hk2FPgEhrhcu2rBKmaUJkBdvmhY1GkHxNglU7hRTZfRPfRJH4TZzJcg1gww9XgA4Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061476; c=relaxed/simple;
	bh=cR1oohkKV3PcSi2aOygDCfEDndNVHUEiBPyQq3y2RyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfo4ZKcaC3hDFQRVO/zxD+RtH6qD7ZEZqcLzJ/CyXNWai49QJA1u4j6DCmS2+XUYPKGEsg9RPh+khFWmikOH0S1jlkMnCCkCICjKm/F6zDos4gnkvVaPPS5ECLiJ5uXzbMdI8gU95nHMjdijf/n2fbW1IBuEHC7rd2B0w9Qg1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqEmKvnt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqEmKvnt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so21197015ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 06 May 2026 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778061463; x=1778666263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ro28UUKQ+6LuLkDZX/nentMS1XTWwGIlGBWvZqrPbYU=;
        b=lqEmKvnt9/v4iVlb8LpXPRYLiBzMNjufiLDDqE1OKRCYkzx9Qnf2R4G7jZj9M69smO
         kyabDYxT9QqP+JTZlcEJMogozSMTmsZXk5pemu8hHUOioI6kKTdkxT7ZweYEVpFU3eC4
         OEnx/7qac2YhPU5pxwREYHTAQm4xfUhb+4cnkorUgKjrRGvg9U45VWE/SUMkzMSFJO5p
         H+H8IO7S+LQArtXktWKjgdNNEpjTfQvpTTYneyV/GDOdYCVUj9DvyvGaDN4S82e/lCyh
         qEQFN6EdP4pH/CaeFWklIHw2tK0sClCEpRkrK1w6mPsqZV3/Y55Y8uGJGdDG7ogUrWSs
         jJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778061463; x=1778666263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro28UUKQ+6LuLkDZX/nentMS1XTWwGIlGBWvZqrPbYU=;
        b=BOkkkbg6WPi1KLPYvSBb895l1YRN8NriwETMv0A5Bp575u2yaOjlQ7XrtiByxpoLyT
         7X74G1nY912zOErHTUhhmbME8bt3CEdwLrByaZ2KSn+ZyUxHVD6XHcauFqyQ9Et3OLT5
         UDPejGmSsldUpg3GT96EJzZtYGBM5iJz1ON8oxsuunIU7nMEOE2QsuacvRobEJmxA420
         qJYbZb5VO/6hunFvmdyqXrd3oXm9gh/SVjphyLHrEVxdFiNnp4VRuXv0XQRY6hTfYzx9
         86flHat3g+NerEoRN2v0cVO9f2h2NN/mhIGyzodMNCJax7uSmjWiY3pNxCDri1ngVyCG
         xaEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8l3Pu4bly+hD4hQ3pfLguv4HHF70kFkSo19nJeK2RnmlrVUVK2KGPKDCLY+sPCbVVchq62E4m25IxN5x2tP8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt1U+TmeLOezidW37+Z7t3hlVTAgQqZ21GsaUPViOHCqX+B3t7
	JWtyj6h8sCxnVN83AdAvJROeKqlR7EIEhmncRok1nml2KdptxG3DULuL
X-Gm-Gg: AeBDievUDTTTN+AB4BU1oxY3buvyyZa+qU8vYJsX9jn1aR/CqFZOpl95+NL25Pj/N6M
	HG5q8lsep55JiPjVxWKxAxjrzGz0Xw+b/uclB7nkPIhXu7B/pDTOgFDkywEv+DPhJq2w2f8PHfH
	4MxtG693WK2i9KK82whVnYpfxQ8jvX6gNM549/8ZA1Erkqn1LjOa0X83hJufc5DGxCW3cn/GBZF
	mzIw1COE/3olmxGrFn2ZqPNGhtYYHrf3Lw/FEv0f7xSRIjDjMTbX/vaknztYt1zh51c/K65IJhU
	l9mkbmonxENqMdm2pfRbvOdne5WdVg38wW1POWXiLP6zFSL9ID6TIkPMrimUikqzuwyh1RX3BZL
	rUx8Sl5uItIo0yef1QE99GOtAr0ZKMmD/uaC0QGmbppvOXri3Zi49j9A+t3GVJyavmjH4lUOIOQ
	z+ojWReTKA8QW1c0DBAZtXjxkvqmu+1a9yr2wqdVKs
X-Received: by 2002:a17:902:e790:b0:2ba:bfc:76b5 with SMTP id d9443c01a7336-2ba78b40166mr28226925ad.4.1778061462485;
        Wed, 06 May 2026 02:57:42 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1cc4sm20385205ad.48.2026.05.06.02.57.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2026 02:57:42 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	"mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: [PATCH v3] coccinelle: Adjust the position of some coccinelle rules
Date: Wed,  6 May 2026 17:56:36 +0800
Message-ID: <20260506095638.8752-1-jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust the position of some coccinelle rules, so they sorted in the
same order as they appear in the header.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
---
Changes in v3:
Split position adjustment to a separate patch

v2: https://lore.kernel.org/linux-hardening/CAHp75Vdvdr0TPzuDDPSoJ4Nixk-6qO_x6Or9iY9LNwSO1Q6mHg@mail.gmail.com/T/#t
---
 scripts/coccinelle/api/string_choices.cocci | 234 ++++++++++----------
 1 file changed, 117 insertions(+), 117 deletions(-)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 375045086912..7b2b76a42acc 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -7,109 +7,43 @@ virtual patch
 virtual context
 virtual report
 
-@str_plural depends on patch@
-expression E;
-@@
-(
--	((E == 1) ? "" : "s")
-+	str_plural(E)
-|
--	((E > 1) ? "s" : "")
-+	str_plural(E)
-)
-
-@str_plural_r depends on !patch@
-expression E;
-position P;
-@@
-(
-*	(E@P == 1) ? "" : "s"
-|
-*	(E@P > 1) ? "s" : ""
-)
-
-@script:python depends on report@
-p << str_plural_r.P;
-e << str_plural_r.E;
-@@
-
-coccilib.report.print_report(p[0], "opportunity for str_plural(%s)" % e)
-
-@str_up_down depends on patch disable neg_if_exp@
-expression E;
-@@
--	((E) ? "up" : "down")
-+	str_up_down(E)
-
-@str_up_down_r depends on !patch disable neg_if_exp@
-expression E;
-position P;
-@@
-*	E@P ? "up" : "down"
-
-@script:python depends on report@
-p << str_up_down_r.P;
-e << str_up_down_r.E;
-@@
-
-coccilib.report.print_report(p[0], "opportunity for str_up_down(%s)" % e)
-
-@str_down_up depends on patch disable neg_if_exp@
-expression E;
-@@
--      ((E) ? "down" : "up")
-+      str_down_up(E)
-
-@str_down_up_r depends on !patch disable neg_if_exp@
-expression E;
-position P;
-@@
-*      E@P ? "down" : "up"
-
-@script:python depends on report@
-p << str_down_up_r.P;
-e << str_down_up_r.E;
-@@
-
-coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
-
-@str_true_false depends on patch disable neg_if_exp@
+@str_enable_disable depends on patch@
 expression E;
 @@
--      ((E) ? "true" : "false")
-+      str_true_false(E)
+-      ((E) ? "enable" : "disable")
++      str_enable_disable(E)
 
-@str_true_false_r depends on !patch disable neg_if_exp@
+@str_enable_disable_r depends on !patch@
 expression E;
 position P;
 @@
-*      E@P ? "true" : "false"
+*      E@P ? "enable" : "disable"
 
 @script:python depends on report@
-p << str_true_false_r.P;
-e << str_true_false_r.E;
+p << str_enable_disable_r.P;
+e << str_enable_disable_r.E;
 @@
 
-coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
+coccilib.report.print_report(p[0], "opportunity for str_enable_disable(%s)" % e)
 
-@str_false_true depends on patch disable neg_if_exp@
+@str_enabled_disabled depends on patch@
 expression E;
 @@
--      ((E) ? "false" : "true")
-+      str_false_true(E)
+-      ((E) ? "enabled" : "disabled")
++      str_enabled_disabled(E)
 
-@str_false_true_r depends on !patch disable neg_if_exp@
+@str_enabled_disabled_r depends on !patch@
 expression E;
 position P;
 @@
-*      E@P ? "false" : "true"
+*      E@P ? "enabled" : "disabled"
 
 @script:python depends on report@
-p << str_false_true_r.P;
-e << str_false_true_r.E;
+p << str_enabled_disabled_r.P;
+e << str_enabled_disabled_r.E;
 @@
 
-coccilib.report.print_report(p[0], "opportunity for str_false_true(%s)" % e)
+coccilib.report.print_report(p[0], "opportunity for str_enabled_disabled(%s)" % e)
 
 @str_hi_lo depends on patch disable neg_if_exp@
 expression E;
@@ -187,43 +121,24 @@ e << str_low_high_r.E;
 
 coccilib.report.print_report(p[0], "opportunity for str_low_high(%s)" % e)
 
-@str_enable_disable depends on patch@
-expression E;
-@@
--      ((E) ? "enable" : "disable")
-+      str_enable_disable(E)
-
-@str_enable_disable_r depends on !patch@
-expression E;
-position P;
-@@
-*      E@P ? "enable" : "disable"
-
-@script:python depends on report@
-p << str_enable_disable_r.P;
-e << str_enable_disable_r.E;
-@@
-
-coccilib.report.print_report(p[0], "opportunity for str_enable_disable(%s)" % e)
-
-@str_enabled_disabled depends on patch@
+@str_on_off depends on patch@
 expression E;
 @@
--      ((E) ? "enabled" : "disabled")
-+      str_enabled_disabled(E)
+-      ((E) ? "on" : "off")
++      str_on_off(E)
 
-@str_enabled_disabled_r depends on !patch@
+@str_on_off_r depends on !patch@
 expression E;
 position P;
 @@
-*      E@P ? "enabled" : "disabled"
+*      E@P ? "on" : "off"
 
 @script:python depends on report@
-p << str_enabled_disabled_r.P;
-e << str_enabled_disabled_r.E;
+p << str_on_off_r.P;
+e << str_on_off_r.E;
 @@
 
-coccilib.report.print_report(p[0], "opportunity for str_enabled_disabled(%s)" % e)
+coccilib.report.print_report(p[0], "opportunity for str_on_off(%s)" % e)
 
 @str_read_write depends on patch disable neg_if_exp@
 expression E;
@@ -263,24 +178,81 @@ e << str_write_read_r.E;
 
 coccilib.report.print_report(p[0], "opportunity for str_write_read(%s)" % e)
 
-@str_on_off depends on patch@
+@str_true_false depends on patch disable neg_if_exp@
 expression E;
 @@
--      ((E) ? "on" : "off")
-+      str_on_off(E)
+-      ((E) ? "true" : "false")
++      str_true_false(E)
 
-@str_on_off_r depends on !patch@
+@str_true_false_r depends on !patch disable neg_if_exp@
 expression E;
 position P;
 @@
-*      E@P ? "on" : "off"
+*      E@P ? "true" : "false"
 
 @script:python depends on report@
-p << str_on_off_r.P;
-e << str_on_off_r.E;
+p << str_true_false_r.P;
+e << str_true_false_r.E;
 @@
 
-coccilib.report.print_report(p[0], "opportunity for str_on_off(%s)" % e)
+coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
+
+@str_false_true depends on patch disable neg_if_exp@
+expression E;
+@@
+-      ((E) ? "false" : "true")
++      str_false_true(E)
+
+@str_false_true_r depends on !patch disable neg_if_exp@
+expression E;
+position P;
+@@
+*      E@P ? "false" : "true"
+
+@script:python depends on report@
+p << str_false_true_r.P;
+e << str_false_true_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_false_true(%s)" % e)
+
+@str_up_down depends on patch disable neg_if_exp@
+expression E;
+@@
+-	((E) ? "up" : "down")
++	str_up_down(E)
+
+@str_up_down_r depends on !patch disable neg_if_exp@
+expression E;
+position P;
+@@
+*	E@P ? "up" : "down"
+
+@script:python depends on report@
+p << str_up_down_r.P;
+e << str_up_down_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_up_down(%s)" % e)
+
+@str_down_up depends on patch disable neg_if_exp@
+expression E;
+@@
+-      ((E) ? "down" : "up")
++      str_down_up(E)
+
+@str_down_up_r depends on !patch disable neg_if_exp@
+expression E;
+position P;
+@@
+*      E@P ? "down" : "up"
+
+@script:python depends on report@
+p << str_down_up_r.P;
+e << str_down_up_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
 
 @str_yes_no depends on patch@
 expression E;
@@ -300,3 +272,31 @@ e << str_yes_no_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_yes_no(%s)" % e)
+
+@str_plural depends on patch@
+expression E;
+@@
+(
+-	((E == 1) ? "" : "s")
++	str_plural(E)
+|
+-	((E > 1) ? "s" : "")
++	str_plural(E)
+)
+
+@str_plural_r depends on !patch@
+expression E;
+position P;
+@@
+(
+*	(E@P == 1) ? "" : "s"
+|
+*	(E@P > 1) ? "s" : ""
+)
+
+@script:python depends on report@
+p << str_plural_r.P;
+e << str_plural_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_plural(%s)" % e)
-- 
2.49.0

