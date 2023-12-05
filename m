Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B/U60tt/"
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB4C194
	for <linux-hardening@vger.kernel.org>; Tue,  5 Dec 2023 10:26:26 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cda22140f2so5804208b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 05 Dec 2023 10:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701800786; x=1702405586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2E08Wp0PAEeNbIbiRL8xBMi7hvEIIZj0Of8hDuuB3w=;
        b=B/U60tt/8REQw9XhxcDwioJ3Fg+SGR2WrCeiqqRSocRsEryNO4pGoRDT+i4QvdiAC4
         lAIYLhXtC1XUpY2Ivhj5/KvsQlfcKlw0uGQTbj2moXHIeHldzfpGw8RdzkYsPmQNR2nK
         7fWC1lOHmICJbeFYC0k75lm2mR6PYVzj3QFLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800786; x=1702405586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2E08Wp0PAEeNbIbiRL8xBMi7hvEIIZj0Of8hDuuB3w=;
        b=Hoj3agLgucdoOYiatWKu0FvnTJOFVPTSpdrZY4P9tnXsm+jtdwxMseH8g/ftu2LEs3
         hYgczoHz4YlN79Ccm7LcuL1zMJi7rk9u+KLtyCxXGkGcNcUBF/hwNbEPTe50PhV5Saak
         tcSu4+e3mbDUIRbYnKGecZVa0fT0WYCg1HE3BXmk0XoPNfnvRtoeMF0ny6ylUxauMR4k
         hCCXsF8Tt7J2AjsPU5t9hVHbBew/oU0eX770z+/I9ENfJ5q3U9MwD8IDe7ygrKWbkdTz
         VtqjhFdG5auRh7/i0taxxyne7pTV8bhUtVGM5eYJlqg7LRY0f7CDQSqlIOXFesgP/28x
         YnDw==
X-Gm-Message-State: AOJu0YzYiXm4HsjxRPs952tpfXZOQ/1O/FnwD7R6I9fR1JAAIWNkgt1k
	OK7yFgPW2gKS3qYAqymZMx28GQ==
X-Google-Smtp-Source: AGHT+IHwsBUiT0eRYB1uJVGZDpNAY4QIFF7fFgrQ+gfLSHfbU5MuEZ2MN3xlKq+NFD9Bs+d11RXqog==
X-Received: by 2002:a05:6a20:728f:b0:181:fe7f:836b with SMTP id o15-20020a056a20728f00b00181fe7f836bmr7808665pzk.7.1701800785686;
        Tue, 05 Dec 2023 10:26:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o8-20020a056a001b4800b006ce61c9495bsm2857794pfv.10.2023.12.05.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:26:23 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] pstore: inode: Convert mutex usage to guard(mutex)
Date: Tue,  5 Dec 2023 10:26:15 -0800
Message-Id: <20231205182622.1329923-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205175449.work.110-kees@kernel.org>
References: <20231205175449.work.110-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4977; i=keescook@chromium.org;
 h=from:subject; bh=I6QANnpHLWcA4i3gT5wmHz8vdSJtJ/8W9NRntgr7o9Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlb2tIe1kl5grDFz02MlwEMZbNkkvJk+E/REGw8
 MmUW++dTRaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZW9rSAAKCRCJcvTf3G3A
 Jmx2D/9XIlu1kzssi07t3R/cbO8iB66RuThDH+nLtM6/s6fMGgOWGONfOGbTkqwrLphjr+32aNB
 otF24YUoS8xAA000Jnya2p8FwsV1eKg0bMoqQ5sn47H2it78TefQ8EbTd3gR4+Yhhw25J2Ix6ub
 I8h0h4Mfpb3B9P8TeCiQag9KMlV3tpqWGAOQBlwAEYkflyVWrFjnIuam/UqP+h+88OHtWUWVUny
 NORS6oduZg5xUxQgxvgZxMo4Aeo2plpQv5gBy1PQjSXO3W8Cap3X24HWCRz0m/BIhakgICpIj4p
 ltf6+OFM1mB4bTVbXbvRlERMha+Wu/AXJIkf0kgRoLRWaiw03eEo2iJZJQ0EMYG71/LjFSox04c
 A/xoV2HbfeyzdlqGqE+p/syA632cT8xUDhnEE0EwkKj/qSC3tn8T4bL1WW8WlwX6ypxz9TfiUhq
 +TuySHA6QE9o2tphXgm3dRwK46Ko+8089EBZ9Fd7v5wG0nXbmvtW5MEMApAxy04tdv2WzsO4pDv
 ukclQZChgMYdM/qi/wQReVSu4APZwi2cy93CJvD1UnCTdwch0f9lMyLVKS5lSbZsoudmhaldAB6
 SUgKhqJT2OElDDpwL3KKHmrRQO3wLpyzRLFz7uaTxmxjErQda2bLWUTZH1SAeI2vDsE9YyzTdek GdMZSGqYO0v+Krw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace open-coded mutex handling with cleanup.h guard(mutex) and
scoped_guard(mutex, ...).

Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 76 +++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 45 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 20f3452c8196..0d89e0014b6f 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -180,25 +180,21 @@ static int pstore_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct pstore_private *p = d_inode(dentry)->i_private;
 	struct pstore_record *record = p->record;
-	int rc = 0;
 
 	if (!record->psi->erase)
 		return -EPERM;
 
 	/* Make sure we can't race while removing this file. */
-	mutex_lock(&records_list_lock);
-	if (!list_empty(&p->list))
-		list_del_init(&p->list);
-	else
-		rc = -ENOENT;
-	p->dentry = NULL;
-	mutex_unlock(&records_list_lock);
-	if (rc)
-		return rc;
-
-	mutex_lock(&record->psi->read_mutex);
-	record->psi->erase(record);
-	mutex_unlock(&record->psi->read_mutex);
+	scoped_guard(mutex, &records_list_lock) {
+		if (!list_empty(&p->list))
+			list_del_init(&p->list);
+		else
+			return -ENOENT;
+		p->dentry = NULL;
+	}
+
+	scoped_guard(mutex, &record->psi->read_mutex)
+		record->psi->erase(record);
 
 	return simple_unlink(dir, dentry);
 }
@@ -290,19 +286,16 @@ static struct dentry *psinfo_lock_root(void)
 {
 	struct dentry *root;
 
-	mutex_lock(&pstore_sb_lock);
+	guard(mutex)(&pstore_sb_lock);
 	/*
 	 * Having no backend is fine -- no records appear.
 	 * Not being mounted is fine -- nothing to do.
 	 */
-	if (!psinfo || !pstore_sb) {
-		mutex_unlock(&pstore_sb_lock);
+	if (!psinfo || !pstore_sb)
 		return NULL;
-	}
 
 	root = pstore_sb->s_root;
 	inode_lock(d_inode(root));
-	mutex_unlock(&pstore_sb_lock);
 
 	return root;
 }
@@ -317,19 +310,19 @@ int pstore_put_backend_records(struct pstore_info *psi)
 	if (!root)
 		return 0;
 
-	mutex_lock(&records_list_lock);
-	list_for_each_entry_safe(pos, tmp, &records_list, list) {
-		if (pos->record->psi == psi) {
-			list_del_init(&pos->list);
-			rc = simple_unlink(d_inode(root), pos->dentry);
-			if (WARN_ON(rc))
-				break;
-			d_drop(pos->dentry);
-			dput(pos->dentry);
-			pos->dentry = NULL;
+	scoped_guard(mutex, &records_list_lock) {
+		list_for_each_entry_safe(pos, tmp, &records_list, list) {
+			if (pos->record->psi == psi) {
+				list_del_init(&pos->list);
+				rc = simple_unlink(d_inode(root), pos->dentry);
+				if (WARN_ON(rc))
+					break;
+				d_drop(pos->dentry);
+				dput(pos->dentry);
+				pos->dentry = NULL;
+			}
 		}
 	}
-	mutex_unlock(&records_list_lock);
 
 	inode_unlock(d_inode(root));
 
@@ -353,20 +346,20 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	if (WARN_ON(!inode_is_locked(d_inode(root))))
 		return -EINVAL;
 
-	rc = -EEXIST;
+	guard(mutex)(&records_list_lock);
+
 	/* Skip records that are already present in the filesystem. */
-	mutex_lock(&records_list_lock);
 	list_for_each_entry(pos, &records_list, list) {
 		if (pos->record->type == record->type &&
 		    pos->record->id == record->id &&
 		    pos->record->psi == record->psi)
-			goto fail;
+			return -EEXIST;
 	}
 
 	rc = -ENOMEM;
 	inode = pstore_get_inode(root->d_sb);
 	if (!inode)
-		goto fail;
+		return -ENOMEM;
 	inode->i_mode = S_IFREG | 0444;
 	inode->i_fop = &pstore_file_operations;
 	scnprintf(name, sizeof(name), "%s-%s-%llu%s",
@@ -394,7 +387,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	d_add(dentry, inode);
 
 	list_add(&private->list, &records_list);
-	mutex_unlock(&records_list_lock);
 
 	return 0;
 
@@ -402,8 +394,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	free_pstore_private(private);
 fail_inode:
 	iput(inode);
-fail:
-	mutex_unlock(&records_list_lock);
 	return rc;
 }
 
@@ -449,9 +439,8 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sb->s_root)
 		return -ENOMEM;
 
-	mutex_lock(&pstore_sb_lock);
-	pstore_sb = sb;
-	mutex_unlock(&pstore_sb_lock);
+	scoped_guard(mutex, &pstore_sb_lock)
+		pstore_sb = sb;
 
 	pstore_get_records(0);
 
@@ -466,17 +455,14 @@ static struct dentry *pstore_mount(struct file_system_type *fs_type,
 
 static void pstore_kill_sb(struct super_block *sb)
 {
-	mutex_lock(&pstore_sb_lock);
+	guard(mutex)(&pstore_sb_lock);
 	WARN_ON(pstore_sb && pstore_sb != sb);
 
 	kill_litter_super(sb);
 	pstore_sb = NULL;
 
-	mutex_lock(&records_list_lock);
+	guard(mutex)(&records_list_lock);
 	INIT_LIST_HEAD(&records_list);
-	mutex_unlock(&records_list_lock);
-
-	mutex_unlock(&pstore_sb_lock);
 }
 
 static struct file_system_type pstore_fs_type = {
-- 
2.34.1

