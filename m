Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C051D89E3
	for <linux-hardening@vger.kernel.org>; Fri, 30 May 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626124; cv=none; b=IBQwi/X+ooyDc9ELwwMJ27B5BBFDtHgBfw/cJAXHgbMfhnQ4nIVqDImyj8wZWgiwoXotYl3X+BEb8xV6hH75wtPoGUCAiXQLQWFRx9etMhWQ1z3qfAwonMQAAfwERztGdrOPpMC+5TIcla4kaYBk/3fNw/ATBaqsR/QKjGg4MtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626124; c=relaxed/simple;
	bh=GdcfJTIn4EytzQKo4ejTdCL4JTbbbptL8+8tqtN4Cvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7F7Tetm8qPGjrhnhNctirVfZHtLbOKYFQlZeAcbMY++7iwa0h7QRjD3ANyglAGFfVW2g9NG3RhPHBFIQKprdMDqg0i1UC1m5R/7LVd+Sl/jn1YvVPxyM1siBqll0NkhQtni1YUBPx2KiFER1+pzvkemmcoRUIEv5UwpUeW3Vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATkJwl0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATkJwl0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50C0C4CEE9;
	Fri, 30 May 2025 17:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748626123;
	bh=GdcfJTIn4EytzQKo4ejTdCL4JTbbbptL8+8tqtN4Cvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATkJwl0WhZr2oNKqAcxbj4uBGmLzfhBZmkWuhd3oOdOeZ18cbiNkyEmaZzixDZ/OH
	 3T1IQWLc2UvpHqooPq1kA3Oxraj7CVeno0n/fIkojyopxiX6/Ec2rc5B4p3YDClKf6
	 FUaEzhbE5smIIkFrQqotEGp9BaxH+cnHnFCqBJj7v5B2d2hqz9qhblvZ7AK3b/cKVh
	 yCSU+J8svgc7hCkDyP8A3/WXZMy0Bb52VNEJcY1TTIMtv+8TdieiD8kp6ATZv29n/2
	 CmbNy/IruGQAbOaMwtQF823e+4h/8Qmascp3h5J4PXXnhvHhvkfivxgINr7vBHXiRa
	 0q8j0Zs+mjz3w==
Date: Fri, 30 May 2025 10:28:40 -0700
From: Kees Cook <kees@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: i915 utils: range_overflows*()
Message-ID: <202505301026.126AB6FFC@keescook>
References: <cd0ea72c6cab6c478336cd1bb5b517a9fe7a150d@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd0ea72c6cab6c478336cd1bb5b517a9fe7a150d@intel.com>

On Fri, May 30, 2025 at 10:44:31AM +0300, Jani Nikula wrote:
> 
> Hi Kees -
> 
> drivers/gpu/drm/i915/i915_utils.h has a handful of helper macros for
> checking range overflows: range_overflows(), range_overflows_t(),
> range_overflows_end(), and range_overflows_end_t().
> 
> Looks like the first one has also been copy-pasted to
> include/drm/drm_buddy.h.
> 
> Feels like include/linux/overflow.h would be the right place for (some
> version of) them.
> 
> Thoughts?

Sure, yes! They need some documentation too. :) And probably some
renaming. It looks like range_overflows() is not end-inclusive, but
range_overflows_end() is? And the _t variants are forcing explicit
types (like max_t, but unlike struct_size_t).

-- 
Kees Cook
