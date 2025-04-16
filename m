Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200E321576A;
	Wed, 16 Apr 2025 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825933; cv=none; b=t6VWSGd99uQ0N74ajzd9wjM6daNTpBxiwRBox+P5362KHlia+gUY70uLJ4q86xOH6X4HAxAMXAHEZIUDPbkVqA5YzPmS22qoXxTrf5+VnSQL3I9sQLetMZ2bBpZkW+mTvh5rAykTh9qaXG4ylEYEo/NteiPk0FQvPchqanw4208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825933; c=relaxed/simple;
	bh=MGg7zlY8w1c4ygae3wQmVztn9Aa9+X7cqIum9lXVmSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2emrMv6NsRoItQd7oILCe9T32hZa0r2Sld5tHW9btbgGdpe6X4ijPHvkEU/kNo8/ZsuresofKkjpY4jmeS0n4O77Am/A8rENmlug6DVcvcStl5LazDrIkzoaM95+zVMgjz/qMTZPrFZDe+WnLSobtopCB9Qq1ljN0cP0U+ipJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRYvgBTH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRYvgBTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768B8C4CEE2;
	Wed, 16 Apr 2025 17:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744825932;
	bh=MGg7zlY8w1c4ygae3wQmVztn9Aa9+X7cqIum9lXVmSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRYvgBTHPEyRc9yOHaQf4+d3mlyza5BchLoQ8UCuMfTwuI4nBe49tu4eOGOLMokZu
	 dnOv938m1QVM2RnTc74JIR5fmJn2r4uVtnqGJgBtVhizCaf+buQaxaSakDKDFlXKLu
	 Ib8HEx/wA8nS1mSs7VWbsrlx36rNG/YJ4RJoJg/ep5lLVgvMRoxlCeo19gSTZjASS+
	 ddCuPrBo2TD8Nyu+j12gGkILvQU4hKvRfp6jvbDYNNtq0I7iB7zY/hTujOzrr6Lc9V
	 nqhoSAxh0TZo6ae8WfyhUzo6DCBglvi0A7ASJ2iT78PXFiFRXxHmyccoZvSVusPp1b
	 qU58RTAJW0sMw==
Date: Wed, 16 Apr 2025 10:52:09 -0700
From: Kees Cook <kees@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	Thomas Huth <thuth@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] slab: Decouple slab_debug and no_hash_pointers
Message-ID: <202504161048.B7A4CAFB@keescook>
References: <20250415170232.it.467-kees@kernel.org>
 <Z_-dPcdiGW0fo8Ji@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_-dPcdiGW0fo8Ji@pathway.suse.cz>

On Wed, Apr 16, 2025 at 02:06:21PM +0200, Petr Mladek wrote:
> On Tue 2025-04-15 10:02:33, Kees Cook wrote:
> > Some system owners use slab_debug=FPZ (or similar) as a hardening option,
> > but do not want to be forced into having kernel addresses exposed due
> > to the implicit "no_hash_pointers" boot param setting.[1]
> > 
> > Introduce the "hash_pointers" boot param, which defaults to "auto"
> > (the current behavior), but also includes "always" (forcing on hashing
> > even when "slab_debug=..." is defined), and "never". The existing
> > "no_hash_pointers" boot param becomes an alias for "hash_pointers=never".
> > 
> > This makes it possible to boot with "slab_debug=FPZ hash_pointers=always".
> > 
> > Link: https://github.com/KSPP/linux/issues/368 [1]
> > Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is enabled")
> > Co-developed-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> > Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Tested-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I am going to wait few more days for a potential feedback.
> I'll queue it for 6.16 unless anyone complains.

Thanks very much!

> See a rant below ;-)
> [...]
> I personally do not like that these two parameters do not have the
> real effect until hash_pointers_finalize() is called at some
> "random" "unrelated" location, namely kmem_cache_init().
> But I could live with it.

Yeah, this is mainly due to slab_debug wanting to be able to control it.
I'd prefer they weren't linked at all, but it's also not too
unreasonable.

> But the alternative solution proposed at
> https://lore.kernel.org/r/Z_0AFjai6Bvg-YLD@pathway.suse.cz
> was hairy another way.
> 
> We could always improve it when it causes troubles.

Right. My thinking is that if another subsystem comes along with the
same compelling complaint as kmem, we can look at it again then. IMO,
really only an allocator should be in charge of such a large knob --
its whole job is managing pointers. :)

-Kees

-- 
Kees Cook
