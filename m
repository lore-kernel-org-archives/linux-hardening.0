Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443427;
	b=0DyWCY3bREi8hbb1UVHnZHaUMy+DrEJZ8CM2p3KcSbVHm0MM+ztrtwr/2aXQe+wj/MZw
	 CuT6JyfR3jgJuJ/1Mbmdk0El6hG2rjj51Hn9wD6L2qH5CCKAeag3BemSaXmcKPbXsHWhv
	 cma4tDXtaf9uPJMU9QOE/Ljb9USeqKSQRmwEKK4Q5feFePWRlLsCn43i5SZwh0dIABD9g
	 cdqsGftoW/3okOdx40e/cp/QD1Bym2yoVGSRR3bPs60eDgHjp+Ih3xgYMgYQ0w7h2dMRM
	 6LOhk6St29DSZAWDTT0W0T2jGF0H0ZA3/TDlWgo1VeY2yDhvpwp7c3hPb+WgpXkhW8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XBjZy5aXe1k0hsGSbAtSU1DGVkk1NgApIFU82uacohQ=;
	b=duNsBrioWiEBLs7Eyz5l06afsQh/n4kPx0uCRTqBMUb6txVXbKFiNhfp5R/uE2pR0+mB
	 cCzmrqfqSbzwgaoS9TexvTAwrG3J8SiOUDkPxbnaFcjwMLhk6MtUnpHhuwfY85lAMgPY9
	 ZtooUDLuZWNMuJOWRs2xrfuBTjjlzfJQ3LGXP16gI9ZTEbB2uskgsRfKaBH88leXKLyl/
	 PMPE89UrOslKFuXmTyEAIo8CL8VuLCtGra42fi+I8locosRz4Y/SD5llHbKLBLWfG/DeQ
	 6yFKCG0tIYRh+vrJVgR4Y15exXpNdcOPXJDQ0OklhPbB6qFnj+q8+3+EpQhrolP3M3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cLxaeoE4;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB561606A31E
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB561606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cLxaeoE4
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3acec6677so4677971c88.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443426; x=1796048226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBjZy5aXe1k0hsGSbAtSU1DGVkk1NgApIFU82uacohQ=;
        b=cLxaeoE4iXSISfK4RRn8Ug9SvqprdpAI6yj+RxqmLvbmun2F1V45+2ywOqhIIPr3Kp
         jMpMoFYijCPOzHOSRIwesOqR7RK+HdX+Kd+h5Jskymk3cTo3y465D8IdBlE8ygYpVUs0
         VUDeMmyUBmOEt2w0KYcKokGEwsYN2kq2RE/gZtZfka5Y4DIVG26/7QowxcANZOQhzdy6
         PCDZzkMphEQVgaPz1nSkhfAHVy/1H0WQ+2yBSn91vzPhqWLe5JttQinOXRX2EG490iWH
         y/+UrW/BPlI1dv2wpXENOEhnfddHsGZgt6X8tbLJqs9dDefB9OSP83oHnignIdWAuf8Q
         JKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443426; x=1796048226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XBjZy5aXe1k0hsGSbAtSU1DGVkk1NgApIFU82uacohQ=;
        b=DDG3djaLkhCRQvHIeD9lWNiRa2xMI79r6kVPKvLNAzPtuN9zWX0KnHW4KYhIQPN4hh
         hRrbynEipZGF2ouRlTfXp+DkZUCO+AFtWOgqWuayhWoqYSLyzMNpmms8RjzYvBJYyP5G
         PXcNAWvSLgAVZFVxpX2yXNFiFphEBHW5/GDlC9/5A7CvYZHvCaf7vTo295eN0rY5yIt0
         B1e5SqSszuo2flOfSXx8TFBtdzYbSNoK3QKh8NqPpSEGPzuf7lao9d3i3nrYUKBIgyIE
         Ebp39Kq2XK34rR2g4JmFXRH1dAYC54E92qoIPo5G9dfsI7ITETkwTBGJD0qaAj3S7Koe
         pXaA==
X-Forwarded-Encrypted: i=1; AL+hErFi65PhmLiGGnzH/JZlfY8+kNmkb6QP6ofNoktJojWB2RPxMy7sBYLYP73d9eEFuCTr0TMNnWW2nY9fL7uCd+o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kezuWwdrjlfJ8DmEo3Bmw5YqSGaMJmCdeP4eFMOe4Hzzl80jY
	6n+V218qyfv+9doItV3MrISiv9cG0YgizGmzOOjJcMoXGWAgZaa8r0tf
X-Gm-Gg: AZFdTZdU7KZ+bHU7+3mhrDs/nPOgYVSwl3DKjq13spEMqeIV12fDAyaFQpLxn9t0S6Z
	MlSo9fuURn0rjIqEfMLuvHcRhALC5wMFOhZEEhlq5zJ+VSeIr1ORX+7E5iqzG1Ppq+W/bf6L0Mp
	383xU6fMc+P+EVC8TToXpder7tSVfpekKjHuRA1PDnqJLJ2kFFyxfK4CnwVbs+lMXK0jyKizO3n
	MOqpD2GmF11Oqk3Wy6Xs175tUH28OVqjwYTvUBdjh5uTwBHdK77PGdcaRpAsyu9B0fWfbUAmt3v
	8Oa5xBiFjNaf+f7n0ZVR8rBZsJcHIM7YSw4NWfPIab35qPtISlEI1oyJRFIfE6aFPe1LkAGAkcs
	QyWzZ4VdceLIL8yN1p1X6ZzniSFmMhxQiBnr9xhw1Nt+LpADSBTpS65Lvxs0VKhlgdAIqXDSuel
	ndMCHLlnvyjS/ZfTcZKdLJA1DXIE5zpEYUbnNNH2iFct19jDBxDJ1KXTYN82jAXihLpUxy8dy/K
	I4JcIKwA9Er88EDm3IhULfv/CMGHMBNumjBBxueY1KQzfpjlykF5lM0f4I2wxTNt/i+HWyHn/5a
	XHHp99Blk4sDwFUunrGUNIqqeB9qr3V/4NSm5vsQTazLux6xdA60L3x8P2xePL7Akldx
X-Received: by 2002:a05:7022:7e82:b0:189:d6bf:7eaa with SMTP id a92af1059eb24-1b56f39c64bmr4473331c88.16.1795443425420;
        Mon, 23 Nov 2026 06:17:05 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm31107781c88.6.2026.11.23.06.16.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:17:05 -0800 (PST)
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
Subject: [PATCH v5 06/19] mm/swap: serialize swap publication before removing swapon mutex
Date: Mon, 23 Nov 2026 22:16:54 +0800
Message-ID: <030796dcb2086484f87e2250d9cf9a04fccf54ab.1795439990.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795439990.git.lianux.mm@gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com>
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
Only expose entries with a published swap_file. Other bits in flags
can already change during device setup, before publication.

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
index 7a97cfd8d009..24f301ef4e3a 100644
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
@@ -3397,20 +3397,18 @@ static __poll_t swaps_poll(struct file *file, poll_table *wait)
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
+	for_each_swap_info(si) {
+		if (!si->swap_file)
 			continue;
 		if (!--l)
 			return si;
@@ -3431,7 +3429,7 @@ static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
 
 	++(*pos);
 	for (; (si = swap_type_to_info(type)); type++) {
-		if (!(si->swap_file))
+		if (!si->swap_file)
 			continue;
 		return si;
 	}
@@ -3441,7 +3439,7 @@ static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
 
 static void swap_stop(struct seq_file *swap, void *v)
 {
-	mutex_unlock(&swapon_mutex);
+	percpu_up_read(&swapon_rwsem);
 }
 
 static int swap_show(struct seq_file *swap, void *v)
@@ -3954,7 +3952,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto free_swap_zswap;
 	}
 
-	mutex_lock(&swapon_mutex);
 	prio = DEF_SWAP_PRIO;
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio = swap_flags & SWAP_FLAG_PRIO_MASK;
@@ -3966,11 +3963,14 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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
 
 	pr_info("Adding %luk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
 		K((unsigned long)si->pages), name->name, si->prio, nr_extents,
@@ -3980,7 +3980,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		(si->flags & SWP_AREA_DISCARD) ? "s" : "",
 		(si->flags & SWP_PAGE_DISCARD) ? "c" : "");
 
-	mutex_unlock(&swapon_mutex);
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
 
