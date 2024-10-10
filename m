Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD51C8317
	for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563308; cv=none; b=Vgqa9OKnckonA5VCpoSZpSEvhbEcjJGxCfQh+i8ExHYx2FbQ3ecbsYb5KEgQ4nG/Kg8L6yN5W25qs45wN1p7C0mmTxD/sYrDEmpF9X2Ra4GcphKBaS0t89GIitsYoyQwALGvGDfxst8Qg8dnEITE/u/bUDPEBx+Ayc1Bi3tInA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563308; c=relaxed/simple;
	bh=/o/yZ4swobCw3VY94GgXQ0C8aM777wTuhgBNMFNnV60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nqx3npx9wPuKuEB82gxI10qFzHO49HwMCF0S6m95b43G10R9KdMCJMlUGG2PrQV182nH/q5ZPqlBIi06BCFepX/s1WV6pMmkcwsnvXVPxx+NRg5BP57icN1PcwqzugOWkVf4AFc4R3/Yb0Sqos6dMC3MRePWPSatoi3J/uo1YFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/yIcTmt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/yIcTmt"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32e8436adso13874787b3.0
        for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563305; x=1729168105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysiTQYnIFAM+GVpiQPZxea96jDzKFB0S2bf0Q1srz24=;
        b=u/yIcTmtS0xO48wZqY0P+gD7n5CoHPHLWbPYHUVVnS2Ff0brg/3EwPNUxiOOGuzl2X
         cqhb8A5bvXAp3JuWPUX644PNybMQyHfyfVEzTiJTWlCBgigPi7WNoc5Pu5UxW8aj1zPz
         c6dyXptV/UAop22++4Mndl7iIeai9JIGpQrqpTQCV+pdbWt17zboNryhJex6ms+ArVyU
         20S4NKH2NTL1QFLwjtcvpJ/5GxaAOnkngOFGvKjAJCmQmQspUmjgjwd4AKr1NTPVQ8MB
         mD05lr9WoN6nQ5y0KspfM7hleP+M+8XwkadYuOJVO0n3gx0dVWmPofparz6arPEeARpS
         W6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563305; x=1729168105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysiTQYnIFAM+GVpiQPZxea96jDzKFB0S2bf0Q1srz24=;
        b=jW9aqs5Xa7kCjKw9TEaa6did29+5k03veF9k2nQHLNPndN0dPrUVJhMU5BuG8AaZau
         6vI6ezfDY8eGc/WsfjtkiTWrUmJyqNcKHlGV81Z57KEt5dS89zKL4Lnfs/zOnHhQRrJs
         AfO/U3O/NxmTgb88lkV/gOc/eRkMONnvZdba3rANH/0BB9M/6ky7CSxpbQ5LBgjZWziF
         N0Q1UGGX/bbxMbxrU/tOjulKVjPT7VXJAGRBOqWvnHzQHAmrO28dP87zHVNR5tcBfnJY
         VYePgKJFxpvcHbzWU1+ik9tuJBSoQpOCuKdBTye5WtMmHKV6sT/5kg0fcYANh6upr85U
         Cs3w==
X-Forwarded-Encrypted: i=1; AJvYcCXj0qPgHEAmOhdFCB1bQxXnjrFdb2MCTi3F6Pb6SDZ0EwzxWxRlqymP9nnmqM9g8mUcCqaideMcLOIJ/dZJdHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjLHpez3L+tj0+jHZqlTPGmtRcWUWKQkAR3ZzO5gFuAecQUG4p
	kT7JX5cB0bAdBR6vGJWARfcCNyww378piGmsjXkV4I78sWToxM1L+DwycloxYUJdNAW2Og==
X-Google-Smtp-Source: AGHT+IGYzCVf/jII8KomABTrMZDoXEXfru199j0RK0tDWPSxK1xkfDqRPfD8R/E6mn2ZF9v6gg5pIreS
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:731:b0:6e3:eab:18b1 with SMTP id
 00721157ae682-6e3221767a6mr203727b3.1.1728563305577; Thu, 10 Oct 2024
 05:28:25 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:28:07 +0200
In-Reply-To: <20241010122801.1321976-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2591; i=ardb@kernel.org;
 h=from:subject; bh=RmdquyWiyHUUPxUBLvM2Ygamlf/86/TxkgF8NWyXERA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ39RGTnOvUT3GJzrx1X9JCRfnpo9w2pI/P+f72q8Y5HS
 2VhS1hJRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI/VqGn4yKCg4MbTISnK/Y
 F87etqfSUuC0V+eSGs4vLtH5KVNelDP8M/12ry6phyVirtfhVYVX34UvNvU0q/3pKLY8Kf7HkZk prAA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241010122801.1321976-12-ardb+git@google.com>
Subject: [PATCH v2 5/5] crypto: x86/crc32c - Tweak jump table to validate
 objtool logic
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Tweak the jump table so
- the address is taken far way from its use
- its offset from the start of .rodata is != 0x0
- its type is STT_OBJECT and its size is set to the size of the actual
  table
- the indirect jump is annotated with a R_X86_64_NONE relocation
  pointing to the jump table

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 39 +++++++++++---------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 45b005935194..ba1cca66875b 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -93,10 +93,13 @@ SYM_FUNC_START(crc_pcl)
 #define    crc1		%r9
 #define    crc2		%r10
 
+	pushq	%rbp
 	pushq   %rbx
 	pushq   %rdi
 	pushq   %rsi
 
+	leaq	jump_table(%rip), %rbp
+
 	## Move crc_init for Linux to a different
 	mov     crc_init_arg, crc_init
 
@@ -168,9 +171,9 @@ SYM_FUNC_START(crc_pcl)
 	xor     crc2, crc2
 
 	## branch into array
-	leaq	jump_table(%rip), %bufp
-	movslq	(%bufp,%rax,4), len
-	addq	len, %bufp
+	movslq	(%rbp,%rax,4), %bufp
+	addq	%rbp, %bufp
+	.reloc	., R_X86_64_NONE, jump_table
 	JMP_NOSPEC bufp
 
 	################################################################
@@ -310,24 +313,11 @@ LABEL less_than_ %j			# less_than_j: Length should be in
 	popq    %rsi
 	popq    %rdi
 	popq    %rbx
+	popq    %rbp
         RET
 SYM_FUNC_END(crc_pcl)
 
 .section	.rodata, "a", @progbits
-        ################################################################
-        ## jump table        Table is 129 entries x 2 bytes each
-        ################################################################
-.align 4
-jump_table:
-	i=0
-.rept 129
-.altmacro
-JMPTBL_ENTRY %i
-.noaltmacro
-	i=i+1
-.endr
-
-
 	################################################################
 	## PCLMULQDQ tables
 	## Table is 128 entries x 2 words (8 bytes) each
@@ -462,3 +452,18 @@ K_table:
 	.long 0x45cddf4e, 0xe0ac139e
 	.long 0xacfa3103, 0x6c23e841
 	.long 0xa51b6135, 0x170076fa
+
+        ################################################################
+        ## jump table        Table is 129 entries x 2 bytes each
+        ################################################################
+.align 4
+jump_table:
+	i=0
+.rept 129
+.altmacro
+JMPTBL_ENTRY %i
+.noaltmacro
+	i=i+1
+.endr
+.size	jump_table, . - jump_table
+.type	jump_table, @object
-- 
2.47.0.rc0.187.ge670bccf7e-goog

