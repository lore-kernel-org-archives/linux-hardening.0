Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4B314A4C7;
	Thu,  5 Jun 2025 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749154533; cv=none; b=ZsGi/9vGk9241Ndh2/uIHGjmBk0bRHMU81kHe6a1Ei9wZ7LxeZtiIYS+QNV21ulT/rWuvF53K/b5d9hnvGiCj+egzxKknHwIHIqDPwfIZhfF0Wrp8Dh4Dj44aSHHHKJiFmdzHgdSG9ad4S4J0GnqyTWosGFeztsF60acmzrQEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749154533; c=relaxed/simple;
	bh=IYT1CcO4LBvLg1Erh1PUlzPXoV02ZdFG//4pEvVZEPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT0w1yBPsWzuryx788aT0PlOKBhUhFHKCJI4qkc0DTWuchreDj7Ul3JyfdzgGuovcGIh8Z/fuqeBjyK4NusPyhhJLxYB5sYDkc4K7UH8vKQngi+OzfAyi29fYSotWq9y9viPBxqw9tbBPfiodxOQF/jHXgL80EQhWVImjc8ZajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTKr/Yt2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTKr/Yt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371BAC4CEE7;
	Thu,  5 Jun 2025 20:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749154533;
	bh=IYT1CcO4LBvLg1Erh1PUlzPXoV02ZdFG//4pEvVZEPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTKr/Yt2Hy5Ra/GPalkzOkUFA7/xkis8nb3QvcUSx1uSkyip3GUeXJLvaI1Q37XYa
	 gtXxU6j0esbWwO7AK21FwIU08/csOV39EEYuh8Y90tsXAEqXxfJh87ws6ci4CAfU6d
	 QvebhzDT+5dO28YbZA/5RsMLwzJFcCI1wZaScn/qjLteznxorhfE+Abf9sCB/pnZ9p
	 /aAw9KIRqxTSARGXt6FedihZ5FXiNVxhjzdvgnyekN+8B+ijeCaAfAh7/ZqWMvQ5pT
	 zHC5/7LMdIfZm+KDKOSVkeUv88+wMQJ2OMUGLoScaB9oyMoEDv33arK+TILWsn4tYJ
	 dKR1Q9gFExg9Q==
Date: Thu, 5 Jun 2025 13:15:32 -0700
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
Message-ID: <202506051314.D6EDFA91D@keescook>
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

Hi,

Is this still planned for 6.16? I just noticed it wasn't in -next, and
we're almost to the end of the merge window...

-Kees

-- 
Kees Cook
