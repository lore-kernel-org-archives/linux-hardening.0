Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923B335BA;
	Fri, 18 Apr 2025 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745007203; cv=none; b=uw4KYO7LZ0EYdam3VyCaGAwDuQCncxuv2yru05KvvSzrMtFvD7KeW+5/rmA30cjLtfuwaZbwZHJNGY5ac6ewfk1T6hzvcPCGEmbMHjLAZ9bt4jFs2Ujsm+GoGxo1fCO+ujDZ0cQxmg2P+K/Jr8hlrDzm3Od6YqP265xSWV+XS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745007203; c=relaxed/simple;
	bh=BVnZkjjSv9MWVlNg/FhLx0h58zSUOIcwkn/bPbmUKkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaB/AfibOCBG5xKIxKB2XkRmfvNFAZeu3xX7RRzMaaqVdMYOPivI1f+y5XaQ6r796iuWw06uo1JHNtJ/0xlI31XtpTkraNDcsT68P6J2YMNYx9ktum/A/89jXZzDJlGP/QgyleXgV2N3W6bZ5Clo4Wt7zseWIsS0R/ZqpghHBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IleN+pZ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IleN+pZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F90EC4CEE2;
	Fri, 18 Apr 2025 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745007202;
	bh=BVnZkjjSv9MWVlNg/FhLx0h58zSUOIcwkn/bPbmUKkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IleN+pZ3cxJ75hjLuM7eHCurpvJEerxB1r3RthS3MTd8IPL8VffVGe0SpwrzIhNAV
	 IhOPw6Qfd3kYmDxxtW+OxfB82G9V/3ocNP7X9c+hVg38BOBPK8KgawxiE1nS9KHcPd
	 yOyGdJRaqkGxSe7a57XPYEwmHHahwxQ/bpkIIkaf2jdsRmO/eT1iqblFSHZLKO5TW6
	 YnBurIWzQBCwXR+kLlwFseJsbgn6wba0/eJ5A2/RA+fQx+NxUa6RQio9yLds7iOTBc
	 Ido92N6j2dynDfmxLcpFGEWRQvcD4/gnd525/3KQDXVreFN73AVCuW54LEvEE+IZdt
	 xvkM7DWO8cyNg==
Date: Fri, 18 Apr 2025 13:13:20 -0700
From: Kees Cook <kees@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
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
Message-ID: <202504181307.254F81843@keescook>
References: <20250415170232.it.467-kees@kernel.org>
 <aAEM73DrpbzdZF92@harry>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAEM73DrpbzdZF92@harry>

On Thu, Apr 17, 2025 at 11:15:11PM +0900, Harry Yoo wrote:
> On Tue, Apr 15, 2025 at 10:02:33AM -0700, Kees Cook wrote:
> > Some system owners use slab_debug=FPZ (or similar) as a hardening option,
> > but do not want to be forced into having kernel addresses exposed due
> > to the implicit "no_hash_pointers" boot param setting.[1]
> 
> Is this behavior documented somewhere or it's only in the code?
> I couldn't find anything other than the code.

Hmm, that's an excellent point. I don't see any mention of it in
kernel-parameters.txt. Perhaps this?

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4568572205ee..982e6511a225 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6483,6 +6483,10 @@
 			Documentation/mm/slub.rst.
 			(slub_debug legacy name also accepted for now)
 
+			Using this option implies the "no_hash_pointers"
+			option which can be undone by adding the
+			"hash_pointers=always" option.
+
 	slab_max_order= [MM]
 			Determines the maximum allowed order for slabs.
 			A high setting may cause OOMs due to memory

> 
> > Introduce the "hash_pointers" boot param, which defaults to "auto"
> > (the current behavior), but also includes "always" (forcing on hashing
> > even when "slab_debug=..." is defined), and "never". The existing
> > "no_hash_pointers" boot param becomes an alias for "hash_pointers=never".
> > 
> > This makes it possible to boot with "slab_debug=FPZ hash_pointers=always".
> > 
> > Link: https://github.com/KSPP/linux/issues/368  [1]
> > Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is enabled")
> > Co-developed-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> > Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> By the way, while this patch does not change existing behavior of
> slub_debug implying no_hash_pointers, kmem_cache_init() is not the only
> place that enables slub_debug_enabled static key.
> 
> Maybe we should update __kmem_cache_create_args() too?
> (in a separate patch)

The state of pointer hashing should not change after boot. (It is
intentionally designed to use __ro_after_init.) Honestly, I'd prefer
that slab_debug was not tied to no_hash_pointers at all...

-Kees

-- 
Kees Cook
