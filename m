Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC93207663;
	Mon, 16 Dec 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376626; cv=none; b=iXaTcnv5VE8gAqLny70iSRh88518Kew9mfopLf2+NKyMRA2j9UIvNFb+zOMusiKRPPSpp4CQqrO4ye0hpIN62bF2cA4yfiagMeun5XWsIxXmngAEYKWTFuFIt/oLz63A9il9IUPUtxwstyJiIH9WDaf/ncluvaGSTHAsKe7GvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376626; c=relaxed/simple;
	bh=UrilX0/oMRPi/el9YKtu6ujZduP8bEv5oeUtYlJxC5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pznJJkGfNWQjGENQQJIrr2HHk/35PoG2SrpeItlUUYrK5R9/VGUk21UadSKmamE8UQuTZX42afvuOs8KRfDU8+IprGLypGJqiRFn5eT3JTfFelMXGLwP2PvQ5TWnAW/hB/egTZzYA3HpAI8qkjLHfJs8Ce6UZ0v7t/sUXx37MAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tikSpEqq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tikSpEqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734376618;
	bh=UrilX0/oMRPi/el9YKtu6ujZduP8bEv5oeUtYlJxC5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tikSpEqqo5hZNVLAH+2kNQvdMK1rm0+OrjE44FCAReXDRqKSzfJjJTdvaGKWhr5Eb
	 W0T3vG94ZnxfU2bBTnWJKdRM+5kOEYzNXpHgSJ/S3TkNfdqalodXLwEFI+L7/lELs/
	 o3w9VxUS6oYaceRe5HOO6Y/E+Qk8PHdbc6UPkKdg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 20:16:43 +0100
Subject: [PATCH 3/4] module: sysfs: Add notes attributes through
 attribute_group
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-module-v1-3-f81e49e54ce4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734376617; l=3421;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UrilX0/oMRPi/el9YKtu6ujZduP8bEv5oeUtYlJxC5I=;
 b=31XnL0mUqI8uayYuGN5y9mOjvZY7z6cfqm0oKFU4CbjuTP7VDA+6R1Ve5d9xDQbsqY8aonsNC
 68QVXDAb+eXAkO0IrZ/iymZuVBskCVi7MshPd1nsAySiRGcOAPen7sL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A kobject is meant to manage the lifecycle of some resource.
However the module sysfs code only creates a kobject to get a
"notes" subdirectory in sysfs.
This can be achieved easier and cheaper by using a sysfs group.
Switch the notes attribute code to such a group, similar to how the
section allocation in the same file already works.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/sysfs.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 935629ac21fa16504ddb5f3762af5539572c3bf1..4f37970f99c999589257713926395686f03103e6 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -145,20 +145,17 @@ static void remove_sect_attrs(struct module *mod)
  */
 
 struct module_notes_attrs {
-	struct kobject *dir;
-	unsigned int notes;
-	struct bin_attribute attrs[] __counted_by(notes);
+	struct attribute_group grp;
+	struct bin_attribute attrs[];
 };
 
-static void free_notes_attrs(struct module_notes_attrs *notes_attrs,
-			     unsigned int i)
+static void free_notes_attrs(struct module_notes_attrs *notes_attrs)
 {
-	if (notes_attrs->dir) {
-		while (i-- > 0)
-			sysfs_remove_bin_file(notes_attrs->dir,
-					      &notes_attrs->attrs[i]);
-		kobject_put(notes_attrs->dir);
-	}
+	struct bin_attribute **bin_attr;
+
+	for (bin_attr = notes_attrs->grp.bin_attrs; *bin_attr; bin_attr++)
+		kfree((*bin_attr)->attr.name);
+	kfree(notes_attrs->grp.bin_attrs);
 	kfree(notes_attrs);
 }
 
@@ -166,6 +163,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 {
 	unsigned int notes, loaded, i;
 	struct module_notes_attrs *notes_attrs;
+	struct bin_attribute **gattr;
 	struct bin_attribute *nattr;
 	int ret;
 
@@ -184,7 +182,15 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 	if (!notes_attrs)
 		return -ENOMEM;
 
-	notes_attrs->notes = notes;
+	gattr = kcalloc(notes + 1, sizeof(*gattr), GFP_KERNEL);
+	if (!gattr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	notes_attrs->grp.name = "notes";
+	notes_attrs->grp.bin_attrs = gattr;
+
 	nattr = &notes_attrs->attrs[0];
 	for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {
 		if (sect_empty(&info->sechdrs[i]))
@@ -196,35 +202,27 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 			nattr->size = info->sechdrs[i].sh_size;
 			nattr->private = (void *)info->sechdrs[i].sh_addr;
 			nattr->read = sysfs_bin_attr_simple_read;
-			++nattr;
+			*(gattr++) = nattr++;
 		}
 		++loaded;
 	}
 
-	notes_attrs->dir = kobject_create_and_add("notes", &mod->mkobj.kobj);
-	if (!notes_attrs->dir) {
-		ret = -ENOMEM;
+	ret = sysfs_create_group(&mod->mkobj.kobj, &notes_attrs->grp);
+	if (ret)
 		goto out;
-	}
-
-	for (i = 0; i < notes; ++i) {
-		ret = sysfs_create_bin_file(notes_attrs->dir, &notes_attrs->attrs[i]);
-		if (ret)
-			goto out;
-	}
 
 	mod->notes_attrs = notes_attrs;
 	return 0;
 
 out:
-	free_notes_attrs(notes_attrs, i);
+	free_notes_attrs(notes_attrs);
 	return ret;
 }
 
 static void remove_notes_attrs(struct module *mod)
 {
 	if (mod->notes_attrs)
-		free_notes_attrs(mod->notes_attrs, mod->notes_attrs->notes);
+		free_notes_attrs(mod->notes_attrs);
 }
 
 #else /* !CONFIG_KALLSYMS */

-- 
2.47.1

