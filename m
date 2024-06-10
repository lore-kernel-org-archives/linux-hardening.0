Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122615588B;
	Mon, 10 Jun 2024 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053349; cv=none; b=or92NXRMPtLA5g5tVDUaLE5eH7tvNW9gMGzjG7WPQcqZ9Jf3pjAcHCYDN1iUKVHf+hJtW1xX/+fNbeNDZWt+ujllk2Nat/diuR8rRdA94ip7pGT22on0OCA4CqdYFG2tr7A5lvd6XeAEhmOWAwiqusqNzEsBM4xK+JKoYG/dvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053349; c=relaxed/simple;
	bh=I16quwF1+onTsrxMVkn0fm482Ug44s2XCPxSOXPFib4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YY4jVG+l0a9MoQ6Nl+tzG+A60rAvFNgxnvOrzAY4+LseIeDTQwMUpddWulf0AI/wYCgJ4qlESlf3P6XAkB9P8lbjGvQTy3a787CLQXFVM/VI/fcbZ7mUQBdJVYi4bEOotxK5lJJYh7ES2133t+5IhFqBFS/G1qc8d8zSve3jONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4ZBRl2c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4ZBRl2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0CEC2BBFC;
	Mon, 10 Jun 2024 21:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718053348;
	bh=I16quwF1+onTsrxMVkn0fm482Ug44s2XCPxSOXPFib4=;
	h=From:To:Cc:Subject:Date:From;
	b=n4ZBRl2cyXlJSIkF3gDY19EtyTFwwr9B5osJdmU/DHn4zYiwMscYm0B1Hr8ixIWnG
	 zd6+RbTbOT6W73b9T7mDPCXomSwptsEvihyMxduGJwQ/uO+I5z+1mWth47qP4ThrjI
	 asYfBHTCCwfcpaOXGQUhuXMPuPkcMscXDrG1kE90V2tPq1mmsF5EzE2WK0oxVdxLu5
	 qFng2XpMQuJMEQPSNvUShN+eyf9hmSv6hKP1Lq1+XyiRGidkJmQl16Ipf1xUB8ftPT
	 I1tpPeFayNRkqSdaDJuoJfiyiZfIeXb1fxNiEn20TQ2SbOxFIpJcM+LHA45OvlTUFv
	 +HUtoakhlBjJg==
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <kees@kernel.org>,
	David Gow <davidgow@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] x86/uaccess: Fix missed zeroing of ia32 u64 get_user() range checking
Date: Mon, 10 Jun 2024 14:02:27 -0700
Message-Id: <20240610210213.work.143-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3063; i=kees@kernel.org; h=from:subject:message-id; bh=I16quwF1+onTsrxMVkn0fm482Ug44s2XCPxSOXPFib4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmZ2nipwFiKWgGXL878DrUseiyOhJ2Ao6EyQM8T 7VpfqH0JIiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZmdp4gAKCRCJcvTf3G3A JkdMD/9hflgzdc0oXm2RKx/VwC9hgxSeI6zZKTCowRa5jYMzRQZWsyIB8Id6E9+Gqw6D5mF6HFq 96U4BJuw0yRhUqGY0OoA208ntVa4+V7/XiUyAGKwzeJlPdXi0Cm3yt/g4eRa4MAt/l7kmqDdWzu Xbq6J7Aa3lbMRp8iwVnUFySxICY7bZcTN6teAPVLrnzXFehQ/whEQBH7ajNbvCurobEc56ccQhm VS66uypQJui+rSaIvRClE0vU7oYajQhBQI+pxRTiKT9uNSNR5dIUoRvRx576MATVo205PPgAqnt AAsF6glC4qBmC/by4+K8lUbXV0mFtqLBeDKZeY8rtQsvBeHbZdl+3ETq8SdKQEEvWQwITRw9/B6 +HPdPyfh6KmJlrtIbY/xtNXleh02Hic5TnRcS+2RkOYr/IusZ1HWrCswW9HaeDqMRFzb4RxwijT uMKxaLzYjO0c/f/B94WKsUTHvhrEePfllv0IH6g79pUMxmiB7Jci6+Q2yxFY6dCZXDr77XT/QWX f017TxJ/YBAG2sO23NbfUTqGMTC+QEas4EVENCkyP6oW/Zn+oA2lrdzJXvTdvE4t2nMeVehPmAn /ZgGdI+iQSw1mnbsQEQ/ULN0vuo6MCpKPLl5r3ya7ZgDiYobtE0n5W8zC+QkMk5ugYopXo3wrDu 2+ezuQl3TBbfL
 Hg==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When reworking the range checking for get_user(), the get_user_8() case
on 32-bit wasn't zeroing the high register. (The jump to bad_get_user_8
was accidentally dropped.) Restore the correct error handling
destination (and rename the jump to using the expected ".L" prefix).

While here, switch to using a named argument ("size") for the call
template ("%c4" to "%c[size]") as already used in the other call
templates in this file.

Found after moving the usercopy selftests to KUnit:

      # usercopy_test_invalid: EXPECTATION FAILED at
      lib/usercopy_kunit.c:278
      Expected val_u64 == 0, but
          val_u64 == -60129542144 (0xfffffff200000000)

Reported-by: David Gow <davidgow@google.com>
Closes: https://lore.kernel.org/all/CABVgOSn=tb=Lj9SxHuT4_9MTjjKVxsq-ikdXC4kGHO4CfKVmGQ@mail.gmail.com
Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and put_user()")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
---
 arch/x86/include/asm/uaccess.h | 4 ++--
 arch/x86/lib/getuser.S         | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 0f9bab92a43d..3a7755c1a441 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -78,10 +78,10 @@ extern int __get_user_bad(void);
 	int __ret_gu;							\
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
-	asm volatile("call __" #fn "_%c4"				\
+	asm volatile("call __" #fn "_%c[size]"				\
 		     : "=a" (__ret_gu), "=r" (__val_gu),		\
 			ASM_CALL_CONSTRAINT				\
-		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
+		     : "0" (ptr), [size] "i" (sizeof(*(ptr))));		\
 	instrument_get_user(__val_gu);					\
 	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
 	__builtin_expect(__ret_gu, 0);					\
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 10d5ed8b5990..a1cb3a4e6742 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -44,7 +44,11 @@
 	or %rdx, %rax
 .else
 	cmp $TASK_SIZE_MAX-\size+1, %eax
+.if \size != 8
 	jae .Lbad_get_user
+.else
+	jae .Lbad_get_user_8
+.endif
 	sbb %edx, %edx		/* array_index_mask_nospec() */
 	and %edx, %eax
 .endif
@@ -154,7 +158,7 @@ SYM_CODE_END(__get_user_handle_exception)
 #ifdef CONFIG_X86_32
 SYM_CODE_START_LOCAL(__get_user_8_handle_exception)
 	ASM_CLAC
-bad_get_user_8:
+.Lbad_get_user_8:
 	xor %edx,%edx
 	xor %ecx,%ecx
 	mov $(-EFAULT),%_ASM_AX
-- 
2.34.1

