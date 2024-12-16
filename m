Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC381E87B;
	Mon, 16 Dec 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376625; cv=none; b=OB//4Boa7omaS63vZ7GW1N4T9Xn5oC1BmkagiVRaoprvxxuGLae6BT+eqF2jDwHp93B3L2CK1KWKmwWTlrOFpUPFKPtCJDxXGqIp53usaPWamgtecv/lLeQXwwtBMQnT+sf72urDy4i7DOBrmklxUIiMoNicRLvDD1+YVOUL0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376625; c=relaxed/simple;
	bh=V7KbNN5UX1x8tPH3JWy/OtA6LHRL65sZkslzVlB6VgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VUQ5TvZExebHjUsng081nVke4O4MnUfrdz5bWAcohvMKIwKO+gfZ04ixpKwZKR4/HMurT/mOXog/hsFIFyvwD6BVyPdYcKstZfbIQ72qc4HJ1QO4rRu0kT/TnfTaRRNo5mT1wZrUNd5mRL6jzUbplfqs/heVhasJHIL1y0NjwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Vu2BaTSd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Vu2BaTSd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734376618;
	bh=V7KbNN5UX1x8tPH3JWy/OtA6LHRL65sZkslzVlB6VgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vu2BaTSdejNlyctdYqRrzqZkUN+MuNVcmtXtdDqbEcH2v2M13ZOiQG7aoMlglarpq
	 mvU8oaCpe6E7I3N6L5c2jGPWGIeNo4CqJy5yRar0CPGZfxD5KjOuMsmvtQEZNzmrvC
	 ODmyjnDal6hMvLGYmP89xx6hvvjdHMrDHoDVJK+E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 20:16:44 +0100
Subject: [PATCH 4/4] module: sysfs: Use const 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-module-v1-4-f81e49e54ce4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734376617; l=3705;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=V7KbNN5UX1x8tPH3JWy/OtA6LHRL65sZkslzVlB6VgA=;
 b=dku+SY1IqoJujrFsPN/9QwRW8kNQruu/B1cX/cx5kwNTA7yqPERm0wTRmnamkfg5rzxDjh7IC
 Uyk15uFVqf8BhIqFUMSAFYZlI71GfTvUeInK734zuM35TQ1LDC/kWR1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core is switching to 'const struct bin_attribute's.
Prepare for that.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/sysfs.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 4f37970f99c999589257713926395686f03103e6..99177cd55f7edec05abd079577ccf161666d8a20 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -31,11 +31,11 @@ struct module_sect_attrs {
 
 #define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
 static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
-				struct bin_attribute *battr,
+				const struct bin_attribute *battr,
 				char *buf, loff_t pos, size_t count)
 {
-	struct module_sect_attr *sattr =
-		container_of(battr, struct module_sect_attr, battr);
+	const struct module_sect_attr *sattr =
+		container_of_const(battr, struct module_sect_attr, battr);
 	char bounce[MODULE_SECT_READ_SIZE + 1];
 	size_t wrote;
 
@@ -61,11 +61,11 @@ static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
 
 static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
 {
-	struct bin_attribute **bin_attr;
+	const struct bin_attribute *const *bin_attr;
 
-	for (bin_attr = sect_attrs->grp.bin_attrs; *bin_attr; bin_attr++)
+	for (bin_attr = sect_attrs->grp.bin_attrs_new; *bin_attr; bin_attr++)
 		kfree((*bin_attr)->attr.name);
-	kfree(sect_attrs->grp.bin_attrs);
+	kfree(sect_attrs->grp.bin_attrs_new);
 	kfree(sect_attrs);
 }
 
@@ -73,7 +73,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 {
 	struct module_sect_attrs *sect_attrs;
 	struct module_sect_attr *sattr;
-	struct bin_attribute **gattr;
+	const struct bin_attribute **gattr;
 	unsigned int nloaded = 0, i;
 	int ret;
 
@@ -93,7 +93,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 
 	/* Setup section attributes. */
 	sect_attrs->grp.name = "sections";
-	sect_attrs->grp.bin_attrs = gattr;
+	sect_attrs->grp.bin_attrs_new = gattr;
 
 	sattr = &sect_attrs->attrs[0];
 	for (i = 0; i < info->hdr->e_shnum; i++) {
@@ -109,7 +109,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 			ret = -ENOMEM;
 			goto out;
 		}
-		sattr->battr.read = module_sect_read;
+		sattr->battr.read_new = module_sect_read;
 		sattr->battr.size = MODULE_SECT_READ_SIZE;
 		sattr->battr.attr.mode = 0400;
 		*(gattr++) = &(sattr++)->battr;
@@ -151,11 +151,11 @@ struct module_notes_attrs {
 
 static void free_notes_attrs(struct module_notes_attrs *notes_attrs)
 {
-	struct bin_attribute **bin_attr;
+	const struct bin_attribute *const *bin_attr;
 
-	for (bin_attr = notes_attrs->grp.bin_attrs; *bin_attr; bin_attr++)
+	for (bin_attr = notes_attrs->grp.bin_attrs_new; *bin_attr; bin_attr++)
 		kfree((*bin_attr)->attr.name);
-	kfree(notes_attrs->grp.bin_attrs);
+	kfree(notes_attrs->grp.bin_attrs_new);
 	kfree(notes_attrs);
 }
 
@@ -163,7 +163,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 {
 	unsigned int notes, loaded, i;
 	struct module_notes_attrs *notes_attrs;
-	struct bin_attribute **gattr;
+	const struct bin_attribute **gattr;
 	struct bin_attribute *nattr;
 	int ret;
 
@@ -189,7 +189,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 	}
 
 	notes_attrs->grp.name = "notes";
-	notes_attrs->grp.bin_attrs = gattr;
+	notes_attrs->grp.bin_attrs_new = gattr;
 
 	nattr = &notes_attrs->attrs[0];
 	for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {

-- 
2.47.1

