Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D501CF7AD
	for <linux-hardening@vger.kernel.org>; Fri, 11 Oct 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666563; cv=none; b=T5HyO+5iejFIK6q5Fk0KfA7oKrjYyHL5tnYyvrcxZd4yutgaMxl+CG/0ZG84rMkFKHMZO3iQaK1K+7xkGClTO5AoEZgOIZRecQIujOqA5mQRk3ljZBYdipVOv0oXzy84093S7seuSwOD1pSJajHUcYRsn0N41yZTFlbo3roXA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666563; c=relaxed/simple;
	bh=2PjQVk510tcbfgZib7AgPxWnnYDh0QAwPChoXMnvxLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rz/OY2c79yAFBFWIkQm70/I+pHUscuvJzSLQH6ioqYJqSv1s8TSd9WCLe43sUnyOeUcREB8WNfTbtkB98OH6E3RwWbaY9Gy3CrlSsNu9QhqcwqiUv1cU1Kw9QfVt9poq1FP31O2IkivF6OMOgImbZOLo8lyRjRyhwFK5QFm3nQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pU1pj/n; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pU1pj/n"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2904a54a10so3227301276.3
        for <linux-hardening@vger.kernel.org>; Fri, 11 Oct 2024 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666561; x=1729271361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqKDRpMnKUFDCBzPjda6uGGHQMDnCKHOVUyUzH1aSkY=;
        b=0pU1pj/nOtxR1b9qf2oydny5YZiBFCdQo/bvL3t88g7ESgUDmCE/fsPperThBrJ2zo
         gG2YBaNw3RhQJvX6ZisFZaTh0Ww2aEWf92dNWu6JraqfmQrzY1V7+izF5f/r7ZaoNv09
         m80IuAaZqqmBMZp1kts535w08WCVKnd27Eupw58j7n29ULi2lwzuzIuLGudfC5IKqPt0
         MD3N6QW/Kaes6pAWRSry8svpJi4+qXUqkN7kCwOLPHFIwTEaDXpu6Pf4mMeiiysRPHyn
         COZWh6+3/x5gSijXPABL+JM5ZtmVKtI/icuaD/vujC2UYo0FYpSR8S+pxHjzdpvhl9g1
         Q9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666561; x=1729271361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqKDRpMnKUFDCBzPjda6uGGHQMDnCKHOVUyUzH1aSkY=;
        b=ssqhfUvL9UuB3Q8wNfv3VW5ZOCc1PvffZLEZpAVon05+X1aI+NtJknGjhtpeRQNifU
         3Y0UXRpmwK9737GVBnEPDyeNzq6uwrE8vShAzGkPePSiyDBvVXqNTb4kha0c65isvmV2
         G8GXOWMXkG6rjtW8hC/j+b5/fVlwmhnZ0H0M1HdDxBTAOVtewtRpXZQgy15q8n6yPv5F
         DxcfVEBPMd7sAZdYC6/NELWT4oAU+IwzQP87pvS3elhlAyPgrjRIHABsJRCEGP6UBRRB
         5KkVv+CZDRSTxAfkd5eGdPiOdrhl75YXEWYJio4ZQnM/w4mpAAOFqyhOVZ5hACu/Nywy
         evXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJFtEXa6Or/CPq7sR7B3Z4MU8nXLDOHa8Qhidcr7WsCZZ6Y2YQ/rOmeqFV0qNjZpvnuHpQMDKAg4Qbt5+dhbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXXG/J50Rcp9trJROnSVWmJhwPO3yOXvI265g2h3ZqZPyiyj/B
	1f2Ms3QVaLn0rFI2GN3VkNR5f1PPH+WczAcPMdBNO11BIjD9EXnf/UGhndyHusDeXc85hg==
X-Google-Smtp-Source: AGHT+IGig0d5gAOPvWubCGMNO+HS6pD/uIfah+XgCdryUbEN/NLF/DgvzT5KU18B+Vqf6kzsVXzoL8F5
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:ef0c:0:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e2919c5a54bmr1972276.1.1728666560536; Fri, 11 Oct 2024 10:09:20
 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:08:55 +0200
In-Reply-To: <20241011170847.334429-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011170847.334429-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=ardb@kernel.org;
 h=from:subject; bh=O1XJt0IMD45pv2Yzif9KcFzsw4OlwGa7+DE3CnbJzlw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0zehXXKTcG3hKH5ilqN7VPNj45fmOiRemqqZWcpXs++
 IUkec3qKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNhM2JkeLw7Ybp/inLsketP
 lx1a+fIA5+GjMSmi/rejKnVb7vCfPMXwPyxi5YQ3XxViDx1bJ8Bs1tXxo+r6YkO91rWPWL/sCUt N4wEA
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011170847.334429-17-ardb+git@google.com>
Subject: [PATCH v3 7/8] crypto: x86/crc32c - Add jump table annotation
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Annotate the indirect jump with a relocation that correlates it with the
jump table emitted into .rodata. This helps objtool identify the jump
table, allowing it to infer the places in the code that are reachable
from the jump.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 45b005935194..7292090e76dd 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -171,6 +171,7 @@ SYM_FUNC_START(crc_pcl)
 	leaq	jump_table(%rip), %bufp
 	movslq	(%bufp,%rax,4), len
 	addq	len, %bufp
+	.reloc	., R_X86_64_NONE, jump_table
 	JMP_NOSPEC bufp
 
 	################################################################
@@ -327,6 +328,8 @@ JMPTBL_ENTRY %i
 	i=i+1
 .endr
 
+.size	jump_table, . - jump_table
+.type	jump_table, @object
 
 	################################################################
 	## PCLMULQDQ tables
-- 
2.47.0.rc1.288.g06298d1525-goog

