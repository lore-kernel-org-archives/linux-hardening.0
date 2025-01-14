Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F51CDFC1
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jan 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891439; cv=none; b=UAocIMu5N8vq3ryu5rOk2vtSDJ2f7nizQSKno91W82LMpE2O6VplfVxOuu68DUfWETrlgZ61Dt19Scg1PNpnKy8Ib5YPrw2rhnxAKnl2Ya+LgvggrXQrbKseul/Tj/xAVZnEzhucRSr9FdXosVXW4phIgn7Nlmw/yChr1nW9vqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891439; c=relaxed/simple;
	bh=o608bbBSXgBbckZm3C+nmGzItyQ406vPwgM2DFNXamk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mM1zfELdpupyOuMbxPQHI4B+cI1G1J9MtvVIKNkEBhC4x9Yov5MpnkFPVeI3Qw9+tlk1jaoz78gIz1pHywAHSD13UxUkfIKaqyirbKU9P0gu5R7QYSou9j+kYUDGVpnB/1oGa8sj6/T+3oaGMI3FOC0DoAgCr+cDxhauGqfUwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wJ4OBq6l; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wJ4OBq6l"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736891434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JbhykM6+EaaFeGUvuFELTlis3wZ07yx3+ZYkSCWCNVw=;
	b=wJ4OBq6lgq8S3DwdJc24RBrVrMWwaDJAckagV0HpNSbpevi+D91cfYlRGyFo01Vu+naIqt
	O4JKas+CWDCTjWglhoHFr1ZF5zqM9TZOU3YfONkyggBJP6Y4zqDeLnXaubA8hafh0JJ/O/
	LUGVmhgIxcnczc01fAX3/ZsBHJVpvJQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH v2] params: Annotate struct module_param_attrs with __counted_by()
Date: Tue, 14 Jan 2025 22:49:54 +0100
Message-ID: <20250114214956.915982-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Increment num before adding a new param_attribute to the attrs array and
adjust the array index accordingly. Increment num immediately after the
first reallocation such that the reallocation for the NULL terminator
only needs to add 1 (instead of 2) to mk->mp->num.

Use struct_size() instead of manually calculating the size for the
reallocation.

Use krealloc_array() for the additional NULL terminator.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use krealloc_array() as suggested by Andy Shevchenko
- Link to v1: https://lore.kernel.org/r/20240823123300.37574-1-thorsten.blum@toblux.com/
---
 kernel/params.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 2e447f8ae183..5f6643676697 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -551,7 +551,7 @@ struct module_param_attrs
 {
 	unsigned int num;
 	struct attribute_group grp;
-	struct param_attribute attrs[];
+	struct param_attribute attrs[] __counted_by(num);
 };
 
 #ifdef CONFIG_SYSFS
@@ -651,35 +651,32 @@ static __modinit int add_sysfs_param(struct module_kobject *mk,
 	}
 
 	/* Enlarge allocations. */
-	new_mp = krealloc(mk->mp,
-			  sizeof(*mk->mp) +
-			  sizeof(mk->mp->attrs[0]) * (mk->mp->num + 1),
+	new_mp = krealloc(mk->mp, struct_size(mk->mp, attrs, mk->mp->num + 1),
 			  GFP_KERNEL);
 	if (!new_mp)
 		return -ENOMEM;
 	mk->mp = new_mp;
+	mk->mp->num++;
 
 	/* Extra pointer for NULL terminator */
-	new_attrs = krealloc(mk->mp->grp.attrs,
-			     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 2),
-			     GFP_KERNEL);
+	new_attrs = krealloc_array(mk->mp->grp.attrs, mk->mp->num + 1,
+				   sizeof(mk->mp->grp.attrs[0]), GFP_KERNEL);
 	if (!new_attrs)
 		return -ENOMEM;
 	mk->mp->grp.attrs = new_attrs;
 
 	/* Tack new one on the end. */
-	memset(&mk->mp->attrs[mk->mp->num], 0, sizeof(mk->mp->attrs[0]));
-	sysfs_attr_init(&mk->mp->attrs[mk->mp->num].mattr.attr);
-	mk->mp->attrs[mk->mp->num].param = kp;
-	mk->mp->attrs[mk->mp->num].mattr.show = param_attr_show;
+	memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));
+	sysfs_attr_init(&mk->mp->attrs[mk->mp->num - 1].mattr.attr);
+	mk->mp->attrs[mk->mp->num - 1].param = kp;
+	mk->mp->attrs[mk->mp->num - 1].mattr.show = param_attr_show;
 	/* Do not allow runtime DAC changes to make param writable. */
 	if ((kp->perm & (S_IWUSR | S_IWGRP | S_IWOTH)) != 0)
-		mk->mp->attrs[mk->mp->num].mattr.store = param_attr_store;
+		mk->mp->attrs[mk->mp->num - 1].mattr.store = param_attr_store;
 	else
-		mk->mp->attrs[mk->mp->num].mattr.store = NULL;
-	mk->mp->attrs[mk->mp->num].mattr.attr.name = (char *)name;
-	mk->mp->attrs[mk->mp->num].mattr.attr.mode = kp->perm;
-	mk->mp->num++;
+		mk->mp->attrs[mk->mp->num - 1].mattr.store = NULL;
+	mk->mp->attrs[mk->mp->num - 1].mattr.attr.name = (char *)name;
+	mk->mp->attrs[mk->mp->num - 1].mattr.attr.mode = kp->perm;
 
 	/* Fix up all the pointers, since krealloc can move us */
 	for (i = 0; i < mk->mp->num; i++)
-- 
2.47.1

