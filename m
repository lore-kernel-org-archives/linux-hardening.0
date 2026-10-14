Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C63AC0DD;
	Wed, 14 Oct 2026 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792018701; cv=none; b=Nq2S1dbRGUOVDddPcju+OQdLftc9IdUrMS/T7cG7dNTvgdxEBbl7Y/G/DE4/FcyAtCmjQN9M9r5flaJWNJSE8TzmrEVHYLjRfaUiZEijzDC+tFd6Fknwvrf6ilsu2e4N1m9l1RHcnviuVlJPpGuQwaWecGVJASp+brgxTlZ3b0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792018701; c=relaxed/simple;
	bh=fayS1IsvfI/a6hkjc/2WtcL99qkaA9BSMYKKgp1sPZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3ctJbJdyQLyT871CopBvFOTTisPBPEYBSJVX4NiIi3Nip1n/m4aivF4ZvieUAKUJrOPzoz6Yfph3TskWVylCGpHktfgJFwr3zB4t8N9FHZFQNakd11NBgADqtX1kWCYdgvsEpfD/SliMZnKuS4iadwo1fZUi9cBh5Yy/aXZ7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5CSnVpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5CSnVpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237601F000C5;
	Wed, 14 Oct 2026 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792018699;
	bh=lxQYzEVBvXOXocjMZoNpLiRnJBxzMGxRySKFZ+2h5dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c5CSnVpyFWGe7N2F0yEfhYxmWMsfu1gy0JJJdX9yLFBKuolyU543RFahoatfjetWs
	 ja6FZncG7TaSI763r1C68FmK2gRuhSCO6nTIrT4+iXxgmH/4WHfHiR50Lqmfzt/z3r
	 6iyhS98h9xgM9nt2BKB2SEaT7PpfpMgIDq/iOlcAjvktYXVJ4TDPBXXD+tdGQE8wxG
	 vE0Mj/piSP8xf2ZYvxfxxIDV/5cIpLpetVvV3K5oaaS0+Q1jqXNLXOOfGQaoGdF6UZ
	 xzXv3wCXS3xdSiOtzNEGzosdvtdxYNYnpHhfeOiscMy4ZkG3wptxc1YjMpUU0YDwO9
	 NOV/IzTAnXnfQ==
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	llvm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] Compiler Attributes: Add __require_explicit_initialization macro
Date: Wed, 14 Oct 2026 15:58:15 -0700
Message-ID: <20261014225818.3457479-1-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014225811.i.852-kees@kernel.org>
References: <20261014225811.i.852-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3809; i=kees@kernel.org; h=from:subject; bh=XyxphQYrpxk0PsdbXh+Mbf71UMdCnvnfDdbeL7EBERc=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkXODmun2I+/Y3rRt7aGZ2dM5psTxicmJ9XqSEgFt+5y bp+xgyJjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkcKmdk+GF+OfNT1Z5kI122 6G8BftMuZc6puVfpe98n5ZqM+JyOLYwMNzKYz6175Faz+WGY/JGVNo3r/N/Una/9/PohV2Ncos8 OZgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

Clang supports the 'require_explicit_initialization' attribute on struct
fields to indicate that a field must be initialized explicitly by the
user when the object is constructed. When an aggregate initializer or
uninitialized variable omits an annotated field, Clang emits a
-Wuninitialized-explicit-init warning (enabled by default).

Add the __require_explicit_initialization macro to
include/linux/compiler_attributes.h (which is included by
include/linux/compiler_types.h and include/linux/compiler.h) so kernel
structs with error-prone initialization (such as mandatory callbacks or
cleanup handlers) can enforce explicit initialization at compile time,
as discussed at the Linux Plumbers Conference.

Also teach Sphinx (Documentation/conf.py), kernel-doc
(tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
attribute macro.

Link: https://lpc.events/event/20/contributions/2392/
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 scripts/checkpatch.pl                 |  1 +
 Documentation/conf.py                 |  1 +
 include/linux/compiler_attributes.h   | 12 ++++++++++++
 tools/lib/python/kdoc/xforms_lists.py |  1 +
 4 files changed, 15 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8a7787d228a6..4a3ae6b0100a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6871,6 +6871,7 @@ sub process {
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
 				"pure"				=> "__pure",
+				"require_explicit_initialization" => "__require_explicit_initialization",
 				"section"			=> "__section",
 				"used"				=> "__used",
 				"weak"				=> "__weak"
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 5ab26ce89daf..3e5cb9ca0970 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -203,6 +203,7 @@ c_id_attributes = [
     "__noreturn",
     "__packed",
     "__pure",
+    "__require_explicit_initialization",
     "__section",
     "__always_unused",
     "__maybe_unused",
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 476c4c560d17..625e95e684c7 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -322,6 +322,18 @@
  */
 #define __pure                          __attribute__((__pure__))
 
+/*
+ * Optional: not supported by gcc
+ * Optional: only supported since clang >= 20.0
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#require-explicit-initialization
+ */
+#if __has_attribute(__require_explicit_initialization__)
+# define __require_explicit_initialization __attribute__((__require_explicit_initialization__))
+#else
+# define __require_explicit_initialization
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index e3dda2fe8a53..32066fbbe763 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -36,6 +36,7 @@ class CTransforms:
         (CMatch("CRYPTO_MINALIGN_ATTR"), ""),
         (CMatch("__private"), ""),
         (CMatch("__rcu"), ""),
+        (CMatch("__require_explicit_initialization"), ""),
         (CMatch("____cacheline_aligned_in_smp"), ""),
         (CMatch("____cacheline_aligned"), ""),
         (CMatch("__cacheline_group_(?:begin|end)"), ""),
-- 
2.55.0

