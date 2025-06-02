Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D319067C
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888454; cv=none; b=U6B/1seBdPmsvyCGD/aRLzEWEBzYXH9w9e9wTUZXZFdv6OLlQG/YhzTe1WhR2NP5meP6j1v2ztojjRlPodLZqmGzR7PsfV7TUy12DUs7gaoknhqFZXOlDimRdfvj6HJTD0WaDLQV5fW6hcMsraYb0Y+FV9Np/wdjayRmBKyoTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888454; c=relaxed/simple;
	bh=O3my166LRHaBSKhIYcdzCfjQsCp0SB3BDG9miz6KYug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le3MRm6LrwDox0Q8YdIPA5TDYZhuhdyX+BmVzYh5RBq2lNeKUSObhsm262WL7UXtfQL7PUNVJI0N1wogd5TwrTVyMK7xIHm0fZ91EKTVUMnJ883YonDGGxp9l/eofRIN+qBu4QsmJgSnlnkqzAwKnXh4VToOf3Bq2wmxpFL1ze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwvfGDng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwvfGDng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5013EC4CEEB;
	Mon,  2 Jun 2025 18:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748888454;
	bh=O3my166LRHaBSKhIYcdzCfjQsCp0SB3BDG9miz6KYug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwvfGDngokneW72eZf83YemJzBLjUKucyMacXdG7AttdAkQctpxFNOTgftS2Bh9bJ
	 wQnTY9hUr/TxJym2bo7fUiDpKUaheyRVA00kI9K2kWfzIASfS3QRXZRV63URoUbior
	 ZskgeiOSEFmOxY/xPLXzOaUk6VB9A05EhM+Vd7G1u+ZaoSWpWXl6pzqIVL6eXp1oGZ
	 bKKxWkjSbD+Y8YwGBUU6xyBGc5zzbzGJCsIzUprq3faUgK4vPOXeTC054p2aYXBmDQ
	 vvU1Y7wUUc7ClMTFnWt+7G3h5P+3eS9wbykvlk5Spkm7obdDoWmm/cZLTBYyLRVCO5
	 4r+nck5OCWz9A==
Date: Mon, 2 Jun 2025 11:20:51 -0700
From: Kees Cook <kees@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: i915 utils: range_overflows*()
Message-ID: <202506021119.8FD6339F@keescook>
References: <cd0ea72c6cab6c478336cd1bb5b517a9fe7a150d@intel.com>
 <202505301026.126AB6FFC@keescook>
 <d127e624d6a851f488c60631a9bf84f6316748eb@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d127e624d6a851f488c60631a9bf84f6316748eb@intel.com>

On Mon, Jun 02, 2025 at 04:10:21PM +0300, Jani Nikula wrote:
> On Fri, 30 May 2025, Kees Cook <kees@kernel.org> wrote:
> > On Fri, May 30, 2025 at 10:44:31AM +0300, Jani Nikula wrote:
> >> 
> >> Hi Kees -
> >> 
> >> drivers/gpu/drm/i915/i915_utils.h has a handful of helper macros for
> >> checking range overflows: range_overflows(), range_overflows_t(),
> >> range_overflows_end(), and range_overflows_end_t().
> >> 
> >> Looks like the first one has also been copy-pasted to
> >> include/drm/drm_buddy.h.
> >> 
> >> Feels like include/linux/overflow.h would be the right place for (some
> >> version of) them.
> >> 
> >> Thoughts?
> >
> > Sure, yes! They need some documentation too. :) And probably some
> > renaming. It looks like range_overflows() is not end-inclusive, but
> > range_overflows_end() is? And the _t variants are forcing explicit
> > types (like max_t, but unlike struct_size_t).
> 
> Ah, naming.
> 
> As we all know, NP in NP-complete actually stands for "naming
> problem". It's hard to come up with a good name, but presented with one,
> it's quick to verify it is indeed good.
> 
> Ideas for the hard part?

Well, since the users already exist with the current names, how about we
skip that for now and just relocate these (with added kern-doc) to
overflow.h and go from there?

-Kees

-- 
Kees Cook
