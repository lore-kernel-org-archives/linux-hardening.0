Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B33033D6;
	Mon, 28 Sep 2026 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598059; cv=none; b=Hd2+5+Y8/uhhqwDKNp3hU8XOrvNNb/hoSLLq/KmtABSeoTDwN3K/yhKr470WPHTawPlUHC3kqujxpRiH8Kwo9Yu9+h6LyXIN7W3+61dXVzdmYq8ymDUaBf7uHcWoTBrQvcE36VEm977kNp5wAofLFAa7VTmuVcIpshziWI1GZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598059; c=relaxed/simple;
	bh=h5hBrZUioMhLyvR/wRBHyoBt0kZaKfr1CiDzwhJ6mf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZ1aT3eSXX5os7hx5fHv78esxBp3byIQEks+BtRZjZ59/Icr3l3kN83gSB3yWAtU3OPYwFHJ7+Dvcnv0stC24WUtYHBiVCtd2l/VxV/jMINTkn+LGLiiHHec9mVODCkz1FcpLpCEfZXXDTa4DFKGl0HwfrB82QfAVnjM8b/HpHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGv+L1mr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGv+L1mr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790598057; x=1822134057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h5hBrZUioMhLyvR/wRBHyoBt0kZaKfr1CiDzwhJ6mf0=;
  b=VGv+L1mrkc3/dKVKnI0tpd2m+0h6RIvZuYkzFqbG/x6mnEXgMQG4xPnr
   1dX5GWXzTefd/ujLVFgq+o2d2Q6iJ9nj1jMwN6g+Ak/U7bE73Xhoy9uxQ
   Lcwt9N5h/ZhcmwjosQpgd15bDz8V9na7Vqk7WSukcnFe7YuEIrtzmH+zy
   jhufn4qUFn9TcKWrG08HxRLZHLBKEkHceO3fZeN38192H8F2Gv6e5L3ga
   b/RWeb6lk+8Bkv04VqZogVjNnxnEZ10ea/10nCdeYX600cAXcZEyZVHHs
   MzGXWW5L6Qhk6nyQ0mSojhHBYR9tdG+4yfjBygSFKusxJaay1V52h0CrD
   w==;
X-CSE-ConnectionGUID: GqSavb6uTa+Pr7kfj9k6nQ==
X-CSE-MsgGUID: Z5WlajzeS/yidKuBBz4sPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="95109725"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="95109725"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:20:56 -0700
X-CSE-ConnectionGUID: XWI2mfi6RVyPeKM0E82JsQ==
X-CSE-MsgGUID: KxaJK7rBQVaAA11SqfKn5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="279765928"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.80]) ([10.245.244.80])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:20:54 -0700
Message-ID: <605221ed-a1b5-4179-be8d-b206c79487d7@intel.com>
Date: Mon, 28 Sep 2026 13:20:51 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu/buddy: add __counted_by_ptr attribute to roots
To: Bill Wendling <morbo@google.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, codemender-patching+linux@google.com
References: <20260925204423.80661-1-morbo@google.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260925204423.80661-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2026 21:44, Bill Wendling wrote:
> In 'struct gpu_buddy', the 'roots' field points to an array of pointers
> to 'struct gpu_buddy_block'. The number of allocated roots is tracked
> by the 'n_roots' field.
> 
> Annotate the 'roots' pointer with the '__counted_by_ptr' attribute
> referencing 'n_roots' to enable compile-time and runtime bounds-checking
> via KASAN and '__builtin_dynamic_object_size'.
> 
> In 'gpu_buddy_init', 'mm->n_roots' is initialized first, and 'mm->roots' is
> subsequently allocated with 'kmalloc_objs(struct gpu_buddy_block *,
> mm->n_roots)'.
> 
> Since the bounds associated with 'roots' ('n_roots') are fully set prior
> to any array allocation or access and remain invariant, this annotation
> will not cause runtime panics or false-positive bounds checks.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Would it make sense to also do this for *_scoreboard and free_tree, if 
we add a new field n_orders?

> ---
>   include/linux/gpu_buddy.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index 2c36124bb696..d7249e500ab6 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -172,7 +172,7 @@ struct gpu_buddy {
>   	 * a power of two, with each root being the largest power-of-two
>   	 * that fits in the remaining space.
>   	 */
> -	struct gpu_buddy_block **roots;
> +	struct gpu_buddy_block **roots __counted_by_ptr(n_roots);
>   	/*
>   	 * Per-order free block scoreboard: free_scoreboard[order] holds the
>   	 * number of blocks of that order currently in the free state.

