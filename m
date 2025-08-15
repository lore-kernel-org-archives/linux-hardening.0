Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CBF26056D;
	Fri, 15 Aug 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248444; cv=none; b=XA0zITMzI02P2aIbt0s4I3fssXnO72z3bBTsue66zaaNKn+W/4lWYRnpxB4JiBMjBF21bURPRY3CZ18r99aW1EBMgJdkr2wT9708bV76lfdTK3DWRR0ArD1wCZVXY7kkF2PokP50nDneOpT68S6oRUxMwfbsjbfeqC6nUgNlT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248444; c=relaxed/simple;
	bh=zwNPHx3VPaaB0fr5c8AD+jkzh7NHAyTQ/A7q4gQ1SG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRb76l7uGiSqXqy9OM9fjLbvfUngVrYZ+pIx28ZVnCFu3tF6x1Mv01/PNHT3Z9ukEzE7lVX217oBHch8Fn/RcwIweJz2BsisVbrpO/fw435dqAjUPZBZeZQUWRKf7Hpxyw2vrOXJei8Kt/ycZHyRkDFaWUv2URUCBsbZRHZdgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8898D2C46;
	Fri, 15 Aug 2025 02:00:32 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FCD33F63F;
	Fri, 15 Aug 2025 02:00:36 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Howells <dhowells@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH v2 7/8] fs: Protect creds installed by override_creds()
Date: Fri, 15 Aug 2025 09:59:59 +0100
Message-ID: <20250815090000.2182450-8-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250815090000.2182450-1-kevin.brodsky@arm.com>
References: <20250815090000.2182450-1-kevin.brodsky@arm.com>
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
 fs/overlayfs/dir.c    | 1 +
 fs/overlayfs/super.c  | 2 +-
 9 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7fc7b6221312..7529399bb71d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1658,7 +1658,7 @@ static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
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
index 00932500fce4..6eef34b02513 100644
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
index 2231192ec33f..63ffa7936246 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -82,7 +82,7 @@ nfs4_save_creds(const struct cred **original_creds)
 
 	new->fsuid = GLOBAL_ROOT_UID;
 	new->fsgid = GLOBAL_ROOT_GID;
-	*original_creds = override_creds(new);
+	*original_creds = override_creds(protect_creds(new));
 	return 0;
 }
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 74cf1f4de174..887ee5adb2dc 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -223,7 +223,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 		new->cap_effective =
 			cap_raise_nfsd_set(new->cap_effective,
 					   new->cap_permitted);
-		put_cred(override_creds(new));
+		put_cred(override_creds(protect_creds(new)));
 	} else {
 		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 		if (error)
diff --git a/fs/open.c b/fs/open.c
index 9655158c3885..351ac9e86a15 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -461,7 +461,7 @@ static const struct cred *access_override_creds(void)
 	 * freeing.
 	 */
 	override_cred->non_rcu = 1;
-	return override_creds(override_cred);
+	return override_creds(protect_creds(override_cred));
 }
 
 static int do_faccessat(int dfd, const char __user *filename, int mode, int flags)
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e..7e7d4f26198d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -575,6 +575,7 @@ static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 	 * We must be called with creator creds already, otherwise we risk
 	 * leaking creds.
 	 */
+	override_cred = protect_creds(override_cred);
 	old_cred = override_creds(override_cred);
 	WARN_ON_ONCE(old_cred != ovl_creds(dentry->d_sb));
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index df85a76597e9..0a45760ff7ae 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1326,7 +1326,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	err = -ENOMEM;
 	if (!ofs->creator_cred)
-		ofs->creator_cred = cred = prepare_creds();
+		ofs->creator_cred = cred = prepare_protected_creds();
 	else
 		cred = (struct cred *)ofs->creator_cred;
 	if (!cred)
-- 
2.47.0

