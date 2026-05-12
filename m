Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4933507C;
	Tue, 12 May 2026 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562804; cv=none; b=VEVwFd/B41umz8fW11bW2mBZCYE7tUtPUeLKfLFOvyr3KvHLVEFX0L2PCmPZntWC9F8B3H+AOijzpg+eV8b9nJgNOmhxhPMbHWDzfv3kkSge8N0kh6WGvnKEC6wptm6QkwzBHUOLyAFMFwahjuwGzUut4EQePv/JGCNOOtqt5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562804; c=relaxed/simple;
	bh=tOGys+YG4qz5yD/e0NN7zHNw7Mi5/xacrSL440qUgAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUDzz2X3gMfVyC81Wq5S51OVggcwbBUdei9uPufDhl2rHPKnDDCid/Upz7ClFQ8rxdGwMq0/PSt7Rt4pT6pc11Bxd6ZSXAL7lMzrcyi81njIhGaAGT/+0N6uYALf+3U4uLuDopFKer+cEbavRmI+Dtx7JUM4+oFN37VxrQTfq7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA9ZG85p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA9ZG85p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74108C2BD00;
	Tue, 12 May 2026 05:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778562804;
	bh=tOGys+YG4qz5yD/e0NN7zHNw7Mi5/xacrSL440qUgAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WA9ZG85pnCfWjPfH96o1K6ZiJJ208mg1UkHc1vCUk//OBCrfGlcQ8pqSMBaYRarhZ
	 2XasZCK+ij8fanqe3B9b6vRRNk4z67wShmp3szQSZNkA9mr5+1rny1ElWcoHY077Hk
	 c3JC0CHxpbTjD0y3tyqUy0M02WctGXzpwXqWHGUqJKaZeH/eO1ddffhIDEgOljoWdF
	 oBP+Maz4NrrRjsyN12Qm76b4fSY5i5BBjz8mE+f7itKxw3L3jmg7lTdzj5fzbpVdQ+
	 RaekGoq+qHo0bWAWX/hUJ+3Aqar0fC8d/E7L6XKxx4pa+/m40/bEB/zUVlf4GhGi8w
	 rPY8L2zwrrg0w==
Date: Tue, 12 May 2026 14:13:21 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Bill Wendling <morbo@google.com>, David Hildenbrand <david@kernel.org>, 
	David Rientjes <rientjes@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Matteo Rizzo <matteorizzo@google.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	linux-hardening@vger.kernel.org, Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Hao Li <hao.li@linux.dev>, 
	"Liam R. Howlett" <liam@infradead.org>, Alexander Potapenko <glider@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/3] slab: improve KMALLOC_PARTITION_RANDOM randomness
Message-ID: <3z5unwqxty4qq2siingxdijbk642te7kf26ba4ff2xsmyptgq5@i6bxrvkfbve4>
References: <20260511200136.3201646-1-elver@google.com>
 <20260511200136.3201646-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511200136.3201646-2-elver@google.com>

On Mon, May 11, 2026 at 10:00:49PM +0200, Marco Elver wrote:
> When using CONFIG_KMALLOC_PARTITION_RANDOM, _RET_IP_ was previously used
> to identify the allocation site. _RET_IP_, however, evaluates to the
> caller's parent's instruction pointer rather than the actual allocation
> site; this would lead to collisions where a function performs multiple
> allocations.
> 
> With the generalization to kmalloc_token_t, we now generate the token at
> the outermost macro, and using _THIS_IP_ would fix this for all cases.
> 
> Unfortunately, the generic implementation of _THIS_IP_ relies on taking
> the address of a local label, which is considered broken by both GCC [1]
> and Clang [2] because label addresses are only expected to be used with
> computed gotos. While the generic version more or less works today, it
> is known to be brittle. For example, Clang -O2 always returns 1 when
> this function is inlined:
> 
>         static inline unsigned long get_ip(void)
>         { return ({ __label__ __here; __here: (unsigned long)&&__here; }); }
> 
> To provide a reliable unique identifier without breaking architectures
> relying on the generic _THIS_IP_, introduce _CODE_LOCATION_: it resolves
> to _THIS_IP_ where architectures provide a safe implementation, and
> falls back to a zero-cost static marker where _THIS_IP_ is broken.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120071 [1]
> Link: https://github.com/llvm/llvm-project/issues/138272 [2]
> Signed-off-by: Marco Elver <elver@google.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

with one suggestion below.

> ---
>  include/linux/instruction_pointer.h | 24 ++++++++++++++++++++++++
>  include/linux/slab.h                |  2 +-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/instruction_pointer.h b/include/linux/instruction_pointer.h
> index aa0b3ffea935..ea5bc756bd99 100644
> --- a/include/linux/instruction_pointer.h
> +++ b/include/linux/instruction_pointer.h
> @@ -8,6 +8,30 @@
>  
>  #ifndef _THIS_IP_
>  #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> +/*
> + * The current generic definition of _THIS_IP_ is considered broken by GCC [1]
> + * and Clang [2]. In particular, the address of a label is only expected to be
> + * used with a computed goto.
> + *
> + *   [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120071
> + *   [2] https://github.com/llvm/llvm-project/issues/138272
> + *
> + * Mark it as broken, so that appropriate fallback options can be implemented
> + * for architectures that do not define their own _THIS_IP_.
> + */
> +#define HAS_BROKEN_THIS_IP
> +#endif
> +
> +/*
> + * _CODE_LOCATION_ provides a unique identifier for the current code location.
> + * When _THIS_IP_ is broken (generic version), we fall back to a static marker
> + * which guarantees uniqueness and resolves to a constant address at link time,
> + * avoiding runtime overhead and compiler optimizations breaking it.
> + */
> +#ifdef HAS_BROKEN_THIS_IP
> +#define _CODE_LOCATION_ ({ static const char __here; (unsigned long)&__here; })

nit: perhaps it can be __initdata to free these after boot?
... if we want to save actual memory allocated rather than the
vmlinux size.

apparently ".init.bss" is a not thing :(

> +#else
> +#define _CODE_LOCATION_ _THIS_IP_
>  #endif

-- 
Cheers,
Harry / Hyeonggon
