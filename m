Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB4175D36;
	Fri,  9 Aug 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188790; cv=none; b=e3PQ1TMgyyRTqUUjXO5dBZxdBnii/73Ce+e4bKVJP1c79mFl7cWzI3RZhnGdFHb38VhKWBTnyUAAeMwK3hMpVwx8OWkLz7/CBxwxVdOvWwR8n+IO47/WmXM7g1cXxz7mDUkirsu+M2XMVpcDc65W+c1DIk3oix4+3xeUXhNU2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188790; c=relaxed/simple;
	bh=Stx3EEnB/9LWtVMs8bPtcAXmif1O8Z/znzWwrIr1yQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hMY+M44pGGrhVGVkFaIf0T/tcTeYW4KHA2VKkZOpQwOxJxp1BH9py2i3ZF9VNb8yjwayI/Qatq8bYD4ip7LYuheSqi+5eEHEINkBCiIGLl40p0xOQsL4epAbUQlb+N9mwcwtqHWTLYGSCBa+pZw4ILpPUuMyJQ4bOQn13v1dF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G96xFR9z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G96xFR9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB099C4AF10;
	Fri,  9 Aug 2024 07:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723188789;
	bh=Stx3EEnB/9LWtVMs8bPtcAXmif1O8Z/znzWwrIr1yQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G96xFR9zVeh09ObUFoqqZFktxg1j3FtzvLiXQZGmQZW/HVQIm7p5HIUbK5Ww99589
	 CNxj96mi3eBlCxegp72LfDbiC9rOvnrWCQzO0YvRFp6aR3VIj/SuoeDWAMXhIbxV8O
	 cjeBU/r8ZOz+n88QSTZXJ9cFA1/i28S4PPfS/AKJ2uwN4tSkbb3JKof8G+eosTEybG
	 485xFvfsK3AuAe/sxtfTl47vL4CU3b2ybBPEAFXxACwNrNDgvU5G2oZNtuTk4AYoyV
	 9pYD8+LMbuhN6C9vBvYfaJZfhUZngVa/DpU5F+dlB9t9jc6WTqOaLW4mZPlzd8Hk+n
	 ziag+GbKspAEQ==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	jvoisin <julien.voisin@dustri.org>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/5] codetag: Introduce codetag_early_walk()
Date: Fri,  9 Aug 2024 00:33:04 -0700
Message-Id: <20240809073309.2134488-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809072532.work.266-kees@kernel.org>
References: <20240809072532.work.266-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359; i=kees@kernel.org; h=from:subject; bh=Stx3EEnB/9LWtVMs8bPtcAXmif1O8Z/znzWwrIr1yQM=; b=owGbwMvMwCVmps19z/KJym7G02pJDGlbjxnOseXU/pJl/43T0XOt5r2jXsvfZqg+sjDOii3I3 vMo2r2zo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCKPwhgZPkd03P/cfODJhK1S TXHcc1wl7ylP8ufytdEOmixz1c7Yg+F/pc/9q0Ub7q7Zv+boUV0X+f1xT5Q6ndp1tt0+78NeFv6 LAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In order to process builtin alloc_tags much earlier during boot (before
register_codetag() is processed), provide codetag_early_walk() that
perform a lockless walk with a specified callback function. This will be
used to allocate required caches that cannot be allocated on demand.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/codetag.h |  2 ++
 lib/codetag.c           | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index c2a579ccd455..9eb1fcd90570 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -64,6 +64,8 @@ void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
 bool codetag_trylock_module_list(struct codetag_type *cttype);
 struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype);
 struct codetag *codetag_next_ct(struct codetag_iterator *iter);
+void codetag_early_walk(const struct codetag_type_desc *desc,
+			void (*callback)(struct codetag *ct));
 
 void codetag_to_text(struct seq_buf *out, struct codetag *ct);
 
diff --git a/lib/codetag.c b/lib/codetag.c
index ef7634c7ee18..9d563c8c088a 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -154,6 +154,22 @@ static struct codetag_range get_section_range(struct module *mod,
 	};
 }
 
+void codetag_early_walk(const struct codetag_type_desc *desc,
+			void (*callback)(struct codetag *ct))
+{
+	struct codetag_range range;
+	struct codetag *ct;
+
+	range = get_section_range(NULL, desc->section);
+	if (!range.start || !range.stop ||
+	    range.start == range.stop ||
+	    range.start > range.stop)
+		return;
+
+	for (ct = range.start; ct < range.stop; ct = ((void *)ct + desc->tag_size))
+		callback(ct);
+}
+
 static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 {
 	struct codetag_range range;
-- 
2.34.1

