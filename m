Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FBB37F756;
	Mon, 11 May 2026 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530126; cv=none; b=piAz9YtmCWqmg/P4xpX+WsoMng12udMKVBUtlcvHpBIiG1CGj8/aNol+6F4k6ttYhzrQ7NzjiQMvZCDY3bzr92PG3dI+njKKaMhbA/5uVf1uxQDkrH9URHKJUaCAHszk3REHih8K4/3fNC6YqQXn3CTKzw8TQhjR2v/pMT0Fv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530126; c=relaxed/simple;
	bh=DWrxPvlJ5hkzAcFJ2xL7k/KJZ1lNdyZVHYKmVbdsOHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChvVv5duXLT2z1kNzI8IrYJNuFSl8OKQ6nmvqleJscuUZesOZBbd093u0NgJe3X5XJD6mvxYiCbRgmLXBA3BC+MRWHIhLuF44fyTckNjHjk3MRD1jHZoeAftHPIqOye9h6/oSk6hYW9Fm8iTgKeON3NZkhoNm8EFMGAS7erPuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVEiUbho; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVEiUbho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE96C2BCB0;
	Mon, 11 May 2026 20:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530126;
	bh=DWrxPvlJ5hkzAcFJ2xL7k/KJZ1lNdyZVHYKmVbdsOHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVEiUbhojNJ+RQjmfCnjap+RcuaGENRIOH6OHWn9gh+iiqDH76jq8P+FNT63CZBNu
	 uTK0nwsCPrsw871JY61zGVmGtvk+YgSVeXWBafd/I4zVtypuRHefmVmbta4WYwJTI7
	 kFJihP9OmW4VssAWv+2v/8VZvqo4qA+e/9DD6WXcPO3dEMrQKDfrsplYOxk69MLdxe
	 FA6vfJXpqC8hvr/oYnwIiBOOL4FDkItAC2xxGGK106JwPkEao5oBjJWVhic28MChg+
	 oIpI+NKw8QEZpGiE7heIgoVxB7bISqGqbW1YbdqSNEErqN82Q+HeexV1wLXWVbpsWz
	 fvdpmVoZC78WQ==
Date: Mon, 11 May 2026 13:08:46 -0700
From: Kees Cook <kees@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org, peter.griffin@linaro.org,
	andre.draszik@linaro.org, willmcvicker@google.com,
	jyescas@google.com, krzk@kernel.org, kernel-team@android.com
Subject: Re: [PATCH] docs: kernel-doc: python: strip __counted_by_ptr macro
Message-ID: <202605111308.52C4CA6@keescook>
References: <20260506-kdoc-__counted_by_ptr-v1-1-70763486871f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-kdoc-__counted_by_ptr-v1-1-70763486871f@linaro.org>

On Wed, May 06, 2026 at 11:04:12AM +0000, Tudor Ambarus wrote:
> The `__counted_by_ptr` macro was recently introduced [1] to extend
> bounds checking semantics to standard dynamically allocated pointers.
> 
> However, the new Python implementation of kernel-doc does not currently
> recognize it as a compiler attribute. When kernel-doc encounters a
> struct member annotated with this macro, it fails to parse the variable
> name correctly, resulting in false-positive warnings like:
> 
>   Warning: ... struct member '__counted_by_ptr(cmdcnt' not described
> 
> Add `__counted_by_ptr` to the `struct_xforms` regex list so it gets
> safely stripped out during the parsing phase, mirroring the existing
> behavior for `__counted_by`. Update the corresponding unit tests.
> 
> Link: https://git.kernel.org/torvalds/c/150a04d817d8 [1]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
