Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C013D8A0;
	Fri,  7 Feb 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738890116; cv=none; b=nRmMm1K+e7+GNYoDNy0muUurdE7cQGx8Eu3xPn9RAaRfjsX3d9q66VFQDHz6M/8N3dFtmuVA2j1oEVZZRCJlMdqGMPegl7S6NtA+IVuqhi1jRnHMCmsQbuqsob+PHEbTc5vAbrEIw2QYpqN5+J7hFmZqHWM37CQLPVIS3z6Olds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738890116; c=relaxed/simple;
	bh=8tAIi6RL1Kebq35UJ0GWYTKAnkLhfTKQxXx4V889VM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lA1Iq3woUVsB4as/hNoc49Ich/RT8MutVVxwopeSFraLe1IUYq+RpcCjO+lVPfBLHmLLU5ojyxqMBWARA7Hwq+7P4cide2SSrCN2dzl1SzDxPBio/D7LRgDAJu2WF1NRX6oTLf3r4BlbCUYaTrilSy6oZXZ58ZQaZG9np9+/XiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj5AEXhC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj5AEXhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE76DC4CEE3;
	Fri,  7 Feb 2025 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738890115;
	bh=8tAIi6RL1Kebq35UJ0GWYTKAnkLhfTKQxXx4V889VM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nj5AEXhCd/RVc/RXQpEz509PF2lHtW0FU/Iy4fo8KlM7q/h05ZmTQgqqspSB1QJa5
	 oVHXez7qc/LQJQv8+0p8H4lDt/+yDdu0C7B0v1Xp5aXufKbN3NhSeqjxUPaUBB8+jp
	 LdWBZvo3i4iTpxQXq+A0uSxn8RxCEPa/3vPO9zXjmeCiqO2AIiUUTmS1gZQ6DKmJEA
	 hCyd4jJXlFckCZ+K3zRVuLfVx4nB1hNnjM6Pytc9WvmFeL1n9v0DZx35n8GShbde0+
	 o0G+lz8XQa0BWofCHhcgsUWDSktBQu3aEwj17pgviaqvBxBLJPaUTgxdyw3yuiQ2H4
	 LXFIf1YbVid0g==
Date: Thu, 6 Feb 2025 17:01:55 -0800
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kernel test robot <lkp@intel.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, nathan@kernel.org,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] string.h: Use ARRAY_SIZE() for
 memtostr*()/strtomem*()
Message-ID: <202502061701.187F080@keescook>
References: <20250206213532.it.087-kees@kernel.org>
 <20250206214014.3567372-3-kees@kernel.org>
 <CAJuCfpEDdtC-NmYu1-RNC8R=Spuc1iQoqy44O8ML92fztF=1bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEDdtC-NmYu1-RNC8R=Spuc1iQoqy44O8ML92fztF=1bw@mail.gmail.com>

On Thu, Feb 06, 2025 at 03:59:53PM -0800, Suren Baghdasaryan wrote:
> On Thu, Feb 6, 2025 at 1:40 PM Kees Cook <kees@kernel.org> wrote:
> >
> > The destination argument of memtostr*() and strtomem*() must be a
> > fixed-size char array at compile time, so there is no need to use
> > __builtin_object_size() (which is useful for when an argument is
> > either a pointer or unknown). Instead use ARRAY_SIZE(), which has the
> > benefit of working around a bug in Clang (fixed[1] in 15+) that got
> > __builtin_object_size() wrong sometimes.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501310832.kiAeOt2z-lkp@intel.com/
> > Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Link: https://github.com/llvm/llvm-project/commit/d8e0a6d5e9dd2311641f9a8a5d2bf90829951ddc [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Tested-by: Suren Baghdasaryan <surenb@google.com>
> 
> Thanks Kees!
> CC'ing Andrew Morton since mm-unstable contains my workaround patch
> [1] for the issue fixed by this patchset. I'm not sure which tree will
> be taking these fixes but once they are in we should drop [1]. Or
> maybe we just drop it now from mm-unstable? Seems like only testbot
> was the only one who complained...
> 
> [1] 0e91345e75b2 ("alloc_tag: work around clang-14 build issue with
> __builtin_object_size()")

Yeah, that should be dropped. I intend to send this fix series to Linus
tomorrow or Saturday before rc2.

-Kees

> 
> > ---
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: nathan@kernel.org
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  include/linux/string.h | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 493ac4862c77..fc5ae145bd78 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -411,7 +411,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> >   * must be discoverable by the compiler.
> >   */
> >  #define strtomem_pad(dest, src, pad)   do {                            \
> > -       const size_t _dest_len = __builtin_object_size(dest, 1);        \
> > +       const size_t _dest_len = __must_be_byte_array(dest) +           \
> > +                                ARRAY_SIZE(dest);                      \
> >         const size_t _src_len = __builtin_object_size(src, 1);          \
> >                                                                         \
> >         BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||                \
> > @@ -434,7 +435,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> >   * must be discoverable by the compiler.
> >   */
> >  #define strtomem(dest, src)    do {                                    \
> > -       const size_t _dest_len = __builtin_object_size(dest, 1);        \
> > +       const size_t _dest_len = __must_be_byte_array(dest) +           \
> > +                                ARRAY_SIZE(dest);                      \
> >         const size_t _src_len = __builtin_object_size(src, 1);          \
> >                                                                         \
> >         BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||                \
> > @@ -453,7 +455,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> >   * Note that sizes of @dest and @src must be known at compile-time.
> >   */
> >  #define memtostr(dest, src)    do {                                    \
> > -       const size_t _dest_len = __builtin_object_size(dest, 1);        \
> > +       const size_t _dest_len = __must_be_byte_array(dest) +           \
> > +                                ARRAY_SIZE(dest);                      \
> >         const size_t _src_len = __builtin_object_size(src, 1);          \
> >         const size_t _src_chars = strnlen(src, _src_len);               \
> >         const size_t _copy_len = min(_dest_len - 1, _src_chars);        \
> > @@ -478,7 +481,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> >   * Note that sizes of @dest and @src must be known at compile-time.
> >   */
> >  #define memtostr_pad(dest, src)                do {                            \
> > -       const size_t _dest_len = __builtin_object_size(dest, 1);        \
> > +       const size_t _dest_len = __must_be_byte_array(dest) +           \
> > +                                ARRAY_SIZE(dest);                      \
> >         const size_t _src_len = __builtin_object_size(src, 1);          \
> >         const size_t _src_chars = strnlen(src, _src_len);               \
> >         const size_t _copy_len = min(_dest_len - 1, _src_chars);        \
> > --
> > 2.34.1
> >

-- 
Kees Cook
