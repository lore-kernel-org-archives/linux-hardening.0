Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90636D517
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461862; cv=none; b=s8VjfbvmvqJgETh1VAHXEQPq2Nsj4j0we7r7NkiEa6sHG4MK8rxmfr9JruEumIwPuKhZ/ToOGwrkMBqQR4whUVIHUpf6qO3+ea9x3/azef9WlFSMe830E44PB+7QUNRvoDzyGmr/SBv85+eLIU71y/7zkekqEMgIzCBjTCYpxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461862; c=relaxed/simple;
	bh=bj4+2GtnYLKlD8yNcwYLRqXAbXzrYAzje02Vbmz7GBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN1OeBgtPpgTJJTiI/WM15jqNrWUjB3sO5JOO+rlpxZAjGUTrl+5MnKCXa4vqQ6+Egzep/PfDM2x2blXHfvHUqv5BGurp+/LgRvORI5vOCRf3An2lwKkWPEx5Ev94YKBn5I8wi5HTkmJB17iSX2K44MOpvF4/EQHurnTIzYVWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnOeUaon; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnOeUaon"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so8696000a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777461858; x=1778066658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sY5W8Fa5UqoxYv90WiQpL4BDo0RVe599HQd6eKPS0Y=;
        b=nnOeUaonE6ZoqJ+FKCB2+0Uy5wPOziugZD3LgYdJQgAjhWwkfj6XhCBYHxG8+jHC0V
         VL+rV24Fr5rgG1Uvf5K+Y1bM/BpRTl9H9rS5F3Dfz+fwCosrZKQNYOfuDr2z9EuJ1/90
         Bh43gMLCcxAdL/ovU8se+IZQPG3jXMvugkpIQILb34Jku1swrq/X7tF/1JmzZrSwt9n4
         CJ9V6Ga8lqufGTZ5I5H7Zwl984hR9+aEjE4fQpzE0Lm6TP2XY1CEkOOcZvteiFXO7/Yt
         TXjn/e3OdXDMVqJ2ADDWtAnXXykhSlWpOsVGiuo4Iz6f2IFzHKI/Z9LnZosZS3h5A9h1
         FPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777461858; x=1778066658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+sY5W8Fa5UqoxYv90WiQpL4BDo0RVe599HQd6eKPS0Y=;
        b=nqjwUlDENIGS4EJMJMJIiQV9zK2a3htguhwEABQ7wr2+YypnjaGjqbZ0A8c/47UEM7
         59Z/L4xHkQyEf/PF1SrYvQ+75dw6YAzqOvE4/YrC7aSMREUedQvBoxZG2GHJE0l9Fv1S
         fz5Asq9nnnH0dh/Z9oxVndc/5LUXq3V5LNmJSLfLhMs/8sRucEXamGEm6lkPx1Zhuv2T
         pGAk69t5Q1gm95Ker6Ci+PLh9XpvXXIaeUQ0HsloE6zZ2Lp0LqaJ7gkVKhIrsCOMCdn/
         9eDaUCHhYmkzFbE36p9Aow6EqUx1xu7223qQvMtDO7I1D9Xy2F+fGIl6M+BXVzeMVD/H
         UBBw==
X-Forwarded-Encrypted: i=1; AFNElJ+VW6YoQmUVSgI2QtK0NFCuAwYjbHuqJuTpjpMlnT5pULRWnCmMLprC6m+w/1fZCqby63DdV8p6+5B5zuB3POw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpAL9Tp5/949GC1clLnZstzY/UpECKDv9N4s1VPXYyeXswwiWP
	GUZeWGq3QtgBlLuxxUjDW5LZ0cVrYwrNrXnlN/YGVygP2YDriNeEK6c8
X-Gm-Gg: AeBDiev9n3ceEO4FaPFsNE275/gtC8ZmKadx6fGxB3RAmF2OYITXH+G3xL/4zSqLCOz
	4vNK1X64YU4RgzaDfYaa0AwPrMi0D3Q+rdye6rQSeaC/o2bD1k1bFoYvCYrja8FKA2oA4pm1Jxr
	yyucBd5WHjyBXj7ujSJPppdQppv8zmV68zX/97TkXyTymTCuh2q/v8X5cZFw27CFsutjHdFgZTC
	OhSN5pKLuF6324ICp+c/AAwXMIKyQONH2X/Gjw9kueuDhnte//QQ/7DT555SgzOjES/jjyGSphN
	ujMTcrjqIX0bGmpFXGy1gF4R+15tH0cfrnAwrkHWevb1aVCDd/BGtixfJmqfxNs1v2h0rUyIV05
	kH6JLVN1BCWdLt/93OmWmm/mFuQ6llY9+cqVqsYwoBbm+HgDSMHOXhH//5xmpLLig4flCdbaP79
	2zAKj4lgTFgaviCRr2WRfWm074nRY0WXVzVNwk0tnI
X-Received: by 2002:a17:90a:d2c6:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-364a0d01ce3mr3196358a91.14.1777461857677;
        Wed, 29 Apr 2026 04:24:17 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649fe8990esm3834484a91.0.2026.04.29.04.24.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2026 04:24:17 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	"mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: [PATCH 2/2] coccinelle: Add rules to find str_alloc_free() replacements
Date: Wed, 29 Apr 2026 19:23:17 +0800
Message-ID: <f04886692531b6f6af52b75113bba43ecf2c7def.1777369070.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777369070.git.jqqlijiazi@gmail.com>
References: <cover.1777369070.git.jqqlijiazi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rules for finding places where str_alloc_free()/str_free_alloc
can be used.

Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
---
 scripts/coccinelle/api/string_choices.cocci | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 375045086912..5e5f0518b90e 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -300,3 +300,41 @@ e << str_yes_no_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_yes_no(%s)" % e)
+
+@str_alloc_free depends on patch disable neg_if_exp@
+expression E;
+@@
+-      ((E) ? "alloc" : "free")
++      str_alloc_free(E)
+
+@str_alloc_free_r depends on !patch disable neg_if_exp@
+expression E;
+position P;
+@@
+*      E@P ? "alloc" : "free"
+
+@script:python depends on report@
+p << str_alloc_free_r.P;
+e << str_alloc_free_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_alloc_free(%s)" % e)
+
+@str_free_alloc depends on patch disable neg_if_exp@
+expression E;
+@@
+-      ((E) ? "free" : "alloc")
++      str_free_alloc(E)
+
+@str_free_alloc_r depends on !patch disable neg_if_exp@
+expression E;
+position P;
+@@
+*      E@P ? "free" : "alloc"
+
+@script:python depends on report@
+p << str_free_alloc_r.P;
+e << str_free_alloc_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_free_alloc(%s)" % e)
-- 
2.49.0

