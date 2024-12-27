Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28BC1F2C56;
	Fri, 27 Dec 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735305821; cv=none; b=epLt0DDSFRERcU4gb4S3asN3zft+O3ZUr/h9+fkKr+K4N+tQkSX77x8ga5CkR77XzoqUxLpxAqv2LHlPFfPNCqJbGPPohnQwQ30pQ3hy2OeeE3O+olPA5OZGjgt7Rr0p63LNom6U33/0UAHcNmmGY3gak6tkozDjwYxvvHUlbeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735305821; c=relaxed/simple;
	bh=NyHZ3hkjhrnYderQwPxSsaZMIcwAhrt2JhACazI/sTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3CqeJs8etwQbWCSosE6kFKA/aoB47VJdr979sNpxje6220fBYKKmU1ixx8VTIxMiXJQZ7X+jgyYUgTFEiYugQyQt4Vv+RSxVa4adE2gwMjooxvFDL46VNc5J46uueM45i4m9xtdygM1i7yQOZj/oArnsDq0g9V/Q3gGUIExqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pooX4bma; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pooX4bma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735305810;
	bh=NyHZ3hkjhrnYderQwPxSsaZMIcwAhrt2JhACazI/sTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pooX4bma7jAaRAWYjllADvOAvPpwInQfV7wIyNjk9Na0P/qFKr5jT77K1WXfyiO8L
	 z9Wi8zvig7q6xHiyWPkYsgFc2SY8qXf1xlvdOda98JUrHNModmr/Zs/caFowflrUk5
	 k4dK2jG/gIcYjkzcWH0OiyJJxNajn357jqgrMgfk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 27 Dec 2024 14:23:21 +0100
Subject: [PATCH v2 2/6] module: sysfs: Drop member
 'module_sect_attr::address'
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241227-sysfs-const-bin_attr-module-v2-2-e267275f0f37@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735305809; l=2030;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=NyHZ3hkjhrnYderQwPxSsaZMIcwAhrt2JhACazI/sTg=;
 b=qorr1OiOp9Q218uSJEB+xwCv3OxULp3uoZXXNx+skBODc2tr9b+7YqaekUGi0Ky6uD7ntxi0p
 n0ZAHDJTOvvA+AROQEn1wa0l2vUPZhO0YWP9BSu0Gv5uQTkDbwFGWdY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

'struct bin_attribute' already contains the member 'private' to pass
custom data to the attribute handlers.
Use that instead of the custom 'address' member.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/sysfs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index b7841f76a933114e6dbd0fc2d32a60b66b7966b6..8955b3da1b499881256670418d41c5d52d9e5a5e 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -21,7 +21,6 @@
 #ifdef CONFIG_KALLSYMS
 struct module_sect_attr {
 	struct bin_attribute battr;
-	unsigned long address;
 };
 
 struct module_sect_attrs {
@@ -34,8 +33,6 @@ static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
 				struct bin_attribute *battr,
 				char *buf, loff_t pos, size_t count)
 {
-	struct module_sect_attr *sattr =
-		container_of(battr, struct module_sect_attr, battr);
 	char bounce[MODULE_SECT_READ_SIZE + 1];
 	size_t wrote;
 
@@ -52,7 +49,7 @@ static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
 	 */
 	wrote = scnprintf(bounce, sizeof(bounce), "0x%px\n",
 			  kallsyms_show_value(file->f_cred)
-				? (void *)sattr->address : NULL);
+				? battr->private : NULL);
 	count = min(count, wrote);
 	memcpy(buf, bounce, count);
 
@@ -99,7 +96,6 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 		if (sect_empty(sec))
 			continue;
 		sysfs_bin_attr_init(&sattr->battr);
-		sattr->address = sec->sh_addr;
 		sattr->battr.attr.name =
 			kstrdup(info->secstrings + sec->sh_name, GFP_KERNEL);
 		if (!sattr->battr.attr.name) {
@@ -107,6 +103,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 			goto out;
 		}
 		sattr->battr.read = module_sect_read;
+		sattr->battr.private = (void *)sec->sh_addr;
 		sattr->battr.size = MODULE_SECT_READ_SIZE;
 		sattr->battr.attr.mode = 0400;
 		*(gattr++) = &(sattr++)->battr;

-- 
2.47.1

