Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF2A2F6577
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227989; cv=none; b=TCq0fuzc8gbfaGNvc3esDP7f1ZhhQzC4caLz8GSacGi+9PtZ5pFscQiq7+TKahe5U2S6lIOPiyEt1MF7v4W9DNliGhvC/No/mmSvE0UfTzreZ6O5VhDBP26wlUkHgixUIwEtXXSID7lgmB+axQTZfxxTydB5jV8j/Lc1exMlQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227989; c=relaxed/simple;
	bh=bnlqihMoP+OehsOX4Qu9na8XM6RJuc5xI2jSiqejPOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BOgfR4+4wTny+sn8gFKnIJ+dt1gX4l1kHIk303p0iMbAU6n6TBC4/fyvlp8gXDybOmkkijXgUXQ9GzC/xnttDdYrBQO0hCBL9nqYciLeo4F234651dTUMFyKy07GGYIREWx++pBpDBB5e75E53Un/sS/6yfbu0GJeicf4etcrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SPZrW0dG; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SPZrW0dG"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2df8d1e91c9so37956355ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791227986; x=1791832786; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G7eLGK4KvBHDJUYriBrlxQjC7HPa3mfoBvjU5hS2xzk=;
        b=SPZrW0dGEExcHGc6mE9HYApEoK1aTiyY145GAnjAleYeX9ihUgGx89mGrSZubURDfH
         BPp7K8u3MXFQoB5NYrQZFjWmWJmi5a5nTG42JdkIzjzSetIS/FYvaOWPBpz9cvbIRu66
         BPRc/5lbw9j6gCLZQLIYaS53OtGJp1I8Wxeki82MVDFDeDXZ9BSVRvg+sfdj+yiBKNnF
         B4Q+YioO0DcJAIOV7IEZYKFOJzMAugJuAboPwwmaDAyIE1WKhkjptMfXYphfaU0mzBhq
         WH4dorl8bMHmXQDsd/vEWtuxp1NtV9QKOCqaFQAtW0t//CpWHR5MQGbSQ0MypQcCSzmp
         N3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227986; x=1791832786;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G7eLGK4KvBHDJUYriBrlxQjC7HPa3mfoBvjU5hS2xzk=;
        b=l9g5pb6K+lYRKE24Iwzv/+ypkVeuRF9l1ZHo3CFO0T2mqk7E7Dl/vjF9hNeAwBKuKF
         Cl2kXvD+bj8zYriZ3v+rqRVG5Z1Oh7rHkViZgfbe5HswwSFQZcoB67CHwcTkhZMvNVvL
         1wf0gummbPXAdUpzdIh1/vR59UU0H1kg6EzgZV8Dh0tr9X7bLvqkq9Vweq2jCvAYGhm1
         8PioqwkfoM+V82Nx4eICh9p3EZfyw9FJKlZSyOm8c8gtwbRzBiUtQAf4n51ftVATQWcO
         dVi6KBrTcePl7lnUJcf0mVdS8Zctg0fkHOFoT8E/csVkt2U7HOq8icAeVDgBNwOk2qRb
         Q7Mg==
X-Forwarded-Encrypted: i=1; AKwUvBzWsY70SRgVHniYhdQxtA7MdRZ7ksUnsjDqQO1zCC1KmYXd1QYKQbh2lgS2MgJQvD25L6/asPMH0BqicfQXqWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcuybOu4vniSIRecik/0ZO8pz5FrYS8LIJlr3nwleYRcRbiXi8
	tAEmE0gLrzorfnhU9yaPMaGCYMQRrVStGB177CFxQoJwbGRdmWa4dke1KeTyvgRJVqkvjIlMp3M
	8
X-Received: from plic14.prod.google.com ([2002:a17:903:370e:b0:2e4:90ac:5fc4])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f682:b0:2dd:ad73:c936
 with SMTP id d9443c01a7336-2e49b60bf8emr102328605ad.23.1791227985632; Mon, 05
 Oct 2026 12:19:45 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:19:43 +0000
In-Reply-To: <20261005102518.2400984-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005102518.2400984-1-morbo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005191943.2588899-1-morbo@google.com>
Subject: [PATCH] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: Kees Cook <kees@kernel.org>, ardb@kernel.org
Cc: gustavoars@kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	justinstitt@google.com, broonie@kernel.org, elver@google.com, 
	alan.maguire@oracle.com, namjain@linux.microsoft.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"

Code that runs outside the kernel proper, such as the EFI stub, gets
nothing out of the counted_by annotations: the bounds checks they feed
(FORTIFY_SOURCE, UBSAN_BOUNDS) are already disabled there.

The annotations can also break the build. A __counted_by_ptr() that
names a member declared after the pointer needs Clang's
'-fexperimental-late-parse-attributes', which the top-level Makefile
adds to 'KBUILD_CFLAGS'. The x86 EFI stub builds its own cflags and does
not get that flag, so it fails as soon as such a struct is pulled in
through a common header.

Overriding the __counted_by_ptr macro from a Makefile doesn't work:
'compiler_types.h' is pulled in with '-include', which is processed
after all -D/-U options, so it re-establishes the definitions. Follow
the '__NO_FORTIFY' precedent instead: let a build define
'__NO_COUNTED_BY_PTR' to turn the corresponding annotation into a no-op.

Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2: Only specify __NO_COUNTED_BY_PTR. Leave __NO_COUNTED_BY until we need it.
---
 include/linux/compiler_types.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..8bde6798b4ec 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -387,8 +387,13 @@ struct ftrace_likely_data {
  *
  *   gcc: https://gcc.gnu.org/pipermail/gcc-patches/2025-April/681727.html
  * clang: https://clang.llvm.org/docs/AttributeReference.html#counted-by-counted-by-or-null-sized-by-sized-by-or-null
+ *
+ * Code that runs outside the kernel proper (e.g. the EFI stub) can define
+ * __NO_COUNTED_BY_PTR to drop the annotation. Such code may also lack the flag
+ * Clang needs to parse a reference to a later-declared member
+ * (-fexperimental-late-parse-attributes).
  */
-#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+#if defined(CONFIG_CC_HAS_COUNTED_BY_PTR) && !defined(__NO_COUNTED_BY_PTR)
 #define __counted_by_ptr(member)	__attribute__((__counted_by__(member)))
 #else
 #define __counted_by_ptr(member)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

