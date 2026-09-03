Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D628D8D0
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396205; cv=none; b=cGffLbBhfApP7PT6MFEiEKDyxWuxS8wonfN7/0nRbRHepmFufHa89oObd/CAJ03A1FQoqmU53Ie49f/BKkpmg4YE9sDo4B3u4WlO5R0/I8Ak3YZfcExq+6NHs8oI06jjPG5wGr6fPEBnPt9nOzU9kA3O4B/pG0HOiUnKYshhsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396205; c=relaxed/simple;
	bh=S0qVyUAFNyTxhWWnoo5/c3erGeCBrJtfACTslJJBRxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0AVG4ofVIkvuv9Ae9qAtzptVvlICfqQItw8TLOR2zgQzPAXAoM8Ism5xSv0J/INXlnj64PNmFndpZSaVbB0k2qKGsMedGdy2fVJkJh4Cytqp9isuCehG9bM+Rm0qeErhqBf4wO16MsyD2c+VMAGrLJqpHIfi/5rfSJ8Df4qXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIfYbQ42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIfYbQ42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCC01F000E9;
	Thu,  3 Sep 2026 00:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788396203;
	bh=ROjEoz1sGLE8wglUbW1V0sZMlOA0x11JHzTD1WIO1rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SIfYbQ42Ysc7ZnQu3kO1+9X2bq3nbVuQMZDZ7xPFWf9OTxfBA6ThpBfLdZ1ArnXqX
	 cxndNzCCgxzNyT4My5WkSSvKcqa0xwptu7z6Y/sbTwlH88tufqtnkgcEXAN0be8ePJ
	 vmS5UHhB+iopnOW16e0n1QmQRpyHV4zLp7+fHp4Ays8IEIMr0VPruG8aSzI0jIw7BG
	 gXXJbNVZ4029OiMtxYvWrgL+UMgouLrdFM/bshDMBCyOKnb0EInuFd1dxqRXQmCWcU
	 sIj4jOZvythXL7l5sAmPD7uSP0MUS9V4wJEk0pW5nP/+OeqGUKSAABORjMop5Q2STG
	 LsnGTYVPKqPwg==
Date: Wed, 2 Sep 2026 17:43:23 -0700
From: Kees Cook <kees@kernel.org>
To: York Jasper Niebuhr <yjn@yjn-systems.com>
Cc: linux-hardening@vger.kernel.org, franzen@sec.in.tum.de, ardb@kernel.org
Subject: Re: [RFC v3 0/5] Bootpatch-SLR: Randomizing Linux Kernel Structure
 Layouts at Boot
Message-ID: <202609021742.8BFCB34D5@keescook>
References: <20260720191146.21473-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720191146.21473-1-yjn@yjn-systems.com>

On Mon, Jul 20, 2026 at 09:11:46PM +0200, York Jasper Niebuhr wrote:
> At this stage, tooling is only available for x86_64. It is based on
> Linux 7.2-rc3. Bootpatch-SLR currently randomizes most of the
> task_struct. A few fields are exempt from randomization because of
> current implementation details (see v2 cover letter).

Another follow-up, FWIW, I was able to also get these randomized without
any problems I could find:


diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index f686a37f7a0a..63ff19da1b73 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -84,7 +84,7 @@ struct linux_binprm {
 	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
 
 	char buf[BINPRM_BUF_SIZE];
-} __randomize_layout;
+} __spslr __randomize_layout;
 
 #define BINPRM_FLAGS_ENFORCE_NONDUMP_BIT 0
 #define BINPRM_FLAGS_ENFORCE_NONDUMP (1 << BINPRM_FLAGS_ENFORCE_NONDUMP_BIT)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 98e21b4cbf32..8501724bcdf7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -79,7 +79,7 @@ struct block_device {
 	 * path
 	 */
 	struct device		bd_device;
-} __randomize_layout;
+} __spslr __randomize_layout;
 
 #define bdev_whole(_bdev) \
 	((_bdev)->bd_disk->part0)
diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index 0e8cd6293deb..fada1a021763 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -18,7 +18,7 @@ struct cdev {
 	struct list_head list;
 	dev_t dev;
 	unsigned int count;
-} __randomize_layout;
+} __spslr __randomize_layout;
 
 void cdev_init(struct cdev *, const struct file_operations *);
 
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 6ef1750c93e2..bac502d6f481 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -148,7 +148,7 @@ struct cred {
 		int non_rcu;			/* Can we skip RCU deletion? */
 		struct rcu_head	rcu;		/* RCU deletion hook */
 	};
-} __randomize_layout;
+} __spslr __randomize_layout;
 
 extern void __put_cred(struct cred *);
 extern void exit_creds(struct task_struct *);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9d1e05e8ae6..d9508cd2e40c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -868,7 +868,7 @@ struct inode {
 #endif
 
 	void			*i_private; /* fs or device private pointer */
-} __randomize_layout;
+} __spslr __randomize_layout;
 
 /*
  * i_state handling
@@ -1292,7 +1292,7 @@ struct file {
 	};
 	file_ref_t			f_ref;
 	/* --- cacheline 3 boundary (192 bytes) --- */
-} __randomize_layout
+} __spslr __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
 struct file_handle {
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ecd96aeb1cee..522e86f66f85 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -287,7 +287,7 @@ struct super_block {
 	 */
 	atomic_t				s_isw_nr_in_flight;
 #endif
-} __randomize_layout;
+} __spslr __randomize_layout;
 
 /*
  * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
diff --git a/include/linux/mount.h b/include/linux/mount.h
index acfe7ef86a1b..3675f7ba31f9 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -60,7 +60,7 @@ struct vfsmount {
 	struct super_block *mnt_sb;	/* pointer to superblock */
 	int mnt_flags;
 	struct mnt_idmap *mnt_idmap;
-} __randomize_layout;
+} __spslr __randomize_layout;
 
 static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
 {
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 0a46e4054dec..d726df308f11 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -240,7 +240,7 @@ struct tty_struct {
 	struct list_head tty_files;
 
 	struct work_struct SAK_work;
-} __randomize_layout;
+} __spslr __randomize_layout;
 
 /* Each of a tty's open files has private_data pointing to tty_file_private */
 struct tty_file_private {

-- 
Kees Cook
