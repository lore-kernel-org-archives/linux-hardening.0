Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40463207DE6;
	Mon, 16 Dec 2024 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376625; cv=none; b=FZbzkHwkHcR09atFh3AiGzNDThDwGMc4nMZFHfOTbygqtEv/FtLdryJF1ObsX7+DPnAxC6/LPIF9EBsXA+gsFh1L9e4yaf9dNkjVI6icptTXR1JYbBYDMJ1rmhYP7FfrstfhcE7njtLqPVDJmgfmh6EuPLgfnaFu6GMJ6zFDeww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376625; c=relaxed/simple;
	bh=kPbX9vewD0+nconYwUSoLoEMScFyNi2Lagyw6lolf6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvmKVODbA1HZ7tJL83Q9wxuFE3i+EnjqGJGZdUHC5CvJPxDllVuBMvRqUsLwYL4y8MFxCq+IgVZAkbMA72JoSBEAipLnTjU9rF40Ga/sZN3vaiErOWA32Fjx9n7FjO6dCO7v7WLX4voYk8jw9S7e5HG8WDLLk356a1pUr2k0wAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=n272yWVO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="n272yWVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734376618;
	bh=kPbX9vewD0+nconYwUSoLoEMScFyNi2Lagyw6lolf6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n272yWVOQ7cE0Ao/evejaJThGEQHM6knXxHbiRd4jnEepwsDppZK+PhhiqMz8KCas
	 Udsqx1rdbl03j3OLdtCYZEwXIAOEptGNIpnIjgjtu2ig6sZ+jeUlW7Ne9hHTbAgHxm
	 uRcKdlAfv/5kPd0UM203bG+i08n/H5T5XhTzDXFM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 20:16:41 +0100
Subject: [PATCH 1/4] module: sysfs: Drop member 'nsections'
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-module-v1-1-f81e49e54ce4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734376617; l=1863;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kPbX9vewD0+nconYwUSoLoEMScFyNi2Lagyw6lolf6c=;
 b=0XJIafOGM2NpbvvaksZLG/iWNunuc2zhszVS1JTvtP7pBBFv2/JsZpfawBh4460TuBUc0xvVY
 E7E0xv2QjLBCrmAIMtvhqJ0x/iJvjbUKYkH2BKpaNNxijyvR1NgMdhw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The member is only used to iterate over all attributes in
free_sect_attrs(). However the attribute group can already be used for
that. Use the group and drop 'nsections'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/sysfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 456358e1fdc43e6b5b24f383bbefa37812971174..b7841f76a933114e6dbd0fc2d32a60b66b7966b6 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -26,7 +26,6 @@ struct module_sect_attr {
 
 struct module_sect_attrs {
 	struct attribute_group grp;
-	unsigned int nsections;
 	struct module_sect_attr attrs[];
 };
 
@@ -62,10 +61,10 @@ static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
 
 static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
 {
-	unsigned int section;
+	struct bin_attribute **bin_attr;
 
-	for (section = 0; section < sect_attrs->nsections; section++)
-		kfree(sect_attrs->attrs[section].battr.attr.name);
+	for (bin_attr = sect_attrs->grp.bin_attrs; *bin_attr; bin_attr++)
+		kfree((*bin_attr)->attr.name);
 	kfree(sect_attrs);
 }
 
@@ -92,7 +91,6 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 	sect_attrs->grp.name = "sections";
 	sect_attrs->grp.bin_attrs = (void *)sect_attrs + size[0];
 
-	sect_attrs->nsections = 0;
 	sattr = &sect_attrs->attrs[0];
 	gattr = &sect_attrs->grp.bin_attrs[0];
 	for (i = 0; i < info->hdr->e_shnum; i++) {
@@ -108,7 +106,6 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 			ret = -ENOMEM;
 			goto out;
 		}
-		sect_attrs->nsections++;
 		sattr->battr.read = module_sect_read;
 		sattr->battr.size = MODULE_SECT_READ_SIZE;
 		sattr->battr.attr.mode = 0400;

-- 
2.47.1

