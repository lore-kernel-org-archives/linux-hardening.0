Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A251F37B3;
	Fri, 27 Dec 2024 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735305822; cv=none; b=VUJeEP4T+khOzGLK9Fgb7Q6P70ClKT47fRMdJRMn2lsF1tQEdp7C3vMfmZ4iNgO5u7g8ezbEu16thpabXwxtgUCZnk8ExbOcVpRtc9WCI+4RLkR6blURFWNtNF8ocf+La6qEiwxElqd1SfDFX4dRPeL7GFiIptvnn65wB8MAtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735305822; c=relaxed/simple;
	bh=TeyRT5JwHtydwOLRe+G9myQi3F2An6hZMnH1NE1+//Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDSq0IQ1D1D3yzqyo7O1kU1cPbnmVoMTV7OzOb1yDId/HvBVtXunICLkvhLovoRqOj+LrBm3Jz9kHnl1GvS8cDLQo9XcJdvM3zYf9Iuh/Thf3w3RNgakUtO4P1eQJorgc0F2azVejfeTy0SmeL2K5J8jtFPW5nwTpcS5FDBIP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ErO0Eyfw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ErO0Eyfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735305810;
	bh=TeyRT5JwHtydwOLRe+G9myQi3F2An6hZMnH1NE1+//Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ErO0EyfwpJv4YcgA0xEAQyMyAgyvTaIIA9SN8RxjyvTHd23Z7Fw0tQYnCge5xyrKY
	 JyCaK6uuSvJYNRncgqIrU4I94559WBt5PsywXa02X3KUE9SsGoXw7JrT3MgKYKK0nu
	 zOAuCZ1gedhxx7B9ZmIIdNKIm6CkKmPb7lFCTZxc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 27 Dec 2024 14:23:23 +0100
Subject: [PATCH v2 4/6] module: sysfs: Simplify section attribute
 allocation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241227-sysfs-const-bin_attr-module-v2-4-e267275f0f37@weissschuh.net>
References: <20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net>
In-Reply-To: <20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735305809; l=2389;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=TeyRT5JwHtydwOLRe+G9myQi3F2An6hZMnH1NE1+//Q=;
 b=4onz1NiJHT4zTS9zmwM5XcRg3R14uRSF1rP8uasu1EbRr0ytOJcRLvLiR5EDV9baUxCGpbov2
 Z/KhXztuL2EB+5vuB9/MsVc+NZJMc5p+wINsKzT5ijldDCarvCaP6X6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The existing allocation logic manually stuffs two allocations into one.
This is hard to understand and of limited value, given that all the
section names are allocated on their own anyways.
Une one allocation per datastructure.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/sysfs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 3d507005d7111b8328c04d35476a73193f73db1c..4b1a963b712b609cde1c4375e789a6ee7f359c7a 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -58,34 +58,37 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
 
 	for (bin_attr = sect_attrs->grp.bin_attrs; *bin_attr; bin_attr++)
 		kfree((*bin_attr)->attr.name);
+	kfree(sect_attrs->grp.bin_attrs);
 	kfree(sect_attrs);
 }
 
 static int add_sect_attrs(struct module *mod, const struct load_info *info)
 {
-	unsigned int nloaded = 0, i, size[2];
 	struct module_sect_attrs *sect_attrs;
 	struct bin_attribute **gattr;
 	struct bin_attribute *sattr;
+	unsigned int nloaded = 0, i;
 	int ret;
 
 	/* Count loaded sections and allocate structures */
 	for (i = 0; i < info->hdr->e_shnum; i++)
 		if (!sect_empty(&info->sechdrs[i]))
 			nloaded++;
-	size[0] = ALIGN(struct_size(sect_attrs, attrs, nloaded),
-			sizeof(sect_attrs->grp.bin_attrs[0]));
-	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.bin_attrs[0]);
-	sect_attrs = kzalloc(size[0] + size[1], GFP_KERNEL);
+	sect_attrs = kzalloc(struct_size(sect_attrs, attrs, nloaded), GFP_KERNEL);
 	if (!sect_attrs)
 		return -ENOMEM;
 
+	gattr = kcalloc(nloaded + 1, sizeof(*gattr), GFP_KERNEL);
+	if (!gattr) {
+		kfree(sect_attrs);
+		return -ENOMEM;
+	}
+
 	/* Setup section attributes. */
 	sect_attrs->grp.name = "sections";
-	sect_attrs->grp.bin_attrs = (void *)sect_attrs + size[0];
+	sect_attrs->grp.bin_attrs = gattr;
 
 	sattr = &sect_attrs->attrs[0];
-	gattr = &sect_attrs->grp.bin_attrs[0];
 	for (i = 0; i < info->hdr->e_shnum; i++) {
 		Elf_Shdr *sec = &info->sechdrs[i];
 
@@ -104,7 +107,6 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 		sattr->attr.mode = 0400;
 		*(gattr++) = sattr++;
 	}
-	*gattr = NULL;
 
 	ret = sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp);
 	if (ret)

-- 
2.47.1

