Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9A02EFDAF;
	Wed,  3 Dec 2025 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764803555; cv=none; b=KKDcoRdwAxKxSmNzoNL/oCoX3jjknl+vgR2sgcdzpfJfDTCaNYsLVzRVNPdXmVGIBfPROfgABGLWWjLrpmYaGAf+Dye4U/m/19Trz3ALe+AOAd6OvdACNhVv5/hKYrSoJCfPAaUEX7azGaA3ZvYueT0FRNtolAAHoOiz73JP1Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764803555; c=relaxed/simple;
	bh=ZPhrI7MQmYmzyNZKm22NDPTdDlwCRn0ToFC4Np+3dp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0jO/4mboFLg+R3GVZdqSLTsj868ABsYAFDbLSSk27WHzJr52a/E8mNcTFLV1lHvyrf7Rl5q4mmaYejeGLgM7aGf5jqxy8sbChs9msvY2tQNKNtUy5E1WdVITIFp/urHwS0xLZ/0xUZrk2Zjvjvy7vsRT2dQnfvjSx1Ck2BRwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECzRbUgV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECzRbUgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902DBC4CEF5;
	Wed,  3 Dec 2025 23:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764803554;
	bh=ZPhrI7MQmYmzyNZKm22NDPTdDlwCRn0ToFC4Np+3dp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECzRbUgVFXorY0hMDmTNqLr5IhX4IhFOBUqyTHrrZfjh2reDMkbKUjcYvDC2pyaqI
	 uKSGmkeqyC/a7wDkblFIVtyLEdS27sug4U8ux09jwZTHCYCNmtbxnpE3DVv7q2LDi6
	 B77fX3Io8g2a3BUlYVzNFTy1S1FHA/d8xXXNJdOqjJn20HByJZ687QFMay7OjyJJgT
	 xgFyK8C6Ytj/XEG36LYEoWq6QWwSEw1YC+cyXq8CdGkTgcmjNK1r+o3IUwtDb2F7C3
	 +Gj57ItT49/fVfUd2NST/8ny+9JMNohAlT6MxME8vdNk8sUcvYFsZSr1OuY4Skry/G
	 7g7EmfZDRiP9g==
Date: Wed, 3 Dec 2025 15:12:34 -0800
From: Kees Cook <kees@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <cl@linux.com>, Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
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
Subject: Re: [PATCH v5 3/4] checkpatch: Suggest kmalloc_obj family for sizeof
 allocations
Message-ID: <202512031511.ACA8A5DB0@keescook>
References: <20251122014258.do.018-kees@kernel.org>
 <20251122014304.3417954-3-kees@kernel.org>
 <f1d2bb84df85237f23ebf6e0f3dfecfd72d615b6.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d2bb84df85237f23ebf6e0f3dfecfd72d615b6.camel@perches.com>

On Fri, Nov 21, 2025 at 08:51:19PM -0800, Joe Perches wrote:
> On Fri, 2025-11-21 at 17:42 -0800, Kees Cook wrote:
> > To support shifting away from sized allocation towards typed
> > allocations, suggest the kmalloc_obj family of macros when a sizeof() is
> > present in the argument lists.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7258,17 +7258,42 @@ sub process {
> >  			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
> >  		}
> >  
> > -# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
> > +# check for (kv|k)[mz]alloc that could be kmalloc_obj/kvmalloc_obj/kzalloc_obj/kvzalloc_obj
> 
> There are _way_ too many of these existing uses to suggest this change
> in existing files so please add '&& !$file' to these tests

The goal would be to also do the proposed treewide change which gets
the vast majority of them converted.

-- 
Kees Cook
