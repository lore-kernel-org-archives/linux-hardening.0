Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A454789
	for <linux-hardening@vger.kernel.org>; Fri, 22 Mar 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143682; cv=none; b=uM+GgZ7GsoZHPKtDFNHkitUEo+IUR6NfLpi8qMWl+u32kSQwprxT45Ae4AOwuTJRmfDTgG5xnfi2XG8vGP5q6yB3Va3ggbjqMbA00Yvm2a5t3i2j6g50D+LpTxN6lAJzoBqZxV/6tf42L3Qz7EnZ7auHjkBy20J6Ll9sO/FbVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143682; c=relaxed/simple;
	bh=kCrIrLnYkyAUgNslNwqkr4zJyZbl2lNoyftR8tSDdlI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=k15wW0RfED8+UeVzYbPGUCoV0Apph4VyfY02OoMjAIzSzwwfqaIvrn1ujwWPiv4sAmLLp0yA6hO8+CYySAAzN20VuqVSk09eZxbCb2lrzCC+/M1TFflrUvh4A8fU5PDyKbSmwC2HDRe+GDts0LDwMdRHf4bM5/fms8WhBL/P5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICE2PxMJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICE2PxMJ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso4288792276.1
        for <linux-hardening@vger.kernel.org>; Fri, 22 Mar 2024 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711143679; x=1711748479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+/cK4VrLmTWPA6318VKJ4yfhkh1wxnx4NftuUd7wmwI=;
        b=ICE2PxMJ0pRRE9X1RSeIBdCDt6WSzDrtld+1akYqJWklKvcRnOmDOFypiomn+wU9L/
         txklE3jYvhd2Of7Yc6eIcNBb+HAeBqwoxf8sSpW+CjywW/V9/EM5OZ/sU/5IE4sJ89Ju
         D1XgdHK/LBPqSyWr5ggtD4GDqCm8F2JsXJpMYi/RQPPcrEuhGpbXXIg83e1w+jm12iCC
         2+A4BYxC+r/s4tpV7/soZQ1ZSiSW6gALAizaqUQ+uRtfIm7dXvwnHxmDp+wur6wJuhKI
         KSr+2HIYZPaekav7/CZvlWg8UXf9TyNfm9Zq4hpxEKS/qDLGvbSrI0DkyBIFpPduZvJs
         IFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711143679; x=1711748479;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/cK4VrLmTWPA6318VKJ4yfhkh1wxnx4NftuUd7wmwI=;
        b=csX9npvUv5qZYO36eqq+R/ZZkA3UmS/7lUFAL+RHuCMcGDA3FJtqICJGzgO/YTIyyz
         MRBctycP0TfX93gI9vO5W9Ffby5GhUDxJwXSAhuwXGpPpPmPwG0J+AKoS8yXtye9ndKb
         F1Klw2pyyGCqVq268di5eywo4dOKu4Op8XUI+gmV3SOmBZxSSV5+JJjc1I1iOb4CowDc
         FZUJLG5n9YaiF+379wME0ktWXy/jTNjiM163HF9st74/tghyK1R+LX05hUQW/3vUQ0XL
         FRKSlTDP8F265bs7UV4Z1JLMwfsoU/CVtE0raPB+MJMFmXZKc0F6cH02IqsFJGodvqjL
         TPWw==
X-Forwarded-Encrypted: i=1; AJvYcCWB567VS0pT3Wp3pUp18/+T1Ah0LHNkZTU9I2lz/CYepvIDyvMUasi1vSb0EOXhAX1TcxuRXywA9detopWIZETI+gPaEZj5axGt2uwcvZ7n
X-Gm-Message-State: AOJu0YzzjdSlfXH0mAbURioy5GIOLZnsK96r1gjBsN6+WQjES40uVB9E
	8gMHBUe7zKF6+ITxFBRLNPQK/r7A6PHBTRu0eJzpF3CGzCwJ2IFVFsJOfOXfRRusXQS7oq2IH2i
	JPg51HX9tPqQg8hc64NxmOQ==
X-Google-Smtp-Source: AGHT+IGV3RX2MGf0rzvIY2wtaSmKEHIRi46fd9KyFEpKIZfmeQmn0ftN16HAHO5u/WowlKQbiF7dNJQp8ZxVbYBPTA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:110c:b0:dc6:53c3:bcbd with
 SMTP id o12-20020a056902110c00b00dc653c3bcbdmr191960ybu.7.1711143679706; Fri,
 22 Mar 2024 14:41:19 -0700 (PDT)
Date: Fri, 22 Mar 2024 21:41:18 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP76/WUC/x2MMQrDMAwAvxI0R+CoXdqvlAxGlhsttpFKSAj5e
 5xud3DcAS6m4vAeDjBZ1bWWLtM4AC+xfAU1dQcK9AwPIvSfFW47Zsdqd9AhceRFkPEVA2dKRCk K9EUzybr995/5PC+VZxzObgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711143678; l=7412;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=kCrIrLnYkyAUgNslNwqkr4zJyZbl2lNoyftR8tSDdlI=; b=7c4BR7I5R869dYN+qXFqT6r2bEMyf5ENyhGKnZH0/dZJUA5NivWjOyavzCgNTjbK/3UXliywE
 iH9vsjf384CC/WP6HVr6QX5YXoufyvayyHWPCuooJeA1MpLZu4LsnGo
X-Mailer: b4 0.12.3
Message-ID: <20240322-strncpy-fs-orangefs-dcache-c-v1-1-15d12debbf38@google.com>
Subject: [PATCH] orangefs: cleanup uses of strncpy
From: Justin Stitt <justinstitt@google.com>
To: Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

There is some care taken to ensure these destination buffers are
NUL-terminated by bounding the strncpy()'s by ORANGEFS_NAME_MAX - 1 or
ORANGEFS_MAX_SERVER_ADDR_LEN - 1. Instead, we can use the new 2-argument
version of strscpy() to guarantee NUL-termination on the destination
buffers while simplifying the code.

Based on usage with printf-likes, we can see these buffers are expected
to be NUL-terminated:
|	gossip_debug(GOSSIP_NAME_DEBUG,
|			"%s: doing lookup on %s under %pU,%d\n",
|			__func__,
|			new_op->upcall.req.lookup.d_name,
|			&new_op->upcall.req.lookup.parent_refn.khandle,
|			new_op->upcall.req.lookup.parent_refn.fs_id);
...
|	gossip_debug(GOSSIP_SUPER_DEBUG,
|			"Attempting ORANGEFS Remount via host %s\n",
|			new_op->upcall.req.fs_mount.orangefs_config_server);

NUL-padding isn't required for any of these destination buffers as
they've all been zero-allocated with op_alloc() or kzalloc().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/orangefs/dcache.c |  4 +---
 fs/orangefs/namei.c  | 26 ++++++++------------------
 fs/orangefs/super.c  | 17 ++++++-----------
 3 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
index 8bbe9486e3a6..395a00ed8ac7 100644
--- a/fs/orangefs/dcache.c
+++ b/fs/orangefs/dcache.c
@@ -33,9 +33,7 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
 
 	new_op->upcall.req.lookup.sym_follow = ORANGEFS_LOOKUP_LINK_NO_FOLLOW;
 	new_op->upcall.req.lookup.parent_refn = parent->refn;
-	strncpy(new_op->upcall.req.lookup.d_name,
-		dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name);
 
 	gossip_debug(GOSSIP_DCACHE_DEBUG,
 		     "%s:%s:%d interrupt flag [%d]\n",
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index c9dfd5c6a097..200558ec72f0 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -41,8 +41,7 @@ static int orangefs_create(struct mnt_idmap *idmap,
 	fill_default_sys_attrs(new_op->upcall.req.create.attributes,
 			       ORANGEFS_TYPE_METAFILE, mode);
 
-	strncpy(new_op->upcall.req.create.d_name,
-		dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.create.d_name, dentry->d_name.name);
 
 	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
 
@@ -137,8 +136,7 @@ static struct dentry *orangefs_lookup(struct inode *dir, struct dentry *dentry,
 		     &parent->refn.khandle);
 	new_op->upcall.req.lookup.parent_refn = parent->refn;
 
-	strncpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name);
 
 	gossip_debug(GOSSIP_NAME_DEBUG,
 		     "%s: doing lookup on %s under %pU,%d\n",
@@ -192,8 +190,7 @@ static int orangefs_unlink(struct inode *dir, struct dentry *dentry)
 		return -ENOMEM;
 
 	new_op->upcall.req.remove.parent_refn = parent->refn;
-	strncpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.remove.d_name, dentry->d_name.name);
 
 	ret = service_operation(new_op, "orangefs_unlink",
 				get_interruptible_flag(inode));
@@ -247,10 +244,8 @@ static int orangefs_symlink(struct mnt_idmap *idmap,
 			       ORANGEFS_TYPE_SYMLINK,
 			       mode);
 
-	strncpy(new_op->upcall.req.sym.entry_name,
-		dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
-	strncpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.sym.entry_name, dentry->d_name.name);
+	strscpy(new_op->upcall.req.sym.target, symname);
 
 	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
 
@@ -324,8 +319,7 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	fill_default_sys_attrs(new_op->upcall.req.mkdir.attributes,
 			      ORANGEFS_TYPE_DIRECTORY, mode);
 
-	strncpy(new_op->upcall.req.mkdir.d_name,
-		dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.mkdir.d_name, dentry->d_name.name);
 
 	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
 
@@ -405,12 +399,8 @@ static int orangefs_rename(struct mnt_idmap *idmap,
 	new_op->upcall.req.rename.old_parent_refn = ORANGEFS_I(old_dir)->refn;
 	new_op->upcall.req.rename.new_parent_refn = ORANGEFS_I(new_dir)->refn;
 
-	strncpy(new_op->upcall.req.rename.d_old_name,
-		old_dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
-	strncpy(new_op->upcall.req.rename.d_new_name,
-		new_dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.rename.d_old_name, old_dentry->d_name.name);
+	strscpy(new_op->upcall.req.rename.d_new_name, new_dentry->d_name.name);
 
 	ret = service_operation(new_op,
 				"orangefs_rename",
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 34849b4a3243..fb4d09c2f531 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -253,9 +253,8 @@ int orangefs_remount(struct orangefs_sb_info_s *orangefs_sb)
 	new_op = op_alloc(ORANGEFS_VFS_OP_FS_MOUNT);
 	if (!new_op)
 		return -ENOMEM;
-	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
-		orangefs_sb->devname,
-		ORANGEFS_MAX_SERVER_ADDR_LEN);
+	strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
+		orangefs_sb->devname);
 
 	gossip_debug(GOSSIP_SUPER_DEBUG,
 		     "Attempting ORANGEFS Remount via host %s\n",
@@ -400,8 +399,7 @@ static int orangefs_unmount(int id, __s32 fs_id, const char *devname)
 		return -ENOMEM;
 	op->upcall.req.fs_umount.id = id;
 	op->upcall.req.fs_umount.fs_id = fs_id;
-	strncpy(op->upcall.req.fs_umount.orangefs_config_server,
-	    devname, ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
+	strscpy(op->upcall.req.fs_umount.orangefs_config_server, devname);
 	r = service_operation(op, "orangefs_fs_umount", 0);
 	/* Not much to do about an error here. */
 	if (r)
@@ -494,9 +492,7 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	if (!new_op)
 		return ERR_PTR(-ENOMEM);
 
-	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
-		devname,
-		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
+	strscpy(new_op->upcall.req.fs_mount.orangefs_config_server, devname);
 
 	gossip_debug(GOSSIP_SUPER_DEBUG,
 		     "Attempting ORANGEFS Mount via host %s\n",
@@ -543,9 +539,8 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	 * on successful mount, store the devname and data
 	 * used
 	 */
-	strncpy(ORANGEFS_SB(sb)->devname,
-		devname,
-		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
+	strscpy(ORANGEFS_SB(sb)->devname, devname);
+
 
 	/* mount_pending must be cleared */
 	ORANGEFS_SB(sb)->mount_pending = 0;

---
base-commit: 241590e5a1d1b6219c8d3045c167f2fbcc076cbb
change-id: 20240322-strncpy-fs-orangefs-dcache-c-9a0cf2d22dae

Best regards,
--
Justin Stitt <justinstitt@google.com>

