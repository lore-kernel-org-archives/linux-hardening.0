Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE234879B
	for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738891; cv=none; b=OFjBWWVPoxmsSWbWfjUzDrmB0iH5W0mrx24pDxwWpu3lBc+VZSpwCbSAnryk9i9gidjab9ghKCYWrdBw03tY8l6Ul6aNH3pPYhR1FCYgW05/tF/en2Uk8SuMkPEySnqkBxSZbdLB/ivA9IbMnWEUajrwaFdpT9nPjCDCtVrORLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738891; c=relaxed/simple;
	bh=e608xdJeqBKKdGNq0v7LWmeQ6DQjWhBH7FxgELGlglQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNMWRf3KWkM4EEplkPvpNeoO3J0rkwnLj+bQtceQlWzu9tV1HQS5yxCn4xw4ldSoM/KQqLzWrJ1JLu7nXrPRN7FwQ6o+oTeeskNNls7DFfu20+vDpsxDGEid/C+MX3yCis3q2Gx+BYe4XLdD6q3r9T8dcNa8//+bQBIKV6jJ6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CXH1yE2/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CXH1yE2/"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so1031018a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 17:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741738886; x=1742343686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5xe36OxoXeIkbizVHSnBn4NRndqdFCX6+LlkAnxrvI=;
        b=CXH1yE2/Yl07OH3aRArU2m+/IjBVe/+zr9zByRPaEbjedAoCDIfGAh0DoVSWOCofmb
         a4NdZsHY6r3NhHdFvW/0bGXNQOgQWNrJcT7Z8+tp5RRoDmSXJM+z4jeZRM7DfdY6JWnr
         EahK7rbvE1eD2tdj7kNS1WzhO4SfxplcYj89w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741738886; x=1742343686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5xe36OxoXeIkbizVHSnBn4NRndqdFCX6+LlkAnxrvI=;
        b=ad36GzNpnlm60va+Wrh4QnaSYXGQx3DFLoth90METovdzJi3FwLoyH4G39t2Bgg4tG
         iOU30pi5qgyEGv0ftwNENRk8iYYOW/T3u850ft7YGDNGUj3u/lxpsw2146IQS+feLLc7
         W2RqqkXr1YeikfsOLPZ/Kv5mQjMo3Xi/ZH5bk6l0qyg5XRd10WK5ql9YKu0QU8fTZqLL
         JwVwZ+oY0M6ChXxxqOo+4uTTfHXwnwIvhG8m4/btqgcP2sFrPYFy2N0RDjxHTBjBB8I1
         mgO9uL8qlIZ4BA1iqLU0Pnw8OxtEllo/qtEu3eV408ms1FHw6zfrXjTULSif8M92l1oh
         /q6A==
X-Forwarded-Encrypted: i=1; AJvYcCVh5YYThm4momjnWa2YFgRaeHQVudXc9Ug+95JCBuGoydGMbujVlfRb4tnxHYAivI/8fbH0YZ6QZdQjeawjNmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnE0QSYs92R3rXRV0JA7tpl9+MzvCdHUF4EaSC7zombVepaCP
	2I8d3/i1geqiMXMA8XzrKV8WNho2Pa7siF3bpyiKBMwTn4vVZew94HsMD2wl0g==
X-Gm-Gg: ASbGnct2xDKCuHmv8fopgnQVCZ01erjSphAbIErJe74QgoZUAPfN6nqMLgf97IrO+XC
	wr0zb/F1TJlMNL7P2Vi8M5QLX69UCZ8yL/0OQbgPpVsmYrD4PocgVFncKEosaoxkf5/eeusv8KI
	nhHrV7wkurpxxYdcLE1oKNi1zU0hPs9mrcUzf4XfI5AkXTe4xKU3feh00wTP9ce7rrzV6uEPWVF
	oKnqya2IE8HNgrpGnhNN5Voh4yg3ZRe9oT8dqS4RLbU3hVMy5kuspepAz2rJ4WetA7waEyJTBjC
	6xX4aAaO0y6ndsn7oxnvK+0TLD1LNno9a+VUiiu6MVLqrKJKZKhLmQkcbz+THaIO0A2m3/TOrtd
	Q
X-Google-Smtp-Source: AGHT+IHtp8ouTXVsgTp2SJJgz2rGEBY4ebI7QJXVPc63NR9EJfuX37UqlqudFu1bAKoYDI0sugwhXA==
X-Received: by 2002:a17:907:6ea1:b0:abf:6b30:7a83 with SMTP id a640c23a62f3a-ac2b9ef11e6mr297381266b.13.1741738886472;
        Tue, 11 Mar 2025 17:21:26 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669fd0sm8846503a12.51.2025.03.11.17.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 17:21:25 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	broonie@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	jannh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 2/2] mseal: allow noop mprotect
Date: Wed, 12 Mar 2025 00:21:17 +0000
Message-ID: <20250312002117.2556240-3-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312002117.2556240-1-jeffxu@google.com>
References: <20250312002117.2556240-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Initially, when mseal was introduced in 6.10, semantically, when a VMA
within the specified address range is sealed, the mprotect will be rejected,
leaving all of VMA unmodified. However, adding an extra loop to check the mseal
flag for every VMA slows things down a bit, therefore in 6.12, this issue was
solved by removing can_modify_mm and checking each VMA’s mseal flag directly
without an extra loop [1]. This is a semantic change, i.e. partial update is
allowed, VMAs can be updated until a sealed VMA is found.

The new semantic also means, we could allow mprotect on a sealed VMA if the new
attribute of VMA remains the same as the old one. Relaxing this avoids unnecessary
impacts for applications that want to seal a particular mapping. Doing this also
has no security impact.

[1] https://lore.kernel.org/all/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/

Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modify_vma")
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/mprotect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 516b1d847e2c..a24d23967aa5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -613,14 +613,14 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	unsigned long charged = 0;
 	int error;
 
-	if (!can_modify_vma(vma))
-		return -EPERM;
-
 	if (newflags == oldflags) {
 		*pprev = vma;
 		return 0;
 	}
 
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
 	/*
 	 * Do PROT_NONE PFN permission checks here when we can still
 	 * bail out without undoing a lot of state. This is a rather
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

