Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965151865EC
	for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225285; cv=none; b=s3z1Iy9LEQG+JnBySPRhGLVRrLNjdh54i1I2wRyzufgPu4RuZ0Q8QMZYIeNwqZaz2cts2CVFGd8wdWcG03sGVfzN1kqwYPg5WGaOmUGJOcxGJwU+ZEOJLdeZuIdQabfE/dxNqmogfub+son4fGGm3lO7eNPg855+BjA/TY3467I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225285; c=relaxed/simple;
	bh=6cTHjuS7EBHBD4xtZqJfXECj5rtdnxI2Mext/1qxcOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCOF59VRjd2Fj9UPOCFzgleqZU7e5MhcnWb0LkjVjOZxPlh2sUVHrGSTLNE3BWRDyCi9ppvsiy7rAWNkkbFu4r67h4IIH6pk8DG7ZBvsxC2CHLMzupom+lhp5q7FKEZVp1372h5vmvdRMNwWbMSUF5C89OgZqUVwAfQ1WtwPRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=3ZFnPrBn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="3ZFnPrBn"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3df1a3cb6so358330a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 04:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1726225282; x=1726830082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6x+FbPBr6LOLetSJiGWO7sMy2gp7jD6h7M3aIAswxc=;
        b=3ZFnPrBnyanINfPLnYAtBudE5xd3tCt592o+CnE8XH9GZ4OXdCRiUUKtVbQTFknxwS
         NkrvTKa2Lxm4GMWstXztXxECMLVUthnDC2tPxe6JCa87j/d4yhqQ8U4w8DDeRJTSj0BN
         OeGYoiYYmaJ6Bt3y+tQ6WD6GjrG4hvMIC+Ba4fofDZtBY4Eq6bIOvZjElQntm1eabNa2
         +gLX+mE6vwZoYHTtrtZokHRV+5QtFYwQkjROJgzUZNXIFRU0/muzcLl/gr+VDpgegEMd
         FRuNPfpIr9E41gOZgjpbYXYgWuRjGhrtiHCWn2saEma+/cAAoxoH0EokIddKWVGt7YDf
         p37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726225282; x=1726830082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6x+FbPBr6LOLetSJiGWO7sMy2gp7jD6h7M3aIAswxc=;
        b=Hx2PYPWasxzC8fh24i4AotA4mmTF//1XBdZh3spL9uzQEBLV8xEv2GUDChy9IoLbXl
         7p9PwK8f6VzX2La9+UpM8BldzFA/BWZqw0plsJ155ymah3fY6n1K4OeJaF/i44t39JZm
         +gws0pwZ0l2nLSaND4uPK9FpPRRExsKeWpe+dH4lapFXUCdoBGx3dU08kbvcfb2xrojd
         vhs4ZusbwpAV+3NXapmI1Ig7kVOhaxC6Gq1jvEhslg2RaaordSiMzA8McdcVUuIoHt0C
         KmUweIO6NoDjoc2OMa1+lvG9LR0uv5Unho7dfiwZkrsAkIQ48NMpQYRMgu4L2oNL8eZK
         BoZA==
X-Forwarded-Encrypted: i=1; AJvYcCVIlAbIDLpZnlgLN8asRUSbqaWKbLxoQEEnScgOzGjhSAoS7e72d6eHnSB+x4muNgjCeO/Lhy8OvgSW4mIyj+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4j5LRjF9o569rXLKzZx/ioquYovEA3wvL5lHo5yznBnmij/1U
	PSrbq22CwopvMq6X4SrPfG3WQkTWeNc3ofkv2kq/6dpEQ64y19W+uXzGuydvWNU=
X-Google-Smtp-Source: AGHT+IGIsdWg7O3qlfv6WqCrKkIhGhaWd9vPtXUZRebQ9smyngb4xqLB6yJC4zM5VZ5puQwM7VOsnw==
X-Received: by 2002:a05:6402:26c3:b0:5c4:bb1:6491 with SMTP id 4fb4d7f45d1cf-5c413e123b3mr1767817a12.3.1726225281653;
        Fri, 13 Sep 2024 04:01:21 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-245.dynamic.mnet-online.de. [62.216.208.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd51f84sm7459257a12.41.2024.09.13.04.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:01:21 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ext4: Annotate struct fname with __counted_by()
Date: Fri, 13 Sep 2024 13:00:14 +0200
Message-ID: <20240913110013.151331-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Inline and use struct_size() to calculate the number of bytes to
allocate for new_fn and remove the local variable len.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/ext4/dir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ff4514e4626b..8e7df15bb971 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -408,7 +408,7 @@ struct fname {
 	__u32		inode;
 	__u8		name_len;
 	__u8		file_type;
-	char		name[];
+	char		name[] __counted_by(name_len);
 };
 
 /*
@@ -464,14 +464,13 @@ int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
 	struct rb_node **p, *parent = NULL;
 	struct fname *fname, *new_fn;
 	struct dir_private_info *info;
-	int len;
 
 	info = dir_file->private_data;
 	p = &info->root.rb_node;
 
 	/* Create and allocate the fname structure */
-	len = sizeof(struct fname) + ent_name->len + 1;
-	new_fn = kzalloc(len, GFP_KERNEL);
+	new_fn = kzalloc(struct_size(new_fn, name, ent_name->len + 1),
+			 GFP_KERNEL);
 	if (!new_fn)
 		return -ENOMEM;
 	new_fn->hash = hash;
-- 
2.46.0

