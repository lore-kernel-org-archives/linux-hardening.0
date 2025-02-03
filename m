Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC22040A6;
	Mon,  3 Feb 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578537; cv=none; b=tO2Sq0GErCkP47m0D2XWlU/yBUdrQk2y5R+9IaTfz+pfdNx97TSSkPvYJ2eBqqrTGpagXm4En+pcfr7aQt1TMunpiyGct7eGSWs+XYXvNDUYG0Jvc1zTWqFxnlrjok/7MwuArmENO4hQiF9PvelSNkzqAgSZDLL7dzlnMzYTXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578537; c=relaxed/simple;
	bh=vAO/eunBsEr6P0ElMFfIqGJ2gw588lZJ/Z20tspMn5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmmjanUf9RBTFvlKDY+qXaR30usv1eoTRWJ+PPpsPFGQ+FNqetRccUds57nP6em16OD8vsInIGUHmu/TNyhsGSDdJx97gvLPULmRoMofpVaOMfikEB1bmmSPiu4bMw9DSEhhZ6tc9IokhGyHc0UEAQU3fnn0BUFl/4fBG0H7Scw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 480031BC0;
	Mon,  3 Feb 2025 02:29:20 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 196943F63F;
	Mon,  3 Feb 2025 02:28:51 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Howells <dhowells@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH 7/8] fs: Protect creds installed by override_creds()
Date: Mon,  3 Feb 2025 10:28:08 +0000
Message-ID: <20250203102809.1223255-8-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250203102809.1223255-1-kevin.brodsky@arm.com>
References: <20250203102809.1223255-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kpkeys_hardened_cred feature, when enabled, automatically
protects credentials installed by commit_creds(). However, because
override_creds() does not consume its argument, it is up to its
callers to protect the credentials before calling override_creds().
This is done by calling protect_creds(), moving the credentials to a
protected memory location.

In some cases, the credentials returned by prepare_creds() are
passed to override_creds() as-is. In such situation where write
access to the credentials is not needed, prepare_protected_creds()
is used to avoid the copy incurred by a separate call to
protect_creds().

This patch covers the main users of override_creds(), but it is not
comprehensive.

This patch is a no-op if kpkeys_hardened_cred isn't enabled.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 fs/aio.c              | 2 +-
 fs/fuse/passthrough.c | 2 +-
 fs/nfs/nfs4idmap.c    | 2 +-
 fs/nfsd/auth.c        | 2 +-
 fs/nfsd/nfs4recover.c | 2 +-
 fs/nfsd/nfsfh.c       | 2 +-
 fs/open.c             | 2 +-
 fs/overlayfs/dir.c    | 2 +-
 fs/overlayfs/super.c  | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7b976b564cfc..ab9f4c8d778a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1657,7 +1657,7 @@ static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
 	if (unlikely(!req->file->f_op->fsync))
 		return -EINVAL;
 
-	req->creds = prepare_creds();
+	req->creds = prepare_protected_creds();
 	if (!req->creds)
 		return -ENOMEM;
 
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 607ef735ad4a..4451651b1e51 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -248,7 +248,7 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 		goto out_fput;
 
 	fb->file = file;
-	fb->cred = prepare_creds();
+	fb->cred = prepare_protected_creds();
 	refcount_set(&fb->count, 1);
 
 	res = fuse_backing_id_alloc(fc, fb);
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 25a7c771cfd8..6ff25dd5c2fb 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -228,7 +228,7 @@ int nfs_idmap_init(void)
 	set_bit(KEY_FLAG_ROOT_CAN_CLEAR, &keyring->flags);
 	cred->thread_keyring = keyring;
 	cred->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
-	id_resolver_cache = cred;
+	id_resolver_cache = protect_creds(cred);
 	return 0;
 
 failed_reg_legacy:
diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index 4dc327e02456..09b377a97147 100644
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -79,7 +79,7 @@ int nfsd_setuser(struct svc_cred *cred, struct svc_export *exp)
 	else
 		new->cap_effective = cap_raise_nfsd_set(new->cap_effective,
 							new->cap_permitted);
-	put_cred(override_creds(new));
+	put_cred(override_creds(protect_creds(new)));
 	return 0;
 
 oom:
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 28f4d5311c40..095664648103 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -81,7 +81,7 @@ nfs4_save_creds(const struct cred **original_creds)
 
 	new->fsuid = GLOBAL_ROOT_UID;
 	new->fsgid = GLOBAL_ROOT_GID;
-	*original_creds = override_creds(new);
+	*original_creds = override_creds(protect_creds(new));
 	return 0;
 }
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 32019751a41e..d64d23e9357e 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -221,7 +221,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 		new->cap_effective =
 			cap_raise_nfsd_set(new->cap_effective,
 					   new->cap_permitted);
-		put_cred(override_creds(new));
+		put_cred(override_creds(protect_creds(new)));
 	} else {
 		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 		if (error)
diff --git a/fs/open.c b/fs/open.c
index 932e5a6de63b..3b5331b7c0f0 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -457,7 +457,7 @@ static const struct cred *access_override_creds(void)
 	 * freeing.
 	 */
 	override_cred->non_rcu = 1;
-	return override_creds(override_cred);
+	return override_creds(protect_creds(override_cred));
 }
 
 static long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index c9993ff66fc2..943ec4300ddb 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -580,7 +580,7 @@ static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 	 * We must be called with creator creds already, otherwise we risk
 	 * leaking creds.
 	 */
-	old_cred = override_creds(override_cred);
+	old_cred = override_creds(protect_creds(override_cred));
 	WARN_ON_ONCE(old_cred != ovl_creds(dentry->d_sb));
 
 	return override_cred;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 86ae6f6da36b..3489a62c5d8a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1318,7 +1318,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_d_op = &ovl_dentry_operations;
 
 	err = -ENOMEM;
-	ofs->creator_cred = cred = prepare_creds();
+	ofs->creator_cred = cred = prepare_protected_creds();
 	if (!cred)
 		goto out_err;
 
-- 
2.47.0

