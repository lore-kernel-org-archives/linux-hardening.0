Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378228A71B
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348257; cv=none; b=MPTYzSod1S8cznJCR7gN1MdKiqh2tkMRuvN1PAmvPBIVRe8THflfTBb6h2wFGAT1ma9Zl/mHY/sQatMzAXJv8+YVq3SUKCJYucEwOfXuP54ZSihcSDW/vYTZBwtwj55rC2CT/Ge5Hq6RWZ1e8955vylQXvuPXvzTPHokHbUKwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348257; c=relaxed/simple;
	bh=Df0aa5+ZsX8G5XgWy9KkYRMvV6mNc63BbHosX8eY4o8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OF7ZIum2JqStN6zRlNZZhABBZpmq0XagzTXPb4MhajwbBKplyOkNofCbYFIee7fVxkXO1ncZGZ4xt0umx2HPVuJ3Mm5jY63ZG6oot0XVZRTXaYS3T3/MnRbWF+sMneVLiUYmBm0TaDo03quVZW0o3VLMXPgn5eKoAZ28AwMLX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iw+jgmV8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw+jgmV8"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so2600129a12.0
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348255; x=1752953055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZxOvBgfnTHoyK5q4atsz+5YwCCAblpmi69RKSG15Xk=;
        b=iw+jgmV8wQNgWy/t+tdmvXb//Y/KH3KEDOk/Ql2UQolmJxSoCJXiki1QMxZ56q/vyJ
         QNFxhOAszCVLSk9VSoBU8V815AvxkTnL21GlcB3Bw710jJ+3bB6+RSkUimMlGzghcKGO
         Vq1CzSXTCkLAqumpWvSf+voatRlOJhyf1eQYBKwNhgAliSlEYYTJe8WlT3Uux4UC/MVr
         /HhcywJqAckF0UWaOqAhBklt3J3TtqoEDCpEYJwiUeI5jW9k1rd0Xm445t+LEcpbVmXd
         6PtlRe74LJd6KG9hZskaR72S/nOmzrwu7gstIWVxaGbmpoIp5xoJr9PTGfbW2q8bQXWM
         qstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348255; x=1752953055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZxOvBgfnTHoyK5q4atsz+5YwCCAblpmi69RKSG15Xk=;
        b=X+DWAqBNkkU10e53KKd3qyBvpunfOKstkbZSLDDzDYTqc+2tcnAD49yTank/PQwsmR
         PuQcYuwV5QHdVAxh92eIoAMCRK3IkmQ/x0YcFQGg+cHmvnfBtiJMdxlVdFk9ph3t+ls+
         ww/mYZQEiCLvETV3YX8Z+XPN7YNPjTNIvycME2owZJbcmyZUwZtEIy8z9CdpVF7CYvIN
         7Awl7Aeaa/ntTMdEyqimeeY6wP4MVb48dylu07+dvYn4r0CJHZyiQZ1IjtdYH5MTLQeQ
         vAsI1NQvoj7MDrN9ZcBa3hWAPm6EZShaXgyny6w7dk6RZHeR4bw+DYLIOuD2jMSKxFmm
         Zs7w==
X-Gm-Message-State: AOJu0Yy3pHo8ODEBMooGipV4UI3IbC1RmPAKkhcF87jSRrWQGTczk9vl
	bSv2q7kPtqjgFd4vkF1H09y3oyB3NBNdNJUzp0bMUtOSgDZKZwaCM/duciXI0MK2
X-Gm-Gg: ASbGncsgwmChq3vY7OL1/0w4KtjYsUk+rLnndwKgynEioZsfMjOOQylD6q7BvNs5fa9
	RfNpPlYCtjYGTKYm5Mj8zhY5oGOJbEWKvuy/P0UuGoQMpKgaBVP/FIRme5vXy3Vah2VKWPG/9Xk
	CB8VVKKzwS3UB7LOfKbI4i7UBuO81lJWfYP/WkGJwt13pV6ZenSLOdz7wryvr/kin8WdMsq3Fk5
	fBfxKcavSPGPDXR9h4pNv4sul0JkhzK+Y0BVtXzndJaYrlMo8e0Hpe3HPwBVQ/wxevckCbO/7su
	ERplFuupPPt68ANOOFVif5IlsyNY3zij2R0UloNnNFsoJQoJdMW9FG4vuLL5qbaEzFd1B6ChT7w
	r5eau9em7ZKTJGFOtH6dVpslOeIfJiJE6iVRhUHC1w5xz
X-Google-Smtp-Source: AGHT+IG1pm23kl93dUAP3AMLsEQnFGEl+XxqNLz0GWRijyKWTJvZIraVIuMCEDYwg9qHnmjbGXedYA==
X-Received: by 2002:a17:902:c40b:b0:235:f632:a4d5 with SMTP id d9443c01a7336-23df07d6008mr92717225ad.9.1752348254666;
        Sat, 12 Jul 2025 12:24:14 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:14 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 03/17] x86: asm: support caching in do_get_user_call()
Date: Sat, 12 Jul 2025 19:21:48 +0000
Message-Id: <20250712192202.707192-4-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Adds various caching functions with different sizes alongside a macro to
select the smallest possible caching function to enable caching of user
calls to protect against time-of-check to time-of-use bugs.
---
 arch/x86/include/asm/uaccess.h    | 211 ++++++++++++++++++++++++++++--
 arch/x86/include/asm/uaccess_64.h |  54 ++++++++
 2 files changed, 254 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..9096aaec5482 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -73,27 +73,215 @@ extern int __get_user_bad(void);
  * Clang/LLVM cares about the size of the register, but still wants
  * the base register for something that ends up being a pair.
  */
+
+#ifdef CONFIG_SAFEFETCH
+#include <linux/safefetch.h>
+#include <linux/safefetch_static_keys.h>
+
+extern int df_get_user1(unsigned long long user_src, unsigned char user_val,
+			unsigned long long kern_dst);
+extern int df_get_user2(unsigned long long user_src, unsigned short user_val,
+			unsigned long long kern_dst);
+extern int df_get_user4(unsigned long long user_src, unsigned int user_val,
+			unsigned long long kern_dst);
+extern int df_get_user8(unsigned long long user_src, unsigned long user_val,
+			unsigned long long kern_dst);
+extern int df_get_useru8(unsigned long long user_src, unsigned long user_val,
+			 unsigned long long kern_dst);
+
+// This macro returns the smallest possible get_user function based on value x
+#define __dfgetuserfunc(x)							\
+	__dfgetuserfuncfits(x, char, df_get_user1,				\
+		__dfgetuserfuncfits(x, short, df_get_user2,			\
+			__dfgetuserfuncfits(x, int, df_get_user4,			\
+				__dfgetuserfuncfits(x, long, df_get_user8,	\
+							df_get_useru8))))
+
+// This macro will deduce the best double fetch get_user protection function,
+// based on the register content
+#define __dfgetuserfuncfits(x, type, func, not) \
+	__builtin_choose_expr(sizeof(x) <= sizeof(type), func, not)
+
+
+//#define GET_USER_CALL_CHECK(x) (likely(!x) && !IS_WHITELISTED(current))
+#define GET_USER_CALL_CHECK(x) likely(!x)
+
+
+// fn  = get_user function name template
+// x   = destination
+// ptr = source
+#define do_get_user_call(fn, x, ptr)					     \
+({ \
+	/* __ret_gu = the return value from the copy from user function */	\
+	int __ret_gu;								     \
+	/*	register  = compiler hint to store it into a register instead of RAM
+	 *	__inttype = func that gets the smallest variable type that fits the source
+	 *	__val_gu  = intermediate storage of user obtained variable
+	 *	Obtain a register with a size equal to *ptr and store the user data pointer inside it
+	 */ \
+	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX); \
+	/* Sparse integrity check, checks is a ptr is in fact a pointer to user space */ \
+	__chk_user_ptr(ptr);							 \
+	/* asm		    := assembly instruction
+	 * volatile		    := no optimizations
+	 *
+	 * Assembler template:
+	 * "call"	       := issue a call assembly instruction
+	 * "__" #fn "_%P4" := stringbuilder that creates the right __get_user_X function name
+	 *			  based on size of ptr
+	 * %P4	       := Take fourth variable value as literal string
+	 *
+	 * Output operands:
+	 * "=a" (__ret_gu)	   := overwrite (=) the address register (a) __ret_gu
+	 * "=r" (__val_gu)	   := overwrite (=) the general register (r) __val_gu
+	 * ASM_CALL_CONSTRAINT := Constraint that forces the right execution order of inline asm
+	 *
+	 * Input operands:
+	 * "0" (ptr)	    := first argument, the user space source address
+	 * "i" (sizeof(*(ptr))) := second argument, the size of user space data that must be copied
+	 *
+	 * This function calls one of the __get_user_X functions based on the size of the ptr data
+	 * This copies the data from user space into the temporary variable __val_gu
+	 * The result of this operation is stored in the variable __ret_gu
+	 */ \
+	asm volatile("call __" #fn "_%P4"						  \
+		     : "=a" (__ret_gu), "=r" (__val_gu),				  \
+			ASM_CALL_CONSTRAINT						  \
+		     : "0" (ptr), "i" (sizeof(*(ptr))));				  \
+	instrument_get_user(__val_gu);					\
+	/* Casts the variable inside __val_gu to the correct type and stores it inside
+	 * the kernel destination 'x'
+	 */ \
+	(x) = (__force __typeof__(*(ptr))) __val_gu;									  \
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_copy_from_user_key) {					   \
+		if (GET_USER_CALL_CHECK(__ret_gu)) {											      \
+			__ret_gu = __dfgetuserfunc(*(ptr))((unsigned long long)(ptr), __val_gu, (unsigned long long)(&x)) ;	  \
+		}														  \
+	}														  \
+	/* Integrity check that expects a 0 as value for __ret_gu (call successful) */ \
+	__builtin_expect(__ret_gu, 0);					    \
+})
+
+// fn  = get_user function name template
+// x   = destination
+// ptr = source
+#define do_get_user_call_no_dfcache(fn, x, ptr)					     \
+({ \
+	/* __ret_gu = the return value from the copy from user function */	\
+	int __ret_gu;								     \
+	/*	register  = compiler hint to store it into a register instead of RAM		      \
+	 *	__inttype = func that gets the smallest variable type that fits the source	      \
+	 *	__val_gu  = intermediate storage of user obtained variable			      \
+	 *	Obtain a register with a size equal to *ptr and store the user data pointer inside it \
+	 */ \
+	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX); \
+	/* Sparse integrity check, checks is a ptr is in fact a pointer to user space */ \
+	__chk_user_ptr(ptr);							 \
+	/* asm		    := assembly instruction
+	 * volatile		    := no optimizations
+	 *
+	 * Assembler template:
+	 * "call"	       := issue a call assembly instruction
+	 * "__" #fn "_%P4" := stringbuilder that creates the right __get_user_X function name
+	 *			  based on size of ptr
+	 * %P4	       := Take fourth variable value as literal string
+	 *
+	 * Output operands:
+	 * "=a" (__ret_gu)	   := overwrite (=) the address register (a) __ret_gu
+	 * "=r" (__val_gu)	   := overwrite (=) the general register (r) __val_gu
+	 * ASM_CALL_CONSTRAINT := Constraint that forces the right execution order of inline asm
+	 *
+	 * Input operands:
+	 * "0" (ptr)	    := first argument, the user space source address
+	 * "i" (sizeof(*(ptr))) := second argument, the size of user space data that must be copied
+	 *
+	 * This function calls one of the __get_user_X functions based on the size of the ptr data
+	 * This copies the data from user space into the temporary variable __val_gu
+	 * The result of this operation is stored in the variable __ret_gu
+	 */ \
+	asm volatile("call __" #fn "_%P4"				    \
+		     : "=a" (__ret_gu), "=r" (__val_gu),		\
+			ASM_CALL_CONSTRAINT					    \
+		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
+	/* Casts the variable inside __val_gu to the correct type and stores it inside
+	 * the kernel destination 'x'
+	 */ \
+	instrument_get_user(__val_gu);					\
+	(x) = (__force __typeof__(*(ptr))) __val_gu;	    \
+	/* Integrity check that expects a 0 as value for __ret_gu (call successful) */ \
+	__builtin_expect(__ret_gu, 0);					    \
+})
+
+#define get_user_no_dfcache(x, ptr) ({ might_fault(); do_get_user_call_no_dfcache(get_user, x, ptr); })
+
+#define __get_user_no_dfcache(x, ptr) do_get_user_call_no_dfcache(get_user_nocheck, x, ptr)
+
+#define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
+#define unsafe_get_user_no_dfcache(x, p, e) unsafe_op_wrap(__get_user_no_dfcache(x, p), e)
+
+#else
+
+
+// fn  = get_user function name template
+// x   = destination
+// ptr = source
 #define do_get_user_call(fn,x,ptr)					\
 ({									\
+	/* __ret_gu = the return value from the copy from user function */	\
 	int __ret_gu;							\
+	/*	register  = compiler hint to store it into a register instead of RAM		      \
+	 *	__inttype = func that gets the smallest variable type that fits the source	      \
+	 *	__val_gu  = intermediate storage of user obtained variable			      \
+	 *	Obtain a register with a size equal to *ptr and store the user data pointer inside it \
+	 */ \
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
+	/* Sparse integrity check, checks is a ptr is in fact a pointer to user space */ \
 	__chk_user_ptr(ptr);						\
+	/* asm		    := assembly instruction
+	 * volatile		    := no optimizations
+	 *
+	 * Assembler template:
+	 * "call"		    := issue a call assembly instruction
+	 * "__" #fn "_%c[size]" := stringbuilder that creates the right __get_user_X function name
+	 *			       based on size of ptr
+	 * %c[size]		    := Take fourth variable value as literal string with
+	 *			       named argument size per 8c860ed
+	 *
+	 * Output operands:
+	 * "=a" (__ret_gu)	   := overwrite (=) the address register (a) __ret_gu
+	 * "=r" (__val_gu)	   := overwrite (=) the general register (r) __val_gu
+	 * ASM_CALL_CONSTRAINT := Constraint that forces the right execution order of inline asm
+	 *
+	 * Input operands:
+	 * "0" (ptr)	    := first argument, the user space source address
+	 * "i" (sizeof(*(ptr))) := second argument, the size of user space data that must be copied
+	 *
+	 * This function calls one of the __get_user_X functions based on the size of the ptr data
+	 * This copies the data from user space into the temporary variable __val_gu
+	 * The result of this operation is stored in the variable __ret_gu
+	 */ \
 	asm volatile("call __" #fn "_%c[size]"				\
 		     : "=a" (__ret_gu), "=r" (__val_gu),		\
 			ASM_CALL_CONSTRAINT				\
 		     : "0" (ptr), [size] "i" (sizeof(*(ptr))));		\
 	instrument_get_user(__val_gu);					\
+	/* Casts the variable inside __val_gu to the correct type and stores it inside
+	 * the kernel destination 'x'
+	 */ \
 	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
+	/* Integrity check that expects a 0 as value for __ret_gu (call successful) */ \
 	__builtin_expect(__ret_gu, 0);					\
 })
 
-/**
+#endif
+
+/*
  * get_user - Get a simple variable from user space.
- * @x:   Variable to store result.
+ * @x:	 Variable to store result.
  * @ptr: Source address, in user space.
  *
  * Context: User context only. This function may sleep if pagefaults are
- *          enabled.
+ *	    enabled.
  *
  * This macro copies a single simple variable from user space to kernel
  * space.  It supports simple types like char and int, but not larger
@@ -107,13 +295,15 @@ extern int __get_user_bad(void);
  */
 #define get_user(x,ptr) ({ might_fault(); do_get_user_call(get_user,x,ptr); })
 
-/**
+
+
+/*
  * __get_user - Get a simple variable from user space, with less checking.
- * @x:   Variable to store result.
+ * @x:	 Variable to store result.
  * @ptr: Source address, in user space.
  *
  * Context: User context only. This function may sleep if pagefaults are
- *          enabled.
+ *	    enabled.
  *
  * This macro copies a single simple variable from user space to kernel
  * space.  It supports simple types like char and int, but not larger
@@ -130,7 +320,6 @@ extern int __get_user_bad(void);
  */
 #define __get_user(x,ptr) do_get_user_call(get_user_nocheck,x,ptr)
 
-
 #ifdef CONFIG_X86_32
 #define __put_user_goto_u64(x, addr, label)			\
 	asm goto("\n"					\
@@ -190,11 +379,11 @@ extern void __put_user_nocheck_8(void);
 
 /**
  * put_user - Write a simple value into user space.
- * @x:   Value to copy to user space.
+ * @x:	 Value to copy to user space.
  * @ptr: Destination address, in user space.
  *
  * Context: User context only. This function may sleep if pagefaults are
- *          enabled.
+ *	    enabled.
  *
  * This macro copies a single simple value from kernel space to user
  * space.  It supports simple types like char and int, but not larger
@@ -209,11 +398,11 @@ extern void __put_user_nocheck_8(void);
 
 /**
  * __put_user - Write a simple value into user space, with less checking.
- * @x:   Value to copy to user space.
+ * @x:	 Value to copy to user space.
  * @ptr: Destination address, in user space.
  *
  * Context: User context only. This function may sleep if pagefaults are
- *          enabled.
+ *	    enabled.
  *
  * This macro copies a single simple value from kernel space to user
  * space.  It supports simple types like char and int, but not larger
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c8a5ae35c871..b588c5248c6d 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -135,11 +135,65 @@ copy_user_generic(void *to, const void *from, unsigned long len)
 	return len;
 }
 
+#ifdef CONFIG_SAFEFETCH
+#include <linux/safefetch.h>
+
+#ifdef SAFEFETCH_STATIC_KEYS
+#include <linux/safefetch_static_keys.h>
+static __always_inline __must_check unsigned long
+raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
+{
+	if (static_branch_unlikely(&safefetch_copy_from_user_key)) {
+		// Insert user data into protection mechanism and then into the kernel destination
+		return df_copy_from_user((unsigned long long)src, (unsigned long long)dst, size);
+	} else {
+		return copy_user_generic(dst, (__force void *)src, size);
+	}
+}
+#else
 static __always_inline __must_check unsigned long
 raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
+{
+	// Insert user data into protection mechanism and then into the kernel destination
+	return df_copy_from_user((unsigned long long)src, (unsigned long long)dst, size);
+}
+#endif
+
+#ifdef SAFEFETCH_PIN_BUDDY_PAGES
+#ifdef SAFEFETCH_STATIC_KEYS
+#include <linux/safefetch_static_keys.h>
+static __always_inline __must_check unsigned long
+raw_copy_from_user_pinning(void *dst, const void __user *src, unsigned long size)
+{
+	if (static_branch_unlikely(&safefetch_copy_from_user_key)) {
+		// Insert user data into protection mechanism and then into the kernel destination
+		return df_copy_from_user_pinning((unsigned long long)src, (unsigned long long)dst, size);
+	} else {
+		return copy_user_generic(dst, (__force void *)src, size);
+	}
+}
+#else
+static __always_inline __must_check unsigned long
+raw_copy_from_user_pinning(void *dst, const void __user *src, unsigned long size)
+{
+	// Insert user data into protection mechanism and then into the kernel destination
+	return df_copy_from_user_pinning((unsigned long long)src, (unsigned long long)dst, size);
+}
+#endif
+#endif
+
+static __always_inline __must_check unsigned long
+raw_copy_from_user_no_dfcache(void *dst, const void __user *src, unsigned long size)
 {
 	return copy_user_generic(dst, (__force void *)src, size);
 }
+#else
+static __always_inline __must_check unsigned long
+raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
+{
+	return copy_user_generic(dst, (__force void *)src, size);
+}
+#endif
 
 static __always_inline __must_check unsigned long
 raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
-- 
2.25.1

