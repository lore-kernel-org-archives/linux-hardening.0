Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96939A
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27758D45;
	Thu, 19 Oct 2023 21:46:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DEE867373; Fri, 20 Oct 2023 06:46:46 +0200 (CEST)
Date: Fri, 20 Oct 2023 06:46:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <keescook@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Justin Stitt <justinstitt@google.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <20231020044645.GC11984@lst.de>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com> <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310182248.9E197FFD5@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> Almost all of the remaining strncpy() usage is just string to string
> copying, but the corner cases that are being spun out that aren't
> strscpy() or strscpy_pad() are covered by strtomem(), kmemdup_nul(),
> and memcpy(). Each of these are a clear improvement since they remove
> the ambiguity of the intended behavior. Using seq_buf ends up being way
> more overhead than is needed.

I'm really not sure strscpy is much of an improvement.  In this particular
case in most other places we simply use a snprintf for nqns, which seems
useful here to if we don't want the full buf.

But switching to a completely undocumented helper like strscpy seems not
useful at all.
