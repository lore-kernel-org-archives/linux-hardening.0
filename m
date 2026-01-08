Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182904421F2;
	Thu,  8 Jan 2026 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864502; cv=none; b=W5Gi9pzhTLTl+I6tZVe3WUagS8Z/e2GVxPzMEBQaLtSN7GJzbUJMlnMuIhLBSeBvIj944iOf6Juc3yKam1PV4Kjex6E3Qw5KlFL03UgKm34yael2GlgfiCfu0B56xq+ONX250cYzGCIQa+YjxBZHdx/kYtdsom1G3VvOgyM2aFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864502; c=relaxed/simple;
	bh=/BtjUWOyZ/3/vfhUotVltmewpoPbkrRlDaS6WEUcZbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNF1YswGKGzkl0rTEdmY725wdOQRALZ8PPh+szHuUqgBhd0EwPpvM/103xDPTIp1CG4XZNe9or5/klWyykp2MEQd1AuLAOD7NwcBpqWcR/ktLhhh7qySgjImwgvzA664iy5CfhJHY3ma/ofGAPgbiRdPPtDW89JZb+lhfwQd63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj0eoQgC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj0eoQgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F140C116C6;
	Thu,  8 Jan 2026 09:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864501;
	bh=/BtjUWOyZ/3/vfhUotVltmewpoPbkrRlDaS6WEUcZbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kj0eoQgCaFA+B3BDB9y2qLhYFwWKesn4a2cAHf+fYS+Zun4sT0i0vR4TFreWKupOZ
	 dflioyrissrScaocYIX1Z2r4ovYuXzATPsaZTawg+/SAPFTqVS8MZYdwd4Cr7T1fqa
	 G/5rus4xMLc3kEIsFK22eefjKSJucP2FGgITzIaslXZ+tt7h+I+sCqfB7n3Zr6dSAe
	 9EAAJEGnBJJfzrq6C1VARWYHDaswl76UjsX/+dKbOR9EgOWBdpFffqW6+JBZ7FEWtu
	 zx7oV4mpe2mMK1PQ4ogFU7DeSpKzlH0f7PcWGfI/89ML1sHT3LYqJnnNcR2fkAH+Z6
	 YZFy9SdCv7Jjw==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC/RFT PATCH 09/19] x86/pm-trace: Use RIP-relative accesses for .tracedata
Date: Thu,  8 Jan 2026 09:25:36 +0000
Message-ID: <20260108092526.28586-30-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=ardb@kernel.org; h=from:subject; bh=/BtjUWOyZ/3/vfhUotVltmewpoPbkrRlDaS6WEUcZbA=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+QvhjvMdcoeSbokebHJW2X9rGHJmjnS+lcILbII47V C7I6HNHKQuDGBeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmMjxm4wMN1MjK1ccPfDFP+h6 lvu+Yt1Lr887+rX5LWTN9vYMK0hIZPgrKm68/33XO9VDoi7d73tbGn71bOYpNo4P/+O1wbFh5Td uAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Use RIP-relative accesses and 32-bit offsets for .tracedata, to avoid
the need for relocation fixups at boot time. This is a prerequisite for
PIE linking, which only permits 64-bit wide loader-visible absolute
references.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/pm-trace.h | 4 ++--
 drivers/base/power/trace.c      | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pm-trace.h b/arch/x86/include/asm/pm-trace.h
index bfa32aa428e5..123faf978473 100644
--- a/arch/x86/include/asm/pm-trace.h
+++ b/arch/x86/include/asm/pm-trace.h
@@ -8,10 +8,10 @@
 do {								\
 	if (pm_trace_enabled) {					\
 		const void *tracedata;				\
-		asm volatile(_ASM_MOV " $1f,%0\n"		\
+		asm volatile("lea " _ASM_RIP(1f) ", %0\n"	\
 			     ".section .tracedata,\"a\"\n"	\
 			     "1:\t.word %c1\n\t"		\
-			     _ASM_PTR " %c2\n"			\
+			     ".long %c2 - .\n"			\
 			     ".previous"			\
 			     :"=r" (tracedata)			\
 			     : "i" (__LINE__), "i" (__FILE__));	\
diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index d8da7195bb00..111be5825529 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -167,7 +167,7 @@ EXPORT_SYMBOL(set_trace_device);
 void generate_pm_trace(const void *tracedata, unsigned int user)
 {
 	unsigned short lineno = *(unsigned short *)tracedata;
-	const char *file = *(const char **)(tracedata + 2);
+	const char *file = offset_to_ptr((int *)(tracedata + 2));
 	unsigned int user_hash_value, file_hash_value;
 
 	if (!x86_platform.legacy.rtc)
@@ -187,9 +187,9 @@ static int show_file_hash(unsigned int value)
 
 	match = 0;
 	for (tracedata = __tracedata_start ; tracedata < __tracedata_end ;
-			tracedata += 2 + sizeof(unsigned long)) {
+			tracedata += 2 + sizeof(int)) {
 		unsigned short lineno = *(unsigned short *)tracedata;
-		const char *file = *(const char **)(tracedata + 2);
+		const char *file = offset_to_ptr((int *)(tracedata + 2));
 		unsigned int hash = hash_string(lineno, file, FILEHASH);
 		if (hash != value)
 			continue;
-- 
2.47.3

