Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C66175D2F;
	Fri,  9 Aug 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188790; cv=none; b=SOZtAw7rVBqTKycKdAReD6J/WoNfRnIVsRZD9zP29CLKW3DgBDgABC503hZfiHT/N01jn3v01Aao0VdmeNo2Pe/HNfpDI2C3+WXGbLDujdBwLLGtzV++nrOqTKZJngWNuooo75ZFPDPWsAH1r2n6v3p8k4XTAvo8JaNgjFsCqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188790; c=relaxed/simple;
	bh=Bm7wZvIpH1u9Fue5VhYGh2wN4XsW+HXCBPDIfO+4Wi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKjo8ng11sVv8znPDT4PMdaoMTqb3r4379FA/1bLpj1Y4pdaeT/JoKu8Glu8g1HXOtGGMDka1q73frNJGGMrenABcd85mSBO5CoAtomt4tFcHG+wSmqrqYPLvR1V/ZDwS2YNjDum2Yd4HfXZE58PxtIaAvjX4T9oew61yA0xyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqpCoLXI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqpCoLXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A604FC4AF0D;
	Fri,  9 Aug 2024 07:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723188789;
	bh=Bm7wZvIpH1u9Fue5VhYGh2wN4XsW+HXCBPDIfO+4Wi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqpCoLXIIBMnBfGGkEX09zukRI2+BmDPINyNOYod5uVhbZDarz3N5Gon+RuXzFMAb
	 oPfcGVx2F89WvXdR38xVPnVsVlOUmNcyHLnIz/i0Chy93oj1L4sP0lHM9ULrx3F+Dy
	 3wtCujBr/ZAjZcrcrOYEQHYox5wX8h0ySRVdiy4kQYmXwl16b/dgOdo7qfIJdcuOze
	 /My+X+Esi8xyVCPP+QA8hTU/aKTo2FyoEfdKL29fwNZw2fSN5v+VcPTVRG6MpbJbIh
	 z6fXqwUOtqJjrwqRQmB4cR3qiejfPc+eHmuFlse3M/B3SuOYmoyKMkjQGsPZiZMAAm
	 X3fYWCL8pp4Yg==
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
Subject: [PATCH 2/5] codetag: Run module_load hooks for builtin codetags
Date: Fri,  9 Aug 2024 00:33:03 -0700
Message-Id: <20240809073309.2134488-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809072532.work.266-kees@kernel.org>
References: <20240809072532.work.266-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=kees@kernel.org; h=from:subject; bh=Bm7wZvIpH1u9Fue5VhYGh2wN4XsW+HXCBPDIfO+4Wi0=; b=owGbwMvMwCVmps19z/KJym7G02pJDGlbjxke+n5p3ULn87cf9DTKdwmaspUUamrMS9iRlnGLf TIne3NeRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQuXGZkeC42Q9N+bpD98SIX x6h7Lvs+C7ZwcS3zP3qIZfUbhd77AQz/IwUeVCk7XGpQ0dpqWr5Ru4/R+rV7RXv5Wob9sVHfDmx hBwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The module_load callback should still run for builtin codetags that
define it, even in a non-modular kernel. (i.e. for the cmod->mod == NULL
case).

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
 lib/codetag.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/codetag.c b/lib/codetag.c
index 5ace625f2328..ef7634c7ee18 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -125,7 +125,6 @@ static inline size_t range_size(const struct codetag_type *cttype,
 			cttype->desc.tag_size;
 }
 
-#ifdef CONFIG_MODULES
 static void *get_symbol(struct module *mod, const char *prefix, const char *name)
 {
 	DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
@@ -199,6 +198,7 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
 void codetag_load_module(struct module *mod)
 {
 	struct codetag_type *cttype;
@@ -248,9 +248,6 @@ bool codetag_unload_module(struct module *mod)
 
 	return unload_ok;
 }
-
-#else /* CONFIG_MODULES */
-static int codetag_module_init(struct codetag_type *cttype, struct module *mod) { return 0; }
 #endif /* CONFIG_MODULES */
 
 struct codetag_type *
-- 
2.34.1

