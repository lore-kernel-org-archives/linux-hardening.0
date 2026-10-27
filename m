Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117211;
	b=ve6mWgMJESXC4Km9+z9r79NHnPfqt8MNQHobpe8gmAxZyAgAMzpdZXXljZ7xzCktkkVT
	 0rN8J2F76HHO2jQuzUQyiVMjZeDcfB1Mwdgew9E0csfTH61R5RLxu3obXC6WGZs8Sz/m0
	 AMNVJz9vZIIwEGRlNij+Dq0m12xn9NUmfYuxcCqbGl93TnBHd9AnVJHe/B8X1jJJdEaGp
	 GA/s7D8xg/oA/Q1YtJX2w+bHQKOr+SehqVId4jBvI1eWY5Rb+b+74d15GYHRx1vLcAm44
	 bwYgdsXu5Lu3JgohLSZcyZl3SlKv4atOXlL7vyDbujiO09/W1hQ5dGrESBrzklPf0Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TppI+6UPKL+8iku51pvieIqLoyMGuox9OFKt53vLtFQ=;
	b=LpO6x9r4yzcTWjYyvGJuXKFIiOLz/K6yALOR7EX3n9qEzJ8baz4YsLTEhE6MYtMV786/
	 YoKWrYdzURi0hHGPFJsjbP83RRTGUS5RSPHJXx7YSEkR1cHM6YRLUetiMVp/IVSEreyde
	 RIBJUV0uP/6RZ6svlVY/rXG7b48O1y3q8Nw27573ShZcnlM9FEqVqQJ0XbXGMNsnc7VZR
	 P1oqa5nMtqoQdClUqmkKcNalWzLlXQwDPpzsYPO06psSkMJCrUVpXr+rzlEeIHJe9F/Zl
	 Gmmi8M9RFp6vlKVBssvbXhqO12TPByGox+ea4zTA5L952AIOuaBy0QPK9QDvdX7E3lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cjNtAT+F;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FB606A321
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B82FB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cjNtAT+F
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc758830601so77235a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117210; x=1793722010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TppI+6UPKL+8iku51pvieIqLoyMGuox9OFKt53vLtFQ=;
        b=cjNtAT+FXQ8OfSS/etqtgs1iqgQtAqM6fTtgv27+FiQrRHNYimv4CFyAj8CngUwhOw
         cP5GgVZHeL2A9UArbiDZa9Yx2jceLTGoyacrV5eV6lT0xjMydGycGfgBEHa8qf0CIhvV
         maemyC5IhZjKEo/cgpsnicmML6pY6Rr8Iec7+LTF66eacMyDuvHg3CKoP3bqgGJRkCwu
         fLT4kaoVddmvkhsiw+nQoTsv0ypNK4h5SSvu83mhb7Q81jsA129TNjX/2/eQKC7Qv4zP
         woEcVsV8R6Tb2NUlLPUytu3t4y1I8qH943cBW6Ic5P7B22eCYSn1ucew0HsDRsCEi42J
         IaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117210; x=1793722010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TppI+6UPKL+8iku51pvieIqLoyMGuox9OFKt53vLtFQ=;
        b=dfCRK2nXKCMz+rDmx1YWNt8lpR/vhA6i6y1AIJK8NjhjyK0689GYnG5U0QWnlEx6zG
         jNMrxIAYYr4PdLGwAbrZ6oCTqRczzcpXj5EJvm76XEfZvGGtUjsWNdoTuDN4TSzOTp48
         S34rlTiCxQ4RT7r1/ACaITf92/Dm6ikGkUodg3lkML8zwwyWegNIECdXplxvN4Jqw0+D
         WNjImVZ1Yh93RKILfDPJ9rtriAZd8aYU59X5m+zLnzC3cL4drYrOEV/YbwzZ8Xe9WjKF
         TxphbS+GcU8woLcdsGH3RMhzTtjWZ0U1Hrc63ia80DwJJQmG7B/cHh2cRxKdvR+0Mx7L
         reeA==
X-Forwarded-Encrypted: i=1; AKwUvBx42+yvUnTBeDpSmXgdM4nItRmfrI4mkgPOEur2TnxGMLXTC1FHQSVb+AKnPV7w2rX/0NjzwlrpciyHxuHKmvY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIR6A9ItBqchb8S3NOVGD1WhKLUssw3RtkIbG7BRYpyrtVJMkIm
	Mey+n8/GPmTr+4mZZwReV091TQrll3UHGmBypufdpGdbpwUhjcuQtP9w
X-Gm-Gg: AYBFou1SXQoxZbRTHowva73oMXhdKor7DOMMdNktDnoqkHzMCJWXc0omp5ktsL0O3zE
	ddEm6Roy9oD4YbsnQz88BjOSRa22ZNgSoSFabatN3l5atvAcTzZ9MFZDQpYk5gNvvBAjmi26euP
	F5fnqx1rL1+U2XYDAynuVP3GcIRzCHu0ORpV4LupJAqb7DK2pwqxGouK3ZTnDYws6Ut4L1FIvi8
	ftlN8sVt6ucCCAFEA/xQWd6X8e9g26dVjIvq/mWf14j52OO83uKwFm3o7WAWbaqUYHFMcP7mHXb
	GridfeVwmaHc7aCU+A18KU1GYHHNpIPPVZR8/y4RQuxHk7tj8Y/D0tGBs/QQa2okElbDcEMbTRa
	UMpz2Jp4jXT4Qo6arLLxSYouP0+AZeNiGk0PfWKjuDB3tjOY/5CdkxTefnTBzknagXOl8sNF/DL
	65TCpb1d9Qd5xaN17T3wiWWzFCni5EcSkuYMsvA9RHkzgNIsh7FjTxzhCtB15mMx/ZYCb0Xw8JY
	Nl21j3KFltOf0wXAeyPzDxopo+38gXUvC7xFvWipCVIG42Ywb8CFXj5stBL1od7n1PhTcsMEVX7
	kmmPEAruWy7toT/Y24E1
X-Received: by 2002:a17:903:1103:b0:2e9:7190:32dc with SMTP id d9443c01a7336-2ea9c68c70emr91918065ad.11.1793117210052;
        Tue, 27 Oct 2026 09:06:50 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b7cdebsm12246305ad.12.2026.10.27.09.06.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:06:49 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	linjh22s@gmail.com,
	kunwu.chan@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org,
	tglx@kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH v3 06/18] mm/swap: serialize swap publication before removing swapon mutex
Date: Wed, 28 Oct 2026 00:06:23 +0800
Message-ID: <200266a50e30e916ad425ccbe2b7cede7f227d22.1793106426.git.lianux.mm@gmail.com>
In-Reply-To: <cover.1793106426.git.lianux.mm@gmail.com>
References: <cover.1793106426.git.lianux.mm@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Move publication of swap_file, resurrection of the device reference and
the writable transition into one swapon_rwsem writer section. Split out
a writer-held enable helper so initial publication can share this
section, while failed swapoff can use the locking wrapper.

With file publication and teardown serialized by the writer, remove
swapon_mutex and use a topology reader across /proc/swaps iteration.
Keep the SWP_USED filter when advancing the swap_info array.

The publication boundary excludes proc readers from partially published
state and gives the lockless live-reference users initialized device
metadata before the device becomes an allocation candidate.

Signed-off-by: Kairui Song <kasong@tencent.com>
Co-developed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4ffde6827d44..4c10e4a2d9b3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -140,9 +140,6 @@ static inline struct swap_info_struct *__swap_iter(int *i, unsigned long flag)
 
 static struct kmem_cache *swap_table_cachep;
 
-/* Protects si->swap_file for /proc/swaps usage */
-static DEFINE_MUTEX(swapon_mutex);
-
 static DECLARE_WAIT_QUEUE_HEAD(proc_poll_wait);
 /* Activity counter to indicate that a swapon or swapoff has occurred */
 static atomic_t proc_poll_event = ATOMIC_INIT(0);
@@ -3097,9 +3094,9 @@ static int setup_swap_extents(struct swap_info_struct *sis,
  * Mark a fully initialized swap device writable and expose it to the
  * allocator. The caller must have resurrected its percpu ref first.
  */
-static void swap_device_enable(struct swap_info_struct *si)
+static void __swap_device_enable(struct swap_info_struct *si)
 {
-	percpu_down_write(&swapon_rwsem);
+	lockdep_assert_held_write(&swapon_rwsem);
 	spin_lock(&swap_avail_lock);
 	si->flags |= SWP_WRITEOK;
 	spin_unlock(&swap_avail_lock);
@@ -3107,11 +3104,16 @@ static void swap_device_enable(struct swap_info_struct *si)
 	atomic_long_add(si->pages, &nr_swap_pages);
 	total_swap_pages += si->pages;
 	plist_add(&si->list, &swap_active_head);
-	percpu_up_write(&swapon_rwsem);
-
 	add_to_avail_list(si);
 }
 
+static void swap_device_enable(struct swap_info_struct *si)
+{
+	percpu_down_write(&swapon_rwsem);
+	__swap_device_enable(si);
+	percpu_up_write(&swapon_rwsem);
+}
+
 static int swap_device_disable(struct address_space *mapping,
 			       struct swap_info_struct **swap_info)
 {
@@ -3275,7 +3277,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	if (!(p->flags & SWP_SOLIDSTATE))
 		atomic_dec(&nr_rotate_swap);
 
-	mutex_lock(&swapon_mutex);
 	percpu_down_write(&swapon_rwsem);
 	spin_lock(&p->lock);
 	drain_mmlist();
@@ -3290,7 +3291,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	percpu_up_write(&swapon_rwsem);
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
-	mutex_unlock(&swapon_mutex);
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	free_swap_cluster_info(cluster_info, maxpages);
@@ -3336,20 +3336,18 @@ static __poll_t swaps_poll(struct file *file, poll_table *wait)
 	return EPOLLIN | EPOLLRDNORM;
 }
 
-/* iterator */
 static void *swap_start(struct seq_file *swap, loff_t *pos)
 {
 	struct swap_info_struct *si;
-	int type;
 	loff_t l = *pos;
 
-	mutex_lock(&swapon_mutex);
+	percpu_down_read(&swapon_rwsem);
 
 	if (!l)
 		return SEQ_START_TOKEN;
 
-	for (type = 0; (si = swap_type_to_info(type)); type++) {
-		if (!(si->swap_file))
+	for_each_swap(si) {
+		if (!si->swap_file)
 			continue;
 		if (!--l)
 			return si;
@@ -3370,7 +3368,7 @@ static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
 
 	++(*pos);
 	for (; (si = swap_type_to_info(type)); type++) {
-		if (!(si->swap_file))
+		if (!(si->flags & SWP_USED) || !(si->swap_file))
 			continue;
 		return si;
 	}
@@ -3380,7 +3378,7 @@ static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
 
 static void swap_stop(struct seq_file *swap, void *v)
 {
-	mutex_unlock(&swapon_mutex);
+	percpu_up_read(&swapon_rwsem);
 }
 
 static int swap_show(struct seq_file *swap, void *v)
@@ -3893,7 +3891,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto free_swap_zswap;
 	}
 
-	mutex_lock(&swapon_mutex);
 	prio = DEF_SWAP_PRIO;
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio = swap_flags & SWAP_FLAG_PRIO_MASK;
@@ -3905,11 +3902,14 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	si->prio = prio;
 	si->list.prio = -si->prio;
 	si->avail_list.prio = -si->prio;
+	/* Publish the file, live reference and writable state together. */
+	percpu_down_write(&swapon_rwsem);
 	si->swap_file = swap_file;
 
-	/* Sets SWP_WRITEOK, resurrect the percpu ref, expose the swap device */
+	/* Make the reference live before exposing the writable device. */
 	percpu_ref_resurrect(&si->users);
-	swap_device_enable(si);
+	__swap_device_enable(si);
+	percpu_up_write(&swapon_rwsem);
 
 	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
 		K(si->pages), name->name, si->prio, nr_extents,
@@ -3919,7 +3919,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		(si->flags & SWP_AREA_DISCARD) ? "s" : "",
 		(si->flags & SWP_PAGE_DISCARD) ? "c" : "");
 
-	mutex_unlock(&swapon_mutex);
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
 
