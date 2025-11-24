Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554492566D3;
	Mon, 24 Nov 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018757; cv=none; b=DpRiU6gIjO7Fd4XNvSFQ+TPUU8j96CDwl45yY+mXIy+KAkbuFg92SK8DU/lYkg58xcMl1Mg0dYSzQvnD/1HsfPDPHD9XeI+lQIy6uChvhAA574PdIy2PWYhwsTLOCUPvnVXeHuIdyzruz3Ka9b1Q5sQgxVTAhl0uk6gdO3VF1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018757; c=relaxed/simple;
	bh=1mdzdRBhx7oGWBUGON3UfVTAnXdL7Q1UJITjOyXRYlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkT/9clFMlhFdeGjI1DCwBLlUotBNmK9T4b0ks6N8r2WQfxQdInCKnDJmHub43s8TLFKH0VIcq96PdDVqvebRFMDfFb+xpsMpTaijDqeKtoQcf72nOJHQu+3PH3U6IZpVL7+6uLPFNhnlxqRNwicU4jCaiAHSX+FOZ5uNK8nT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K3KqGjjZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K3KqGjjZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pbFLNQfa1lwkUj1c6wEBCQkuto/HQ8MD1t1w/QlDuKE=; b=K3KqGjjZfNg+chFeoY8EF1luJ8
	yv4rmbRZFXywOqiF9wwHgnSWhuN8N77C5eYkvTUzeHAUDWisXjNcJbafeY58VPfjZoppu/SS94Vgg
	tJYHvnI/3nFsQhOW7X1kZBfoqtz9IyMRGxTpeUWoD1dhtQiktCCCbNYjh3YA9ZBLd2n92EeOuuN7k
	czcAXu14cYg0vNYEsb88MA8+J99yz0Z4sRVdVBfKQbr1tEsKSBb6IswrqYZPkGG9te6VYAM104e03
	ZckhHCkk4bmC3f+NNjeAcr5KuiGAqYLX0qcqKi+YofXhWRgufo4XTN2v38rcP2OgelFfG6o6Yg38W
	JvMf2AGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNdr4-00000007Xk7-3jr0;
	Mon, 24 Nov 2025 21:12:14 +0000
Date: Mon, 24 Nov 2025 21:12:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
Message-ID: <aSTKLsRNiEKtDqPI@casper.infradead.org>
References: <20251122014258.do.018-kees@kernel.org>
 <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <202511241119.C547DEF80@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511241119.C547DEF80@keescook>

On Mon, Nov 24, 2025 at 12:38:57PM -0800, Kees Cook wrote:
> For code like:
> 
> 	u8 size;
> 	...
> 	size = struct_size(ptr, flex_member, count);
> 	ptr = kmalloc(size, gfp);
> 
> While struct_size() is designed to deal with overflows beyond SIZE_MAX,
> it can't do anything about truncation of its return value since it has
> no visibility into the lvalue type. So this code pattern happily
> truncates, allocates too little memory, and then usually does stuff like
> runs a for-loop based on "count" instead of "size" and walks right off
> the end of the heap allocation, clobbering whatever follows it.

Have we investigated a compiler warning like
-Wimplicit-arithmetic-truncation that would complain about this kind of
thing and could be shut up by an explicit cast:

	size = (u8)struct_size(ptr, flex_member, count);

or arithmetic that can be proven to not overflow:
	size = struct_size(ptr, flex_member, count) & 0xff;

Maybe such a warning already exists and it's just too noisy to even
start thinking about turning it on?
