Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A281364052
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228067; cv=none; b=MUD9TKTvTi3syUKIyjYlhVpnpGqdeApOKvR233TiSD08NBld0gJSgaQr/eVdsIOhyUn1+rzeg5ndWw2/0yJfEEs0AC+bFA8h3Fs8WowAXKIZ70uIHT0DdFvgxkm6lf4FRRyYK33J5FA8VEjgtdrqM7ZOwR5f3asBRDoF7gCpE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228067; c=relaxed/simple;
	bh=YQ7/Ax0UxErTNnT63wTa7fRKhXKFuf3K2gplq2MDpb4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MfsQLtPC++/TioVdNWDWds+TM+OkLdylaT74he2dbegTbC4p9dWIlTTkH4Fwglh8XU+MbQAOW5Pv+JBqE7Yqne4XrMeRWbPTvFBqVhlnDxGP01AGp6xV4o1Lu24Xeuviyau8n6qIw8UAU2WKxYvb19vivabWBsVko0eiO3PU9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VtWMHxRe; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtWMHxRe"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df7bc60df6so12787255ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791228066; x=1791832866; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rrTypWKyXrNGtquOYVr8mPkgvP23qIJmTIldcFVC0/Y=;
        b=VtWMHxReun91lPUi3FXOy0ahEp/8E68w98EPHn1S693AdOdpV268ykB8PaNPK/7tK2
         zWksmwHLruEGpdacf9Bhwv2qAt/miKigpWAQ5N8vr7s5J5I9/jIJOuswwfCUqnIk3VHl
         ensYXYJoufVVPch3FlYpgJ+iwzwCnWr81630Wouw0luzejUpv/laPJnL+ZkZnP2y7tWP
         y6OXvEON+L1ragiXgjJfIc6teWJSLcIryiLuWPqLi1stx9OjniPW7Hbh7hSkp5e0Rvn/
         1sn7gfsP5bDSqPGBeBIzNp4EKEupj0uCBph2TSGIHLqAWyJ4WPZhHdtH0MK5ly6X1ioG
         wxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791228066; x=1791832866;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rrTypWKyXrNGtquOYVr8mPkgvP23qIJmTIldcFVC0/Y=;
        b=qO4tGcx0phzBOy6pVOw8uqZSm070QAwhvryEn7cC1Quvib3Dz940ldxOLqvnHKof8y
         F3gNI4QmMrP3ImzMsOfRABkr79yL5YXwu1J6MrV/ahWw1UqSlZC0fENwTMXVdTmeyZIT
         x/P45y4/1SOii7E8Nar890Ydf/xpqr4qPZNAwslhhExAhbpYQ3Xqi9/ZkGcs/QFszfW7
         4iss6CjdcujbvwnYOrhlo1aNKSe8Vz4C0nIHXB9X137E/5joUi1DewtgNO83ugAe2i8P
         4NGd6qQPFqEE7W+tmAyTraJ9jJHVn8JSiJDqI4oA3WgOlaVuSOOGJwkjjz7F6IXrvOni
         ZSuQ==
X-Forwarded-Encrypted: i=1; AKwUvBy79jFpyDEQ2QDHJ6Y0KbjKEvboPHPSftL+EULGtTsXdsXCaF4fUQpM4kf9lKQiJTJoIJwx3R3k26HAUadYVJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOQ9Zbm91xiuBIhdcoGqUSqMqP1RQBpPGfYjxPfnXiK9ootg77
	5R7uA9fkVVQ6SKoZNEraODa1GUyqGqbxmsIXdRkOKbt2ikln+KDC2LhBp/cbPh+QNjzRZwX1KhJ
	Z
X-Received: from plbmh14.prod.google.com ([2002:a17:903:9ce:b0:2e2:cbb6:3b7d])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:9341:b0:2df:ab09:2656
 with SMTP id d9443c01a7336-2e49b6ad7famr81214365ad.44.1791228065326; Mon, 05
 Oct 2026 12:21:05 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:20:52 +0000
In-Reply-To: <20261005102518.2400984-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005102518.2400984-1-morbo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005192052.2589382-1-morbo@google.com>
Subject: [PATCH v3] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
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
v3: Add the version to the Subject line.
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

