Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6323947AC;
	Wed,  1 Jul 2026 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890876; cv=none; b=oE9boWHJ3+IGxNJLGL3Mm1pjZ61G8e7CcmoLkQB2jZmZ1b/T2y3sNAen037n3GsNPBfaxKuZvE05Mxv/DSnkb92i5Xcj47/ZNlR/U9o/gfGVtdohf0whOg7LTt2leZiNAxz2TZaDzp8ra4NRxVfwPr4EeOnLUWQlB06HhBKQcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890876; c=relaxed/simple;
	bh=jW1NBw1qHnlKhZfdMyrKwtK+Ae90Kyc+mX3kaOFeRMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAzETCH/TT9UFyUfElFpjCjtZSy+qDVax58Ux+LSeIBjm/eWCfdAGe+lG8+yyXaUigDzHiuWKVRn3ZOoKbk4rkDA142mULVp+aXSYxSxDIC3xUcOYB2tLi188q1QoTnnn6/3aMdO7jRlqP9x7CGAP5GsyfPzF/pOIVNVo0cVLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F4A3l3VO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F4A3l3VO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jW1NBw1qHnlKhZfdMyrKwtK+Ae90Kyc+mX3kaOFeRMA=; b=F4A3l3VOrTV/2NUkR9aRZaFBjQ
	TuviMDd0XaPHi2ZWyedDQOjTgG9RM2G3SBYKtgNyluugoaL/Oh5FvjRcsC/SdtOe3oirj95manQ/1
	3LDhDeXDZAFaiVKzZNaGz3Jh0zJ2UmhVzvb+FExz5aRIzYMRjRfloewNYde1yA/06CVsX2dtka/So
	tREX9A1R46sDhtI5dT5yi9pChQ3yXRgiBZm9+KVWXLK/4b9c9CkS8Hna/AGuk2ebfwTwLq76o4FgT
	k2cV/luBoNu9eILWC/uLhwiwbnGskD9wJxEWGYJgECEZi4T7AjqATU4tEArVxcV2iGVLfhoTG/Tvq
	n3jHRGww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wepMK-00000006DoP-2HsQ;
	Wed, 01 Jul 2026 07:27:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C368030035C; Wed, 01 Jul 2026 09:27:47 +0200 (CEST)
Date: Wed, 1 Jul 2026 09:27:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Xiang Mei <xmei5@asu.edu>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hardening@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
	Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
	Yan Shoshitaishvili <yans@asu.edu>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
Message-ID: <20260701072747.GN48970@noisy.programming.kicks-ass.net>
References: <20260629214712.1198680-1-xmei5@asu.edu>
 <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>

On Mon, Jun 29, 2026 at 03:29:50PM -0700, Dave Hansen wrote:

> But, really, if ENTER is so evil and nobody uses it, shouldn't we just
> have an MSR bit somewhere to tell the CPU to #UD for it rather than
> playing these stack games?

For supervisor mode only, I suppose. We can't ever get rid of userspace
ENTER because legacy I suppose. But we can make sure the kernel is
clean.

So yeah, having a knob to make supervisor-ENTER trap would be useful I
suppose.
