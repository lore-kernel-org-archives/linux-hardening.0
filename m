Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC73B4E8C
	for <linux-hardening@vger.kernel.org>; Sat,  5 Sep 2026 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636599; cv=none; b=LHTNGH6BadEUEjyEyRhD7czV4iEOfFmKa4Oux1/Dv5Z6MH5lYZdlLCNp3AI2t7JXT36cPfxUSR3zvv96AifxbHNUT0RWNcd5pplEdRJeKCOktUWSDRWgmvI4wiJj+waJG3xVYu+NAQLShIamm/PaJKuhwLEx45vaXWSZrMy1wBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636599; c=relaxed/simple;
	bh=viFijJiUhOJEOjb4FCpGEYRsqqRivUhUbJK/aUiKGrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFvLkbwzf+n6gOHh/0R2rOPuau2DwR2SDLaQuISKRBuRcFyL0m+70Dx1f6Kng65Ivmi9pSPxlQV2aRhqxU3qxSLVOwCIG/j7q0/rNfDhMFXg5sqjsBIKpf6UBsDJPLcjqzsAL1oAHneLtnrjRMS/EXZ61JeufZBVpFa2OUIBV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jscuox0h; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jscuox0h"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8588583a7c3so22963867b3.2
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636597; x=1789241397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ygh7AiGeWs6lyLt2xt2E6KSyS8AtAFMza59CShkrWvo=;
        b=jscuox0hqvZEanx0bJ4s99jvCOFqTTnnHyZ78NABjer5/oxM8oiN/+oyiz5azZhHOr
         E/hKU/UqES5M1all8l38o8K0VctueGrU6kTMYhFgamoLW7SX2hn/+hMsBSM+5ZROL3FA
         W9H331AWuMnfp1yFob8EvYSG0IWSwfbQ+jnbd+dhJKLQqK0CtQ5oi7fGEpO7Ny0CeAYq
         LuzL7CPsRmGQ2Gq5SiHo+FzdHJhu6Opqli59PIpsKxmpcjjoEm+NEHEAU5aOzAZ/NJY9
         cTq/RYbl65Zrkyb193TQSvNimKZena049U4UU20729gjdX6k9AirQ5a3JbRxZuX4+Nsp
         8yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636597; x=1789241397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ygh7AiGeWs6lyLt2xt2E6KSyS8AtAFMza59CShkrWvo=;
        b=JEwvWSUz/aUvqcsRzMHD2LCZezN0AbOehGfqEaMCzvw5QOn2pIIRVn0CxaHffbFq2Q
         cWfR3mbEM+6nEmZDTsQg68c+x/0UJXU1tGdinODxaeCltEoQC3I4SJv2L42sKL/8pq2y
         InVhYX2HYfglwOGAqDa2M1KybYSmm9SgXaYqCh7+7Tj7AzVUHPcGwPmHAPsIZsqlBuUg
         Rcw8sInEcymQI+KkrVMqlMka4QGOIzhXoPGxxZFgkKbG27iRMhEaRouviHuix626lRGv
         vW7EL4waHf1ctFGgZJLkAqnFLRDpRHURhFzj46LC6wY9mQfg+vnWS6WdKEAt2GxhMLau
         eRfA==
X-Forwarded-Encrypted: i=1; AKwUvByHZc5mdtL/8buLLJvoBvNWPSDqBkoNVGI2CuglLML4v8h5sbeQXwe34Wi2DKdAJevj5usX2mW+UCkFvn4qJyE=@vger.kernel.org
X-Gm-Message-State: AFuF++kRXaxxrOdbWz6VBI0rKvnL0VmwgdzjgxtwjUyfFHkAVJMm01hR
	UtLNZYZvdkO7WMXWsQP7SqdaNuPK00dZMSEAHjV+k/hPBk9HbfFCjb87
X-Gm-Gg: AYBFou3rtWRtrpmasbLNKxw/HGERJoYnphjJWdCtauhGCFkj423UzVUWDprvgjXviEA
	Lwu9uVozQRALEPnu3AA4TO4ripblRi+xJovAhwPfijKE/MsI2P0vF5bKjL1ufkwqIKcsRbfUM8v
	3UhstmbI3JJmdyuZNXYNHyIAgowNhhRcKQ5MxMtbv8nxpqRmIKX5gHFEQKwvox1wOz41/xv7wU4
	qJ73GzDkST/Ng8++/LWtk/qxPiqZQLRFwwbtZJ5SZKEmO0GhOUVojCTUje3w/15NYohpiOGSgHi
	P2qj0VnGf6TcM1/jFYd7Pfn/U6mmtCVXgBMf1On1utyvycjWettCDaIu/XvPVPsngoIPHCM2rlb
	OzNTGHE96ZDoEL+vtT3693nzDRuijKBo5xBDcyK2POugB6oqKdCyiuQA5754iyMaVnq6nZ7ZjoO
	IUqjxxl80eBxMK1fZw5XAQTTizzOU34tw7rJUUOiruqN5HxCPjIAUlfHPab6yb
X-Received: by 2002:a05:690c:dc3:b0:873:5bb2:6c03 with SMTP id 00721157ae682-8735bb26d04mr24162197b3.45.1788636597114;
        Sat, 05 Sep 2026 12:29:57 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714befac64sm43433107b3.47.2026.09.05.12.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:29:56 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 05 Sep 2026 15:29:35 -0400
Subject: [PATCH v2 14/22] alpha: select ARCH_HAS_DEBUG_VM_PGTABLE
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-arch-kconfig-options-v2-v2-14-83e8245761a2@gmail.com>
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Kees Cook <kees@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=viFijJiUhOJEOjb4FCpGEYRsqqRivUhUbJK/aUiKGrY=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm5E7hNFtoYzplxRY+63dfFkRlxigY5Z+pYXovri+cV
 7xw42+xjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnGYwfD/5JPs6xFXF
 VL1/x651rI9jRr64e26RN3ctcvuGvq9mTZxwCG/0kznryZkpTO8CgiQUjr9v/wqXP//M96ZbR+Q
 xUz2//onTwA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

CONFIG_DEBUG_VM_PGTABLE runs a boot-time self test over the page table
helpers: the protection bit accessors, pte_modify(), the swap entry
encoding including the exclusive marker, and, where the architecture
supports them, the huge page helpers.  Alpha implements everything the
test needs for a three-level page table without huge page support.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Matt Turner <mattst88@gmail.com>

Also mark Alpha as "ok" in the debug-vm-pgtable feature matrix.
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
---
 Documentation/features/debug/debug-vm-pgtable/arch-support.txt | 2 +-
 arch/alpha/Kconfig                                             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index 156687a7436d..b4e2374fe201 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -6,7 +6,7 @@
     -----------------------
     |         arch |status|
     -----------------------
-    |       alpha: | TODO |
+    |       alpha: |  ok  |
     |         arc: |  ok  |
     |         arm: | TODO |
     |       arm64: |  ok  |
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index da4ec8399517..4bd5e913baaf 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -6,6 +6,7 @@ config ALPHA
 	select HAVE_SYSCALL_TRACEPOINTS
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_HAS_CURRENT_STACK_POINTER
+	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_OPS if PCI
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_GCOV_PROFILE_ALL

-- 
2.54.0

