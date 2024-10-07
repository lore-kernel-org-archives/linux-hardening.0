Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE971D2F73
	for <linux-hardening@vger.kernel.org>; Mon,  7 Oct 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306484; cv=none; b=jm/aPOJGEeU0uNk6Zq5YpHaoYJpixzIaNUoxGFVPDxppqQ3l+P9rMxBrdyuwFdl8KbfI6B23qipSf/prGv5KvPQXl3UxEIyy427jLVUjmEpVqC/ufyV5Z74CpuupyJJL/9QBPlMNI3Mawv0l9bQjkT49X3a0Zbvs3wek5GiUGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306484; c=relaxed/simple;
	bh=KYZdCfC0G0TJf0tBV4UmKxSBuXIDsk+eUUerAygPEqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xykz62He3FxsjlEMqJCG1w6EzcCK7pZvOICxPSi4t1TBmC5PGKrw7xcTXYvP1bkwAKml1/YdZgBg4m8SOuo6qLcyLzdH1IEzcfY4LQfwUxfMBiFVe1PiRPMixpEkg++8XM6tQBbH50Gjs6WE5YLFhNUf3VrNQXOBhWQA7wnZfpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=giuipzxN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="giuipzxN"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb1e3b449so6268765e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 07 Oct 2024 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1728306480; x=1728911280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CnzLtnFN9tco4+Q7+k8LRZ84/ndqz1jYrt7A2OLgTL8=;
        b=giuipzxNZ2QUJBrrDgDyuIRgXTX1m7/lHJASPXJvXG/NHGRSzrx0qnYAFoiomS0dop
         njqZ7mtWHbP6Bcyzc5Bje3kPnHaoa/4KYHhYhoLuPDsD7g2vAyY18lElg0Guiw6/f5zn
         F9nP8LfQIUrZUXBvdCRilFt+4JfnmNx6Zj19+EaKmK0XJ8SMojq1SfXl1PqZlWk6CJwp
         g7wo3xOu1ppb+P2kG6qjHr7USlREUetmG/DPlolv9dQkPeezq7VWD61Bfhuyq7dAx1WT
         h+fRPuTCELSSL2bXySB6DB+Z4RY64P9xGMH9DfzVGsEpI1y3Pwts8xaqBLmdU4q/lE6K
         7ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306480; x=1728911280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnzLtnFN9tco4+Q7+k8LRZ84/ndqz1jYrt7A2OLgTL8=;
        b=VBqF4ZDi5U9fc1VMSUlsp53Z1J8r46RHmn7owLRgb37DKcKt/XyhW1s5Qc+2jG0Gez
         SwOs8/160uzzF9/JM22tIo70mJVk07MFA65D8RlqBr2ujgg0eYGfV1DXkU+TnWNYG5v3
         +jnfBUuMqLds7lCnyZdL8itVv59Dt+UknVlknUCQfuX2KWGjODhcfHqrcFVX+E9j+wHj
         yJxedzPbFo84mAFXXkv5jDTfdAdz9ushk7yxykChDuBnZW/gIL79Fn41HbV5/ThzCdvm
         KILuengsZjGU7ZHEqemyXXMA8WmdH6vGMvMc6uuqvPNq8GILX8aDyFVp0k0ew0INkybA
         C9uw==
X-Forwarded-Encrypted: i=1; AJvYcCX1WO2oxTAsaun6SVE+6OwNGL5kfTrFSC6UrcR++Kgcc9V7dx3z+SltwXzkpCyof0RvBs4MsXquzDKUl0sWF2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9tfe3LWHfCkJl++Qm50us8AFkGR5oaZg5XadLzxy0JL1jAE/
	hSsALwRshb1CGTOwjTA74TX/7PoLlZEYPsqU6RPpiwADZ+N9CGTZkW+mAcHKL3E=
X-Google-Smtp-Source: AGHT+IFKomC1GoHgGz5NqJWTmdK3mKrk/2NM18HnZpDqf7JGIgfOX+Yoshy8dmLmPM10rEY56FpXrw==
X-Received: by 2002:a05:6000:186c:b0:374:c800:dc3d with SMTP id ffacd0b85a97d-37d0e6f362fmr3112919f8f.1.1728306480338;
        Mon, 07 Oct 2024 06:08:00 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-206.dynamic.mnet-online.de. [62.216.208.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695f113sm5679931f8f.80.2024.10.07.06.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:07:59 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH] ext4: Annotate struct fname with __counted_by()
Date: Mon,  7 Oct 2024 15:07:16 +0200
Message-ID: <20241007130716.3442-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.2
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/dir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ef6a3c8f3a9a..02d47a64e8d1 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -418,7 +418,7 @@ struct fname {
 	__u32		inode;
 	__u8		name_len;
 	__u8		file_type;
-	char		name[];
+	char		name[] __counted_by(name_len);
 };
 
 /*
@@ -471,14 +471,13 @@ int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
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
2.46.2

