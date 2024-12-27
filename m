Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29191F37A3;
	Fri, 27 Dec 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735305821; cv=none; b=j+QryEPE/C4Gx7XdMbj0LG/7d37JdZ/mqbmvwuFFZTUEly3dU4ZljGrPOUU3SHNpqJNTfi2ZpuUcHBfhCa0rM1rAGRDvm7CteSZugF14aKcIKTJ6B95FyuKurxTsxYZCKQWyRC0Obz+W1ATiaGTWua+MX15eVq9f5TaV8hUub8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735305821; c=relaxed/simple;
	bh=kPbX9vewD0+nconYwUSoLoEMScFyNi2Lagyw6lolf6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIywl/r6gUoNzkkijqPBYpzpSo820/t2nLpB49iO7IpXCV/KgC7qUtPfugl5TQfVVZqygZOIjs4tz7Al8CTZ4X1P3JF6oOlhioeM6SXyNdAA+Dq947chOjgHI2z9ztUWFx+OIvTGSGZZZtdl6qFqk01cUIFTpu1zEGGEKrnI/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OYRwV1Lx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OYRwV1Lx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735305810;
	bh=kPbX9vewD0+nconYwUSoLoEMScFyNi2Lagyw6lolf6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OYRwV1LxutLunu6Ity59v+8g3fJJTh2eCeyXIbJLWNQhtOIwVDx7jMMREsBOrK0ut
	 QFyVgbxm5dElWbM1sMlJV+mSXup29YM9YlLZzvwhb7DwV0ArV8r3l/weoRLZ5P2ztE
	 0OnGyLMZvoasYZTsOUplofTi21yJ6W/tTkoWJZso=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 27 Dec 2024 14:23:20 +0100
Subject: [PATCH v2 1/6] module: sysfs: Drop member
 'module_sect_attrs::nsections'
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241227-sysfs-const-bin_attr-module-v2-1-e267275f0f37@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735305809; l=1863;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kPbX9vewD0+nconYwUSoLoEMScFyNi2Lagyw6lolf6c=;
 b=RcpP+ZL9Id2+eYyAu7kl1Eoqaek5pf5vxL1BluAJXsgmHJQGK2KcJE47Jc7GQ0N0uSoTJ4M/C
 8j6i32V/JPPCAA+kVSK8Td027jC/v9CULXCmZswvQDcjtCpnyxaDThu
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

