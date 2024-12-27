Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995E1F37AD;
	Fri, 27 Dec 2024 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735305821; cv=none; b=qttBwbinkKr919ugDxpxTPo6o8Od6cBiRcXfPiEWjdbb1hCIKbqiir95fnkPp3MJDMaSMvmTtR/OXvzUFmswqe3u3hZSdRUMDWYt3BYrS4Cdo7SVkzKx8MZnSeUvCAbPwlnC++9XrSn/iEohS/MM2JObC7TrJkdhBsymbxfcggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735305821; c=relaxed/simple;
	bh=K02KJuxHoyR3doDRIJgCmzfosr6MYLp9M2UJxLzc+pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCbDdrq4lwlH7knbuqst0nia63bz92q2yaWo2Or5DNc6Au3caSutO8gbnytUtt8f8b+rDunDQovN5DbpF9K25RSt3Qv9jKhTZwkPSKUJQ1dZ8DpNCW9PWh6khbxscwEpwmtM0y1MvDnM74la12v6YK6kjbpvw3yqpzI0sI9HSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WxAzzrvX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WxAzzrvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735305810;
	bh=K02KJuxHoyR3doDRIJgCmzfosr6MYLp9M2UJxLzc+pw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WxAzzrvX6I9x+DRGo4tI5HllXQSsE23PnCt+7cUWcxn4ZXOwOAP4lZbEhH5zJhary
	 uTHlRtjf5A4ZVWteDBW7zU80a1E9mmvyRX4sC8UnWSZLlpZ/iJeo8+8OVaVE1irCvC
	 8u/nwk5Kwerx6bJwLcX0hUKjdxVg1gN0OYM7cFvw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 27 Dec 2024 14:23:24 +0100
Subject: [PATCH v2 5/6] module: sysfs: Add notes attributes through
 attribute_group
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241227-sysfs-const-bin_attr-module-v2-5-e267275f0f37@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735305809; l=3549;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K02KJuxHoyR3doDRIJgCmzfosr6MYLp9M2UJxLzc+pw=;
 b=7xBBtyCfmRqKo+9VgUdWzdBI8PeiiNgD0iy3kGRotz2l4vcAuDwJWpicTJfUsFaVZOZi4T4uv
 F8PZPjR29StCHtT72pSrMPC781lI64QHJSDMlfYbKDXfcZyGHjyYKci
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
 kernel/module/sysfs.c | 54 ++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 4b1a963b712b609cde1c4375e789a6ee7f359c7a..d04cb12eac7be63dd0bb65bd55e97280e7875e4e 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -138,20 +138,13 @@ static void remove_sect_attrs(struct module *mod)
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
+	kfree(notes_attrs->grp.bin_attrs);
 	kfree(notes_attrs);
 }
 
@@ -159,6 +152,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 {
 	unsigned int notes, loaded, i;
 	struct module_notes_attrs *notes_attrs;
+	struct bin_attribute **gattr;
 	struct bin_attribute *nattr;
 	int ret;
 
@@ -177,7 +171,15 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 	if (!notes_attrs)
 		return -ENOMEM;
 
-	notes_attrs->notes = notes;
+	gattr = kcalloc(notes + 1, sizeof(*gattr), GFP_KERNEL);
+	if (!gattr) {
+		kfree(notes_attrs);
+		return -ENOMEM;
+	}
+
+	notes_attrs->grp.name = "notes";
+	notes_attrs->grp.bin_attrs = gattr;
+
 	nattr = &notes_attrs->attrs[0];
 	for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {
 		if (sect_empty(&info->sechdrs[i]))
@@ -189,35 +191,35 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
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
-	if (mod->notes_attrs)
-		free_notes_attrs(mod->notes_attrs, mod->notes_attrs->notes);
+	if (mod->notes_attrs) {
+		sysfs_remove_group(&mod->mkobj.kobj,
+				   &mod->notes_attrs->grp);
+		/*
+		 * We are positive that no one is using any notes attrs
+		 * at this point.  Deallocate immediately.
+		 */
+		free_notes_attrs(mod->notes_attrs);
+		mod->notes_attrs = NULL;
+	}
 }
 
 #else /* !CONFIG_KALLSYMS */

-- 
2.47.1

