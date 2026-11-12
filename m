Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515467;
	b=fO5sAaHH6c/sn7dXLHStcL13HGui3Jypx0QroPgRc6pdKQ6Fuj+aCKSc9z0ZPFdMV2k+
	 0r8EwR0F86XWNZqSgG6sNaQYto79k1oukMzyBY5DNyqAIBNAkSwFTPojtzaEZF1MtWB6d
	 I4Qnae/HXiJwZMgahQnvMv8Zsqy3DLyAsBK3BZ1+rbWEWqSQRIrK6T8ohTex9OlOSRKy1
	 GhKeRcOQ5ly7CEN1j7hmzZ3GYBsMJq53mIq6mjl9Z5J58HMwwpsflUE7ddHzXKKnxSIzw
	 NIMs8r9bAt27782iUdcLNTPdvHt3G4aMrMETR4hkPd0HUtN9nzdvTeTu4j0Lx7zfWvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515467;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/ubvRwcccWxNSpvErPp2UoWwkLJEHMxbyrj8UkWM8eI=;
	b=T0EoVtzmqSlCFQP564lE25ARLTTPKThy8codTa1JZOrjN7W634gy7Exs92BTUqxp7YBY
	 2OISEPfAGaj66t+tSwT9Di4SzkKyUMgxDF+ilHWoOMv7wXbNFSkh5P2XnqHiDsmF3yXu8
	 UwGu0dOxeh46HbaGrhijk/MUjiwnyvON3WM4Wr3VhibuBZ15DJEDaxZS9v5FcGQEl6/t1
	 xUwJBgjiQYgPyd1EMXdmbjnERLRnM7JLC0cEp4NDGQfTdt5EcbZSDRmfwsga2RacySyG0
	 lrXOeIz/iZqnM2p4jGDmYLKg1YME9Ey/xoBu4YGVYFLVCl0I4+WKe4ofjjgbXgyYH1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YL+30wZl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4A606A31C;
	Thu, 12 Nov 2026 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YL+30wZl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8471F000C4;
	Thu, 12 Nov 2026 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515466;
	bh=/ubvRwcccWxNSpvErPp2UoWwkLJEHMxbyrj8UkWM8eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YL+30wZlS3rLh0LeYgGh3r2fl8dbqxa4BVc2cZYACexmclv8smqaglQhJXIa+CBMB
	 NU5iiWe/1RB9aPIE6m90iNaRY7mQiN5B/RT777CXw8WayNq8s5VcB6JhqOCXuZsqVI
	 AlMn8YPLtrT5zH+2tCR3DquiYl5lbhe4gcFTXba/kohtiD1dmXn5OiwmlQo4tkCtQf
	 3g9J6dOl8xNyD3VPu7Y8mp1Or+xSLausei4DzmwB+h3aUUksDRitynPUtLuzX9LQLl
	 9WQ5LpsNfQtYemhDVfrP416SkjNY10qLRx+aT+azNsjqC6VwY09hCGiKg7vc/N/95p
	 TY2jtnGIuNj0Q==
Date: Thu, 12 Nov 2026 12:31:06 -0800
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>, hverkuil@kernel.org,
	mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <202611121228.D57E624119@keescook>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
 <20261108210232.13800dd3@pumpkin>
 <avDmyLYpWOQ2WB-i@debian>
 <202611120947.AC428BE4B@keescook>
 <20261112190702.480740d2@pumpkin>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112190702.480740d2@pumpkin>

On Thu, Nov 12, 2026 at 07:07:02PM +0000, David Laight wrote:
> But both snprintf() and seq_buf are far more expensive than doing the
> strlen().
> There is the separate issue that strlcpy() manages to needlessly inline a
> strnlen() in a lot of the call sites - instead of deferring it to the
> helper function.

Right, my driving goal here isn't about performance, it's about
correctness (as much as possible given our giant codebase). We don't
need the most perfect fast implementation if it's too easy to shoot our
feet. strlcat() requires an external bounds that has no strict tie to
the destination argument, and it has no bounds information at all for
the source argument.

If we're in fast-path, we have a different set of criteria. And seq_buf
was actually designed for that, as it trades storage for speed: it keeps
the needed offsets in memory, but that makes it fast for stuff like
perf.

-- 
Kees Cook
