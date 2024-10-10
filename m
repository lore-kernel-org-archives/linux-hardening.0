Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F91C7B64
	for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563305; cv=none; b=A2ZdZFEm9pvv2DjaGlPOcGNJnHu1cOtq4eLRP4x98+3jyrF5JaqaAKVTWDR2jjD/wZmqB7d5DKBTTtvXDo0171kEGj61SI/mobYIoN+729VrrcNdehYBXwMSufjxx2KeRS/B/HY4qqV3T6EK3SAcEje0uE16E0g7/r7hvmXcZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563305; c=relaxed/simple;
	bh=MRo6HjQ15aNR0eJ50gt5+sfVcqyhO/6KpFlpqqECZJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ck57bd0FlKvXZEZ82lleudyhmlsTiD89NeUaE7qIPZIvJGnL5/rSt+NdUYnKkL1I+Zol5j5HcwHyGLUmF5NwLM0BJee3c4IpnMIPefqnB2m2YYtVzua78EdzGLWSMypGfDyhU1dN75B/S3VUyDuy/Oydghbm6lHzB3r/Eleu9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0S+8+lSS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0S+8+lSS"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb161fso1514942276.1
        for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563303; x=1729168103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GuP8Dw+VpWRcprLt/X+HiKdbyXuiqtG6Iu2yHIJSWwU=;
        b=0S+8+lSS44nykFrKjGUzoK18TaMFv2oQaIIIBssHcKaLsig5Iof+NqWDH0qoCYJF4Q
         f+zKOuwFOGL0YLYZMFWZxXFCkI+cccg+XdRdqMtbJ3Rk0DUGBT2U3tRGACsTGnZGyVtW
         nNK9h4mrzBcJFKUGNNmfC+Sd1Ltxbe9+R4z8fYNkyXgzuRqjxNSKw8d+PpKgZWMl4WaW
         5wpSDM9Eyq1retUOeyCJppS3jGsFlC8Rvltqx+3nJGyNEmp2IEJ06C7Rre7xvBpOaDxj
         1PW8Jr9DnJyLcVAoqWHR5TftHA2OtI01O26vWiXeXh2j4t0DQnJYPwklb3rp6Py2gi63
         67FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563303; x=1729168103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuP8Dw+VpWRcprLt/X+HiKdbyXuiqtG6Iu2yHIJSWwU=;
        b=EFZAN8kZPnU+JcWOhwYxeAs3x3S+Uvw08gK3PmCyx5ZVYiZcVfSGrm0oBnucz8CgVE
         rV0YzA6UncdNzhJT6csqW0IOoITeb4BRGIe86YpwZX3QjT3MpPSCzoD0oCxbPOmOl/58
         7Og2MFkF9WZtkL05KNRCOsj/mEyEhzVZicvitPCDpatT7567FWxN0fzcVzMsNgFpczAs
         +B2jJPtWruPtxAymdaILValMsg0w7IXDpYvbIWqFCSqPRgWCXq5G/THYRI5dbFzbRne7
         OYITNd4phzfNQ9faqczoMimR/Oowi/LVdIMKRUapx9t/xC7r5nSbEL4M7vZmzZOoDR2V
         WWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3eoaTZZ0b29XVX6AZe9VaZubESreZn5G0NIUZaW/R6NBCMmJf8+Cg++uVWMFtSAomFOsQvfPNIPo3DEVLYMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyld6My1ljJVKrSunEZlSvo4WG1CM4FrwujMQ2vKYKRGrWA+jX9
	/WldRuv/Qi7kKVZAWlmtHk46nyLMvzE7XVO5ZTM269GHntyob+iLo9pXvq9tEGED+ry5gw==
X-Google-Smtp-Source: AGHT+IHL+aSBpZQ8XgGYGpH0O9CURph9tagSzDdjdDu89XN4DeeMFZXywYndZAwf/GPPkkHqRxOiKyoU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5b:312:0:b0:e28:e97f:5394 with SMTP id
 3f1490d57ef6-e28fe33aed1mr4678276.4.1728563303096; Thu, 10 Oct 2024 05:28:23
 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:28:06 +0200
In-Reply-To: <20241010122801.1321976-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=ardb@kernel.org;
 h=from:subject; bh=NRgY3UMAuDIJTAcx2+Y8d13RXHmPxwHdPW9+1ltPrDw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ39RMS9+3HyUVxz3N6rFic4/86um9+3/smqyr/zTgncZ
 Zo+yetsRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIqxUM/wPfJZ9NNS48fad3
 z8LWxz+ElmpIu7zdPqu+Zt7CeZ/qNXsYGV4nxAswx5UceSYy9bxb+me/sxyZ5Rs5/+us4FRYvUT 7Ez8A
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241010122801.1321976-11-ardb+git@google.com>
Subject: [PATCH v2 4/5] crypto: x86/crc32c - Use idiomatic relative jump table
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The original crc32c code used a place-relative jump table but with a
slightly awkward use of two separate symbols. To help objtool, this was
replaced with a bog-standard position dependent jump table call, which
was subsequently tweaked to use a RIP-relative reference to the table,
but still populate it with absolute 64-bit references.

Given that objtool will need to be taught about the jump table idiom
that compilers use when running with -fpie enabled, let's update the
jump table in the crc32c code once again to use this standard idiom,
where the jump table carries 32-bit references relative to the start of
the table, and the destination address can be obtained by adding the
two.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index bbcff1fb78cb..45b005935194 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -53,7 +53,7 @@
 .endm
 
 .macro JMPTBL_ENTRY i
-.quad .Lcrc_\i
+.long .Lcrc_\i - jump_table
 .endm
 
 .macro JNC_LESS_THAN j
@@ -169,7 +169,8 @@ SYM_FUNC_START(crc_pcl)
 
 	## branch into array
 	leaq	jump_table(%rip), %bufp
-	mov	(%bufp,%rax,8), %bufp
+	movslq	(%bufp,%rax,4), len
+	addq	len, %bufp
 	JMP_NOSPEC bufp
 
 	################################################################
-- 
2.47.0.rc0.187.ge670bccf7e-goog

