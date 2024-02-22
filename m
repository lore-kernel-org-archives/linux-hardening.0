Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4D14B806
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626875; cv=none; b=StOBtpiv1/08TKphGEUZCfvV3etLx+swMWsgiqbK+jrU7J9FsvHzpYDUDuKU5agdIjn1z6eHS/yJqEKM4sqCHzgQt9RvmmyG5rGnG9JHnPEkaZDr/LHEzBlxOPU3Rq5rRgBwQz/ZIlIZFsJgKgy0vBKkKKc1JJNLQoOfKKxGlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626875; c=relaxed/simple;
	bh=4bS0TVmSCUPqoUf6s/inM/xSKlKTIsOpdrrMKBI49sU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VNOs/cbNdtZKl3rQryXSNn9GFPxELE8zn5G8/MAxBNshh8sKvQ8IsiMzxcM7TGb8YU2Pce49BcclT6kHXCYByj4K/OTToaFCJpxpwC5R3coCtR4/RACwSrkdlqMLtYayoDdh5SI9+Zq1Xdhv6LSVLPjROXMbnydG/lvJnzqaE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BMe3JlKZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BMe3JlKZ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e435542d41so3521506b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 10:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708626873; x=1709231673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfPkDsWA+aRwifarjemEZi4ZPjyIBZYeoxCAGkzcJUo=;
        b=BMe3JlKZRuiZuegvlXduL8PzAnStk/c5KenqpAP3z8AZvusiuLnMhssAt23mBpoS7u
         uDYglRRj4SsxSg6+2aIWzsPcrPBnMr4wg6j8D4tTBE4n/dDYGab629DNl3R4B++68d8w
         XkzInMMWkZGFd0rM5IEXMecQBjj61yC0uH68A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708626873; x=1709231673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfPkDsWA+aRwifarjemEZi4ZPjyIBZYeoxCAGkzcJUo=;
        b=UPQlWl2iwV2ufAqmCRyJj6ua6G3ziiBhIIJTVQlGNn5YXfMEvuPTS+4rZb0AvCmZni
         SAGcwWO4QVtM/+PKm0nlXJt5BGx0Nb973Hg4MWULgDjfyE0t2PWdWNXwsYQ91cEZ8nGN
         0579BdQGHKr6mkudY6zlUrXCMES2QpjaXgKnYiOtG7accFWHkF+U3Z4PzEMEKjCM0LKg
         Dg9pmz6c5znRqgt2xrLcRz34NywVpqBduyaHhiaAVvT1ynBpxWYxT3T7IoDBmeNANjCT
         Tz4id6h28vKVS6B9jXB+8RC1daJDx4Lfb3HndBgedmW7Giv4WY6yXvWyuadLm2tqwwYt
         cw+g==
X-Forwarded-Encrypted: i=1; AJvYcCV+MJF5xMzA6jMEo/jh4YIrM51NOecOEZPCHtWsnAWsaS1qpjeh/qHgKcBZuBQIBxOZlh5ondyRAYZGWsGZpp5EnVSqnakL5JzsW7L+4V49
X-Gm-Message-State: AOJu0Yy72bMTTndoG8bF3uY5cLSbNS3sUvrteT9QZM0a9B7KR7SI4rqG
	vIEtDGim0pqd9jUXl0UjQjtOj8DPDmhQQogBQWle3S5hSeRDOm8YWwQOlvyx7g==
X-Google-Smtp-Source: AGHT+IHlVSuqpMJVAPkZdW0IBzmZcOWzwDQRSfM0cYEyeruuDXgDNt3dHIva4hbm0JkVguyI5ImW7g==
X-Received: by 2002:a05:6a00:c82:b0:6e4:d81e:1399 with SMTP id a2-20020a056a000c8200b006e4d81e1399mr1292368pfv.22.1708626873289;
        Thu, 22 Feb 2024 10:34:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k6-20020a635a46000000b005db034d1514sm10675775pgm.82.2024.02.22.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:34:32 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	Luis Henriques <lhenriques@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: inode: Only d_invalidate() is needed
Date: Thu, 22 Feb 2024 10:34:31 -0800
Message-Id: <20240222183424.work.482-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4bS0TVmSCUPqoUf6s/inM/xSKlKTIsOpdrrMKBI49sU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl15O2wYWUWyoP3QKNOPh3mrCkRKF9q2EA8CvnY
 FXsTrEplXuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdeTtgAKCRCJcvTf3G3A
 JjydD/9f4FX3OVEjwZ0fXfY04dKcuWu2AUZmsPhfgk/M3jcN8bvvcOM4l5INP/5Wsk8QBA3FCbU
 lDCJUdtEDwSTHiSLfhpYtOWhLAMZsuJFqyzCq8hLF9ci64XbJ/Uup6lDL0wPSN71ah3ZopZrn/J
 o2BMfLll63i2IK+gMZyOa10ACj1lO1tTPCLGLJAYraA68Cot2BwzpQXfxUnrPKajkDSv0moZfxi
 khoWppIeHQxg/4lqCLC044T6vi0VNKRMH4JfGAZhmghSR8C+NoNWALeJqQRADxiOCjrte/7CX44
 1WuCyqJgEJEJs4YZw7WTKGRo4Exgfx2BIRDfYFyLVWbV8uJcuSN8dRVmkLdEEYrlsOp04U9l3AM
 uXeYYwg+OlPdQbRRmTx1FDTO817kbuCBbxcsHoaE86UqTAC9nA2Kgy3+Vmrc7EO+zjbaTTPXqo1
 HByprXyr7HegXwiWgpPGovxotZJFM6tfK03zQCDvbEhA31F8FPwUW1RTqytHvtL4ceV4J3wiOLl
 d36nMAKKb8D9DOXXHkNhdejB/jFnCjDiKw+6W1gqJd1RDP3vjOztRvjfbHiiEL6Bi2u4IAPFTuK
 W4UOEgpm1ZktZwm+q1tL5N+ePpZyHrW2cXihQYcpzq5nx66t+x+a/UUh1Kzts2KgQ+bWICjC3oN
 ZxpWBfr +ho2AWsw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Unloading a modular pstore backend with records in pstorefs would
trigger the dput() double-drop warning:

  WARNING: CPU: 0 PID: 2569 at fs/dcache.c:762 dput.part.0+0x3f3/0x410

Using the combo of d_drop()/dput() (as mentioned in
Documentation/filesystems/vfs.rst) isn't the right approach here, and
leads to the reference counting problem seen above. Use d_invalidate()
and update the code to not bother checking for error codes that can
never happen.

Suggested-by: Alexander Viro <viro@zeniv.linux.org.uk>
Fixes: 609e28bb139e ("pstore: Remove filesystem records when backend is unregistered")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
---
 fs/pstore/inode.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index d0d9bfdad30c..56815799ce79 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -307,7 +307,6 @@ int pstore_put_backend_records(struct pstore_info *psi)
 {
 	struct pstore_private *pos, *tmp;
 	struct dentry *root;
-	int rc = 0;
 
 	root = psinfo_lock_root();
 	if (!root)
@@ -317,11 +316,8 @@ int pstore_put_backend_records(struct pstore_info *psi)
 		list_for_each_entry_safe(pos, tmp, &records_list, list) {
 			if (pos->record->psi == psi) {
 				list_del_init(&pos->list);
-				rc = simple_unlink(d_inode(root), pos->dentry);
-				if (WARN_ON(rc))
-					break;
-				d_drop(pos->dentry);
-				dput(pos->dentry);
+				d_invalidate(pos->dentry);
+				simple_unlink(d_inode(root), pos->dentry);
 				pos->dentry = NULL;
 			}
 		}
@@ -329,7 +325,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 
 	inode_unlock(d_inode(root));
 
-	return rc;
+	return 0;
 }
 
 /*
-- 
2.34.1

