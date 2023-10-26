Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2726E20
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6CC18F;
	Thu, 26 Oct 2023 03:01:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3711867373; Thu, 26 Oct 2023 12:01:49 +0200 (CEST)
Date: Thu, 26 Oct 2023 12:01:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <keescook@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Justin Stitt <justinstitt@google.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <20231026100148.GA26941@lst.de>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com> <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook> <20231020044645.GC11984@lst.de> <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com> <202310201127.DA7EDAFE4D@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310201127.DA7EDAFE4D@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 20, 2023 at 11:30:49AM -0700, Kees Cook wrote:
> I'm curious where you looked and didn't find documentation -- perhaps
> there is an improvement to be made to aim one to where the existing
> documentation lives?

My order was the following:

 - look for kernel doc on the main function implementation in
   lib/string.c (as found by a grep for an EXPORT_SYMBOL for it)
 - after not finding it there, but seeing that it has an ifdef for
   an arch override, which turns out to be unused
 - then I grepped the Documentation/ directory for it, and while
   there are quite a few matches for strscpy, they are largely
   in examples, with the only text referring to strscpy being
   Documentation/process/deprecated.rst that tells you to use it
   instead of strcpy, but not how it actually works
 - after that I realized that some people put the kerneldoc on
   the declaration, so I looked at that in string.h, but couldn't
   find it.

> > There's some docs at [1]. Perhaps there could be more?
> > 
> > [1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292
> 
> Right, And it's even valid kern-doc, which gets rendered in the kernel
> API docs, along with all the other string functions:
> https://docs.kernel.org/core-api/kernel-api.html#c.strscpy

Well, I never use the generated kerneldoc because it's much harder than
just grepping the tree, but indeed it exists even if it's hidden in
the most obsfucated way.  But at least I know now!

