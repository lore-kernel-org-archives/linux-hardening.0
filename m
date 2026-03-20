Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78721DE4E0;
	Fri, 20 Mar 2026 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034591; cv=none; b=faRm0yaohdk+T0BvyoRwHSHp2vhK46JKsMiZq4kaLFPZyb+sk/AYAs3lafSvFSD7oOmboJBi9jWAn/brLMRXGt9ijsaiCKqK/amySKXC/wizlHdeTE+9rajXuL5tirWdldq4O4Udc4uMjWYSeLGg7jaLcLT9bTdyHg9Imt6UXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034591; c=relaxed/simple;
	bh=PItEKBs5N75jkQc0IGyr3nsPtC76/q+czmp4uYav2+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/6w0I1cxD0aPOIKuSIRMjUmEgWB/kDDj+ytDhPa/B/on+mfAu7odfH/vpTml/Zjo/5bxiLTLnLeIs1epsAyhiOH4ZhU0wCDez68tzdenvhRgMPfV0ezKLu1T+2vNO+9tqL+GUpUjtJqd+cILl25zrwnrlp5X3QzliE62hM49LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8Nuezi/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8Nuezi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F2CC4CEF7;
	Fri, 20 Mar 2026 19:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774034591;
	bh=PItEKBs5N75jkQc0IGyr3nsPtC76/q+czmp4uYav2+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8Nuezi/gsT1GxMvyu2PdP82s/MqZzWrE3ZHP9KkU6Hy8+CcVG/VBrvYz7/We3MAn
	 d8gZsPvyb6ibnIMgTLVRvgSPhwupSekCGdzFYtguq1+QwGT1IjX7TMOsOvBcFwHXTJ
	 8+k16AXdQcvNhoQHxQTHmTDFWu23HJl09dPQbS7mwQdTFvH0ChAaobP1mBvOhkA6at
	 rYhqlHqDkLD5zxJFAe7WNVyxMQjFuLxwv3Lz8ZxCuvJc2FSbNydxDXqfc+/OmIhIxq
	 bnTForeowW9UQfkwjYXKPNBTkMI6AMiOQenJZLWYm5CyYCkMe9EorMPxji9qRRSNHP
	 cJk3VoOz/lVZw==
Date: Fri, 20 Mar 2026 12:23:10 -0700
From: Kees Cook <kees@kernel.org>
To: Ingo Saitz <ingo@hannover.ccc.de>
Cc: Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Build error in next-20260223 gcc-plugins/latent_entropy_plugin.so
Message-ID: <202603201220.8E538CC1@keescook>
References: <4051116.1771996801@turing-police>
 <202602242333.24E5CB214@keescook>
 <4147110.1772032451@turing-police>
 <abVntmj9O7uXnES2@spatz.zoo>
 <abV0OEcoN6H_QZEP@spatz.zoo>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abV0OEcoN6H_QZEP@spatz.zoo>

On Sat, Mar 14, 2026 at 03:44:08PM +0100, Ingo Saitz wrote:
> On Sat, Mar 14, 2026 at 02:50:46PM +0100, Ingo Saitz wrote:
> > I attached [...]
> 
> Grml, here you go
> 
>     Ingo
> -- 
> const_cast<long double>(Λ)

> From 552485b879d19780afd3614d69508c3ea7cb242f Mon Sep 17 00:00:00 2001
> From: Ingo Saitz <ingo@hannover.ccc.de>
> Date: Sat, 14 Mar 2026 14:24:56 +0100
> Subject: [PATCH] Replace CONST_CAST with const_cast<>.
> 
> For gcc-16, this was removed in gcc trunk
> 
> see commits
>   c3d96ff9e916c02584aa081f03ab999292efbb50
>   458c7926d48959abcb2c1adaa22458e27459a551
> ---
>  scripts/gcc-plugins/gcc-common.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
> index 8f1b3500f8e2..7b3517b31e0a 100644
> --- a/scripts/gcc-plugins/gcc-common.h
> +++ b/scripts/gcc-plugins/gcc-common.h
> @@ -309,7 +309,7 @@ typedef const gimple *const_gimple_ptr;
>  #define gimple gimple_ptr
>  #define const_gimple const_gimple_ptr
>  #undef CONST_CAST_GIMPLE
> -#define CONST_CAST_GIMPLE(X) CONST_CAST(gimple, (X))
> +#define CONST_CAST_GIMPLE(X) const_cast<gimple>((X))
>  
>  /* gimple related */
>  static inline gimple gimple_build_assign_with_ops(enum tree_code subcode, tree lhs, tree op1, tree op2 MEM_STAT_DECL)
> @@ -414,7 +414,7 @@ static inline void ipa_remove_stmt_references(symtab_node *referring_node, gimpl
>  #ifdef __cplusplus
>  static inline void debug_tree(const_tree t)
>  {
> -	debug_tree(CONST_CAST_TREE(t));
> +	debug_tree(const_cast<tree>(t));
>  }
>  
>  static inline void debug_gimple_stmt(const_gimple s)
> @@ -422,7 +422,7 @@ static inline void debug_gimple_stmt(const_gimple s)
>  	debug_gimple_stmt(CONST_CAST_GIMPLE(s));
>  }
>  #else
> -#define debug_tree(t) debug_tree(CONST_CAST_TREE(t))
> +#define debug_tree(t) debug_tree(const_cast<tree>(t))
>  #define debug_gimple_stmt(s) debug_gimple_stmt(CONST_CAST_GIMPLE(s))
>  #endif

Thanks for this!

Should CONST_CAST_TREE be explicitly defined instead, to match
CONST_CAST_GIMPLE in the this header file? It seems weird to have one of
two done this way: we should either do both or neither (CONST_CAST_GIMPLE
is only used in the header file too).

Is const_cast<gimple> and const_cast<tree> valid back through GCC 8
(earliest Linux-supported GCC)?

-Kees

-- 
Kees Cook
