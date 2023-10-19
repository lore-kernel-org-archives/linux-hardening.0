Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59D8F6A
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EnOF/bKt"
Received: from out-206.mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F47FE
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 17:32:37 -0700 (PDT)
Date: Wed, 18 Oct 2023 20:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697675555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hwS7/DcUtHPt4kJq4hSNEacDz1a7ECv/zqs7i4aI0Eg=;
	b=EnOF/bKtp+QW7N3HS2qa+3qrbx+KqloGAi0gphqa7ayhh+LjdKDLCnEhls/ElClHD6wMYw
	Y8oaqaEJrneKjjqeYz5ZUWTInl6kNnkeYYpK6Fo0QaKzV9VIC7+4hiKvsinpxOM32psro6
	YdGflUMi+/JeK4oGK29uqBksKWyQUqQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] bcachefs: Refactor memcpy into direct assignment
Message-ID: <20231019003232.5uwphr7de7nybsra@moria.home.lan>
References: <20231018230728.make.202-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018230728.make.202-kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 18, 2023 at 04:07:32PM -0700, Kees Cook wrote:
> The memcpy() in bch2_bkey_append_ptr() is operating on an embedded fake
> flexible array which looks to the compiler like it has 0 size. This
> causes W=1 builds to emit warnings due to -Wstringop-overflow:
> 
>    In file included from include/linux/string.h:254,
>                     from include/linux/bitmap.h:11,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/smp.h:13,
>                     from include/linux/lockdep.h:14,
>                     from include/linux/radix-tree.h:14,
>                     from include/linux/backing-dev-defs.h:6,
>                     from fs/bcachefs/bcachefs.h:182:
>    fs/bcachefs/extents.c: In function 'bch2_bkey_append_ptr':
>    include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
>       57 | #define __underlying_memcpy     __builtin_memcpy
>          |                                 ^
>    include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>      648 |         __underlying_##op(p, q, __fortify_size);                        \
>          |         ^~~~~~~~~~~~~
>    include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>      693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>          |                          ^~~~~~~~~~~~~~~~~~~~
>    fs/bcachefs/extents.c:235:17: note: in expansion of macro 'memcpy'
>      235 |                 memcpy((void *) &k->v + bkey_val_bytes(&k->k),
>          |                 ^~~~~~
>    fs/bcachefs/bcachefs_format.h:287:33: note: destination object 'v' of size 0
>      287 |                 struct bch_val  v;
>          |                                 ^
> 
> Avoid making any structure changes and just replace the u64 copy into a
> direct assignment, side-stepping the entire problem.

This does make me wonder about the usefulness of the fortify source
stuff if it can be sidestepped this way, but hey, I'll take it :)

Pulled it into the testing branch, https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing
