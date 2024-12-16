Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD08207A25;
	Mon, 16 Dec 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376625; cv=none; b=GSzFBGOmiFFb2dbVXM9Nx3YZXk4Sx3/v0h/2sSZeOizZvJl35rzImUiV4Ym9AvQuRlHHTkevbBIEIDTHhDxVcjoxQlICyt8d0Vk+2Gag0TuZRfp+p+1OLti9CzpBBGQyEg2wrm1EMEwsuT7LvqibTER3atXBb6WswoPtku3Avck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376625; c=relaxed/simple;
	bh=9gril4gyQM9zVQHoguqYvXCzzoFQLjwyPA1+UWZuxb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=THYqRG3xxiXpkdgNlZQ9Bs831zl107u1A/EVBylnHbp1lyhMcH8Ex8thhjKTtxtzGiMP1j0liBigyiHRfR3QKwh7xhFe/DR1hGwfaECqIDI4jHYtXzK8ei/HIBHh3ZQ95/CZgZsLNMw4kt28S0MlLiqoEc1sWW0FVYg+6F/QyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sprcHkAw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sprcHkAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734376618;
	bh=9gril4gyQM9zVQHoguqYvXCzzoFQLjwyPA1+UWZuxb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sprcHkAwydylzD4wVcgdnhpTKuOFvuOHabqnhZoxNbANMTXltbLDQDQi9t3cXTRHF
	 ibHGIsQdgegY/GdGpSkI9lUYmcfJSUiVusw70iKDz2obPolHd2D13h0r8SoTPSgVc8
	 np1RXQDp/yeAcYB1Hg6usLKblC17Ayyyue6zhA0E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 20:16:42 +0100
Subject: [PATCH 2/4] module: sysfs: Simplify section attribute allocation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-module-v1-2-f81e49e54ce4@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-module-v1-0-f81e49e54ce4@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-module-v1-0-f81e49e54ce4@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734376617; l=2398;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9gril4gyQM9zVQHoguqYvXCzzoFQLjwyPA1+UWZuxb0=;
 b=PbGSIk1DEgM5qb1g4h7qnitNHNjep+LEPpsjMSMMM4uodzwvCKN80+ZjwgQxxtu8Od6MFKcEX
 R4XJlE7aW21BrT/JUfRATGlzum4mvpQuldhgV0au2r+1KrcuHbN8+2Q
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
index b7841f76a933114e6dbd0fc2d32a60b66b7966b6..935629ac21fa16504ddb5f3762af5539572c3bf1 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -65,34 +65,37 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
 
 	for (bin_attr = sect_attrs->grp.bin_attrs; *bin_attr; bin_attr++)
 		kfree((*bin_attr)->attr.name);
+	kfree(sect_attrs->grp.bin_attrs);
 	kfree(sect_attrs);
 }
 
 static int add_sect_attrs(struct module *mod, const struct load_info *info)
 {
-	unsigned int nloaded = 0, i, size[2];
 	struct module_sect_attrs *sect_attrs;
 	struct module_sect_attr *sattr;
 	struct bin_attribute **gattr;
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
+		ret = -ENOMEM;
+		goto out;
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
 
@@ -111,7 +114,6 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 		sattr->battr.attr.mode = 0400;
 		*(gattr++) = &(sattr++)->battr;
 	}
-	*gattr = NULL;
 
 	ret = sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp);
 	if (ret)

-- 
2.47.1

