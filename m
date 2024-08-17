Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAA81EEE6
	for <linux-hardening@vger.kernel.org>; Sat, 17 Aug 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723904490; cv=none; b=bSmPwBsEG/5tHQs123JCMU/xkoLUDHVAw1HO07RPXG0aMRJOeOTftbKe2obbVtRbFv02nk05vjksGzvE2qoB/eREq+EVQHDiNtshOnYdvKBdY1M9KPQzR/XOICgcMNn2cDu1QlDnWyyLuFFzng5yyjiFpf9WN8o526qVdpwRwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723904490; c=relaxed/simple;
	bh=vjjnpzw4xihlbZ0brAqP1VmfV3dyscnLMEfBKjis4LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRpuSi7y9dg7/hikMCKInupzyqRXpc1ddnzHJM0QgXn7Xxpd4RaIs6iFfA/1WPs0OcPTjonR+q2HRDelUqaja4mpfIAzLOWSXVhUhQfX4OmzwZ7JOoyY99QUkpG7wjcNyuFpLdT04SSlcSSU8S72z0e627+1eyY7qtAJSA1DZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=kevwTIZs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="kevwTIZs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42812945633so23686055e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 17 Aug 2024 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723904486; x=1724509286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yIPvpn5RiREIdWEvUL9xddN+rBBaKKA9WfA/vQhO7s=;
        b=kevwTIZsWgb0Qcn2pajoUNJYXd3+lCvWBB/kOAZldjJs+JfystjbSlqbSFjdz4O4MK
         Y4vWHy5BrpH/8SUyf7TmwjoiiJxkSRdHR0HO3IBEP1ckCddjnLnPuTKmn/V93UwPusY4
         A47AyBEWe+biq3jAAg4KSzF3z4jMgJs24wTPveuN53SSUrGuv996w5EFo9GAyRE5+N2m
         cG2v5JvgLVe4R0EodLIhlS19LLQgYHTWZnONHshiaidY8luqkec4rUlWXkxldsZpkHs0
         LkmxfMmmUwtgwNDt9/9F61Ek2Fsyb9jgtrSp+c2MF4qdpaR6fhkEaJFj18FNJ1sWYwQ1
         a/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723904486; x=1724509286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yIPvpn5RiREIdWEvUL9xddN+rBBaKKA9WfA/vQhO7s=;
        b=WKYzF6fzjfYc3/9FkYyTllDganDizo/4AbBkq6lSD1/25s5Gdrr9abgbf/E0MDBJok
         GmTEwDg05WyOvFnYsY0G93scJlkuBRJjFyCIughYZSfp2U+/xVEQB6S2Cy9aX1GIlKtJ
         7E1Nc7g8mfbyqxVO+r8n7oUcnc/ZkHUOQv77aeSqbACU/E5WkrEKTvY5LQWVTgZIApjH
         1tvuMDyuQHqOfKQVfUtmpcfTb64oY7IjmgcSI9kLw84ZuLJqVe/V1KmneSZausbJFT7T
         16g4npVaV1FtS6Tv/foNy8feWXl1e62LOiB32Bh+H8eOZT2/i5D9XUGaT+euSxzE7RRR
         bPlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdiBtdxdsJWtziQCtZmtTCHhyQvuitWABGjmdXg8C8Czeojj1EVZDNRJb4ZIc4j/TIhZOpUfYtzVnXPrh6jDi1ZYITAM4cwiSONow+FysS
X-Gm-Message-State: AOJu0YzAf2PX/0C69q1YS6InlAcV7ELGGu+7Ti7+1WgOGQ6jWGsLXDQ9
	Q/zLvzalkHkJVNokQQFr/R8Lmd4eQ2LGhIzbDV9GgHAcZxLy297jEj1zFgsoCvE=
X-Google-Smtp-Source: AGHT+IGTnbsZzhgA30HV1nq4jUBYXpBcMACaAMCY4g0TJpzNpkhYWLeLKT8kVFN1sqa4jKwuB/P+pA==
X-Received: by 2002:adf:a2da:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-3719464cd9dmr4721751f8f.28.1723904486056;
        Sat, 17 Aug 2024 07:21:26 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a397sm6008530f8f.24.2024.08.17.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 07:21:25 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: anna@kernel.org,
	jlayton@kernel.org,
	bcodding@redhat.com,
	kolga@netapp.com,
	josef@toxicpanda.com,
	gustavoars@kernel.org,
	kees@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] NFS/flexfiles: Replace one-element array with flexible-array member
Date: Sat, 17 Aug 2024 16:20:23 +0200
Message-ID: <20240817142022.68411-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated one-element array with a modern flexible-array
member in the struct nfs4_flexfile_layoutreturn_args.

Adjust the struct size accordingly.

There are no binary differences after this conversion.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
 fs/nfs/flexfilelayout/flexfilelayout.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 39ba9f4208aa..fc698fa9aaea 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2224,7 +2224,7 @@ ff_layout_prepare_layoutreturn(struct nfs4_layoutreturn_args *args)
 	struct nfs4_flexfile_layoutreturn_args *ff_args;
 	struct nfs4_flexfile_layout *ff_layout = FF_LAYOUT_FROM_HDR(args->layout);
 
-	ff_args = kmalloc(sizeof(*ff_args), nfs_io_gfp_mask());
+	ff_args = kmalloc(struct_size(ff_args, pages, 1), nfs_io_gfp_mask());
 	if (!ff_args)
 		goto out_nomem;
 	ff_args->pages[0] = alloc_page(nfs_io_gfp_mask());
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index f84b3fb0dddd..a269753f9a46 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -115,7 +115,7 @@ struct nfs4_flexfile_layoutreturn_args {
 	struct nfs42_layoutstat_devinfo devinfo[FF_LAYOUTSTATS_MAXDEV];
 	unsigned int num_errors;
 	unsigned int num_dev;
-	struct page *pages[1];
+	struct page *pages[];
 };
 
 static inline struct nfs4_flexfile_layout *
-- 
2.46.0

