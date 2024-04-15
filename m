Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9182862
	for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198943; cv=none; b=WNLUbL2jQgC0RxjJeH3OVnVYgbHdm8/D3vWWs3T97VKMBZtZbX/5+SJmUp10ApueASzFz5UPBZ4MPFHCckrRKlzMDq2c27j6xod0Yzk77yod4e5UHLsDxIAVTUdxgaoGxOQ0oAqdT+ccmUeKLcsXqKi+d83iDl7uOqM1/5EYo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198943; c=relaxed/simple;
	bh=LbN3vPPFFh9Aw4Li7guMwa2zc/mmZK2K8i0/aDCHb3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuCkfH1Z5gwaUMrL5OvjY9Z+AImc6GSrJNmvx7o1HG/oHvdCbemMcAGUz5YWHNNVvWblZLQ6Rk/L1ImJzRWBflKWGKdymHs1SdC2abXGjnjnVre9uaRS1RYBGLgvw9ArXbj+Z6DQ+OTVOsQ5ih/HvaMdiIrI1xiztPVKBow72z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y1a8ZueO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y1a8ZueO"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so1151200b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713198941; x=1713803741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iXbJH0cVJ4nmmmu00apsXHUH2CgJzw3cA9Huce0b50=;
        b=Y1a8ZueOfAtDEOoYni87wEliwgVL65NSgwX0GMhMWOHEzm14klTNyAdYIOx1BmeRkx
         JWdtMoMHHYkmjJdPBdJn9jidutBh0S9/L9fIxrhtupaPKwHZUKCOsEi2oJzxg591rk1z
         XBZnC2LodvJlGMZhixZJxuONwDz1QCJJPzvsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198941; x=1713803741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iXbJH0cVJ4nmmmu00apsXHUH2CgJzw3cA9Huce0b50=;
        b=OaDjimtE8s/GYkBrr0ehpQfcigJbtaqUqFVLDClRZmKQcgXd8Qk1iFFUjTFfUojKg4
         A9vNBBEAIWcs9dBKA19UnEPHo5NLECjK8IYy3uZ7cVPjN62BMUWvhC11SyV2qbcFnSG1
         7JpaK9BR00+XtCAVgHMvharDxzAXS10OHDsdfGH4509pfYR9eKdRFzw0MhAM3MYl5Suu
         Oc3PQxCzOszc1jsUepGTuRNVOFeEqz3Gp6Rx/sZMInSt4ANHqYt2lP3zTjAvBsWi7AOR
         09v2OZRgsSvZZ+zhvNUmSbLbb/yIvGGM9loCKbFFnxqIEfJkkP4I0BL6FLQedQ4I41bj
         QzVA==
X-Forwarded-Encrypted: i=1; AJvYcCXpdoQ9kHtCvEOLfmPaqE8SC5yoMry0opmawKwbSiAYURvE0wIqNgJ13uDTGSRF8OzYELnuqJsJhIchPZ91lfnsaHFFnw8INDzm5FSBJKJj
X-Gm-Message-State: AOJu0YyHM8VvFWpbOWi3kh1+acYFf42ZVZPd13a6GBfiv+Ml70g/MFlK
	MtxhsjdlUm/GDqslLO2lKEOIB+FKdLFH16wMLEf3BoVa0nPsMpkOqoqu68ZWEg==
X-Google-Smtp-Source: AGHT+IEnWFlBUtlHwsk92i90BD+0YVbJMZlklZvuszYn32fReCkIhwN/hdSLkl+zg3BR7klNQ6I0LQ==
X-Received: by 2002:a17:902:d58b:b0:1e2:1915:2479 with SMTP id k11-20020a170902d58b00b001e219152479mr11022843plh.12.1713198940554;
        Mon, 15 Apr 2024 09:35:40 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id f12-20020a170902684c00b001e3d2314f3csm8299078pln.141.2024.04.15.09.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 09:35:40 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org
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
Subject: [PATCH v10 4/5] mseal:add documentation
Date: Mon, 15 Apr 2024 16:35:23 +0000
Message-ID: <20240415163527.626541-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240415163527.626541-1-jeffxu@chromium.org>
References: <20240415163527.626541-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add documentation for mseal().

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/index.rst |   1 +
 Documentation/userspace-api/mseal.rst | 199 ++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 Documentation/userspace-api/mseal.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index afecfe3cc4a8..5926115ec0ed 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -20,6 +20,7 @@ System calls
    futex2
    ebpf/index
    ioctl/index
+   mseal
 
 Security-related interfaces
 ===========================
diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
new file mode 100644
index 000000000000..4132eec995a3
--- /dev/null
+++ b/Documentation/userspace-api/mseal.rst
@@ -0,0 +1,199 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Introduction of mseal
+=====================
+
+:Author: Jeff Xu <jeffxu@chromium.org>
+
+Modern CPUs support memory permissions such as RW and NX bits. The memory
+permission feature improves security stance on memory corruption bugs, i.e.
+the attacker can’t just write to arbitrary memory and point the code to it,
+the memory has to be marked with X bit, or else an exception will happen.
+
+Memory sealing additionally protects the mapping itself against
+modifications. This is useful to mitigate memory corruption issues where a
+corrupted pointer is passed to a memory management system. For example,
+such an attacker primitive can break control-flow integrity guarantees
+since read-only memory that is supposed to be trusted can become writable
+or .text pages can get remapped. Memory sealing can automatically be
+applied by the runtime loader to seal .text and .rodata pages and
+applications can additionally seal security critical data at runtime.
+
+A similar feature already exists in the XNU kernel with the
+VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall [2].
+
+User API
+========
+mseal()
+-----------
+The mseal() syscall has the following signature:
+
+``int mseal(void addr, size_t len, unsigned long flags)``
+
+**addr/len**: virtual memory address range.
+
+The address range set by ``addr``/``len`` must meet:
+   - The start address must be in an allocated VMA.
+   - The start address must be page aligned.
+   - The end address (``addr`` + ``len``) must be in an allocated VMA.
+   - no gap (unallocated memory) between start and end address.
+
+The ``len`` will be paged aligned implicitly by the kernel.
+
+**flags**: reserved for future use.
+
+**return values**:
+
+- ``0``: Success.
+
+- ``-EINVAL``:
+    - Invalid input ``flags``.
+    - The start address (``addr``) is not page aligned.
+    - Address range (``addr`` + ``len``) overflow.
+
+- ``-ENOMEM``:
+    - The start address (``addr``) is not allocated.
+    - The end address (``addr`` + ``len``) is not allocated.
+    - A gap (unallocated memory) between start and end address.
+
+- ``-EPERM``:
+    - sealing is supported only on 64-bit CPUs, 32-bit is not supported.
+
+- For above error cases, users can expect the given memory range is
+  unmodified, i.e. no partial update.
+
+- There might be other internal errors/cases not listed here, e.g.
+  error during merging/splitting VMAs, or the process reaching the max
+  number of supported VMAs. In those cases, partial updates to the given
+  memory range could happen. However, those cases should be rare.
+
+**Blocked operations after sealing**:
+    Unmapping, moving to another location, and shrinking the size,
+    via munmap() and mremap(), can leave an empty space, therefore
+    can be replaced with a VMA with a new set of attributes.
+
+    Moving or expanding a different VMA into the current location,
+    via mremap().
+
+    Modifying a VMA via mmap(MAP_FIXED).
+
+    Size expansion, via mremap(), does not appear to pose any
+    specific risks to sealed VMAs. It is included anyway because
+    the use case is unclear. In any case, users can rely on
+    merging to expand a sealed VMA.
+
+    mprotect() and pkey_mprotect().
+
+    Some destructive madvice() behaviors (e.g. MADV_DONTNEED)
+    for anonymous memory, when users don't have write permission to the
+    memory. Those behaviors can alter region contents by discarding pages,
+    effectively a memset(0) for anonymous memory.
+
+    Kernel will return -EPERM for blocked operations.
+
+    For blocked operations, one can expect the given address is unmodified,
+    i.e. no partial update. Note, this is different from existing mm
+    system call behaviors, where partial updates are made till an error is
+    found and returned to userspace. To give an example:
+
+    Assume following code sequence:
+
+    - ptr = mmap(null, 8192, PROT_NONE);
+    - munmap(ptr + 4096, 4096);
+    - ret1 = mprotect(ptr, 8192, PROT_READ);
+    - mseal(ptr, 4096);
+    - ret2 = mprotect(ptr, 8192, PROT_NONE);
+
+    ret1 will be -ENOMEM, the page from ptr is updated to PROT_READ.
+
+    ret2 will be -EPERM, the page remains to be PROT_READ.
+
+**Note**:
+
+- mseal() only works on 64-bit CPUs, not 32-bit CPU.
+
+- users can call mseal() multiple times, mseal() on an already sealed memory
+  is a no-action (not error).
+
+- munseal() is not supported.
+
+Use cases:
+==========
+- glibc:
+  The dynamic linker, during loading ELF executables, can apply sealing to
+  non-writable memory segments.
+
+- Chrome browser: protect some security sensitive data-structures.
+
+Notes on which memory to seal:
+==============================
+
+It might be important to note that sealing changes the lifetime of a mapping,
+i.e. the sealed mapping won’t be unmapped till the process terminates or the
+exec system call is invoked. Applications can apply sealing to any virtual
+memory region from userspace, but it is crucial to thoroughly analyze the
+mapping's lifetime prior to apply the sealing.
+
+For example:
+
+- aio/shm
+
+  aio/shm can call mmap()/munmap() on behalf of userspace, e.g. ksys_shmdt() in
+  shm.c. The lifetime of those mapping are not tied to the lifetime of the
+  process. If those memories are sealed from userspace, then munmap() will fail,
+  causing leaks in VMA address space during the lifetime of the process.
+
+- Brk (heap)
+
+  Currently, userspace applications can seal parts of the heap by calling
+  malloc() and mseal().
+  let's assume following calls from user space:
+
+  - ptr = malloc(size);
+  - mprotect(ptr, size, RO);
+  - mseal(ptr, size);
+  - free(ptr);
+
+  Technically, before mseal() is added, the user can change the protection of
+  the heap by calling mprotect(RO). As long as the user changes the protection
+  back to RW before free(), the memory range can be reused.
+
+  Adding mseal() into the picture, however, the heap is then sealed partially,
+  the user can still free it, but the memory remains to be RO. If the address
+  is re-used by the heap manager for another malloc, the process might crash
+  soon after. Therefore, it is important not to apply sealing to any memory
+  that might get recycled.
+
+  Furthermore, even if the application never calls the free() for the ptr,
+  the heap manager may invoke the brk system call to shrink the size of the
+  heap. In the kernel, the brk-shrink will call munmap(). Consequently,
+  depending on the location of the ptr, the outcome of brk-shrink is
+  nondeterministic.
+
+
+Additional notes:
+=================
+As Jann Horn pointed out in [3], there are still a few ways to write
+to RO memory, which is, in a way, by design. Those cases are not covered
+by mseal(). If applications want to block such cases, sandbox tools (such as
+seccomp, LSM, etc) might be considered.
+
+Those cases are:
+
+- Write to read-only memory through /proc/self/mem interface.
+- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
+- userfaultfd.
+
+The idea that inspired this patch comes from Stephen Röttger’s work in V8
+CFI [4]. Chrome browser in ChromeOS will be the first user of this API.
+
+Reference:
+==========
+[1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
+
+[2] https://man.openbsd.org/mimmutable.2
+
+[3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com
+
+[4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc
-- 
2.44.0.683.g7961c838ac-goog

