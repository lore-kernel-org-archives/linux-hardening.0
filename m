Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CC2144DB;
	Tue, 15 Apr 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736403; cv=none; b=rtwfXCUqnS0uk4r6m2P8i+f/OaQmelsb4uMAyaamm9VfUFu9Q81ssMVa48Q6YXeN0lTSlgA1HZ+VGaGrmMQOUBl6dXRl8Jn4kmUkup+CjQo1kNrYjvZdHGenKHuws1hJ3y0HEWB1zPfLx8/gaJA9ItXJER9PAT1jB4bVGJ213GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736403; c=relaxed/simple;
	bh=K5ffwUoIPZMzOdb9wN+7SAH5h6bX8pLcajxWE/Iis2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+cZInrMHxxNRqS7EdoO3CU+xQe3GkDAOx/yJJ0IJsMtHhGz5oR20nqQ6borrjWnkeMKhM28H5nO0gE69nAHR2wNwos2fEs5FH/PKooLTN2g7x43VlsSXCTeW1+kGOo1Fi+x9jaPN0RckhHJtM3JlDwQq30fofRr3zye/CHFzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edUbzBjj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edUbzBjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E4BC4CEE9;
	Tue, 15 Apr 2025 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744736403;
	bh=K5ffwUoIPZMzOdb9wN+7SAH5h6bX8pLcajxWE/Iis2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edUbzBjjOmodaXj6JfbuCpTgUp2PWa37c1CGYhXKWoY0uDuA5eSN6qrmxKwUZOtZE
	 iC/8CHBAPcHyDLW6By/H2BS/HBP1apDreRO0gpTS9DJM7ksbPOOHAN9GOoZIxl1NWl
	 vloz5ui324K8NL3oA5ZCbY/daYek0pmLRc0k06EmM1LbbiJNFuW90CZJmqpAR70tuG
	 PYKLbUaQIS9x9wLJpsuKmbFpTT8WTN9W7XCOdqZCaLKEZWuEF1GYUr3YTNxlbD1wGN
	 /gCkpoDEHp/I1Edrp1av53pb84/+h59ZyzDgZD5tGBr5YcD2bo/3FzEVCOwIuoADYK
	 pqtWr5YahT1UA==
Date: Tue, 15 Apr 2025 10:00:00 -0700
From: Kees Cook <kees@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
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
Subject: Re: [PATCH] slab: Decouple slab_debug and no_hash_pointers
Message-ID: <202504150956.9AFF9545@keescook>
References: <20250410174428.work.488-kees@kernel.org>
 <Z_0AFjai6Bvg-YLD@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_0AFjai6Bvg-YLD@pathway.suse.cz>

On Mon, Apr 14, 2025 at 02:31:42PM +0200, Petr Mladek wrote:
> On Thu 2025-04-10 10:44:31, Kees Cook wrote:
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
> 
> The idea makes sense. But it seems that the patch did not handle
> the "always" mode correctly, see below.

Actually, it was the "never" mode that was being ignored. Whoops! (The
double negation language is a little odd.) I've fixed this for v2 with
an explicit switch statement.

> > -int __init no_hash_pointers_enable(char *str)
> > +void __init hash_pointers_finalize(bool slub_debug)
> >  {
> > -	if (no_hash_pointers)
> > -		return 0;
> > +	if (hash_pointers_mode == HASH_PTR_AUTO && slub_debug)
> > +		no_hash_pointers = true;
> >  
> > -	no_hash_pointers = true;
> > +	if (!no_hash_pointers)
> > +		return;
> >  
> >  	pr_warn("**********************************************************\n");
> >  	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> 
> 
> The mode/policy is generic but this function is ready to be called
> only once. And we might actually want to call it twice, see below.

I'd like to keep it a single call. I feel this simplifies the reporting
logic, keeps the selection logic in one place, and allows us to
trivially examine that it is safe to use with __init.

Thanks for the review!

-- 
Kees Cook
