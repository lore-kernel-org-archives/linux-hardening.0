Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F32AE8D
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754025; cv=none; b=J8FLKB6+ObUaDd6kFeGeVbFQMPRUPgl6ZpQkytrQyVzpMUZIkFMRtSSRZCnjDTOzqzU06lqtq7MbwnIGj8uFQ2rPzQZRYLnagbanwCfVJ1dhS8QJZ23fL7aQrMltTAc3TTjEE8TRl/fZR9hEj4P158wYcJ9fGhUprC95JML6pxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754025; c=relaxed/simple;
	bh=MYCPdC5mx9elsFs5SLOof97idIHJHiNCqO7tF8T3XPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=reOxrUWuy2CcvBALiKvDEp73wTELnTgJ/f+7Se4W366hTPsfW5jzDfimFHXCXpVrJ/+Cy5PSAuWe5vOGZRUQl5AcZntkocg2ULniXYisjoQv+u7F6K5rIKRzdGF0GdcWrXH2UbpxTBVctGK/n26LSg/pzMfejIeONfxxpyrWCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRB8cUr/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRB8cUr/"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7bb2303fe94so2627867b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 11:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763754023; x=1764358823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHmgZO6ethqvsbdYO3ab/+ap1rYqr7kszhE/exMXa8o=;
        b=YRB8cUr/urL0fjbrFd/oH54JDlHYEgM57QSpgVENhrdkqVcJInWbkO5NDMMtnP2JL+
         p4btTlqm9f4LkhO33zGIWHrq+QGE+c1NuRFz+8AmQknocnybp+zqgCxOK/Csh63Yx4aO
         GKKOSZsL4Un19gY9qtpdTgh1Ps0zxyVTaLCIedtXtFOj+OUatiSI+gWfd/qYxGOOUOlP
         km5zaCn68IQ1mJwmvDufspkQeRBYt+40KSoquXtbYcS8hd120jeShT7DNDTiHIpEGfA2
         fkZizmMJzATdJ/8oP+093kajjae9cCjfY4EGVVBGwoZnnq9McI6uDO4Cg55eamQf5i6q
         Bpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763754023; x=1764358823;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oHmgZO6ethqvsbdYO3ab/+ap1rYqr7kszhE/exMXa8o=;
        b=NjWGlAsZsOISaouPF5cRFlpDsxSgaBc+fP+AtcSHBm+KiI/LwZdznEOPJ2D6O9QU0z
         4+opdtVs432BsJq94RRG9cLCCZrNxVyegekYul1Kcrgqxn9uSjwpA/8IZ5o180ReDFJX
         nh1qf5NaTZw38jG/eSoJiymm+FbNKE2QNdCqmK39GSsNaQeDy78RnLTt9dTq2sPltm2g
         XXHwpB9rw1Wp/GLQv19e8433TmMYLiWf9Z7MnQxWssVKlpBf6UUXRu+3aesWZZ4cBjPU
         mAWSvF61hQu0RrTHdHKLNN6IgtXR42wy6H99TUJzxVhynBnjzgFdgqipfpsgdPe0ahdY
         PIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX89etnSyVlNdAZC2shzgOEx+bAUSXTr4jWT/K6uqsmxJ1Mr6fB4l2ukxzECQVBhtqqdGTmLVR5WxFzwaYnKAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb99c3SZrjUsn9KKI8QT3w6SZpbeCGRddS6RjJhjj3xFJeMiE+
	/hr9LBd/RGW+JCGxid0TD4rOejYiuq0wOmqFSsx4Q0R8qCn+ow+OcjVKSgoF1YogRwb6xwajJrX
	o
X-Google-Smtp-Source: AGHT+IFih8IJ4RxuxQ2Hu+KI5Fa8rvFm0yb8dOgyZXKnABQhio/5PRYjKYWbcph5Yc9RmZLpsyq4X9QrgA==
X-Received: from pfbdf7.prod.google.com ([2002:a05:6a00:4707:b0:782:3712:63e4])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918e:b0:350:f9c5:f90c
 with SMTP id adf61e73a8af0-36150e995admr3760493637.27.1763754022557; Fri, 21
 Nov 2025 11:40:22 -0800 (PST)
Date: Fri, 21 Nov 2025 19:39:43 +0000
In-Reply-To: <20251121193957.1655580-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121193957.1655580-1-morbo@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121193957.1655580-2-morbo@google.com>
Subject: [PATCH 1/2] Compiler Attributes: Add __counted_by_ptr macro
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Marc Herbert <Marc.Herbert@linux.intel.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, John Stultz <jstultz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Brian Gerst <brgerst@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	Jan Hendrik Farr <kernel@jfarr.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Clang and GCC are expanding the '__counted_by' attribute to support
pointers in structs. Clang has support for it since version 21. This
requires defining a separate macro, '__counted_by_ptr', because, while
the attribute has the same name for both a pointer and a flexible array
member, minimal compiler versions need to catch up.

The effect of this feature is the same as for __counted_by on flexible
array members. It provides hardening the ability to perform run-time
bounds checking on otherwise unknown-size pointers.

Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Marc Herbert <Marc.Herbert@linux.intel.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Thomas Wei=C3=9Fschuh" <thomas.weissschuh@linutronix.de>
Cc: John Stultz <jstultz@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/compiler_types.h | 11 +++++++++++
 init/Kconfig                   |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.=
h
index 0a1b9598940d..2b0251bb951c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -351,6 +351,17 @@ struct ftrace_likely_data {
 # define __assume(expr)
 #endif
=20
+/*
+ * Optional: only supported since clang >=3D 21
+ *
+ * clang: https://github.com/llvm/llvm-project/pull/137250
+ */
+#ifdef CONFIG_CC_HAS_COUNTED_BY_FOR_POINTER
+#define __counted_by_ptr(member)	__attribute__((__counted_by__(member)))
+#else
+#define __counted_by_ptr(member)
+#endif
+
 /*
  * Optional: only supported since gcc >=3D 15
  * Optional: only supported since clang >=3D 18
diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..298c94c4c1b1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -139,6 +139,11 @@ config CC_HAS_COUNTED_BY
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108896
 	default y if CC_IS_GCC && GCC_VERSION >=3D 150100
=20
+config CC_HAS_COUNTED_BY_ON_POINTERS
+	bool
+	# Needs clang 21.1.0 or higher.
+	default y if CC_IS_CLANG && CLANG_VERSION >=3D 210100
+
 config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) =3D=
 { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
=20
--=20
2.52.0.rc2.455.g230fcf2819-goog

