Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272737703A
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777531302; cv=none; b=NP6TGEB6F2TWbUYNCtbIWGlxdTVVx2V0musGmUEst9UfisGS5w+WdtG1Byeu7fA2opXWPbJj25fMYEJbxTLUPAgoSD3/7FNMpUQplz0WAa4kgTAox678TnVfkK/Jy/8l960RR9eG6oRX6sUnS+51Z0vycpASjkSFrnAuU+sVbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777531302; c=relaxed/simple;
	bh=s+D4E7weVxpoi/KNR6/hyKngEDgrfBntCkFkFSTnwJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ebj5tKLBYjr/OknrRdiBzZj1loO4osiGblkdZtSriWvw2pmhvqjPl/iQu/4B9Q1T/3DDB3z+JWYJJV7g1w+n3xmm0gIbtRewfcO8y328vtToNqPccRjBMUpu0s1dEzpJdwcZ15tChewEVYQk7F7o+viRvKfHwdf0+fJsS0kl2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bye0Jmhr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bye0Jmhr"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso432102b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 23:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777531300; x=1778136100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olN7yyAJdML/hgufOM5IAEYIPUlmPuDpGh2nWEkwNIQ=;
        b=bye0Jmhr8zrMWa2+biTY0x1ieFJHAwci/wcz1aM/IG99hKfV+Kd1ztVZuBPOTbtuc3
         I2bXO89/uDpqyLE4pqUnCp7G+Pq+hBoOAysUfb0US6d84Fryh0DjVRL8vaK/AK4QO+It
         beDeWKiU05QfYHShF/VSN5FDDojDKd9gr58sElU+7jX2GDRYGclzfxAzzdxhP5DplXXs
         pxNAoWl4p78QvcdJ4zcavbTRjpiShJzi2hbYpjSYAACGMbovrAFJJf+Dzr/Eza9KYJh7
         y4IVGLbRBXPpN8RLwYu4fG4yM0R694Qe9M90rT+HYc5kTXuncVhOmYxWZiLpBMi3digd
         TH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777531300; x=1778136100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=olN7yyAJdML/hgufOM5IAEYIPUlmPuDpGh2nWEkwNIQ=;
        b=HMu4ROkSQXIW3LaAD6t+0LGm2I+e9KeP+/v/pYwfxU7Fm9J5OH2rMSEVRmlKSr42Iv
         q2SMZZKEZk9l4vHTvwdcmVJzS4zd7HT8eHeiHGRMDOQ17hJI5m8X9d1wvoWqmBfPv31o
         D3TcN1Go5JXpUMy2uEn1iPMotmTEIMwfTN65XKeVLtNeBw7uxuj/3y6Qw0dXDncgFCA2
         vOfuNzQGRNtLJceI/IaTByx1Fy2y7Rdq6azTsiOmivZa0Y51D0dg7CAwvqL1ZtQJ4NXy
         e+YhYXd5f0V2li5XM0bTO19x2eb/85Wcz6AuEJ7gn+z7G6bNDw+yvKPV1ERrlEgS8QjW
         CUTA==
X-Forwarded-Encrypted: i=1; AFNElJ9kLMZhCUYgVax4wvQ+S11zaUORY1dFxotuTYuvmP8iH62KupgXPRmDLYj6Ov5RMBKjpsr87Gi76RvCkqIwSy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw81EKY1jbpmEeLSjXPBpgT2L85JugKml8VsFajn3iVNQk3ScwM
	LButgNC9L5CYK6XSCsErRH5cjx9suDlrguAEKjd4QAVQXI/j7DQ/ajEu
X-Gm-Gg: AeBDiescYr1bLo+zwsDoj4yLfNph8Dl5MKj2RNoBI2KSTv3FZJLv6qvJQ2hnfbfVJfJ
	UXkywRyh5u/L8QyQPluaTTttOP0XOm9U/TLs0G996gq5mldOhc33TlMC7SOuA1GnCOCHjSU4g7W
	tM67Rs6AWAkviQEPJ/3rzl1KT3vPD81GregoNUB9tP9dlXStPTT72CVbiP4tMv17pGiUQTTIiyG
	wdyxEmdyExjXAFYAJZ9SedN72QqS/PjCj4G0h8s5/veMmhZn7wp4Sup8jbmlaiQ3PMPZuOiLtWF
	neEnlo/jKpgyuOSsmLCAx/aEwEauEMMwlUAxrGZGqK22zJVJqnHGAfMBwa0y8GsyHaygKG+578H
	ub8qpO+LUxN0wpkjvtjLNCIPXK/CJUkQY/vm3jKhCOphMqnta08mmj4C3KhVx1+AVtv8p5UjU/q
	YROtUdEC74j+VgBKA7WjuD4cHcqKTJOewY5u7nj6n1
X-Received: by 2002:a05:6a00:3e0f:b0:832:e65:ddcd with SMTP id d2e1a72fcca58-834fdc8235emr2083774b3a.45.1777531299876;
        Wed, 29 Apr 2026 23:41:39 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed6df1f6sm4096088b3a.30.2026.04.29.23.41.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2026 23:41:39 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	"mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: [PATCH v2 2/2] coccinelle: Add rules to find str_alloc_free() replacements
Date: Thu, 30 Apr 2026 14:40:41 +0800
Message-ID: <2ec1942dae69caf3c387e68a65091f84c40249d5.1777529232.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777529232.git.jqqlijiazi@gmail.com>
References: <cover.1777529232.git.jqqlijiazi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rules for finding places where str_alloc_free()/str_free_alloc
can be used.
This currently finds 4 locations.

Adjust the position of some coccinelle rules, so they sorted in the
same order as they appear in the header.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
---
V2: Keep coccinelle stances sorted in the same order as they appear in
the header.
---
 scripts/coccinelle/api/string_choices.cocci | 228 ++++++++++++--------
 1 file changed, 133 insertions(+), 95 deletions(-)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 375045086912..516b30828380 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -7,109 +7,81 @@ virtual patch
 virtual context
 virtual report
 
-@str_plural depends on patch@
+@str_alloc_free depends on patch disable neg_if_exp@
 expression E;
 @@
-(
--	((E == 1) ? "" : "s")
-+	str_plural(E)
-|
--	((E > 1) ? "s" : "")
-+	str_plural(E)
-)
+-      ((E) ? "alloc" : "free")
++      str_alloc_free(E)
 
-@str_plural_r depends on !patch@
+@str_alloc_free_r depends on !patch disable neg_if_exp@
 expression E;
 position P;
 @@
-(
-*	(E@P == 1) ? "" : "s"
-|
-*	(E@P > 1) ? "s" : ""
-)
+*      E@P ? "alloc" : "free"
 
 @script:python depends on report@
-p << str_plural_r.P;
-e << str_plural_r.E;
+p << str_alloc_free_r.P;
+e << str_alloc_free_r.E;
 @@
 
-coccilib.report.print_report(p[0], "opportunity for str_plural(%s)" % e)
+coccilib.report.print_report(p[0], "opportunity for str_alloc_free(%s)" % e)
 
-@str_up_down depends on patch disable neg_if_exp@
+@str_free_alloc depends on patch disable neg_if_exp@
 expression E;
 @@
--	((E) ? "up" : "down")
-+	str_up_down(E)
+-      ((E) ? "free" : "alloc")
++      str_free_alloc(E)
 
-@str_up_down_r depends on !patch disable neg_if_exp@
+@str_free_alloc_r depends on !patch disable neg_if_exp@
 expression E;
 position P;
 @@
-*	E@P ? "up" : "down"
+*      E@P ? "free" : "alloc"
 
 @script:python depends on report@
-p << str_up_down_r.P;
-e << str_up_down_r.E;
+p << str_free_alloc_r.P;
+e << str_free_alloc_r.E;
 @@
 
-coccilib.report.print_report(p[0], "opportunity for str_up_down(%s)" % e)
+coccilib.report.print_report(p[0], "opportunity for str_free_alloc(%s)" % e)
 
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
@@ -187,43 +159,24 @@ e << str_low_high_r.E;
 
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
@@ -263,24 +216,81 @@ e << str_write_read_r.E;
 
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
@@ -300,3 +310,31 @@ e << str_yes_no_r.E;
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

