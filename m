Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VwpHN4+I"
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F11D5
	for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 15:17:15 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d8029dae41so4785862a34.0
        for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423035; x=1703027835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D1PlLUfxR4CYnPMS2OzloWMrMloIYQmh/cjfDWMVaY=;
        b=VwpHN4+IJZhT1v7aZl1ccbIWgf9dK4aE019rwpcXSpH2ps8fUikdnlYv2UJ8l+nt9/
         FlA/9gvk04NWswkP53hK603251om+FfWYZrjDdQ6LIcZkq3TZtcg+4a0GG+loqPhWvQD
         nXlonMf2JgHsnjKGXif9SSk/qGoZ1/LzWhhTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423035; x=1703027835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D1PlLUfxR4CYnPMS2OzloWMrMloIYQmh/cjfDWMVaY=;
        b=U23+TOMBrQmpCO1B7m6k3QgeKEsX9dN9RJx2lBEgl8nMvgGmty46Fd8aypnPD3h1b3
         3b6vuEhCDoXrMQK9f7u+oWVaWG+fU0dnO7XFnsJWDRPoLzK4gA8Jm9fosH7TgKt+j0JY
         o4JP631W6AKzuMBW14nBt4p18b8liBon4ZP4v8pUYLoqNYx+mSZIpwjUsemo2wsf78b7
         FrlnZV1vZvYM+O58kahpB92bN2uWwB9Fr9KuFF6UvUZhys1yvRnDu0JqMghsD3mhO08V
         8/HyVhcf070QCqMqAp/cb3Wr0aKtfuVGgN34wrPC5O2OW4F0FgBUo7e85cFxDOqHuJk+
         a6GQ==
X-Gm-Message-State: AOJu0Yx0r3f7tR1q3VQZ2NAvOf+N/D5QhV3wBnSu+EEFmX8zfLVQ3J1Z
	Z4rhjITtuwpKg7RJYRNfhh5uYw==
X-Google-Smtp-Source: AGHT+IELl9vxFDBtqlLqQjHJMgXEg7iTyGXK7EqaCyV/trQ5sRcstZZrUugD0WkeVeiGw0jvX4mjLw==
X-Received: by 2002:a05:6358:262a:b0:16e:2898:5e02 with SMTP id l42-20020a056358262a00b0016e28985e02mr9003519rwc.32.1702423034702;
        Tue, 12 Dec 2023 15:17:14 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id s188-20020a635ec5000000b005c6617b52e6sm8763314pgb.5.2023.12.12.15.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:14 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v3 04/11] mseal: add MM_SEAL_BASE
Date: Tue, 12 Dec 2023 23:16:58 +0000
Message-ID: <20231212231706.2680890-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212231706.2680890-1-jeffxu@chromium.org>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

The base package includes the features common to all VMA sealing
types. It prevents sealed VMAs from:
1> Unmapping, moving to another location, and shrinking the size, via
munmap() and mremap(), can leave an empty space, therefore can be
replaced with a VMA with a new set of attributes.
2> Move or expand a different vma into the current location, via mremap().
3> Modifying sealed VMA via mmap(MAP_FIXED).
4> Size expansion, via mremap(), does not appear to pose any specific
risks to sealed VMAs. It is included anyway because the use case is
unclear. In any case, users can rely on merging to expand a sealed
VMA.

We consider the MM_SEAL_BASE feature, on which other sealing features
will depend. For instance, it probably does not make sense to seal
PROT_PKEY without sealing the BASE, and the kernel will implicitly add
SEAL_BASE for SEAL_PROT_PKEY. (If the application wants to relax this
in future, we could use the flags field in mseal() to overwrite
this the behavior of implicitly adding SEAL_BASE.)

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/mmap.c   | 23 +++++++++++++++++++++++
 mm/mremap.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 42462c2a0c35..dbc557bd460c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1259,6 +1259,13 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			return -EEXIST;
 	}
 
+	/*
+	 * Check if the address range is sealed for do_mmap().
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm(mm, addr, addr + len, MM_SEAL_BASE))
+		return -EACCES;
+
 	if (prot == PROT_EXEC) {
 		pkey = execute_only_pkey(mm);
 		if (pkey < 0)
@@ -2632,6 +2639,14 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
+	/*
+	 * Check if memory is sealed before arch_unmap.
+	 * Prevent unmapping a sealed VMA.
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm(mm, start, end, MM_SEAL_BASE))
+		return -EACCES;
+
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
@@ -3053,6 +3068,14 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 
+	/*
+	 * Check if memory is sealed before arch_unmap.
+	 * Prevent unmapping a sealed VMA.
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm(mm, start, end, MM_SEAL_BASE))
+		return -EACCES;
+
 	arch_unmap(mm, start, end);
 	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 }
diff --git a/mm/mremap.c b/mm/mremap.c
index 382e81c33fc4..ff7429bfbbe1 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -835,7 +835,35 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
+	/*
+	 * In mremap_to() which moves a VMA to another address.
+	 * Check if src address is sealed, if so, reject.
+	 * In other words, prevent a sealed VMA being moved to
+	 * another address.
+	 *
+	 * Place can_modify_mm here because mremap_to()
+	 * does its own checking for address range, and we only
+	 * check the sealing after passing those checks.
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm(mm, addr, addr + old_len, MM_SEAL_BASE))
+		return -EACCES;
+
 	if (flags & MREMAP_FIXED) {
+		/*
+		 * In mremap_to() which moves a VMA to another address.
+		 * Check if dst address is sealed, if so, reject.
+		 * In other words, prevent moving a vma to a sealed VMA.
+		 *
+		 * Place can_modify_mm here because mremap_to() does its
+		 * own checking for address, and we only check the sealing
+		 * after passing those checks.
+		 * can_modify_mm assumes we have acquired the lock on MM.
+		 */
+		if (!can_modify_mm(mm, new_addr, new_addr + new_len,
+				   MM_SEAL_BASE))
+			return -EACCES;
+
 		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
 		if (ret)
 			goto out;
@@ -994,6 +1022,20 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	/*
+	 * This is shrink/expand case (not mremap_to())
+	 * Check if src address is sealed, if so, reject.
+	 * In other words, prevent shrinking or expanding a sealed VMA.
+	 *
+	 * Place can_modify_mm here so we can keep the logic related to
+	 * shrink/expand together. Perhaps we can extract below to be its
+	 * own function in future.
+	 */
+	if (!can_modify_mm(mm, addr, addr + old_len, MM_SEAL_BASE)) {
+		ret = -EACCES;
+		goto out;
+	}
+
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-- 
2.43.0.472.g3155946c3a-goog

