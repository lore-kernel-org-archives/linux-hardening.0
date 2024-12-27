Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D11F37AE;
	Fri, 27 Dec 2024 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735305821; cv=none; b=AnRQMHordknCfObVwPsYfRs0rhxfwzEqs4gcWdf969mRMKP0rAv5JO4R52u/V7AkIGVO434wAjqR+XED6pqszJFBRimHSsD86RmfQJm5MGJ1P3cssKCvQ8vX+FFe+8vWP9rnVRs+f6Jy/lYOr+NrI7TihjLE9d97A112tdPM3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735305821; c=relaxed/simple;
	bh=QoqqZMdscJifL85sSU4W8OY4Djn0uzs7qpMPaw0acy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=raYTK0SE0WP/163n7PqtYXErCIFx79RyS9rsOHSyylZxtpLYEP5TEyW4kx/0XiK3YcReCcTEAydIwaarrx/zeXypANP/m6/VGjoEoDU2ogZcFGg2Zgi54Pr1gzmB7ltDFfArIL8Le+JBnXNn5EZoY83xy2HcGTB/h06JugoHhQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IZweKvep; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IZweKvep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735305810;
	bh=QoqqZMdscJifL85sSU4W8OY4Djn0uzs7qpMPaw0acy0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IZweKvepjmNrroQf7LtKcfatQkN+yorL/6R2ymJD7ZCmmEI792MIwp1sXzBlT1C5O
	 3hMJiXYij7GpMFTGDmdiv82vSLgrisgIAP0PxVCxLS+pHNmswNhLsOBxfbmwPBC0/n
	 7/932UB1IfmN76G5BULIDU0Ms16jHDdS67GpC/mQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 27 Dec 2024 14:23:25 +0100
Subject: [PATCH v2 6/6] module: sysfs: Use const 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241227-sysfs-const-bin_attr-module-v2-6-e267275f0f37@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735305809; l=3169;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QoqqZMdscJifL85sSU4W8OY4Djn0uzs7qpMPaw0acy0=;
 b=GuaY64bsgH40d08xbPdonBvAes0cdWVElxunF+rL4jI1VlFfWopEe02t5GzNyq1ZVbNcu+jj/
 TxfzRl6frftArjL8DhH1HxBUujw56qi592q0GzRInSqBG+odDVfhKHW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core is switching to 'const struct bin_attribute's.
Prepare for that.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/sysfs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index d04cb12eac7be63dd0bb65bd55e97280e7875e4e..853745e353381204161541c6f29bf97c42ec6df3 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -26,7 +26,7 @@ struct module_sect_attrs {
 
 #define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
 static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
-				struct bin_attribute *battr,
+				const struct bin_attribute *battr,
 				char *buf, loff_t pos, size_t count)
 {
 	char bounce[MODULE_SECT_READ_SIZE + 1];
@@ -54,18 +54,18 @@ static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
 
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
 
 static int add_sect_attrs(struct module *mod, const struct load_info *info)
 {
 	struct module_sect_attrs *sect_attrs;
-	struct bin_attribute **gattr;
+	const struct bin_attribute **gattr;
 	struct bin_attribute *sattr;
 	unsigned int nloaded = 0, i;
 	int ret;
@@ -86,7 +86,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 
 	/* Setup section attributes. */
 	sect_attrs->grp.name = "sections";
-	sect_attrs->grp.bin_attrs = gattr;
+	sect_attrs->grp.bin_attrs_new = gattr;
 
 	sattr = &sect_attrs->attrs[0];
 	for (i = 0; i < info->hdr->e_shnum; i++) {
@@ -101,7 +101,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 			ret = -ENOMEM;
 			goto out;
 		}
-		sattr->read = module_sect_read;
+		sattr->read_new = module_sect_read;
 		sattr->private = (void *)sec->sh_addr;
 		sattr->size = MODULE_SECT_READ_SIZE;
 		sattr->attr.mode = 0400;
@@ -144,7 +144,7 @@ struct module_notes_attrs {
 
 static void free_notes_attrs(struct module_notes_attrs *notes_attrs)
 {
-	kfree(notes_attrs->grp.bin_attrs);
+	kfree(notes_attrs->grp.bin_attrs_new);
 	kfree(notes_attrs);
 }
 
@@ -152,7 +152,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 {
 	unsigned int notes, loaded, i;
 	struct module_notes_attrs *notes_attrs;
-	struct bin_attribute **gattr;
+	const struct bin_attribute **gattr;
 	struct bin_attribute *nattr;
 	int ret;
 
@@ -178,7 +178,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 	}
 
 	notes_attrs->grp.name = "notes";
-	notes_attrs->grp.bin_attrs = gattr;
+	notes_attrs->grp.bin_attrs_new = gattr;
 
 	nattr = &notes_attrs->attrs[0];
 	for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {

-- 
2.47.1

