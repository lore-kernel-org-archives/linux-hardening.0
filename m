Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98323C8A1;
	Tue, 15 Jul 2025 05:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556780; cv=none; b=F7MU881yt/Lot43HCthNfHapeTet7Ud8H/F0ZhT6QRJarL/544vO1u8y/o4i6FhV1huFsm/9rg6D+bktTRoRJRj4EeBXQ0iLymkCfFcQ3QVXHcOww29P3jwnnc9VztBsefrhfiAgxJyBzvKAm6oTP4jbw8Qump6k/qIZmX3T0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556780; c=relaxed/simple;
	bh=5kJrTLqEK1l9YRk4TYXY3UDlW4+Q7ZyR4bvWSBUgUaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ0kf1rvsbGcTCKdeQLZw9wuUmZVfV645FYWR7LTPkCcrEUo7TWEifNpl3pefF1nw2hKMvJ5S++pEy36D24JhWDGU4zHFMwtBtfyHHESBpSnoWyTWlnSRhI9zZ66vzmYQbAaBDa+GwZze4sxuNi0V9HkDXfEUnxfIZGKmAaEsSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sj/n5ugK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sj/n5ugK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF659C4CEE3;
	Tue, 15 Jul 2025 05:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752556779;
	bh=5kJrTLqEK1l9YRk4TYXY3UDlW4+Q7ZyR4bvWSBUgUaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sj/n5ugKL9ykdWrIT+XGG95CfEapwo9WgrNNxjl4GIflUC6TQ84uZ3wMWiGhj0Vxb
	 8mXV8V7E+SD5AP/aAM/heraB3ndsWzpudozFW6V6psdo5VeToVtj0OJ3mCGcqUB1MS
	 CGPJU12tcQyWoDmHguGdOeCgMFfp7QaA7iKaq/fdKHxTYTjJdnkv0160osGqVFoMBG
	 +iPkaCd4l7IEy3gVJAQydTP4PPc5yLLr0VP/KSO1b84QS3X7sBszabOWvkuzLZjVo2
	 LO0CkPGw5NpCDASRVOpbHSlkQNeKJTf9VQvEeOhYWW2FUTDwatpxGK5AvZKh5yqIEp
	 rTG31ApuNCbVw==
Date: Mon, 14 Jul 2025 22:19:39 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Martin Uecker <ma.uecker@gmail.com>,
	Alejandro Colomar <alx@kernel.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Andrew Clayton <andrew@digital-domain.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <202507142211.F1E0730A@keescook>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
 <20250711184541.68d770b9@pumpkin>
 <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>

On Fri, Jul 11, 2025 at 10:58:56AM -0700, Linus Torvalds wrote:
>         struct seq_buf s;
>         seq_buf_init(&s, buf, szie);

And because some folks didn't like this "declaration that requires a
function call", we even added:

	DECLARE_SEQ_BUF(s, 32);

to do it in 1 line. :P

I would love to see more string handling replaced with seq_buf.

-- 
Kees Cook
