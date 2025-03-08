Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CBF29D05
	for <linux-hardening@vger.kernel.org>; Sat,  8 Mar 2025 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741401199; cv=none; b=o6szDbzKxOqr5kEye8uxwVb4HApvowVql0ZWRcTlmFEWeLOje2GiMWDiCHZlzYyPnkOVEm2WHnLr6lIjMrCK9t1wCjF51kc/jL3tLAv8GwB/OgrKxHltXaqU3Mj3pDj/Zc2OOqSGLZx/KcWtaPoxw2ZTV0NKNLfEhimyZZNboqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741401199; c=relaxed/simple;
	bh=8y7jXNcb6ARWEXok82aZRH5T5isSwP8i7PMYGI1wjuI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EHdYNQPV27h+GVxq0UCt+GMw+z2Xg6igvOoG0OLkRGkonqnspGhFQeNMEpcAbUmox46PG0U+igIoW1l76+Qz3AeAhcfgzOqK0MI312oprLWtvLh8v08lZw4QOHPQwhLkBhavDU0yVrhmfZXF+06Lml3qbNLcBF2JaWfQHTLFJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0PFhym6; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0PFhym6"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-3f3a3c63929so906250b6e.2
        for <linux-hardening@vger.kernel.org>; Fri, 07 Mar 2025 18:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741401197; x=1742005997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jKzjjHkyghJxAnuAXwC3PWRJfez3LkNv1m9ZaRZ16eg=;
        b=k0PFhym6QKycn58ms3PcuKzU7mFgWoQakPp97JPvFg7L27Cc71YeteHgTaTZZaMlnJ
         ogd3lgesN/Dr84dReNV7LCtztys27zpM1ZEg7Hm7KRMF3OZfZrj4vt/mt/uv8cOK+W/1
         sUH6gukIFwTe9ddB0ik2DoaH0VftCFTA4RbJSMqK/D9ROb0EJ1v/c1cC66LdIYpeX/I6
         UDm6hcQPo18bW9XLQVGIrBWhVmSLkhbUw1IXoHVyWUYlR0+aHMCsJNx6TWQ+oU92JJrG
         A1evKqbcjClZZ541zWLBbHkTtuzdlcC1g+XH+LQbrbgNh36Lit7QcEJKKuv4hF1b4KpG
         Yv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741401197; x=1742005997;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKzjjHkyghJxAnuAXwC3PWRJfez3LkNv1m9ZaRZ16eg=;
        b=MdyC6KbEpHnY9GuCkcBu/rHl7VYVsTlFEyYefG+pCMDFAdFblFW8gY6UOt36QJnpEF
         r3jGImfU9XZp2Bpp3sfLxi1rdUeycD0bS5aq4HUVLBjzF/WB1BVDq0uPCbl6ViXYiXY3
         s3csvfXQyBgJvcGRd6WFOTML+8geD1biv+Kdkq7qQzlWpR3D3Hb7cmuUT8w6BgD3HMJE
         SqIr+ql9e7s8RAmQqNOxFJNp1uN4LS6cTgy2v9w5MmLBZ+Ds2e2wAOmNEa06hK+Y4MXk
         jrtK4FZ17C4KBoPv2ynDOTptJghEWVUJcRAW4kzNtY5uFV59mBiNolLnoOgm/505Zf/n
         bhkg==
X-Forwarded-Encrypted: i=1; AJvYcCXJUncTVGXLELpTR8Mt6Dz/2S8Q7wvnqiRplOj4yP1NJQlHvQ62L8V7MHjt+ifMffuqqzL1dX1YbFaatYcPAb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65Zvl6ogJX0sDvhvVjQOOmWZeT5mWuUCLPN4LWKdwRdTnq26b
	XFxQyjBRqVAs+1NOpqzGXMY/cdXohVdNQMfu+PPrrL1kUquGkSjwNAmagfyhy2rRlA==
X-Google-Smtp-Source: AGHT+IFFZMokntAqkxOEmyT2cvJ9U4fSWph4TCXA8wvZ1kT5cN4sra8A6sENMM+l+kubdYKyBOP+ETg=
X-Received: from oabnw7.prod.google.com ([2002:a05:6870:bb07:b0:2c1:c983:48c1])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:264e:b0:727:345d:3b7b
 with SMTP id 46e09a7af769-72a37b41aafmr3231129a34.5.1741401197125; Fri, 07
 Mar 2025 18:33:17 -0800 (PST)
Date: Fri,  7 Mar 2025 18:33:13 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308023314.3981455-1-pcc@google.com>
Subject: [PATCH] string: Disable read_word_at_a_time() optimizations if kernel
 MTE is enabled
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The optimized strscpy() and dentry_string_cmp() routines will read 8
unaligned bytes at a time via the function read_word_at_a_time(), but
this is incompatible with MTE which will fault on a partially invalid
read. The attributes on read_word_at_a_time() that disable KASAN are
invisible to the CPU so they have no effect on MTE. Let's fix the
bug for now by disabling the optimizations if the kernel is built
with HW tag-based KASAN and consider improvements for followup changes.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
Cc: stable@vger.kernel.org
---
 fs/dcache.c  | 2 +-
 lib/string.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e3634916ffb93..71f0830ac5e69 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -223,7 +223,7 @@ fs_initcall(init_fs_dcache_sysctls);
  * Compare 2 name strings, return 0 if they match, otherwise non-zero.
  * The strings are both count bytes long, and count is non-zero.
  */
-#ifdef CONFIG_DCACHE_WORD_ACCESS
+#if defined(CONFIG_DCACHE_WORD_ACCESS) && !defined(CONFIG_KASAN_HW_TAGS)
 
 #include <asm/word-at-a-time.h>
 /*
diff --git a/lib/string.c b/lib/string.c
index eb4486ed40d25..9a43a3824d0d7 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -119,7 +119,8 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
 		return -E2BIG;
 
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && \
+	!defined(CONFIG_KASAN_HW_TAGS)
 	/*
 	 * If src is unaligned, don't cross a page boundary,
 	 * since we don't know if the next page is mapped.
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

