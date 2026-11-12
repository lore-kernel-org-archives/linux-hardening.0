Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503393;
	b=bxoVjAsyswXhGl75SozunY7JiwFUWs+S51H2cIWd71BN9lgo309TxbUM6NhMl0mp7prs
	 aEA9TN28WnBhQBgYEh2ZOB7BdEOK2V3GaUdOHka3gLxo1NbVXnojeQr1HUf/vw9K92GCo
	 cO/zudTUjqwa5q73Ql2p0uPdAAQrbCFwR0OkexFcFbbQeuuwsgPFq51AxQWUNlzGKIBY1
	 otn/qYx7L5N65A8XiyR3WMPug2E/ea5U7kmIRp9N8OL53294fOOTFBKVQV12qihLdbaXI
	 IjYNLvOdhIRn3PNKgalGyIAL4YoIs2rdpYOAvisqPLte9HenZzs2DHzkuqiJL4PGjEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503393;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JQz1mAG4FwwJpOtTSrz+KeRLlzMJvENpxMLZke3zOIA=;
	b=KsjIo/62zht9eg+LOjMsTYjZzqOqvOSa+1+jow4nYO03h9DbEU7JD7elgREMdovONXEX
	 UHMuzs2nLBvO3ETRyAWCsqETscPnWcSTCgLSNWUM1PmqZDKfq0dMX+f7WzWXUKVcJ/S+M
	 E+tXTF65ngnJWqjkBH5J1UruKWAeqe/DCztzg9ryDRFACUB3d8sh2QKAszmLXN1ccahhM
	 kfWr5Ipxq76PfxnfHFDKL5MdcPXlVrgppr1kXFZxhjF77TDWTj7UF2VfQIzZTB7d1wcrf
	 2Q9P7nhPouQeyo2mrlXyc22ohD2baW7B+BHs3fgFdqZwR6QcAYcYgHvvUZrozWl8UXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awUCTYpT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53264606A8A0;
	Thu, 12 Nov 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awUCTYpT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A801F000C4;
	Thu, 12 Nov 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503393;
	bh=JQz1mAG4FwwJpOtTSrz+KeRLlzMJvENpxMLZke3zOIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=awUCTYpTsL/Oqe6fVjS9VAtu1JcOzy/ql79vB7BsSjY2uKsKiaHY/Acj8eAp4GSv7
	 e2YXOuKtoTEentofTPEmJdAma196fYP7qDeIgA97OToCwOhpz5uN7yk1e712OJxDHL
	 24aLHcenx9e0ZM2r69lH7TO5CohTbnvw2lC/noUnpF8F0V9751gXt77lOpolk3gwvf
	 VJpQwFBK5zHuosDMEMb6msCer633TwwVNaK3cGSmaEHudN6tdWc+HJMp0dyGlSYI+A
	 x51go4dIRkKaSkbxkP+ZPxnOy4n8s7A53NYiNXDGwOmRBb8MAMG+1stdufFWxX/R3s
	 DEaXKLRxo35iQ==
Date: Thu, 12 Nov 2026 09:09:52 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	driver-core@lists.linux.dev, linux-hardening@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	justinstitt@google.com
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for
 devm_kmalloc
Message-ID: <202611120905.DF88D9849@keescook>
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-2-kees@kernel.org>
 <20261112004039.GA523044@killaraus.ideasonboard.com>
 <avWNCC3_Ff0knO6J@devuan>
 <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com>
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
In-Reply-To: <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com>

On Thu, Nov 12, 2026 at 08:34:13AM -0800, Linus Torvalds wrote:
> On Thu, 12 Nov 2026 at 02:13, Alejandro Colomar
> <alx+linux-hardening@kernel.org> wrote:
> >
> > I suggest removing kmalloc_obj() entirely, and using kmalloc_objs()
> > always, with a second argument of 1 when we want a single object.  This
> > would remove the risk of that typo.
> >
> > I also suggest having default arguments without variadic macros.  The
> > way to do that is using empty arguments.  Linus complained that it hurts
> > his eyes, but it really makes these macros much safer.
> 
> No to both. These are both "make the code worse to catch errors that
> the compiler should have been able to catch anyway".
> 
> If you *really* want to catch them, make "gfp_t" be a 'struct'. That
> way even compilers without things like the restricted types that
> sparse has will catch at least that one.
> 
> I did that many many years (argh, decades - I'm old) ago to catch all
> the 'pte_t' etc issues when rewriting the MM layer, and it works very
> well.
> 
> It's going to be somewhat painful, but ti might be worth it. People
> who only use GFP_xyz flags to pass them around wouldn't notice.

One thing Justin was poking at was adding a "strict" mode to typedef
that gets us a new native type that follows all the same rules as its
underlying type, but refuses implicit casting. That way you get stuff
like gfp_t or pid_t that still works sanely but refuses to take values
from non-matching types (i.e. it would catch this case). It's handy for
the Overflow Behavior Type work too (for similar reasons). e.g.:

typedef __distinct unsigned int pid_t;

or something like that. Then you don't need the accessors like we have
for the struct-style wrappers.

-Kees

-- 
Kees Cook
