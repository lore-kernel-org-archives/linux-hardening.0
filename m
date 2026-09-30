Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1E7367B85;
	Wed, 30 Sep 2026 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735328; cv=none; b=C3qn60xecKjWA98ohxbKlEBR9JIoqAqE76Tz4/snuSbl48lI0KxOOHYz/NCFadDqsvL1G8Gkul8ddhBfreyzZXnZzaSu+HnuOg0PPo3s+5LAeXqO+WMMFkWTTo6pI0s8aK1ZnhtdC6vEbM51wO40rN6ewpERNRPQ1lou/fQ4X0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735328; c=relaxed/simple;
	bh=zB0otH/hVEu1Wr4tyBHwbPwBa/K1KHpyemdLa5Z69u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCRsU7BjheAzI9xLV2rCIjtgScf1t5cmyMjEdG0Aaa74dPM30iiXJbTgC9/QuzcA72zxMtTgwQxfub5SOpiqdYyZtKKDWlcyg2mCd7yWziZiHNbBQ503QdxWWi9nZPV5eAdZG1S4F7/xzVfFXCDjlc58UKN0RkahvNCBddTF3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlV4/Pjo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlV4/Pjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A801F000FF;
	Wed, 30 Sep 2026 02:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735324;
	bh=5tiPKJQOAbmGdP7F/ZZTAcs55NJ2xHhHsVb8/IhifjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mlV4/Pjo9HdddtFvEqunjDInLUpUpfhsvKPFuo2vdYVkPL7KGqOUVUAztl2BSs3qS
	 1XKwBwYLcR5Ad+OwR0yvAPuDfmqRxkd9Oh0FooyEKtBXg0wqui4nHB0+x8UZN1+CQ8
	 FkDrfLtcsc/SSc7pyBRLQSaK6zOhGqZ+lDqEsHaPWg2YT7kXKHzWpR4rhsRlRu/MSe
	 SyVmQE3p2pOsJWUEk2kARp9vAH6decN9qpXdu0iqguwltyXeVH/roaX7N3U5+StQqO
	 QeGIB7N0wgJ3XA78hRs7XnGGubQCLMLETLPVPjXFY2TxvEotUcmkOvxuugd3w1vYpx
	 8lVrud6y7liMw==
Date: Tue, 29 Sep 2026 19:28:44 -0700
From: Kees Cook <kees@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bill Wendling <morbo@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 5/9] seq_buf: Add seq_buf_strlen()
Message-ID: <202609291927.9D27E60@keescook>
References: <20260919002658.stay.929-kees@kernel.org>
 <20260919002714.4060307-5-kees@kernel.org>
 <2026091953-cherub-empty-ef35@gregkh>
 <202609191326.4042FC4@keescook>
 <2026092037-antsy-shrapnel-6139@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026092037-antsy-shrapnel-6139@gregkh>

On Sun, Sep 20, 2026 at 06:34:32AM +0100, Greg KH wrote:
> WARN on the init makes more sense, but even then it feels odd as if we
> wanted to make a seq_buf with data from a device or userspace, we would
> have to verify the size is non-zero _before_ creating the seq_buf or we
> would crash.  So someone has to check the "untrusted" data somewhere,
> right?
> 
> And why can't we have buffers of 0 size work just fine?  What prevents
> that?  People have "empty" strings for lots of things.

Yeah, okay. I'll not add the WARN for seq_buf_strlen() and remove it
from seq_buf_str().

-Kees

-- 
Kees Cook
