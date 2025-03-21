Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E1230BFB;
	Fri, 21 Mar 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589669; cv=none; b=dcmHkVrdEpo4OtT/va4Tj1uPq4IF7P7TxJ+d8kvRoqtNnMaJIf+QzaspdVew9+32cRLXo3bep31qLxqIvhEGO+MNho2dWrS+G06wpCiyhr0HetQIkYGRDeuRLYV/+VB7PXh0Me+TDsggx5LABiV/WdsUNIx2ImNQkQnLxDi3lzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589669; c=relaxed/simple;
	bh=pXkT7am0yPdv1f217KYbpZB7Vpb7nbz805ybospBIJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9GWmIsSLZ2kkG/RaNuO1dVYZ5q0cVdAmsR8xOdgXBe6m4ykamquu1vCcp0AgzCVRyUikrc4s+HHlqzOy88ggRPLtpzdj+qZtqjJ4NRWZSxFbbC57m9M98YBzZmVnS1QnlNKgePBmcRUhhd9CrHsaK5cAOnMXDGIACsJ7nfbZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq6FRsac; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq6FRsac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED03EC4CEEC;
	Fri, 21 Mar 2025 20:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742589669;
	bh=pXkT7am0yPdv1f217KYbpZB7Vpb7nbz805ybospBIJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nq6FRsactxGBEYHtLF3Za33uutSX27PtxKislPtxAwTqwMQ+zcr2Pnher41Tvum6B
	 2MOaTtLPlzws2XoXhOa/xU/E4DXa+FKn/vGZc9vfUk+t8/h5lqpJ/eSOzKiT84fzPT
	 vUpDmjlqWK5LNXSsjCZW3LOkMFBD7zzsWOlaTPS7uf0l8j1ELbatdPAbVIfI1egtjZ
	 qa/src68Zz9yI10j3UmXT1QTSzgrxUohavaH8Y/7BrXUcMQaxGUojp/YqxfwUUa7Hf
	 0duFvny7lEZ26T+ZnseYRDDE6O3AYCqS0VE58E++i0Lonsc1J5jF6zzEEKCzVV1PgR
	 yWliFNrMPyTww==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/5] compiler_types: Introduce __is_lvalue()
Date: Fri, 21 Mar 2025 13:40:59 -0700
Message-Id: <20250321204105.1898507-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321202620.work.175-kees@kernel.org>
References: <20250321202620.work.175-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=kees@kernel.org; h=from:subject; bh=pXkT7am0yPdv1f217KYbpZB7Vpb7nbz805ybospBIJs=; b=owGbwMvMwCVmps19z/KJym7G02pJDOl3z92xNW0r5P3/MeLSnvR0CZZtWdbr/5dHKHKuqdLay qwz5aNgRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQmVTEyvPh086Doky/nYrhe V8tftL7GnKNle7gx7YFvQXqK9tPeDIb/Cdzvpq39JNZ6hde6yu7FQpEkxr8qZt3HYo7wXCvqzvv FBQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

If __builtin_is_lvalue() is available, use it with __is_lvalue(). There
is patch to Clang to provide this builtin now[1].

Link: https://github.com/kees/llvm-project/commits/builtin_is_lvalue/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/compiler_types.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e09d323be845..eb016808dfa8 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -468,6 +468,16 @@ struct ftrace_likely_data {
 #define __annotated(var, attr)	__builtin_has_attribute(var, attr)
 #endif
 
+/*
+ * Determine if a given expression is an lvalue for potential
+ * assignment. Without the builtin, report nothing is an lvalue.
+ */
+#if __has_builtin(__builtin_is_lvalue)
+#define __is_lvalue(expr)	__builtin_is_lvalue(expr)
+#else
+#define __is_lvalue(expr)	false
+#endif
+
 /*
  * Some versions of gcc do not mark 'asm goto' volatile:
  *
-- 
2.34.1

