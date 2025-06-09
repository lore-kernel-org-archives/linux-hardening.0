Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1638C1FF1B5;
	Mon,  9 Jun 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482688; cv=none; b=nsIyDFw4O4JA8G+Z/xC2+2mRJBjA77lt35nK/HlxllFjfIRYMmepzrpa3/9yDKRR6GjImWMaiCxOfXorE/sRIE5kdopLWmis62oMpR0m6CRppT2K2SeCsHe3usScSucvo7bIx0AsYLYatRpx/StaQUV4I9rtM/u/4jHqyoNQNvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482688; c=relaxed/simple;
	bh=ozjXpJHyeUzJv7RP45tM13BD+asvs0L+N0AGD1q7nAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkPxMW8bzkqvPEHfPl9h84plOM46fHmEcuzv2GpdupTje+YIm8kU5Tab0O5EjroVzTWwh9aGwq0VXlcmh270cn/FolTswRYLx13ye36iqFXv3Q7xYenaOrApgdnsn0bTP9UC2LMB+UcqYk3jeUrazTsX2qquOfNYpeXgaDZ53GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTG/SW1V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTG/SW1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3B5C4CEEB;
	Mon,  9 Jun 2025 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749482687;
	bh=ozjXpJHyeUzJv7RP45tM13BD+asvs0L+N0AGD1q7nAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTG/SW1VeshB/wdGO8XLzIf0hdyKLbl1+KLe8EridFc899vFQW0d6ONCeyFLYsHW5
	 V59dAkT9Ep6Fs7nZMRPuONnctbLRkaVWhIASGcFHmen8JrPq5B4buiGitfIJf3CVP3
	 3fP65nd/2wdXYmpO4UXj5RFF9yoYWjeLR2iEn8TzlPU66JvaTzE6KEYWO8t0rJNvGL
	 ai7uFP5EQTZbYyqRMbVpF172LgDudE4jtD8dcDNZfmtRXfUh3Md28yHE/cWMYtetWU
	 eA6a8JgrbzFqkCj+siPjSf6t2D6QXPu70eVKysRyk8wuZT9uFXlmDzWTmR3tZujpk7
	 3ixrHVeRTM5Yg==
Date: Mon, 9 Jun 2025 08:24:47 -0700
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
Message-ID: <202506090823.33ED63C@keescook>
References: <20250415170232.it.467-kees@kernel.org>
 <Z_-dPcdiGW0fo8Ji@pathway.suse.cz>
 <202506051314.D6EDFA91D@keescook>
 <aEbyHeG8qh8GChTh@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEbyHeG8qh8GChTh@pathway.suse.cz>

On Mon, Jun 09, 2025 at 04:39:25PM +0200, Petr Mladek wrote:
> On Thu 2025-06-05 13:15:32, Kees Cook wrote:
> > On Wed, Apr 16, 2025 at 02:06:21PM +0200, Petr Mladek wrote:
> > > On Tue 2025-04-15 10:02:33, Kees Cook wrote:
> > > > Some system owners use slab_debug=FPZ (or similar) as a hardening option,
> > > > but do not want to be forced into having kernel addresses exposed due
> > > > to the implicit "no_hash_pointers" boot param setting.[1]
> > > > 
> > > > Introduce the "hash_pointers" boot param, which defaults to "auto"
> > > > (the current behavior), but also includes "always" (forcing on hashing
> > > > even when "slab_debug=..." is defined), and "never". The existing
> > > > "no_hash_pointers" boot param becomes an alias for "hash_pointers=never".
> > > > 
> > > > This makes it possible to boot with "slab_debug=FPZ hash_pointers=always".
> > > > 
> > > > Link: https://github.com/KSPP/linux/issues/368 [1]
> > > > Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is enabled")
> > > > Co-developed-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> > > > Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> > > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > > Acked-by: David Rientjes <rientjes@google.com>
> > > > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > 
> > > Tested-by: Petr Mladek <pmladek@suse.com>
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > 
> > > I am going to wait few more days for a potential feedback.
> > > I'll queue it for 6.16 unless anyone complains.
> > 
> > Hi,
> > 
> > Is this still planned for 6.16? I just noticed it wasn't in -next, and
> > we're almost to the end of the merge window...
> 
> I am terribly sorry. I have forgot this patch...
> 
> I have just pushed it into printk/linux.git, branch
> for-6.17-hash_pointers.
> 
> Also I updated the documentation, aka applied the diff
> from https://lore.kernel.org/r/202504181307.254F81843@keescook
> See
> https://web.git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-6.17-hash_pointers&id=de1c831a7898f164c1c2703c6b2b9e4fb4bebefc
> 
> As the branch name suggests, I am going to push it for 6.17.
> If it is too late for you then please let me know.

As long as it's in -next and scheduled to land, I'm happy. I'd always
like it earlier, but the less workflow disruption the better! :)

Thanks!

-Kees

-- 
Kees Cook
