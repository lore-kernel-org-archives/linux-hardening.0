Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78611F4288;
	Fri, 27 Dec 2024 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735305824; cv=none; b=l9beJq1IZjqM/s+rnXewddxzeTLzyl0gizps3VbC7ikH9GxICYGXwMbJTUPCmtXLNELgsLtZVWsT+8c2bW9/VI389zQpS/q5YA59Hn0+YNPLHgYdwg5yRc9qHc9AXR8MpugXndtu45b2eYqoo6QMZDQmmwk1EJxAUWQu67TYUNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735305824; c=relaxed/simple;
	bh=FhZcpa+oH0AuaI//x4ZCk0kWcoGzPTmlzuGyc897LEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQFg2xloxcfJUsdjttg6EmDDp4OWU0cWa95LOooRLcjI67uOFBW9JkXwGwYsn77kIuEtd/5FxnnHFLSYy1ET/UR5wlrCeeycSsYN/5Qnimd/AJL8wAVgfHO3uM91SPJaUQ4uO7LR9IdDtKbqQTwddlymbnGHNArfQvvDyV5Jd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tvnGtSfe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tvnGtSfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735305810;
	bh=FhZcpa+oH0AuaI//x4ZCk0kWcoGzPTmlzuGyc897LEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tvnGtSfePS7SbtytS/Caiv2qPt+/8KzLete/W1WoHxfOLXkeS2cgegg680xcEtsJy
	 0FfQAUY8da68c1UR4weIpx1DwjDe3LSba74o150reC+zDGirDwKMf7PHd1gi3Ab8hJ
	 9VRvKGLZ9Veb+EuK/ePCvOKHwWVbdg9jiw/P7ps0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 27 Dec 2024 14:23:22 +0100
Subject: [PATCH v2 3/6] module: sysfs: Drop 'struct module_sect_attr'
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241227-sysfs-const-bin_attr-module-v2-3-e267275f0f37@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735305809; l=2536;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FhZcpa+oH0AuaI//x4ZCk0kWcoGzPTmlzuGyc897LEI=;
 b=u0qKz3BMtEpVGZXUui3SoMB/EwETgeN08i19n73QAIeK4X/aiflTBqEyt4MDXvG7NGaEOmPsS
 6L5hReKxg6tCSIhs3ntGT8bWm7LnzZF8Aend7nQMZtcRYudgyQWCyTk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is now an otherwise empty wrapper around a 'struct bin_attribute',
not providing any functionality. Remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/sysfs.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 8955b3da1b499881256670418d41c5d52d9e5a5e..3d507005d7111b8328c04d35476a73193f73db1c 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -19,13 +19,9 @@
  * J. Corbet <corbet@lwn.net>
  */
 #ifdef CONFIG_KALLSYMS
-struct module_sect_attr {
-	struct bin_attribute battr;
-};
-
 struct module_sect_attrs {
 	struct attribute_group grp;
-	struct module_sect_attr attrs[];
+	struct bin_attribute attrs[];
 };
 
 #define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
@@ -69,8 +65,8 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 {
 	unsigned int nloaded = 0, i, size[2];
 	struct module_sect_attrs *sect_attrs;
-	struct module_sect_attr *sattr;
 	struct bin_attribute **gattr;
+	struct bin_attribute *sattr;
 	int ret;
 
 	/* Count loaded sections and allocate structures */
@@ -95,18 +91,18 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 
 		if (sect_empty(sec))
 			continue;
-		sysfs_bin_attr_init(&sattr->battr);
-		sattr->battr.attr.name =
+		sysfs_bin_attr_init(sattr);
+		sattr->attr.name =
 			kstrdup(info->secstrings + sec->sh_name, GFP_KERNEL);
-		if (!sattr->battr.attr.name) {
+		if (!sattr->attr.name) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		sattr->battr.read = module_sect_read;
-		sattr->battr.private = (void *)sec->sh_addr;
-		sattr->battr.size = MODULE_SECT_READ_SIZE;
-		sattr->battr.attr.mode = 0400;
-		*(gattr++) = &(sattr++)->battr;
+		sattr->read = module_sect_read;
+		sattr->private = (void *)sec->sh_addr;
+		sattr->size = MODULE_SECT_READ_SIZE;
+		sattr->attr.mode = 0400;
+		*(gattr++) = sattr++;
 	}
 	*gattr = NULL;
 
@@ -186,7 +182,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 			continue;
 		if (info->sechdrs[i].sh_type == SHT_NOTE) {
 			sysfs_bin_attr_init(nattr);
-			nattr->attr.name = mod->sect_attrs->attrs[loaded].battr.attr.name;
+			nattr->attr.name = mod->sect_attrs->attrs[loaded].attr.name;
 			nattr->attr.mode = 0444;
 			nattr->size = info->sechdrs[i].sh_size;
 			nattr->private = (void *)info->sechdrs[i].sh_addr;

-- 
2.47.1

