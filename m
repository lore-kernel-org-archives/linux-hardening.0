Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33A14BF9B;
	Mon,  8 Jul 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466321; cv=none; b=M9W+2e/NKKfVS3Vb9xnA5Lfz0tTo4kdOaPnXl+ugX7bz9/tBb2Xywv1HXmDXiAwjN14suLUoT4GVvFGattcT4da6kGws2GdbujIVFXLZZFbZ2TmYpwqi+4qJ6BT0ZNrkS6QoTaoeuo3DOMwX7LIlstFY+AJTg//Ak8S8jL5y28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466321; c=relaxed/simple;
	bh=uANC145QcD7DtmOmXpWRLhF0n/zqG8SYT4uWyFnv9BY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evWT+Vm1mzFwPF/IiUat3NW5QMRKhogDiWTZxaaq/AbizbTiSCuxlOkkvfOO5LNs2Rkz+9y/vWlnAeZpo9XKwsadi0jz6/4/pZhVMEVLvZFTafXhF5cp156yM8li3if+50V62AomPMV8SbczmFCJunT6wxWUP33+6vDQffymt+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut65n4tt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ut65n4tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37087C3277B;
	Mon,  8 Jul 2024 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720466321;
	bh=uANC145QcD7DtmOmXpWRLhF0n/zqG8SYT4uWyFnv9BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ut65n4ttGog05ECx2J7Ldhpidc1j6a0Kg5kWfNkx5hEy2XKc4T74clrOBRyrT2GJ2
	 CSQZtSl9G+pY2KfI2kLVU3EYynPPP960w63i+RsXCwZVSlnAzmExTguHq/jE0knrMM
	 X7Z9+ZkzVzNMI7DgFbeHkR5RLzQVMYQKvka2ssC0ulRh9HdvY14lvLjnROkAPejfqa
	 i3tcAgr/1wTJrgxGXnR+m3TngfcUKH9xaqrqOIC9WSVBimd+A0+lEv7nalw1ELiJ9j
	 PInNsXUs9wMhgis609Ppl5l4djbXdb9B2flDlTDLjDaaETeJ5l72a6Wi1oM6t7XTFM
	 uJMg0bR3VpwEQ==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	Jann Horn <jannh@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC][PATCH 2/4] slab: Detect negative size values and saturate
Date: Mon,  8 Jul 2024 12:18:36 -0700
Message-Id: <20240708191840.335463-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708190924.work.846-kees@kernel.org>
References: <20240708190924.work.846-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2917; i=kees@kernel.org; h=from:subject; bh=uANC145QcD7DtmOmXpWRLhF0n/zqG8SYT4uWyFnv9BY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjDuONss2HaGaoXnvMw6YATx2x2Smf4BEOjQW7 uHB+UwHbbiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZow7jgAKCRCJcvTf3G3A JpNWEACsSqZxKHvZ7EzYarhtHgRtezUJVoSb5d0p/QDZ1pIlQRudtH/v5C446CA6MwZGgOnK+Fe gvW+lh4/Nse3mJwCt6zIp5Hmszca534ybfPGJ1f2lmqP8WC187ToIlZ18g1VuZi1YMdWUbgVHmz 1v+MGEZd7jTPa3dxhAhy0jdXamCYtyf2x3vXuPOUCtpvg5KBn1xYEQgOyOC+uD6xJumWNebym1m 23l2UgNPi43g5bg1ji+gjrMcSpiCU9vKIRqD14K/m9xaYJinwUbaJDri8UWItePlAe3/TimtaZa 9sGERC9xqNHHzmBo009EyLRyvkp635+FCCSpy1kAJVE72UTuh6v0wY6373ZpVGkeAfrAbnyrOji teF56Y//AEWe+GeeIaz+3p8pW73CyBuYf+PS0R47/zvCdzB7K5GhsvRGpEZin1Iv0BS2F9Z3dz2 XloogfHgtO+Z6ayNcm0tRMZ4napyGwOq+VUlCx15GM0Kont3N+v5gx8BJaTOIV8cvey81K3F0OE vuJtxGTSwjOjw0269OcMQHdZOQAYYZUIOjumwVkN6OnG3N8PPiiEGx/dB4ROz71ZMz+N+lqXHIb zpT7z7g4b8mnD3XnkBb9Dp+HSiqVQ747eJjuHjVjIzJ1RVf0+bMXUJwXSrHysPt7GWU7z1zaOb4 k+QYgVvnbVehHqA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The allocator will already reject giant sizes seen from negative size
arguments, so this commit mainly services as an example for initial
type-based filtering. The size argument is checked for negative values
in signed arguments, saturating any if found instead of passing them on.

For example, now the size is checked:

Before:
				/* %rdi unchecked */
 1eb:   be c0 0c 00 00          mov    $0xcc0,%esi
 1f0:   e8 00 00 00 00          call   1f5 <do_SLAB_NEGATIVE+0x15>
                        1f1: R_X86_64_PLT32 __kmalloc_noprof-0x4

After:
 6d0:   48 63 c7                movslq %edi,%rax
 6d3:   85 ff                   test   %edi,%edi
 6d5:   be c0 0c 00 00          mov    $0xcc0,%esi
 6da:   48 c7 c2 ff ff ff ff    mov    $0xffffffffffffffff,%rdx
 6e1:   48 0f 49 d0             cmovns %rax,%rdx
 6e5:   48 89 d7                mov    %rdx,%rdi
 6e8:   e8 00 00 00 00          call   6ed <do_SLAB_NEGATIVE+0x1d>
                        6e9: R_X86_64_PLT32     __kmalloc_noprof-0x4

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index d99afce36098..7353756cbec6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -684,7 +684,24 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 	}
 	return __kmalloc_noprof(size, flags);
 }
-#define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
+#define kmalloc_sized(...)			alloc_hooks(kmalloc_noprof(__VA_ARGS__))
+
+#define __size_force_positive(x)				\
+	({							\
+		typeof(__force_integral_expr(x)) __forced_val =	\
+			__force_integral_expr(x);		\
+		__forced_val < 0 ? SIZE_MAX : __forced_val;	\
+	})
+
+#define kmalloc(p, gfp)		_Generic((p),    \
+	unsigned char:  kmalloc_sized(__force_integral_expr(p), gfp), \
+	unsigned short: kmalloc_sized(__force_integral_expr(p), gfp), \
+	unsigned int:   kmalloc_sized(__force_integral_expr(p), gfp), \
+	unsigned long:  kmalloc_sized(__force_integral_expr(p), gfp), \
+	signed char:    kmalloc_sized(__size_force_positive(p), gfp), \
+	signed short:   kmalloc_sized(__size_force_positive(p), gfp), \
+	signed int:     kmalloc_sized(__size_force_positive(p), gfp), \
+	signed long:    kmalloc_sized(__size_force_positive(p), gfp))
 
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
-- 
2.34.1

