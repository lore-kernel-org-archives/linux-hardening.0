Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB32DF3EB;
	Tue, 22 Apr 2025 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354376; cv=none; b=D05LywW/BWM6eGbzoQDRaO9FCDL1Rj67pjXFOaUvKUdBJuMTwgutR0GR35RZGA07Rd93O8Ki9ZQ1iBlJ8PoG/kV7LxpVTISGpUJ9h4gcWPqN6f/66ekXI0/kdmv8TaPoPiLEU3j1Kw7/jJ2r1WElwLm/gY7Y++uTOfsXrVRJq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354376; c=relaxed/simple;
	bh=fZhWCVrVCxDYaQIa/PSjvSZGwxh4M8xmhZX2yqflXms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNtlmenQ1d7zTUMzOOa1wanBFrGp2+uEJkppHggMQOGNIUkmurgikeGwtQslDxl5ZWcKq4nolMYz5WFG8sP5U/sNb4zGHiUnnhMU2Hd2TFA5wCq0aXtNSaqpfpnp9vERR9Ss+9yNNSQ9KeQRTiQZUQW3KCF77IQ5cRNvzwM99WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuCQ9rgJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuCQ9rgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5D9C19424;
	Tue, 22 Apr 2025 20:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745354375;
	bh=fZhWCVrVCxDYaQIa/PSjvSZGwxh4M8xmhZX2yqflXms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZuCQ9rgJWY0KaJt02KpBllLcfPsL9o0NHsGxFqdaXVT50MrQWsYqAtpKmeVp8Ykv0
	 4DwWomudqvo8pYLbQhdAdpbrJxipJNRZdJwItptBDgKlORBUGdFe0KWERh/LwnOgB9
	 h7/NtQOxxXFjXyiF7xtXN0QyADHzgr+iyU93WMFTXPiKrl5Qw0awbIs01RbV8ztVgW
	 /QehBiaoxArUV2W2hArIyVuap3TQwW3KHU5n8JbCpUSrGvzMYoLQLBK+ur8gQImkWY
	 fb4hTljI05O6oZdZMfcvtF/Yhse/LIVc9h6sP72KB7AkYbN7U5j0v4Fy7pLuQiz8jV
	 QuVvng2cK0MqA==
Date: Tue, 22 Apr 2025 13:39:32 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2][next] overflow: Add STACK_FLEX_ARRAY_SIZE() helper
Message-ID: <202504221338.05240DB@keescook>
References: <cover.1745342381.git.gustavoars@kernel.org>
 <8f9ab8fcd26ce59c0e0e25e095b446a77849c08e.1745342381.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f9ab8fcd26ce59c0e0e25e095b446a77849c08e.1745342381.git.gustavoars@kernel.org>

On Tue, Apr 22, 2025 at 11:21:36AM -0600, Gustavo A. R. Silva wrote:
> Add new STACK_FLEX_ARRAY_SIZE() helper to get the size of a
> flexible-array member defined using DEFINE_FLEX()/DEFINE_RAW_FLEX()
> at compile time.
> 
> This is essentially the same as ARRAY_SIZE() but for on-stack
> flexible-array members.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/overflow.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 6ee67c20b575..5b2e0cc9aba2 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -420,6 +420,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>   * flexible array member.
>   * Use __struct_size(@name) to get compile-time size of it afterwards.
>   * Use __member_size(@name->member) to get compile-time size of @name members.
> + * Use STACK_FLEX_ARRAY_SIZE(@name, @member) to get compile-time size of array @member.

Instead of "size of" how about "number of elements in"

>   */
>  #define DEFINE_RAW_FLEX(type, name, member, count)	\
>  	_DEFINE_FLEX(type, name, member, count, = {})
> @@ -438,8 +439,20 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>   * flexible array member.
>   * Use __struct_size(@NAME) to get compile-time size of it afterwards.
>   * Use __member_size(@NAME->member) to get compile-time size of @NAME members.
> + * Use STACK_FLEX_ARRAY_SIZE(@name, @member) to get compile-time size of array @member.

Same here.

>   */
>  #define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
>  	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
>  
> +/**
> + * STACK_FLEX_ARRAY_SIZE() - helper macro for DEFINE_FLEX() family.
> + * Returns the number of elements in @array.

Which matches these docs.

> + *
> + * @name: Name for a variable defined in DEFINE_RAW_FLEX()/DEFINE_FLEX().
> + * @array: Name of the array member.
> + */
> +#define STACK_FLEX_ARRAY_SIZE(name, array)						\
> +	(__member_size((name)->array) / sizeof(*(name)->array) +			\
> +						__must_be_array((name)->array))
> +
>  #endif /* __LINUX_OVERFLOW_H */
> -- 
> 2.43.0
> 

-- 
Kees Cook
