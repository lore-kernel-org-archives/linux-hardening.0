Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CEC478E57
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197060; cv=none; b=ENlW1GYw8/BKZb2Yu34MQo5I6rmTyyO5tPnNKVVc/WGEaWk6l9/g0XCWrcaWg3CmVA8tbMyQ+ZkAP4Bha1iFBXg4SOwHHvJrz8qCn2TQAZfZxKVf48OXt93oKHw10fA8jDuEzIWKBLR+xxe7oAuT+t363H406IzXbLOcaLlJjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197060; c=relaxed/simple;
	bh=hXqAAVZ7iU9coIiuKsZdIYbDpWgQ81ehzhxS/8jQUaw=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OKEcuwpPjSxuC/GDNIbSvF3WfC/gR3M21+M7X17spPP9ewVCE5Omdd2oWm9v818OdTC6GpZaLMs6ST4iH89EEtfUIlxZk8ZI4tHu/yzsEaI9TGpQKu1bldkRaCLlCJ81v/7Iu+AUBCQqDA4gMBodJGPBFHycrkbEemF2QPDObkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UydTROGy; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UydTROGy"
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-47b7f5b898aso1218669fac.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791197057; x=1791801857; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+TZBKNvvBhmDD3cSiSzM94pM4ii0iFMxmeGyibiGnBg=;
        b=UydTROGy9SgK3t03M6KfrD4/sZvouL8vZQ9MG2mZ3C2zkLTXYq6rfhp9PaOTDZaT9A
         bCkxEtZhYelXKj/FKQrm+oj9dJIiZJbV1lKF+AYjCauYx7/MSdcCIGYg6azdROFfAmNm
         MrAVal7V2jnEm04vX8wouJaSVcnaohJIVGxJvaUixmW+phb9++5RrzgcznO3izltQogK
         WazUCaa4BRU4IGZl/OFZLdLxh0TRq+lteCFtgqPie38XIENLaoRqQvj8VT1cAjunUy56
         ZZh/aGf3L6G2cKNv9E6l40mxn2vsz5faZyYT7jE0GZS4lp5hQVBYiOil8NLvH3a01a74
         +N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791197057; x=1791801857;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TZBKNvvBhmDD3cSiSzM94pM4ii0iFMxmeGyibiGnBg=;
        b=BdIeKPzrZRXOvwyXPDa/DA8z5FJEtOtwMlbQmZgOWki9JI43QrWsC2AtV7mnLtb82N
         y+f4mvAF7953z3K4JUpXy6+4bS8gKKOPHZbRUl3K/F1H5KHrVDPCyRZFtOTYZz+VIu0g
         P5BLjqTV6nTGkx+MvfCRV315RS4gXKJQO/sA7Y8h4IbWPkfT8a6NGh3OooG/1Mz7Xu6p
         /WU3n9nlrQklQv6+U9xjvuR6nWag/9aSQDk2J8/fFtlB0AeUghnIXhFKn8dzFwLVJecc
         2kNAoGj/EHyKLNjJv3Mz/Kh57zlueV5cJn2i0civO3yx6zvFv2EOwtp3+N04u6V4MucS
         k94A==
X-Forwarded-Encrypted: i=1; AKwUvBzH1qd/ZVZuAwvuq107IiMxLfi0wIfcuGMFSUXFc2xRM+wNxx0OT3kNBmHQ/tCQgjjYbYies0o9LrqQTLal7RA=@vger.kernel.org
X-Gm-Message-State: AFuF++nJuGNFZhZBQVuYl9xBSgC9EhS+E4jDplRql4dmMrK3EWkxJoD5
	STyLX+Inz8qT/9xLbzKGPSU4Gw8Z8kS3ZoFKshpTXDE0FxaI7bfgY94w3CsJhV1FrWu9V0KJ5lk
	CUebfLSeC96COq2kJrH/C8yyLyQ==
X-Received: from ioa7.prod.google.com ([2002:a05:6602:8007:b0:9c7:3c39:1ace])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1811:b0:4e6:46cf:4a14 with SMTP id 5614622812f47-4f528ee2d7bmr10154776b6e.25.1791197056690;
 Mon, 05 Oct 2026 03:44:16 -0700 (PDT)
Date: Mon, 5 Oct 2026 03:44:15 -0700
In-Reply-To: <20261005102518.2400984-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <asN_J2XBnJgbJijS@google.com>
Subject: Re: [PATCH] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
From: Justin Stitt <justinstitt@google.com>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, ardb@kernel.org, gustavoars@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, broonie@kernel.org, 
	elver@google.com, alan.maguire@oracle.com, namjain@linux.microsoft.com, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

Hi,

On Mon, Oct 05, 2026 at 10:25:18AM +0000, Bill Wendling wrote:
> Code that runs outside the kernel proper, such as the EFI stub, gets
> nothing out of the counted_by annotations: the bounds checks they feed
> (FORTIFY_SOURCE, UBSAN_BOUNDS) are already disabled there.
> 
> The annotations can also break the build. A __counted_by_ptr() that
> names a member declared after the pointer needs Clang's
> '-fexperimental-late-parse-attributes', which the top-level Makefile
> adds to 'KBUILD_CFLAGS'. The x86 EFI stub builds its own cflags and does
> not get that flag, so it fails as soon as such a struct is pulled in
> through a common header.
> 
> Overriding the macros from a Makefile doesn't work:
> 'compiler_types.h' is pulled in with '-include', which is processed
> after all -D/-U options, so it re-establishes the definitions. Follow
> the '__NO_FORTIFY' precedent instead: let a build define
> '__NO_COUNTED_BY' or '__NO_COUNTED_BY_PTR' to turn the corresponding
> annotation into a no-op.  The two are kept separate but parallel so they
> can be folded together once all supported compilers handle
> '__counted_by' on pointers.
> 
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  include/linux/compiler_types.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index c5921f139007..916a946f623c 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -371,8 +371,14 @@ struct ftrace_likely_data {
>   *
>   * __bdos on clang < 19.1.3 can be off by 4:
>   * https://github.com/llvm/llvm-project/pull/112636
> + *
> + * Code that runs outside the kernel proper (e.g. the EFI stub) can define
> + * __NO_COUNTED_BY to drop the annotation, since it gains nothing from the
> + * bounds checks. Kept in step with __NO_COUNTED_BY_PTR below so the two can
> + * be folded together once __counted_by covers pointers on all supported
> + * compilers.
>   */
> -#ifdef CONFIG_CC_HAS_COUNTED_BY
> +#if defined(CONFIG_CC_HAS_COUNTED_BY) && !defined(__NO_COUNTED_BY)
>  # define __counted_by(member)		__attribute__((__counted_by__(member)))
>  #else
>  # define __counted_by(member)
> @@ -387,8 +393,13 @@ struct ftrace_likely_data {
>   *
>   *   gcc: https://gcc.gnu.org/pipermail/gcc-patches/2025-April/681727.html
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#counted-by-counted-by-or-null-sized-by-sized-by-or-null
> + *
> + * Code that runs outside the kernel proper (e.g. the EFI stub) can define
> + * __NO_COUNTED_BY_PTR to drop the annotation, as with __NO_COUNTED_BY. Such
> + * code may also lack the flag Clang needs to parse a reference to a
> + * later-declared member (-fexperimental-late-parse-attributes).
>   */
> -#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> +#if defined(CONFIG_CC_HAS_COUNTED_BY_PTR) && !defined(__NO_COUNTED_BY_PTR)
>  #define __counted_by_ptr(member)	__attribute__((__counted_by__(member)))
>  #else
>  #define __counted_by_ptr(member)
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 

Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks
Justin
