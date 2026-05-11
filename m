Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454123290C9
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529736; cv=none; b=Rrwla7Gfl6wbF7uauEIkJ3h5eb4O0IZsFWKPMFpr6f/uDO6VOF7SmFuHvozSLXDyFftykLKCK7EpmxpsCPPGvNhZOgrqIQrM72+/cr9hsyGqIXUtJPGCvasxTp6aYqVy9WLacuOLO8PDOn6RYr2R0HJ08rUl3QAn6PcXsU0bzWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529736; c=relaxed/simple;
	bh=3soCOAIvdELQvsXpjzW6fUm/qXnhcabrdpgiCXdhVnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qvStPeSObfh0Ngh0PyVdeA6MqL2ED6zvHyJsXloH9HytxMjtCRNYssUJDKXL94B66SHctngfIy4B8dWo1SZpgsx4gAEy4L89w04XU4tEEtNhoui+QDlB8JjP9feGm4oOhzxhPKO4iw4rfQ70KfJfZTqGSgbHVCiLFj54QLRf8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RwJNNDp0; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwJNNDp0"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8ff07df5e4so405235166b.3
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778529734; x=1779134534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kSzWbBLsBd6qB4iAbq+envEAJK7ihSlVnGWw0+sGFs=;
        b=RwJNNDp0U5gzA21wjdGfkq8ipVPNgAJIvwy9kKgbxgK0k6cFjlinWBcnjdAl7YHxlX
         MX0YyCNu/ObUH1PjTkfEoXKTtifAv2XYif75+NcvR2PBwGOqTBP2Uz5Nn5agoT03Mtne
         V/Iujfe+CfOFmvOa9AXRUNisl3XMJXAUob2cQJ7hXCjkTfgxmYykfVsljccQOGfPIAiJ
         vy2aDR46Uuw9tbHkxFITJ+1FQQ0KazTgwtdRyRqNcCl7hfZDmkR5j+9LLnhmsVNjb63d
         9/ZAI9ZIkT5kYiwR/M+hmSdEfqkDjRhGXTT/Vzj77gllgwVbLUzx3U/nKXJSa7UAg2ad
         jOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529734; x=1779134534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kSzWbBLsBd6qB4iAbq+envEAJK7ihSlVnGWw0+sGFs=;
        b=jLnZTsjA+CArWqwnsOTkzP9i+H6SXXh3tjARijbUFMJ55ie6DKfP+mXs14DLEtt7NJ
         KIlzP6bIIwqXYYILAXLIcZeGziSQovi52/xhKg4qfjJI/kCiIOr7OaOmOv//Jo3d3E5h
         Oghu8taFnDAi68FwO5M2jSKjY1pSYOzKlmjTskD25Gy0HyAN04l42PbROlfOo75auPFn
         w4O6ROfzDya3DFJwth7vZxe3fMqTiqwZaVppJ3sqShU1XOrqmYpqdwHtvsAfVOtgIQks
         11C5IiG8pRaAddnmMpXP1nC5tq0K2/DAd1AKpqtQJ8Kwa6vZMBi5VFzndiBzAytcHAy2
         9tMA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZjrxwKi3UOtAW+TtH8oo0xfnUetOnuwMF7JLWOljtxf6FQxlruhq27ehm3A8Ub+muukBjKh/Q4DTVErvLmfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5T0Z1g+Kx3aRdvjAI2sQ/RG5wxDuhkfzi0JvmoP04CWO8sAN7
	HvPNiiJ2bjJ+T82hkevzkOu6mgGmvS07awbecqhPSNaIpieDCSoqx3PGXsA5/E3hkij3iNBCgUL
	gQQ==
X-Received: from ejche33.prod.google.com ([2002:a17:907:3da1:b0:bcc:71b:9645])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:a01:b0:bab:f5c7:23ca
 with SMTP id a640c23a62f3a-bc56df0650fmr1477434066b.38.1778529733351; Mon, 11
 May 2026 13:02:13 -0700 (PDT)
Date: Mon, 11 May 2026 22:00:49 +0200
In-Reply-To: <20260511200136.3201646-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511200136.3201646-1-elver@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511200136.3201646-2-elver@google.com>
Subject: [PATCH v4 2/3] slab: improve KMALLOC_PARTITION_RANDOM randomness
From: Marco Elver <elver@google.com>
To: elver@google.com, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Bill Wendling <morbo@google.com>, 
	David Hildenbrand <david@kernel.org>, David Rientjes <rientjes@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Matteo Rizzo <matteorizzo@google.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, linux-hardening@vger.kernel.org, 
	Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
	"Liam R. Howlett" <liam@infradead.org>, Alexander Potapenko <glider@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

When using CONFIG_KMALLOC_PARTITION_RANDOM, _RET_IP_ was previously used
to identify the allocation site. _RET_IP_, however, evaluates to the
caller's parent's instruction pointer rather than the actual allocation
site; this would lead to collisions where a function performs multiple
allocations.

With the generalization to kmalloc_token_t, we now generate the token at
the outermost macro, and using _THIS_IP_ would fix this for all cases.

Unfortunately, the generic implementation of _THIS_IP_ relies on taking
the address of a local label, which is considered broken by both GCC [1]
and Clang [2] because label addresses are only expected to be used with
computed gotos. While the generic version more or less works today, it
is known to be brittle. For example, Clang -O2 always returns 1 when
this function is inlined:

        static inline unsigned long get_ip(void)
        { return ({ __label__ __here; __here: (unsigned long)&&__here; }); }

To provide a reliable unique identifier without breaking architectures
relying on the generic _THIS_IP_, introduce _CODE_LOCATION_: it resolves
to _THIS_IP_ where architectures provide a safe implementation, and
falls back to a zero-cost static marker where _THIS_IP_ is broken.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120071 [1]
Link: https://github.com/llvm/llvm-project/issues/138272 [2]
Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* New patch.
---
 include/linux/instruction_pointer.h | 24 ++++++++++++++++++++++++
 include/linux/slab.h                |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/instruction_pointer.h b/include/linux/instruction_pointer.h
index aa0b3ffea935..ea5bc756bd99 100644
--- a/include/linux/instruction_pointer.h
+++ b/include/linux/instruction_pointer.h
@@ -8,6 +8,30 @@
 
 #ifndef _THIS_IP_
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
+/*
+ * The current generic definition of _THIS_IP_ is considered broken by GCC [1]
+ * and Clang [2]. In particular, the address of a label is only expected to be
+ * used with a computed goto.
+ *
+ *   [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120071
+ *   [2] https://github.com/llvm/llvm-project/issues/138272
+ *
+ * Mark it as broken, so that appropriate fallback options can be implemented
+ * for architectures that do not define their own _THIS_IP_.
+ */
+#define HAS_BROKEN_THIS_IP
+#endif
+
+/*
+ * _CODE_LOCATION_ provides a unique identifier for the current code location.
+ * When _THIS_IP_ is broken (generic version), we fall back to a static marker
+ * which guarantees uniqueness and resolves to a constant address at link time,
+ * avoiding runtime overhead and compiler optimizations breaking it.
+ */
+#ifdef HAS_BROKEN_THIS_IP
+#define _CODE_LOCATION_ ({ static const char __here; (unsigned long)&__here; })
+#else
+#define _CODE_LOCATION_ _THIS_IP_
 #endif
 
 #endif /* _LINUX_INSTRUCTION_POINTER_H */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index c232f8a10af6..efab6b2ccf21 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -503,7 +503,7 @@ int kmem_cache_shrink(struct kmem_cache *s);
 typedef struct { unsigned long v; } kmalloc_token_t;
 #ifdef CONFIG_KMALLOC_PARTITION_RANDOM
 extern unsigned long random_kmalloc_seed;
-#define __kmalloc_token(...) ((kmalloc_token_t){ .v = _RET_IP_ })
+#define __kmalloc_token(...) ((kmalloc_token_t){ .v = _CODE_LOCATION_ })
 #elif defined(CONFIG_KMALLOC_PARTITION_TYPED)
 #define __kmalloc_token(...) ((kmalloc_token_t){ .v = __builtin_infer_alloc_token(__VA_ARGS__) })
 #endif
-- 
2.54.0.563.g4f69b47b94-goog

