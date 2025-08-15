Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FF26056D;
	Fri, 15 Aug 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248438; cv=none; b=sz45C1XbPl8RjLapAYbymj10h5VqAY3S+j3SS6BUyrqigdhRdFBqzoUDaJv+HH2UgB4e4/rZwlWuAXiEQhJk4n0ROWsfHv3nu+hlA3Uz9vEbI2dCCRc2bdppJnasK1GJ3ZB7nvz0+LGx1LQ2moW3/NpaOocJmF3/pUfFDkmH/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248438; c=relaxed/simple;
	bh=oaUjVWDqxZhoAsqTVxDAFltZwS97f995rLnVivY6MVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkhG9XStKK9RHYqeZkvj8T6xU7+4yPU9G1IU8Vo0VqgxJZnKF9vlHWoQoLdzcablm6NFJIJdNmTkjsTJNdLiCwR6FS3g3efFA03Js3Tk4gZGLaiCrNX5SvMoR/Xp42gI1A2OoqspO7QgEX9IS/OYxAusb95WSczCKigwwgIh0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA1E62C43;
	Fri, 15 Aug 2025 02:00:27 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9416A3F63F;
	Fri, 15 Aug 2025 02:00:31 -0700 (PDT)
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
Subject: [RFC PATCH v2 6/8] cred: Protect live struct cred with kpkeys
Date: Fri, 15 Aug 2025 09:59:58 +0100
Message-ID: <20250815090000.2182450-7-kevin.brodsky@arm.com>
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

This patch introduces a feature to prevent unintended modifications
of live credentials, by moving them to protected memory when they
are installed via commit_creds(). The protection mechanism is kernel
pkeys (kpkeys): protected memory is mapped with a non-default pkey
and write access is disabled by default. As a result,
task->{cred,real_cred} can only be written to by switching to a
higher kpkeys level.

The kpkeys_hardened_cred feature is enabled by choosing
CONFIG_KPKEYS_HARDENED_CRED=y and running on a system supporting
kpkeys.

Credentials are not directly allocated in protected memory, as that
would force all code preparing new credentials to switch kpkeys
level. To avoid such disruption, prepare_creds() and variants still
allocate standard memory. When commit_creds() is called, the
credentials are copied to protected memory, and the temporary object
(in a standard kmalloc slab) is freed.

This approach does not work so transparently when it comes to
override_creds(), because it does not consume the reference: the
object it gets passed cannot be moved. Callers of override_creds()
will need to explicitly call a new protect_creds() helper to move
the credentials to protected memory once they are done preparing
them. Some of these callers use the unmodified output of
prepare_creds(); prepare_protected_creds() is introduced to avoid an
unnecessary copy in such cases. This patch does not handle these
situations, but it does not break them either (credentials installed
by override_creds() will simply be unprotected).

Various helpers need to modify live credentials. To that end,
guard(kpkeys_hardened_cred) is introduced to switch to the kpkeys
level that enables write access to KPKEYS_PKEY_CRED.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/cred.h       |  12 +++
 kernel/cred.c              | 179 +++++++++++++++++++++++++++++++------
 security/Kconfig.hardening |  13 +++
 3 files changed, 177 insertions(+), 27 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index a102a10f833f..8eacc4f3de60 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -16,10 +16,17 @@
 #include <linux/uidgid.h>
 #include <linux/sched.h>
 #include <linux/sched/user.h>
+#include <linux/kpkeys.h>
 
 struct cred;
 struct inode;
 
+#ifdef CONFIG_KPKEYS_HARDENED_CRED
+KPKEYS_GUARD(kpkeys_hardened_cred, KPKEYS_LVL_CRED)
+#else
+KPKEYS_GUARD_NOOP(kpkeys_hardened_cred)
+#endif
+
 /*
  * COW Supplementary groups list
  */
@@ -162,6 +169,8 @@ extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
 extern void __init cred_init(void);
 extern int set_cred_ucounts(struct cred *);
+extern struct cred *prepare_protected_creds(void);
+extern struct cred *protect_creds(struct cred *);
 
 static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 {
@@ -199,6 +208,7 @@ static inline const struct cred *get_cred_many(const struct cred *cred, int nr)
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return cred;
+	guard(kpkeys_hardened_cred)();
 	nonconst_cred->non_rcu = 0;
 	atomic_long_add(nr, &nonconst_cred->usage);
 	return cred;
@@ -223,6 +233,7 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return NULL;
+	guard(kpkeys_hardened_cred)();
 	if (!atomic_long_inc_not_zero(&nonconst_cred->usage))
 		return NULL;
 	nonconst_cred->non_rcu = 0;
@@ -246,6 +257,7 @@ static inline void put_cred_many(const struct cred *_cred, int nr)
 	struct cred *cred = (struct cred *) _cred;
 
 	if (cred) {
+		guard(kpkeys_hardened_cred)();
 		if (atomic_long_sub_and_test(nr, &cred->usage))
 			__put_cred(cred);
 	}
diff --git a/kernel/cred.c b/kernel/cred.c
index 9676965c0981..95d316f73786 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -20,6 +20,8 @@
 #include <linux/cn_proc.h>
 #include <linux/uidgid.h>
 
+#include "../mm/slab.h"
+
 #if 0
 #define kdebug(FMT, ...)						\
 	printk("[%-5.5s%5u] " FMT "\n",					\
@@ -62,6 +64,48 @@ struct cred init_cred = {
 	.ucounts		= &init_ucounts,
 };
 
+static bool hardened_cred_enabled(void)
+{
+	return IS_ENABLED(CONFIG_KPKEYS_HARDENED_CRED) && arch_kpkeys_enabled();
+}
+
+static bool cred_is_protected(const struct cred *cred)
+{
+	struct slab *slab;
+
+	slab = virt_to_slab(cred);
+	if (!slab)
+		return false;
+
+	return slab->slab_cache->flags & SLAB_SET_PKEY;
+}
+
+static struct cred *alloc_unprotected_creds(gfp_t flags)
+{
+	if (hardened_cred_enabled())
+		return kmalloc(sizeof(struct cred), flags);
+	else
+		return kmem_cache_alloc(cred_jar, flags);
+}
+
+static struct cred *alloc_protected_creds(gfp_t flags)
+{
+	return kmem_cache_alloc(cred_jar, flags);
+}
+
+static void free_creds(struct cred *cred)
+{
+	bool cred_in_jar = true;
+
+	if (hardened_cred_enabled())
+		cred_in_jar = cred_is_protected(cred);
+
+	if (cred_in_jar)
+		kmem_cache_free(cred_jar, cred);
+	else
+		kfree(cred);
+}
+
 /*
  * The RCU callback to actually dispose of a set of credentials
  */
@@ -75,7 +119,8 @@ static void put_cred_rcu(struct rcu_head *rcu)
 		panic("CRED: put_cred_rcu() sees %p with usage %ld\n",
 		      cred, atomic_long_read(&cred->usage));
 
-	security_cred_free(cred);
+	scoped_guard(kpkeys_hardened_cred)
+		security_cred_free(cred);
 	key_put(cred->session_keyring);
 	key_put(cred->process_keyring);
 	key_put(cred->thread_keyring);
@@ -86,7 +131,7 @@ static void put_cred_rcu(struct rcu_head *rcu)
 	if (cred->ucounts)
 		put_ucounts(cred->ucounts);
 	put_user_ns(cred->user_ns);
-	kmem_cache_free(cred_jar, cred);
+	free_creds(cred);
 }
 
 /**
@@ -174,7 +219,7 @@ struct cred *cred_alloc_blank(void)
 {
 	struct cred *new;
 
-	new = kmem_cache_zalloc(cred_jar, GFP_KERNEL);
+	new = alloc_unprotected_creds(GFP_KERNEL | __GFP_ZERO);
 	if (!new)
 		return NULL;
 
@@ -189,29 +234,10 @@ struct cred *cred_alloc_blank(void)
 	return NULL;
 }
 
-/**
- * prepare_creds - Prepare a new set of credentials for modification
- *
- * Prepare a new set of task credentials for modification.  A task's creds
- * shouldn't generally be modified directly, therefore this function is used to
- * prepare a new copy, which the caller then modifies and then commits by
- * calling commit_creds().
- *
- * Preparation involves making a copy of the objective creds for modification.
- *
- * Returns a pointer to the new creds-to-be if successful, NULL otherwise.
- *
- * Call commit_creds() or abort_creds() to clean up.
- */
-struct cred *prepare_creds(void)
+static struct cred *__prepare_creds(struct cred *new)
 {
 	struct task_struct *task = current;
 	const struct cred *old;
-	struct cred *new;
-
-	new = kmem_cache_alloc(cred_jar, GFP_KERNEL);
-	if (!new)
-		return NULL;
 
 	kdebug("prepare_creds() alloc %p", new);
 
@@ -248,8 +274,57 @@ struct cred *prepare_creds(void)
 	abort_creds(new);
 	return NULL;
 }
+
+/**
+ * prepare_creds - Prepare a new set of credentials for modification
+ *
+ * Prepare a new set of task credentials for modification.  A task's creds
+ * shouldn't generally be modified directly, therefore this function is used to
+ * prepare a new copy, which the caller then modifies and then commits by
+ * calling commit_creds().
+ *
+ * Preparation involves making a copy of the objective creds for modification.
+ *
+ * Returns a pointer to the new creds-to-be if successful, NULL otherwise.
+ *
+ * Call commit_creds() or abort_creds() to clean up.
+ */
+struct cred *prepare_creds(void)
+{
+	struct cred *new;
+
+	new = alloc_unprotected_creds(GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	return __prepare_creds(new);
+}
 EXPORT_SYMBOL(prepare_creds);
 
+
+/**
+ * prepare_protected_creds - Prepare a new set of credentials in protected
+ * memory
+ *
+ * This function is equivalent to protect_creds(prepare_creds()), but avoids
+ * the copy in prepare_creds() by directly allocating the credentials in
+ * protected memory. The returned object may only be modified by switching to
+ * a higher kpkeys level, if kpkeys_hardened_cred is enabled.
+ */
+struct cred *prepare_protected_creds(void)
+{
+	struct cred *new;
+
+	new = alloc_protected_creds(GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	guard(kpkeys_hardened_cred)();
+
+	return __prepare_creds(new);
+}
+EXPORT_SYMBOL(prepare_protected_creds);
+
 /*
  * Prepare credentials for current to perform an execve()
  * - The caller must hold ->cred_guard_mutex
@@ -309,7 +384,9 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		return 0;
 	}
 
-	new = prepare_creds();
+	guard(kpkeys_hardened_cred)();
+
+	new = prepare_protected_creds();
 	if (!new)
 		return -ENOMEM;
 
@@ -400,6 +477,10 @@ int commit_creds(struct cred *new)
 	BUG_ON(task->cred != old);
 	BUG_ON(atomic_long_read(&new->usage) < 1);
 
+	guard(kpkeys_hardened_cred)();
+
+	new = protect_creds(new);
+
 	get_cred(new); /* we will require a ref for the subj creds too */
 
 	/* dumpability changes */
@@ -555,9 +636,16 @@ int set_cred_ucounts(struct cred *new)
  */
 void __init cred_init(void)
 {
+	slab_flags_t flags = SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT;
+	struct kmem_cache_args args = {};
+
+	if (hardened_cred_enabled()) {
+		flags |= SLAB_SET_PKEY;
+		args.pkey = KPKEYS_PKEY_CRED;
+	}
+
 	/* allocate a slab in which we can store credentials */
-	cred_jar = KMEM_CACHE(cred,
-			      SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+	cred_jar = kmem_cache_create("cred", sizeof(struct cred), &args, flags);
 }
 
 /**
@@ -584,7 +672,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 	if (WARN_ON_ONCE(!daemon))
 		return NULL;
 
-	new = kmem_cache_alloc(cred_jar, GFP_KERNEL);
+	new = alloc_unprotected_creds(GFP_KERNEL);
 	if (!new)
 		return NULL;
 
@@ -627,6 +715,43 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 }
 EXPORT_SYMBOL(prepare_kernel_cred);
 
+/**
+ * protect_creds - Move a set of credentials to protected memory
+ * @cred: The credentials to protect
+ *
+ * If kpkeys_hardened_cred is enabled, this function transfers @cred to
+ * protected memory. The returned object may only be modified by switching to a
+ * higher kpkeys level, for instance by using guard(kpkeys_hardened_cred).
+ *
+ * Because the credentials are copied to a new location and the old location is
+ * freed, any exising reference to @cred becomes invalid after this function is
+ * called. For this reason only the caller should have a reference to @cred.
+ *
+ * If any failure occurs, or if kpkeys_hardened_cred is disabled, @cred is
+ * returned unmodified.
+ */
+struct cred *protect_creds(struct cred *cred)
+{
+	struct cred *protected_cred;
+
+	if (!hardened_cred_enabled())
+		return cred;
+
+	if (WARN_ON(atomic_long_read(&cred->usage) != 1))
+		return cred;
+
+	protected_cred = alloc_protected_creds(GFP_KERNEL);
+	if (WARN_ON(!protected_cred))
+		return cred;
+
+	guard(kpkeys_hardened_cred)();
+
+	*protected_cred = *cred;
+	kfree(cred);
+	return protected_cred;
+}
+EXPORT_SYMBOL(protect_creds);
+
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 653663008096..cb494448c7ae 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -289,6 +289,19 @@ config KPKEYS_HARDENED_PGTABLES_KUNIT_TEST
 
 	  If unsure, say N.
 
+config KPKEYS_HARDENED_CRED
+	bool "Harden task credentials using kernel pkeys"
+	depends on ARCH_HAS_KPKEYS
+	select KPKEYS_UNRESTRICTED_RCU
+	help
+	  This option enforces the immutability of tasks credentials
+	  (struct cred) by allocating them with a non-default protection (pkey)
+	  and only enabling write access to that pkey in a limited set of cred
+	  helpers.
+
+	  This option has no effect if the system does not support
+	  kernel pkeys.
+
 endmenu
 
 config CC_HAS_RANDSTRUCT
-- 
2.47.0

