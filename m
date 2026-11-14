Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667810;
	b=D1sY2afml8Z/aYqjpSR0KoAMlKUxmTh/Ev4kc54fWnSyx3UxtfYTaqcfYUOI34nRHyxD
	 ngf1sxx13FAiKvarH5MYdmlQTEae411BGvWa9SJpfeiXbEwA1J6Kjoqmw6qLSJnh5PzpV
	 mnmSLDGxYCTL85exwwKPrcnrxSXEOYDFRHmNDpxNwK0Nvk88Z8d1c6W4aUdAPfp+vt6RL
	 wAWd8b8kX5pwc9nzThnhXo27laqN0OIyyO7eTR1cJwRSGbRLDwGTMhcm9VAedb56wc/OF
	 9n1M3DXQYZ8nlitmnQGsXN2GQ6I4A1BVAYxkG0+wei2nU+J0pj+rtiP+lNM3QFw0IqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=61DsEOxba8skZR4p3LqyMSQOqgKdFaCOdElEjJjoWTU=;
	b=2Eg8FL71V1svv2yO0w4bAgZe2dO9wALa2rt2KC0VxIgwqQQvnXNtQRdnBjmgD9SXYCDZ
	 PZvNKz6dhVyPWSlSMhHkm7ew9voRheLZ/SHDkAaAXQo1uik1g5ownbrHGD1DzPYAB/gra
	 CR1Si7+btYTYBfLP+aliBmdW4khEcLd5kU4jURJpuuZhy135HuF7v9KzFIm7A9JeF32i+
	 8wAhBDeKesLtjX7i8OihrCb34MyMBIaHD3lv3Jdxa32ZtwBYx5j1Q4U3WJ4Py+qHYPS5I
	 KHPWir+xi982sW63RLfEGyjRODy6B0wIXlF6arzCOwRVQr0Zz5gbwDwc1HmQ6zNZNLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mUIL9BTl;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF9606A323
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6DF9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mUIL9BTl
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ee0533d249so7178745ad.1
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667809; x=1795272609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61DsEOxba8skZR4p3LqyMSQOqgKdFaCOdElEjJjoWTU=;
        b=mUIL9BTlS0dmocio5ZxOhki/8vWVly2KHdKU5Xvbut/jpOp67tuicY4D0n7O7ETNhG
         auwoHkEfp+aIDunNEeWKLhREVaIAnQFtHCFYA9zIW6V18wuzYNmrfYWehz2KyaAGVEc3
         mgUk2szJeScZtMW9EIdr21YPj6uV82B/Uj34tG98LCDpvkGxc1KfMsssStZOTqwc09Yw
         WQk4Rs5424BU8thGY5BSk12ODnfxfinS1PBgauZGf4SbNQJIkNND47fbPPAcBgNOzUzC
         RMGCiD0UVOvo2bLPABTPvMquC7de/e0Gu/CyV9SBfuO/dftkzykde9Gzm4ffFSBYgx6c
         GTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667809; x=1795272609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=61DsEOxba8skZR4p3LqyMSQOqgKdFaCOdElEjJjoWTU=;
        b=CI9LRug0jyyMV7WZjJR0TAKFkjhr6MP06Hz27k/fD2lG2Y2NkIiFsoCrmxEknADqOR
         5UNS4WrLymlGC/9StLjVjwelQCSGrSqSAZI6nxB6a1WwiCPaoGYSzC/cdM2RcyRFbohI
         noxJ4TPFuUQauQ6LPrz26ddPscySrz2ZMUwRcXa5v2JX0z2TssVjCIe4mDtViAYrNnvD
         zwgttQnfN2JwYOfHbHAN+Jaz8bZ8sT6RpEXrB+y1eTCVIpheMyHm3AoM1O2TGEgona+2
         ouI0CmfMWACepELgfcVp+rWWdRQaOtGldTOFcCXTUYAupoD1s5QwME+y63szDKY3UJaI
         wppA==
X-Forwarded-Encrypted: i=1; AL+hErFBlL/vBv8F5Tw9bEyXpqYZRtwzQLJ0jqOwBiYmLHdvoBT5se7M97SUZKNP85sYCAdmfTaQ8RVVcEwoZqtDH/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nDVeOud7n8yiKBY/B6kiOvhKVtlsmxbtNiWq7kWOhFOL+GKy5
	PgsTvOqwA6afREJ9jAeJZf/zlwBWy15YHMYj9x8GdOw/QrNm6/8nwN65
X-Gm-Gg: AYBFou02OZok37uMlQuLwLwVfDVf1oOV0gekKWOZEhuYdnTDroBwxzbR9CEDjZWXLu2
	AYzrLFKDU5cB7bSL6LbU8wfzjN1sOv35TX2/PlbwbEM5CFNUjV4Dvd2vkp12zeXIZNLF1k21vBe
	WVvzJq337LZIieXcOKBnusFNQKqFLN4zbZ7Es7BAJqLRt+ZFYd61jtlXBL4rz7XTuOvjZyN8TwO
	ZV09wsdVKEDrIn+lsfYx66a+NTgK8/DbatiBKuP3QwkpVn3MP/4buuoNWFyNn39Vc5ICw5RH1E+
	2psFeu5j7jOsKE/1UfZRVagW6UOjD31rThW5xErbzw/M1jV7p3dqNyi/WQomUSCveW+G+yjwdLz
	NxRbyuo9hwtuwG/N9v58CbdSRSrYIN5L5jXeMx/bHrckpIcwPyOUs5tOuX42aFPngjPCoGuQhV8
	xHf0Lg7GKg2XVOmx159b6Y8vlvwKaK9mszACSdbVrMst7zPSouu+Hw03KLdCKcWsyUZW+p0TZEc
	AW0RZeWhS2SXvJyemvmeruR22aaFTU9yK87MHpAULsXRhHBDzK9TIRs0V/KpAyh81El+B7eE1Ba
	a95dDjDCe7sOXbcSn74/mgpU4H54IYz/gaKPmU/DqL/abRGit1Xl/VSokdJkcbX6PMnyyffjT8d
	UjUJp1WXUUEsguQ==
X-Received: by 2002:a17:903:1904:b0:2e9:61bf:6587 with SMTP id d9443c01a7336-2ee0df758b3mr57253215ad.49.1794667809095;
        Sat, 14 Nov 2026 06:50:09 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0fa3ee33sm20913015ad.76.2026.11.14.06.49.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:50:08 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH v4 06/18] mm/swap: serialize swap publication before removing swapon mutex
Date: Sat, 14 Nov 2026 22:49:54 +0800
Message-ID: <ed10255256780c856689549e65654f8b01d40c2e.1794666741.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
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
index ae8421e18448..277a5c749987 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -139,9 +139,6 @@ static inline struct swap_info_struct *__swap_iter(int *i, unsigned long flag)
 
 static struct kmem_cache *swap_table_cachep;
 
-/* Protects si->swap_file for /proc/swaps usage */
-static DEFINE_MUTEX(swapon_mutex);
-
 static DECLARE_WAIT_QUEUE_HEAD(proc_poll_wait);
 /* Activity counter to indicate that a swapon or swapoff has occurred */
 static atomic_t proc_poll_event = ATOMIC_INIT(0);
@@ -3161,9 +3158,9 @@ static int setup_swap_extents(struct swap_info_struct *sis,
  * Mark a fully initialized swap device writable and expose it to the
  * allocator. The caller must have resurrected its percpu ref first.
  */
-static void swap_device_enable(struct swap_info_struct *si)
+static void __swap_device_enable(struct swap_info_struct *si)
 {
-	percpu_down_write(&swapon_rwsem);
+	lockdep_assert_held_write(&swapon_rwsem);
 	spin_lock(&si->lock);
 	spin_lock(&swap_avail_lock);
 	si->flags |= SWP_WRITEOK;
@@ -3173,11 +3170,16 @@ static void swap_device_enable(struct swap_info_struct *si)
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
@@ -3340,7 +3342,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	if (!(p->flags & SWP_SOLIDSTATE))
 		atomic_dec(&nr_rotate_swap);
 
-	mutex_lock(&swapon_mutex);
 	percpu_down_write(&swapon_rwsem);
 	spin_lock(&p->lock);
 	drain_mmlist();
@@ -3355,7 +3356,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	percpu_up_write(&swapon_rwsem);
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
-	mutex_unlock(&swapon_mutex);
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	free_swap_cluster_info(cluster_info, maxpages);
@@ -3401,20 +3401,18 @@ static __poll_t swaps_poll(struct file *file, poll_table *wait)
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
@@ -3435,7 +3433,7 @@ static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
 
 	++(*pos);
 	for (; (si = swap_type_to_info(type)); type++) {
-		if (!(si->swap_file))
+		if (!(si->flags & SWP_USED) || !(si->swap_file))
 			continue;
 		return si;
 	}
@@ -3445,7 +3443,7 @@ static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
 
 static void swap_stop(struct seq_file *swap, void *v)
 {
-	mutex_unlock(&swapon_mutex);
+	percpu_up_read(&swapon_rwsem);
 }
 
 static int swap_show(struct seq_file *swap, void *v)
@@ -3958,7 +3956,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto free_swap_zswap;
 	}
 
-	mutex_lock(&swapon_mutex);
 	prio = DEF_SWAP_PRIO;
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio = swap_flags & SWAP_FLAG_PRIO_MASK;
@@ -3970,11 +3967,14 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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
@@ -3984,7 +3984,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		(si->flags & SWP_AREA_DISCARD) ? "s" : "",
 		(si->flags & SWP_PAGE_DISCARD) ? "c" : "");
 
-	mutex_unlock(&swapon_mutex);
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
 
