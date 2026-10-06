Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE63D9529
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279843; cv=none; b=fqgrKQ0uGCtDNe3kV+yI5TRmBYKe1V6DftIwSmBpDe30Tl1ZyVdGC35Re7u66S+uo1aY0JQ5KT/i346JKayyQ0am+L3T1vFcJHwI6QV+FrIxokb8BcX8J8+AAd+8JSRm7Kz5z+2w4BvTCsRsyDj14ENoxrUCeoJXNoyUYkNtK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279843; c=relaxed/simple;
	bh=iLcbc1HzGTozKQw6QU5goIrH/E+sVR+cS+TOcPW2ZOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tw7J3roPQ6zsFwjLwbnH+E1fdBgKd8xiIGXcx/nr2ui7+uwF5VLNl7xsMJcLVupzSItjsfLEGp+ox7jsbYiKs9HgBHz3lZC0EnMPSiHxgmH/Vufzae1aB/cSeGLqivA660fsHVwHpbe3RDgUFDB97YjXYmN8bm003mNQNdeGLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cWSBbcin; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWSBbcin"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso2317155a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 06 Oct 2026 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791279841; x=1791884641; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HjGTgfZsDADCktmqdDXJCkHYgkEUNyCL+EFPGA5tSXE=;
        b=cWSBbcinzVHHyYhCaeKztIIfL+hofX4z/rrNPDDgzetvziAT1cyiI4BrXHt2XsyrYM
         q6oxPMsuYPIucSeQziJktloRRnQH20xen5cPutdoVOa2u0PrceAijpdivf0Bd09w7cq5
         YmWDeFmDDK0fvkIFsvty6c7zz0WANfNR1XXQ/EHa/6wxuq2GwIAoJibQ3vI3mHzl17my
         2d26BqZwDgZqDIZWhpUoA2O09IzIfd40GE8Ua2/z4qQjdwHJWABsSU7RHIBUqw7PGUaC
         HgikLMnuC9dH8SaiQziBwe2HPf1h4QV5SXMheKUCXA7cDDweuXqq0JRVPuxbF4FThKk9
         fFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791279841; x=1791884641;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HjGTgfZsDADCktmqdDXJCkHYgkEUNyCL+EFPGA5tSXE=;
        b=z5GQMtqxcpmLcnbGTprA06cu5lS2parglwHGpFsIxMr6yRQGVHXKWyqe/SyCWV73a5
         SadghoQ+4h7tPVDBQfIQauNgxZwFTDfhwGq4zafA3x3kHZVow4GFNQtkKiNgVfUtBKUn
         wR4q5srzPczpawEUWm7nNBARf2mH7S70sAbhKSeY5n1LeKcGi1xN/M+pjKZPu386nsQ4
         bDQyS7D8fsPE3RupfoIT5NThHFAKQYiTn43s331wEeNL9OqMc5CYeH3D54ZT/urYs0U6
         xRCiqHIWgIuQNZryryv8OFET3eWEJt4yZFlOXZXtZmhoJLP22dk3RvaljfcEMU5iaofD
         sHmg==
X-Forwarded-Encrypted: i=1; AKwUvBy0cnbz5w52PBcZoILXpPc/e7BCLfuhb66qf+QiyBHaWpTijNWMv/bvrl33KE2GfevItM+UdZdZ81vAJ1kN4Kg=@vger.kernel.org
X-Gm-Message-State: AFuF++nBY3tAjyftDSHA0+JpuqWAfHuQbxilL/4R5wZbc98bzCaEMj8B
	aMdDHMCbUhQjQ7fOcnMHw9xeTEXd4Hr1Na5NEbQ9xzUte5OZYAVhH56A1jddm03Aa4PCwyX8IqD
	E
X-Received: from pgba19-n1.prod.google.com ([2002:a05:6a02:6453:10b0:cc8:1e8a:c8d0])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2c11:b0:3e0:dc12:890a
 with SMTP id adf61e73a8af0-3e1248398a9mr649187637.86.1791279840528; Tue, 06
 Oct 2026 02:44:00 -0700 (PDT)
Date: Tue,  6 Oct 2026 09:43:58 +0000
In-Reply-To: <20261005102518.2400984-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005102518.2400984-1-morbo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006094358.2948476-1-morbo@google.com>
Subject: [PATCH v4] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
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

Overriding the macros from a Makefile doesn't work:
'compiler_types.h' is pulled in with '-include', which is processed
after all -D/-U options, so it re-establishes the definitions. Follow
the '__NO_FORTIFY' precedent instead: let a build define
'__NO_COUNTED_BY' to turn the corresponding annotation into a no-op.

Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2: Only specify __NO_COUNTED_BY_PTR. Leave __NO_COUNTED_BY until we need it.
v3: Add the version to the Subject line.
v4: Use __NO_COUNTED_BY to reduce churn later on.
---
 include/linux/compiler_types.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..05e2b637f1cd 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -371,8 +371,13 @@ struct ftrace_likely_data {
  *
  * __bdos on clang < 19.1.3 can be off by 4:
  * https://github.com/llvm/llvm-project/pull/112636
+ *
+ * Code that runs outside the kernel proper (e.g. the EFI stub) can define
+ * __NO_COUNTED_BY to drop the annotation, since it gains nothing from the
+ * bounds checks. __NO_COUNTED_BY should be used sparingly, because there are
+ * better options for opting out of bounds checking.
  */
-#ifdef CONFIG_CC_HAS_COUNTED_BY
+#if defined(CONFIG_CC_HAS_COUNTED_BY) && !defined(__NO_COUNTED_BY)
 # define __counted_by(member)		__attribute__((__counted_by__(member)))
 #else
 # define __counted_by(member)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

