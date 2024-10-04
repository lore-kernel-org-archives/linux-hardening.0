Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B451E378D;
	Fri,  4 Oct 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062629; cv=none; b=ZdnBnUtW3BSPtp4NNg9iiPEDnP0cL6O7/GcIIVUr/8pGxrRpmFmoiIaHH2APIHfHho2dxXAp0e9QgNfTU7/lNISIu7A2dFHpg7U1SZa6HCl1Qwbc/taSbOxALZ7nxr6HJh/wR4G1NmRVn40zqYXINZlF4Ht8tZzd3k6yl2cPERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062629; c=relaxed/simple;
	bh=Ck04ZwAJLUC52xG8xW/cvhMb6CgIDBwDNggWk8T5Z6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q40Uzpe5+nK8FpJjhhi74OUtL4ew3Pp9OtHME3vyQo8WEJuf+f0bceVYKBnSk8svaypEmZ+ZxPFQux0yUPZNaEgA5Oqb7qYaOl4LzJaLK5kBBbwZ8EWIgz8zbdX9ctJ4cudHV/F1NSm/NIobftqi5qZfQ5AeLF9n7Eb+rkVm3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRnK+Hc8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRnK+Hc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459D2C4CEC6;
	Fri,  4 Oct 2024 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728062629;
	bh=Ck04ZwAJLUC52xG8xW/cvhMb6CgIDBwDNggWk8T5Z6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRnK+Hc8fbZvqSga/zsdsMP74yY2Pz6jVlLqCCHwKxGGmm8KNdEr4zdpu2IAhCLPb
	 lRaZbchE7zyY27Ol9Hnw1uWRbliPl8I/+/zilZPSKXUzKJC12bSV7HSlWpl5DiSMLB
	 HEtpGPskvn2MfPZvV+vmD81CeSXVEr7PaNhTPCm2Rkd2jjSIGGFWJfsUKASwbMQNHs
	 uP2JSq3E6dNWwubN3+b+dfKgeVeIX661LoHrOpwP6Zyl5LE3pLKdri5Mk8VL0E2nli
	 COSe9o3f5MkB154n+3I+MJydU/ZNq9U612HB6Fs44DljKJXML+LxDLyynurnyC1mM5
	 lmi9vJ1Zilt0g==
Date: Fri, 4 Oct 2024 10:23:46 -0700
From: Kees Cook <kees@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Marco Elver <elver@google.com>, linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] slab: Introduce kmalloc_obj() and family
Message-ID: <202410041014.7DE8981@keescook>
References: <20240822231324.make.666-kees@kernel.org>
 <eae36648-6f9f-486d-b352-c92a315431a1@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae36648-6f9f-486d-b352-c92a315431a1@intel.com>

On Fri, Aug 23, 2024 at 06:27:58AM +0200, Przemek Kitszel wrote:
> On 8/23/24 01:13, Kees Cook wrote:
> 
> > (...) For cases where the total size of the allocation is needed,
> > the kmalloc_obj_sz(), kmalloc_objs_sz(), and kmalloc_flex_sz() family
> > of macros can be used. For example:
> > 
> > 	info->size = struct_size(ptr, flex_member, count);
> > 	ptr = kmalloc(info->size, gfp);
> > 
> > becomes:
> > 
> > 	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);
> > 
> > Internal introspection of allocated type now becomes possible, allowing
> > for future alignment-aware choices and hardening work. For example,
> > adding __alignof(*ptr) as an argument to the internal allocators so that
> > appropriate/efficient alignment choices can be made, or being able to
> > correctly choose per-allocation offset randomization within a bucket
> > that does not break alignment requirements.
> > 
> > Introduces __flex_count() for when __builtin_get_counted_by() is added
> > by GCC[1] and Clang[2]. The internal use of __flex_count() allows for
> > automatically setting the counter member of a struct's flexible array
> > member when it has been annotated with __counted_by(), avoiding any
> > missed early size initializations while __counted_by() annotations are
> > added to the kernel. Additionally, this also checks for "too large"
> > allocations based on the type size of the counter variable. For example:
> > 
> > 	if (count > type_max(ptr->flex_count))
> > 		fail...;
> > 	info->size = struct_size(ptr, flex_member, count);
> > 	ptr = kmalloc(info->size, gfp);
> > 	ptr->flex_count = count;
> > 
> > becomes (i.e. unchanged from earlier example):
> > 
> > 	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);
> 
> As there could be no __builtin_get_counted_by() available, caller still
> needs to fill the counted-by variable, right? So it is possible to just
> pass the in the struct pointer to fill? (last argument "&f->cnt" of the
> snippet below):
> 
> struct foo {
> 	int cnt;
> 	struct bar[] __counted_by(cnt);
> };
> 
> //...
> 	struct foo *f;
> 
> 	kmalloc_flex_sz(f, cnt, 42, gfp, &f->cnt);

I specifically want to avoid this because it makes adding the
counted_by attribute more difficult -- requiring manual auditing of
all allocation sites, even if we switch all the alloc macros. But if
allocation macros are all replaced with a treewide change, it becomes
trivial to add counted_by annotations without missing "too late" counter
assignments. (And note that the "too late" counter assignments are only
a problem for code built with compilers that support counted_by, so
there's no problem that __builtin_get_counted_by() isn't available.)

Right now we have two cases in kernel code:

case 1:
- allocate
- assign counter
- access array

case 2:
- allocate
- access array
- assign counter

When we add a counted_by annotation, all "case 2" code but be found and
refactored into "case 1". This has proven error-prone already, and we're
still pretty early in adding annotations. The reason refactoring is
needed is because when the compiler supports counted_by instrumentation,
at run-time, we get:

case 1:
- allocate
- assign counter
- access array // no problem!

case 2:
- allocate
- access array // trap!
- assign counter

I want to change this to be:

case 1:
- allocate & assign counter
- assign counter
- access array

case 2:
- allocate & assign counter
- access array
- assign counter

Once the kernel reaches a minimum compiler version where counted_by is
universally available, we can remove all the "open coded" counter
assignments.

-Kees

-- 
Kees Cook
