Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ccmrnqGe"
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071621A2
	for <linux-hardening@vger.kernel.org>; Tue,  5 Dec 2023 10:26:27 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ce32821a53so1859271b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 Dec 2023 10:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701800786; x=1702405586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNgNutvDkhDCEpZkCHrbvZX51uthcX9S/dgTvap+CHg=;
        b=ccmrnqGefy2wA4FqGJld45wKa0jMfAiCyuWW7J+hf7Stk2fV9V9a9HMtxYo563I6cS
         pava/cdOQB7qiYHw63yAQcv8FsjY8JPGV3IDo0joc+SoqZPHwSCNBeq2qFS+/bwteaGl
         cPD7iO5KuQffZRaJVLz1+gPgkAe8/SPB0NQbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800786; x=1702405586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNgNutvDkhDCEpZkCHrbvZX51uthcX9S/dgTvap+CHg=;
        b=VkjoEXV7ZiHd992JTln2VPrluug078nSxQDr1OYnW7cmQJejPUKejxSZ8A/6xhCxVF
         V2OhvK1Mhe7+NccILi2e+SrR2aPaC0hH49lOuVQwgCJAxdI9Fk0q6+jYMqI9OqJ4Z+3U
         fOSB9Afiymf1jfmHZ7juX1KM/zYB75MUU+VDJH4KD379HdIKfApek6n/4nFON4cOfkRo
         qWGjvQJxPWTsLvo2w6JFUpD9i0MkxocZDx/8Wcqio8/2D42Ram37trYm6T7mYjlNU2J0
         CAdrmToG7NiEuhQC1cq5icqTt6ND1ZM8KuT9eYqahx3zIPh6fs6tHikKsO8WA1/ctTPN
         /bWw==
X-Gm-Message-State: AOJu0YyJVqKAHT8Bcw99O15n3V50PuIn1TefZ8mybNr03UgneN69Xm3O
	CcPs4qbAvKUNUkgOcn0B31ccEw==
X-Google-Smtp-Source: AGHT+IF64v3HUro+IAdNmJfhP5zEfUQ8LFp8hTAQAP04jfRuB28nLOYmpuhI2SgaFhVm6Uz6d08KGQ==
X-Received: by 2002:a05:6a00:4c8a:b0:6ce:5904:6e56 with SMTP id eb10-20020a056a004c8a00b006ce59046e56mr1845130pfb.57.1701800784800;
        Tue, 05 Dec 2023 10:26:24 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx9-20020a056a001e0900b006cdc6b9f0ecsm9717290pfb.81.2023.12.05.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:26:23 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] pstore: inode: Use __free(pstore_iput) for inode allocations
Date: Tue,  5 Dec 2023 10:26:16 -0800
Message-Id: <20231205182622.1329923-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205175449.work.110-kees@kernel.org>
References: <20231205175449.work.110-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; i=keescook@chromium.org;
 h=from:subject; bh=m7xJrXjdtPyXrzBu3Ps5CblAxgEi3qDUjX52ildQ9J4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlb2tIyZn9161W1eERCcqbEe/5HMlwbKkyq8hlo
 PIozsHu7tuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZW9rSAAKCRCJcvTf3G3A
 JrGcEACiwwEJFv3oAhDndCSOgseaVPz8t0wmLNflw7I79+2O05ST07/bnukMu7wcDTs6ld4FbLO
 96grfA1IyYXAU9844SLcKwzhoP0ulK+dmxQgUwf1Q5vPFHe7IAJh1SPwHoEe6pjBkkXs/ACBISS
 ep3FTHlt/AmiJ2L6Gy8ZfTO+paAqhGEboybqlfzW12gLQs/Zl9/bKotOHcyIghbdCKJ8/M0NoXP
 91yTm4PES+zC3pxgDS/wfPkKIZzmySj0z9vaLd0uTUNJPfj12LUrU4uxm/CuUlPzKJV36epH+vv
 zyWOesh1ZbLoae9vCk74CQuICILefP7sUR3gf3ndlJF7vbPDDTXTTDNtXM8uNfgGHkLRMQ10oI0
 IxjyzuWGjeVZdaVGclhrjAwQj0TzGBYdwQ9knwPNc70/1YEKggPNeXAERDIVQS+71h1HTU+r5H5
 JZMdWhNMipiTLv94qsj1Uy+jwa2qnvzOVsIM0DiQc9n1feg0lCcpF0GR2BTShwVjGM2bkeMP/Xx
 cAqkN+FocxUzl4UUBI8zt0N7Jx+f5cce+7ZxITiRAvtC/KjwehN0mU/e1X4ujblQm3BewlfjyeG
 Bh5bfbY01i1lNnCgrcqqI4d8uV3CuikibWhrDgTimswe+0KOSoVTId99LjyyKx1NwF3xtUBslSt AUiwfzzG6TJHoag==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Simplify error path for failures where "inode" needs to be freed.

Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 0d89e0014b6f..a27764341079 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -35,6 +35,8 @@ static LIST_HEAD(records_list);
 static DEFINE_MUTEX(pstore_sb_lock);
 static struct super_block *pstore_sb;
 
+DEFINE_FREE(pstore_iput, struct inode *, if (_T) iput(_T))
+
 struct pstore_private {
 	struct list_head list;
 	struct dentry *dentry;
@@ -337,7 +339,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 {
 	struct dentry		*dentry;
-	struct inode		*inode;
+	struct inode		*inode __free(pstore_iput) = NULL;
 	int			rc = 0;
 	char			name[PSTORE_NAMELEN];
 	struct pstore_private	*private, *pos;
@@ -369,7 +371,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	private = kzalloc(sizeof(*private), GFP_KERNEL);
 	if (!private)
-		goto fail_inode;
+		return -ENOMEM;
 
 	dentry = d_alloc_name(root, name);
 	if (!dentry)
@@ -384,7 +386,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 		inode_set_mtime_to_ts(inode,
 				      inode_set_ctime_to_ts(inode, record->time));
 
-	d_add(dentry, inode);
+	d_add(dentry, no_free_ptr(inode));
 
 	list_add(&private->list, &records_list);
 
@@ -392,8 +394,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 fail_private:
 	free_pstore_private(private);
-fail_inode:
-	iput(inode);
 	return rc;
 }
 
-- 
2.34.1

