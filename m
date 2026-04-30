Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C122580D7;
	Thu, 30 Apr 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556416; cv=none; b=Q0/fwPHdZyxwWrR/mQYPWWCpalePESIsrNX8VK9WBNTI9EuNahtpp4NKXgQZ8zIFIuuYKYVkAdKrNjFsujTHLtqkN9gy/hitkH/QsVNhSDcPJQYqkVf8a1zgaK2dwAhXxI46dS5mdkVT9cisn0avoGdq3/7BlkIBVFJ4MHl0KGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556416; c=relaxed/simple;
	bh=7U8ayXs8dLaDtAfBoZdyIo0zZFSxc/yxzpat1zXZUMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6oVX2HjZoacZKWASXheMlYzz4ckp0SIGZgV/EMTfugNTM9+yD9W41JeJRp1BftgLnRMUcjgaSvVpR5dFCw67mZd0RuNJI+F4KpuGzCZW0f3NZPYdsh1ZAsKzXjaVEvl18U8SXlJe7MkCaWWywWDbS+0uacITWly0bYGqPIy+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWLOgp/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWLOgp/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BA0C2BCB3;
	Thu, 30 Apr 2026 13:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777556416;
	bh=7U8ayXs8dLaDtAfBoZdyIo0zZFSxc/yxzpat1zXZUMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VWLOgp/7lmtUIlfIBQsumZu9DqNoyrI6AFV/UJZFNKHwi3s2WunGOAVYOtVpexm0H
	 oo3XENSmWYRSIE31RiCAYVpqkRwPC1RuQuBRkO0UBZpZrwLJBv9InZA0xaL/JlZyFz
	 eNklDEVLen2i/TmnQzAjSQbPLDsR4hH/R8BYHQncZETlDt2g87pUfun60PtKxa0VYw
	 6aoAt2KanmXWVK41cR2Sx9eJImTYV5lwIjdNAjColajbxOEgjmfGWfgNLEsl/Hplp9
	 XfTzLgIdw6QK5Feg2nPX+FgGRJGZ4kaCeL5TuBCAACgag/3t6JDueiFS+a77nEbkaR
	 DRcbb6fDXV/nA==
Message-ID: <9c321184-9080-4d5c-bd1a-a16cd0bbaed3@kernel.org>
Date: Thu, 30 Apr 2026 15:40:08 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] slab: fix kernel-docs for mm-api
Content-Language: en-US
To: Marco Elver <elver@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, Harry Yoo <harry@kernel.org>,
 Hao Li <hao.li@linux.dev>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com,
 llvm@lists.linux.dev, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260424132427.2703076-1-elver@google.com>
 <20260424132427.2703076-2-elver@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260424132427.2703076-2-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/26 15:24, Marco Elver wrote:
> The mm-api kernel-doc comments have been broken for a while, as many
> documented symbols shifted from being direct function definitions to
> macros wrapping _noprof implementations during the introduction of
> allocation tagging (starting with commit 7bd230a26648 "mm/slab: enable
> slab allocation tagging for kmalloc and friends").
> 
> When the kernel-doc block remains above the internal implementation
> function but uses the public API name, the documentation generator fails
> to associate the documented symbol and generates warnings and fails to
> emit the documentation.
> 
> Fix this by:
> 
> 1. Moving the kernel-doc comment blocks from slub.c to slab.h, placing
>    them directly above the user-facing macros.
> 
> 2. Converting the variadic macros for the documented APIs to use
>    explicit arguments.
> 
> No functional change intended.
> 
> Signed-off-by: Marco Elver <elver@google.com>

+Cc Jon

I thought it was supposed to work because the kernel-doc scripts were at the
time taught by commit 51a7bf0238c2 ("scripts/kernel-doc: drop "_noprof" on
function prototypes") to handle _noprof. In the current form git grep finds:

tools/lib/python/kdoc/kdoc_parser.py:        suffixes = [ '_noprof' ]
tools/lib/python/kdoc/xforms_lists.py:        (KernRe("_noprof"), ""),

Doesn't it work for you then?

