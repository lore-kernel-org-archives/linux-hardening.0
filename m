Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE944F3EA7
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617327; cv=none; b=SfrmKiPBrCUh5ipTr7TX8CjGmqB9+iE1XfxXVWzjsvOB0o+AXZ3aoMl15fAdb/mytnQ/H3Fy1MGlz9FzI32elh9z/+Fp2pYaF96J35Vo0t5leEpPBW5PyIMfBuR8WthIA/Q/lye7UL7byR346A89VEwS6QiPxQgNOz23XjkSu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617327; c=relaxed/simple;
	bh=momiFi30dkRlx2WVT0ox6hshqYd8/ScvZC1qApjMV/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GOSIHeNczl5NPdNG+OiPCy7LWq7bXrFUTrExcH3i87yAHaEp2WPGgKubIG3fFwaR8IMJMPRKPorio6Htgnbw+WGcYAdgUHc1Za+WN+UGBjWjwnb/G6QuPYGuOVAqs00QR3Bep7Bq+SheYlr+Hry4SWJ5i29slub/z6hQpG6e/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpusiUIY; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpusiUIY"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e735659b7so24431155e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617320; x=1791222120; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M7XOG6J7aO3z9jj4htZ8vsmTX5Bj+aw1I6NLY6zP7oo=;
        b=OpusiUIYkIQ3U0Q/FckLtcA3bcnMi4TZJUA9deDWoJcHerKxGRf8rX3oYChjzQdCE2
         Ffub0Nzn662HUnwiioyRgs4aGlyv45DqK6DXBQSUk7QqFl//O7xujqjkEvueX/uDIHJD
         yR2voG0tQewiNw1GyojVp7MPaSUysNXrwOj/taK2m7GVDV464YaByyovf1Em7IZ1sM7t
         MthgkAi0WfWcQDL9w1c7h1bhv3+kC+Qq+ymwBMBpzQNi9bctxaNJX3lC+oqYC9hvHbTy
         Cp4G0x2ZSykNKMmibw8B5sFhwlyU0lRbBxa8akbbFRXAE2S7a+mIraTvAeqmjsKqWXFA
         p2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617320; x=1791222120;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7XOG6J7aO3z9jj4htZ8vsmTX5Bj+aw1I6NLY6zP7oo=;
        b=DYsa53hqhMkuDCWHzgyLMzRmsweeEyCqbEfym0v4KYDpuJYoC/OH3uFaTSapoWExMY
         GNSySZk83IpAqlGW5BVQwie0RlTD0Xj3/3G+zV8sGI+fU6u/b728tCYBw2y3caquoQCw
         A5L4du+8Ik9PY5PsLr0EK9EdLRx0nYtTSCtJNdtHH5tHAHhlXnp01rqSMJQWNgVWRsuV
         2uh7snFhtZ1l2pQhoRIFWTR04RJH9rfpWFNBfm37CwpqU2vmneaqIFKvElxKydX6Zo9t
         5QZED9JhSTao/iKMgWL+LWFauizM/4g54a7M75756JfzHd7WXZ0QMzAlxWLs9vdVnn+U
         kUmg==
X-Forwarded-Encrypted: i=1; AKwUvBziH1T5W3EpHlaF3pkiQAOJNMK771tKPPgKugMM1RiYHDgyIgK+V9On96wDy9KGIkDrpDjMxg0zEO05sPds6Mw=@vger.kernel.org
X-Gm-Message-State: AFuF++nVB9BCGT+H+BxVUVg5yU5ijNkVAQ7+kxtt6tHWOXbJXDDAUy45
	WNYVvQp+FctYDv6HQimMSqCjSAxC6B8+AGFkPacEkzjah/73XRM9Utan7z9qnfkE12ZrC4a4pHu
	izANGHY7rObuSVg==
X-Received: from wmpj18.prod.google.com ([2002:a05:600c:4892:b0:4a0:264:76ac])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6388:b0:4a0:1d2:1a8a with SMTP id 5b1f17b1804b1-4a001d21b90mr75432355e9.16.1790617319925;
 Mon, 28 Sep 2026 10:41:59 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:17 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-11-smostafa@google.com>
Subject: [RFC PATCH 10/15] mm/vmalloc: Add a get_vm_area_node()
From: Mostafa Saleh <smostafa@google.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	akpm@linux-foundation.org, urezki@gmail.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, kees@kernel.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, gustavoars@kernel.org, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Linus Walleij <linus.walleij@linaro.org>, 
	David Stevens <stevensd@google.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pasha Tatashin <pasha.tatashin@soleen.com>

get_vm_area_node()
Unlike the other public get_vm_area_* variants, this one accepts node
from which to allocate data structure, and also the align, which allows
to create vm area with a specific alignment.

This call is going to be used by partially populated stacks in order
to allocate the VA space for the kernel stacks that might be larger
than the memory mapped behind it.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[Switched to vmap_pages_range instead of noflush variant, fix typos]
Signed-off-by: David Stevens <stevensd@google.com>
[vmap_pages_range() already in the header, and remove the export as it
 was not needed, update commit msg]
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/linux/vmalloc.h |  3 +++
 mm/vmalloc.c            | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index aed121d729b0..e6a9c1bbe789 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -250,6 +250,9 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 					unsigned long flags,
 					unsigned long start, unsigned long end,
 					const void *caller);
+struct vm_struct *get_vm_area_node(unsigned long size, unsigned long align,
+				   unsigned long flags, int node, gfp_t gfp,
+				   const void *caller);
 void free_vm_area(struct vm_struct *area);
 extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bea9f76ed7e7..9f4634c7977e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3301,6 +3301,30 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				  NUMA_NO_NODE, GFP_KERNEL, caller);
 }
 
+/**
+ * get_vm_area_node - reserve a contiguous and aligned kernel virtual area
+ * @size:	 size of the area
+ * @align:	 alignment of the start address of the area
+ * @flags:	 %VM_IOREMAP for I/O mappings
+ * @node:	 NUMA node from which to allocate the area data structure
+ * @gfp:	 Flags to pass to the allocator
+ * @caller:	 Caller to be stored in the vm area data structure
+ *
+ * Search for an area of @size/align in the kernel virtual mapping area and
+ * reserve it for our purposes. Returns the area descriptor on success or %NULL
+ * on failure.
+ *
+ * Return: the area descriptor on success or %NULL on failure.
+ */
+struct vm_struct *get_vm_area_node(unsigned long size, unsigned long align,
+				   unsigned long flags, int node, gfp_t gfp,
+				   const void *caller)
+{
+	return __get_vm_area_node(size, align, PAGE_SHIFT, flags,
+				  VMALLOC_START, VMALLOC_END,
+				  node, gfp, caller);
+}
+
 /**
  * find_vm_area - find a continuous kernel virtual area
  * @addr:	  base address
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

