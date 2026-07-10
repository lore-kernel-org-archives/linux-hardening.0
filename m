Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9D383985
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711194; cv=none; b=peWie7EJJKEk19IGFLHaa4H+qeG/Jgo5P1A4jXBlQ9P3Ucmyvivt2jnqMt/dpeYO3jTJMZYT56VK102AAFnHtoS0J8xCQknLLehXC0Ign+PGMabsDQRXNNZf77BXhvIJjf8uY4WwMcbo9CFvAd5qOcJs04aCr7VGsRZiIz4o+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711194; c=relaxed/simple;
	bh=wBHj2DDsORxLaaEOFw5CeOwHpasYZMthFcc8Wln7+ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DP2nYkQ0Nc8+bh3rVoNSwZCxUjt0Ux6+uY8JRx1bZJvOeOmHS9VlU0fcP5x0pM1GEXD1gJ8XFyORmYt/6dXgKFwBE7EsFccAeDVxhuRe4Uf65F1121u25UDlOzEte9BNpv7PJ/7t7AffQvdS0znvm/xlDmpNfUA0bQRuhIDTzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=AZxs+4uz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="AZxs+4uz"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso874264a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783711191; x=1784315991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NcdQyycTKVB+4a4arLxKC9ob+myz3mwJ4DTAVSkIbwk=;
        b=AZxs+4uz4H7Zxyu9zb53xpVbB5TbeaQgel/bsasBqKgYMz3B4kPQz9IPpFH1bSWSEt
         I5DKjIlUOdSdYtS4zECCQspO2MHPHuAzIuAuibn4nQhFRppMLVXipDGo+jHc1EsEIH7o
         NdD5w6UigcrI3sa+e557Oo+zbSPUTk6IPRZ3UL0P3wquFGdLNqmb+/N34gfuoRDqnqVA
         UW/8XK1RF77UhG8XJKmwmxaOkfrKrtThXGWo4+SsYEvfXS7+zn4+unhyxOfFbp7XVaeV
         K4yceIvknt7oamaEaS+XfQGkdcIs1wYYq7OZKtC/u7bRLNkYxR/V7HmwB+0qrbI5vz5L
         lBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711191; x=1784315991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NcdQyycTKVB+4a4arLxKC9ob+myz3mwJ4DTAVSkIbwk=;
        b=lmjCBu6KDBtpnqhwv/CdafiPrQkzV8Ky2bXQ+LIfKidJmQRwAmeA16E+4Yt59nYt3Y
         ILSdApP4KuThVMWOopyPkKhnK/Fy0w5LyDMZDHSwnEZGNIcZJTw9LCgCJR/rYl9GhgSY
         9aEjAiDon9jHCyivr1LUfr53Ck8gfy3pMOW+mgvKBxu/s/svhDEVciGMf4/u+rYXlswA
         YOXNEo0x2XguVBeZSM5aKEGNICADc262q8BS+RCdaCCAt0xSZMrn3XzJI2IE37HBK2Mm
         Senb1wU0K4J0wyYpUhgE9O+7Fb2ZiEM3CjlX7FVnQOSqT/r9ZBcIlegXyZkCMlx5Vv26
         YJxg==
X-Forwarded-Encrypted: i=1; AHgh+RqvGshhaBGR4uy8qG56EjvHIuizhJIxVKg6ru/qQI7fvhWt20kLgxctpQM5bCXBqR4KtTWpOmaDXsybXsP95J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWAuGQGTtChKitzj8KeeXPG98M2xDMadzOde4YILBUYolIuaP
	TRRFRotAx8/mS8bCcDcBr8E7QagkgJh9UaD8HCfK/sSJOrTO/kGenNZXYmvr0xOHSQ==
X-Gm-Gg: AfdE7ck3TyapD+4bjh/OQu14sNaof7URd7C0yMHL8PbJK0bnjhIWma4T1vJKXJlXb/X
	dHYcz741tjm8qB1I+5K+Sg0DNZ+Iq8GD+2OZBHvUBvowwcZItd+IZ8itcfoliuQHw8kXzjfsonq
	fmux9KQ64X+N3mr2a0Zj+xxibaPf+VEYZz2Gd+czwY8m6E6XuPZBleqhB6JZ2644UJWjiDa6zKi
	vHEqaQO6yzdcug3vXrXk99eXtXJnepLfrTyXxRLyNoxacWIv1spCq6+eeO/1tddRtJWLVyq8M/e
	7lJfHeQTJN0cI3/L3IEhN0Z2Jak5oZ2VL8fPqHHv8az2bUgqZfwSjcbr/iAPSu0MqMDYBz2msVH
	mftk4MX1V86BLiUmIXAYGli++wajE6brmGA/b3D3nkApZStkMd0OoqtDxCn9mcMl99yxnuYANRK
	AbDxzZyUoKNUa7vExt7CtaZCpR34H3kAEySCcLlqHXs09gEIwohz9ql7XuQWl05JewBeL6o8OuC
	vUp/xjz
X-Received: by 2002:a05:6a20:9404:b0:3b3:cea:874d with SMTP id adf61e73a8af0-3c110160ccdmr327248637.18.1783711191344;
        Fri, 10 Jul 2026 12:19:51 -0700 (PDT)
Received: from rip.tailfedc6c.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm41912582eec.14.2026.07.10.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:19:51 -0700 (PDT)
From: Jennifer Miller <jmill@asu.edu>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org
Cc: jmill@asu.edu,
	xmei5@asu.edu,
	samitolvanen@google.com,
	peterz@infradead.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next v1 1/1] bpf: Enable JIT hardening by default when x86_64 CFI is enabled
Date: Fri, 10 Jul 2026 12:19:32 -0700
Message-Id: <20260710191932.120911-2-jmill@asu.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710191932.120911-1-jmill@asu.edu>
References: <20260710191932.120911-1-jmill@asu.edu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initializes bpf_jit_harden to 1 if x86_64 CFI is enabled. Prevents the
misuse of BPF JIT code to craft CFI signatures or Endbr64 instructions
by enabling constant blinding for JITted BPF code from unprivileged
users.

Signed-off-by: Jennifer Miller <jmill@asu.edu>
---
 kernel/bpf/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 47fe047ad30b..ed22b90c6e4e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -548,7 +548,11 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
 /* All BPF JIT sysctl knobs here. */
 int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
 int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
-int bpf_jit_harden   __read_mostly;
+/* Enable hardening by default when x86_64 CFI is enabled to prevent CFI
+ * hashes and endbr64 instructions from being crafted.
+ */
+int bpf_jit_harden   __read_mostly = IS_ENABLED(CONFIG_X86_64) &&
+					IS_ENABLED(CONFIG_CFI);
 long bpf_jit_limit   __read_mostly;
 long bpf_jit_limit_max __read_mostly;
 
-- 
2.34.1

