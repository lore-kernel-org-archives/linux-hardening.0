Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF6320B;
	Fri, 30 May 2025 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628367; cv=none; b=YeRXrRDfWU+Gnz8SqyHfus5cMcy0ECu4gemCdjfhq/qL+pn9K6/IxEboeaTgipBgf2ykOty5UuSTsfFzdGspOHZ1P4n+aAOyM2V47Hl5uMHeJKw4EyvKzQXsliPtspTp2b9kBo+Jy5hw+gEyoDqHJJ9DhBI/GkD+zAX5J/9twXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628367; c=relaxed/simple;
	bh=vTjL12s6KvtxA3tMHxUHBMgloZwocQuSUhLfD5vvNtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxBttSELVAaXWA+lO6wEHor4iXWaE2WCsUqoU4LsmXKRxYh744V/HijdPtNlGc3s/VGDEgALNUZNuKK6UiRFFlAZc3pQ5LpvBjbfs4RIGFShCVv0F0+Yl0nTzgOKvOKBQl8n6C9OoK3rwDyAwohUkzx9d5DcGTOfd2mFWihXHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN4Re0Sd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN4Re0Sd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1D7C4CEE9;
	Fri, 30 May 2025 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748628366;
	bh=vTjL12s6KvtxA3tMHxUHBMgloZwocQuSUhLfD5vvNtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tN4Re0SduTQAupT/AgsL3IJXj9KsGw3/jtt0x6mQ+11wviDGwPUzdmQ/NdKf9FTLH
	 igXbZ6mzpvUFiZAi3IuZQqtfe7gPbwSJgkmtrxATmw5o3ZAhpF+nLPzRta2SLUEpng
	 ZFp1w4XoguzIeaoUkNuZAtB1nH0KrnaRbm9a16FRdr74kXxyNedo4mGH4rYakB/UTO
	 TvBobJDk021EBFRx7ognli1P2B659+5AEat0M5tsuUxnE8wK/nv3ynPmCFIhs2BFCt
	 PVyhxifT3Mj0K+BnqmMbjIBiVKUOr5lAViQWeC9yuGILIn2ySKjWRoJ0ZU/Ve44TyT
	 6Lh37fMXtwPUA==
Date: Fri, 30 May 2025 11:06:01 -0700
From: Kees Cook <kees@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3][next] overflow: Fix direct struct member
 initialization in _DEFINE_FLEX()
Message-ID: <202505301054.A786A183@keescook>
References: <aBQVeyKfLOkO9Yss@kspp>
 <d4eed1e3-6fc0-4372-8ced-ae6a49f3c5c1@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4eed1e3-6fc0-4372-8ced-ae6a49f3c5c1@intel.com>

On Fri, May 30, 2025 at 04:59:35PM +0200, Alexander Lobakin wrote:
> Unfortunately this can hurt performance on my setup.
> In XDP, we usually place &xdp_buff on the stack. It's 56 bytes. We
> initialize it only during the packet processing, not in advance.
> 
> In libeth_xdp, see [1], I provide a small extension for this struct.
> This extension is 64 byte, plus I added a definition (see
> `__LIBETH_XDP_ONSTACK_BUFF()`) to be able to define a bigger one in case
> a driver might need more fields there.
> The same as with &xdp_buff, it shouldn't be initialized in advance, only
> during the packet processing. Otherwise, it can really decrease
> performance, you might've seen recent Mellanox report that even
> CONFIG_INIT_STACK_ZERO provokes this.

FYI, you can use __uninitialized to force CONFIG_INIT_STACK_ZERO to
leave an automatic variable uninitialized.

> What would be the best option to resolve this? This flex XDP buff on the
> stack is fully safe, there are a couple checks that its size does not
> exceed the maximum (defined by xdp_buff_xsk) etc. And we really need to
> initialize it field-by-field in a loop on a per-packet basis -- we are
> sure that there will be no garbage.

But yes, this is suddenly not available for _DEFINE_FLEX after the
referenced patch.

> It's even worse that most drivers will most likely not want to add any
> additional fields, i.e. this flex array at the end will be empty, IOW
> they just want a plain libeth_xdp_buff, but I made a unified definition,
> with which you can declare them on the stack both with and without
> additional fields. So, even if the drivers doesn't want any additional
> fields and the flex array is empty, the struct will be zero-initialized
> and the same perf hit will apply.
> [...]
> [1] https://lore.kernel.org/netdev/20250520205920.2134829-9-anthony.l.nguyen@intel.com

Okay, so it sounds like you need the old behavior of _DEFINE_FLEX, *and*
a way to apply attributes (like __uninitialized).

How about replacing _DEFINE_FLEX with:


#define __DEFINE_FLEX(type, name, member, count, trailer...)		\
        _Static_assert(__builtin_constant_p(count),			\
                       "onstack flex array members require compile-time const count"); \
        union {								\
                u8 bytes[struct_size_t(type, member, count)];		\
                type obj;						\
        } name##_u trailer;						\
        type *name = (type *)&name##_u

#define _DEFINE_FLEX(type, name, member, count, initializer...)		\
	__DEFINE_FLEX(type, name, member, count, = { .obj = initializer })


Which would yield this for ___LIBETH_XDP_ONSTACK_BUFF:


#define ___LIBETH_XDP_ONSTACK_BUFF(name, ...)				\
	__DEFINE_FLEX(struct libeth_xdp_buff, name, priv,		\
		      LIBETH_XDP_PRIV_SZ(__VA_ARGS__ + 0),		\
		      __uninitialized);					\
	LIBETH_XDP_ASSERT_PRIV_SZ(__VA_ARGS__ + 0)


Does that look like what you'd want? (Note I didn't actually build this;
I want to make sure the concept is workable...)

-- 
Kees Cook
