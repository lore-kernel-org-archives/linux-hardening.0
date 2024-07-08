Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2ED14B956;
	Mon,  8 Jul 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466321; cv=none; b=UGp9TqUJeIkqUAgoEas4w0/i3NZWzfwV+ON9NOhrUeL3yNqVTzNF5PfAM5bD4rI3dG/IpuVrNsZ2yNFuz/YqLNVo9aTHdJQ2EtBOyMAFhTtH2w/A4dUfW26QiAoX3S5OO8y9RWQMJLGvrdHabINEHSeq68jAZYl0koreHfpX+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466321; c=relaxed/simple;
	bh=O6uIF+RFb01/GkReF4c6yk0p7sEtVWsPKR+FVmZnPi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ML7bGwrgvlIfgBYHPgHEPSYoL3DM1Z5TqfL7sjBv2iDbhnLSXS6+tlZiBMcyTzT9h0rblIUSs/OGoWNzBTZkD5RUPK0BWmUzTGUy5FqTWJcrzJrokHyB5pbLEaiU0InwI3FcZqJkctvUCXdk9qKbmsrwBu1yw8xUHkWxXxOzUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBzSORRQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBzSORRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D04C116B1;
	Mon,  8 Jul 2024 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720466321;
	bh=O6uIF+RFb01/GkReF4c6yk0p7sEtVWsPKR+FVmZnPi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBzSORRQiLiff8Gt65xgdcsif3RTxeKz1s8jxuUpFcPqCg4GXqfeY60Bp5Sr6NDt6
	 sKm8ByWTr7nsPxBThcQ0eygZzbQTbpCYfSbOQ3Grh1Q1/B0cSm0bFBgb4YLLpLxNZe
	 7QtTgO0VXe5kn0ThiO9iDjja/Mt4+pBB9FoYcOUN/408klWc7JTeIJuOIfQdJGijVr
	 FUGJlud2dIurrddrGyqjk1TGBu5yxqMJTZzOYpZLVTZRsk0uSbFD9m+4yS9QPJm7JY
	 HbBiA53Tyrm+FS03p4QLenM8NH6KgwCPl/StdCn69LCQuH4t5Q5gwf6Q9ttbnovGPZ
	 o3Ttn6Sviffag==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jann Horn <jannh@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [RFC][PATCH 1/4] compiler_types: Add integral/pointer type helper macros
Date: Mon,  8 Jul 2024 12:18:35 -0700
Message-Id: <20240708191840.335463-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708190924.work.846-kees@kernel.org>
References: <20240708190924.work.846-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3006; i=kees@kernel.org; h=from:subject; bh=O6uIF+RFb01/GkReF4c6yk0p7sEtVWsPKR+FVmZnPi8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjDuOeb7yBgPyjlDL1Ai4m2QU+GxeSGQAOayAT TMFTIpLqQ+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZow7jgAKCRCJcvTf3G3A JnhED/9Lhq1R3gm7NGEM0GLkbRQxXYQbYhq2A0e8dvTbqL1MASPu1YC5TcrbqV5beglnN39elKy 8h3QpI2J9XUnMTLYTBEg5lDLW+1z+31YXjNB25ZFCc+Ctpj+wcNCSlYnp9ANujR+cahpM0JckAj oOLtGwZ/Mx6+6qGV5Jz/BZPjL9YWUc9zLyp2s257xHqZLXH/84hL1l+i87K67lDi/EQwOTxqNGX /6QC/nozNZtNkJYrkMQpcF8AYxDlf/xCAU/ErY3CYau8FFJT+uWUpT/y/QhZhq0J4v1TWqNeySe MpPzuTkvCGc6XOLP1cu2vGfY5H5zrDvLX8CnGAQM22FrntYKLQ/XKOgULWZeO1Vb5vY9rULYjGL 4yYUDqpg2jeiYVUUyUIoLmMGtnIG+v0PqJiG5wTvdo7rTRjvKaoRyPWEvEX5wnFHyM9NldiATIQ j+cWxEy7WRl9Z3H6FGQv+UR21Ul3jIk1k8a4CQzxIE+uVMJastG3rPktpN8IpvYVJIfCPkljETR ZMhOUoc2JtV/UzFcSMe8G6dUx5ilIAuZmPNPMMYRYNx6XL7XtJGN1VpXifzym299nbhBmaUEHtG xuJ4YXvx0N7aHcyiK46IPzlAJRGalHwAm8hIfmUoBUbdZ1Ak6G0uCvYDOYTiBhB5L79fiI2Z6/y DSP5VB8ZDjqsgZA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Many compiler builtins (e.g. _Generic, __builtin_choose_expr) perform
integral vs pointer argument type evaluation on outputs before evaluating
the input expression. This means that all outputs must be syntactically
valid for all inputs, even if the output would be otherwise filtering
the types. For example, this will fail to build:

 #define handle_int_or_ptr(x)					\
	_Generic((x),						\
		int: handle_int(x),				\
		int *: handle_ptr(x))
 ...
 handle_int_or_ptr(7);

error: passing argument 1 of 'handle_ptr' makes pointer from integer without a cast [-Wint-conversion]
  108 |     handle_int_or_ptr(x);
      |                       ^
      |                       |
      |                       int

To deal with this, provide helpers that force expressions into the
desired type, where the mismatched cases are syntactically value, but
will never actually happen:

 #define handle_int_or_ptr(x)					\
	_Generic((x),						\
		int: handle_int(__force_integral_expr(x)),	\
		int *: handle_ptr(__force_ptr_expr(x)))

Now handle_int() only ever sees an int, and handle_ptr() only ever sees
a pointer, regardless of the input type.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Hao Luo <haoluo@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/compiler_types.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index f14c275950b5..7754f3b6a91f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -450,6 +450,29 @@ struct ftrace_likely_data {
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
+/* Is the variable addressable? */
+#define __is_ptr_or_array(p)			\
+	(__builtin_classify_type(p) == __builtin_classify_type(NULL))
+
+/* Return an array decayed to a pointer. */
+#define __decay(p)				\
+	(&*__builtin_choose_expr(__is_ptr_or_array(p), p, NULL))
+
+/* Report if variable is a pointer type. */
+#define __is_ptr(p)		__same_type(p, __decay(p))
+
+/* Always produce an integral expression, with specific type/vale fallback. */
+#define ___force_integral_expr(x, type, val)	\
+	__builtin_choose_expr(!__is_ptr(x), (x), (type)val)
+#define __force_integral_expr(x)	\
+	___force_integral_expr(x, int, 0)
+
+/* Always produce a pointer expression, with specific type/value fallback. */
+#define ___force_ptr_expr(x, type, value)	\
+	__builtin_choose_expr(__is_ptr(x), (x), &(type){ value })
+#define __force_ptr_expr(x)	\
+	__builtin_choose_expr(__is_ptr(x), (x), NULL)
+
 /*
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
-- 
2.34.1

