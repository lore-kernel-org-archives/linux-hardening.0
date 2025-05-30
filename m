Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82FF189513;
	Fri, 30 May 2025 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748631169; cv=none; b=b7jUM6nYiBdB5etkcDoRHsuRHPtvqyitHuCCaIu7MTkoJUhDw75Ornay1aoSDAz/M79B3RhzQWFfId343xggdfFPJ2lBOBaedo0MdS2JlluKUjpXbha0s6itbjhgF2YhqU5CO9T0GrCEedw1UWumBEWEI//tpKTnpsgF8vEN7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748631169; c=relaxed/simple;
	bh=FQPMKronnbZixqRF5rYHmx0k8Hi4UbqrcPT7Lo9aCCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTBCbbxGSEraFrk0zGCzONwpAJQg6PgVJ+kqG8trT/5IzphCdue3yk0onIelrPKCdNfZwRwoCadvp/hFOvg4VRYf7VK7VelzUPlQbpMra1RAp4MZGTPLm3SxGF+f9rLrKjZJoGs9by4wvsYrLMSwc0JB9T1To6TLLE2jQbaIKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGKZIj90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGKZIj90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BB2C4CEE9;
	Fri, 30 May 2025 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748631168;
	bh=FQPMKronnbZixqRF5rYHmx0k8Hi4UbqrcPT7Lo9aCCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGKZIj90Q5s5AJPF1+8umGeT5/FLGKUv58yrc3F1xglLV+y+/9nkpZ/hMNuWtOnYC
	 RuDmOXQ/Ike8Xg/kaEWCsIV0EvK5S3ugsWEqZz1SKCbdE/tq7yD9bIHGmxVz5sBOF1
	 mw1XrSQgQDaRJmYzREBW4IZl/ukAe6mORVds5ndzU7Fjk0I1Jpx36GYRBQEA3h9pmG
	 S+ly9EMibSnypgkOwkKGGhYGvOA7ea9UGKSxMedsMpRR4ZfITo9rYPtO/advDQXQm3
	 4dF3rqsU+UBDPFXi/roQvmjx/bD2vRCS2O/SjSjWBNOhBFW7H+3dXZlSGZ+cOOqyMH
	 UeIJjmXI3KgMw==
Date: Fri, 30 May 2025 11:52:45 -0700
From: Kees Cook <kees@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3][next] overflow: Fix direct struct member
 initialization in _DEFINE_FLEX()
Message-ID: <202505301151.6CEDBBF8@keescook>
References: <aBQVeyKfLOkO9Yss@kspp>
 <d4eed1e3-6fc0-4372-8ced-ae6a49f3c5c1@intel.com>
 <202505301054.A786A183@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505301054.A786A183@keescook>

On Fri, May 30, 2025 at 11:06:01AM -0700, Kees Cook wrote:
> #define __DEFINE_FLEX(type, name, member, count, trailer...)		\
>         _Static_assert(__builtin_constant_p(count),			\
>                        "onstack flex array members require compile-time const count"); \
>         union {								\
>                 u8 bytes[struct_size_t(type, member, count)];		\
>                 type obj;						\
>         } name##_u trailer;						\
>         type *name = (type *)&name##_u
> 
> #define _DEFINE_FLEX(type, name, member, count, initializer...)		\
> 	__DEFINE_FLEX(type, name, member, count, = { .obj = initializer })
> [...]
> Does that look like what you'd want? (Note I didn't actually build this;
> I want to make sure the concept is workable...)

FWIW, this is working as expected: https://godbolt.org/z/P7Go8Tr33

I'll send a proper patch...

-- 
Kees Cook
