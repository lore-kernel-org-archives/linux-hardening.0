Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8FE4503B;
	Thu, 17 Jul 2025 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796024; cv=none; b=mUJBtpx5bR8W0J/lLxMtBK6cHrtLOke7tibeL7+rDo4hIRVqLqdOw2YODt/kM+JvkcfTYjfqYm6Zonck3HizRGc+pmn+/EonZ2dLH+28C9B3is8AybnVUsTzKdc1XcalOmINbCCA6OcjO9L1SBtMCm/Dmy1iMZOeY3VQjUJGzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796024; c=relaxed/simple;
	bh=I1B30MQpTQXktRPkN777QTQ08u2BAwEEqXctlyniqWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghgQQfaT8Im0vMOsUxgZql1y/Aq4LP2ijrtGDnWPEKPVxVtIS8NLH8rxMNkKZYzxjx3TBMnBRxss/hyfwIGUXhROZJIGAQEoPnuZzz2R+ZCL93nS4Rsld0qW0s+0BTzfM2g/Ohoo3QJsom61LGAnrHqgFwn9kOfUQzjJwSvYOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpLCkMB3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpLCkMB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D14C4CEE3;
	Thu, 17 Jul 2025 23:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796024;
	bh=I1B30MQpTQXktRPkN777QTQ08u2BAwEEqXctlyniqWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpLCkMB38ReuCUES6mxdPPSP9JoA5/6Ff1AfVkh8IUf47Pg/A/KN7JYYH4zc4uVjp
	 Cv2s5oLH+Y3jLrXYtvnL2YYq7GQrNjQdyc5HTk5QCmuw3MvRWzNBGfuBpA/1KapApl
	 wYkZY3PKauv7I39dXAsPbcDUrXBWxcKIHY8jvvDpNTYoWxPkDnj2w/uEnQ/aS390WF
	 1mxpm8Zz5eNi6SanyCApo1PwXhFjV+iXEb13Yejavt6DlP+IV79CHEkIIVmROvAqMF
	 bhPC516vVddLC3h/Yq1HXnniECD12s7M0mAz8Lxi4nqX4k0hnGS0kzYHanDU3jzRyx
	 sLHxgoTqDx0yg==
Date: Thu, 17 Jul 2025 16:47:04 -0700
From: Kees Cook <kees@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Martin Uecker <ma.uecker@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <202507171644.7FB3379@keescook>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
 <20250711184541.68d770b9@pumpkin>
 <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
 <202507142211.F1E0730A@keescook>
 <3o3ra7vjn44iey2dosunsm3wa4kagfeas2o4yzsl34girgn2eb@6rnktm2dmwul>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3o3ra7vjn44iey2dosunsm3wa4kagfeas2o4yzsl34girgn2eb@6rnktm2dmwul>

On Tue, Jul 15, 2025 at 09:08:14AM +0200, Alejandro Colomar wrote:
> Hi Kees,
> 
> On Mon, Jul 14, 2025 at 10:19:39PM -0700, Kees Cook wrote:
> > On Fri, Jul 11, 2025 at 10:58:56AM -0700, Linus Torvalds wrote:
> > >         struct seq_buf s;
> > >         seq_buf_init(&s, buf, szie);
> > 
> > And because some folks didn't like this "declaration that requires a
> > function call", we even added:
> > 
> > 	DECLARE_SEQ_BUF(s, 32);
> > 
> > to do it in 1 line. :P
> > 
> > I would love to see more string handling replaced with seq_buf.
> 
> The thing is, it's not as easy as the fixes I'm proposing, and
> sprintf_end() solves a lot of UB in a minimal diff that you can dumbly
> apply.

Note that I'm not arguing against your idea -- I just think it's not
going to be likely to end up in Linux soon given Linus's objections. My
perspective is mainly one of pragmatic damage control: what *can* we do
in Linux that would make things better? Currently, seq_buf is better
than raw C strings...

-- 
Kees Cook
