Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B312F399;
	Sat, 22 Mar 2025 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742627933; cv=none; b=rw8J+UciPLZ0xRc8N9DTmE5Lhof+twvNITLsfqwQ10+gKXGR0BGCXYttqbuf2swrMIFQdPUeJRcRbjWhPy6jkPDGVPsVJPPeEg0IvTMz8YwaEv6bJE0NLcVSPdWtCqXTO6FMbuuai6Ki3THenvBTDpkHAO24sh+Kt00fq05dJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742627933; c=relaxed/simple;
	bh=5YMW/DlS0ebGtlxpPMHrs7Dv7gA/oYjUad8cwYfX9Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yt4LyKCSwLMBw6Zv3qtlVnPxaUG9kgODoOqLQrM7u2kBVDkvc9RX3u/xT9ea663Fr7kxIsA3YeJTrQTAiHVsKPZGKcyorP2s+9hpo5YOM/5cbplTo6xe1UOuwoCgpfW7RgzfZx/1xkYMJ2uJSeQB+Ri3G7aIYFjWY/awGjhcgME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMFiqeNI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMFiqeNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169ADC4CEDD;
	Sat, 22 Mar 2025 07:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742627933;
	bh=5YMW/DlS0ebGtlxpPMHrs7Dv7gA/oYjUad8cwYfX9Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMFiqeNIksNdGGRfCHxNVLnfEM0y+dtvL4aPrDhAWdnK6/kfk0QxvmdrO3iv9fpxw
	 DLNpWIooMxIjV+zHXcTTay4U3gjiAEeBCJD2MQXxEP/473xpYLhrM4F25Axravembf
	 cATBSlxgy67RYIpjrpUHOH/C9mbvKiQvHNg1kbGTz8eEq/P8jMbOILzy18Amt0BKX8
	 +NoGdA80UA8YGxGZk0gJT5LSqDKAqqvsmaGT57kWxGvRgmwy21RWxDlKFlVIFsnKap
	 0RP11hAGgBowov3NI0SRqsBJUY2RmS8Sqx5N6y8doSBWSgpGROgYKgilW4jURCBv+Y
	 u8oR0afv5C95A==
Date: Sat, 22 Mar 2025 00:18:49 -0700
From: Kees Cook <kees@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/5] slab: Set freed variables to NULL by default
Message-ID: <202503220003.FABF5E82D1@keescook>
References: <20250321202620.work.175-kees@kernel.org>
 <20250321204105.1898507-4-kees@kernel.org>
 <CAG48ez2-stu91bgZawx_AaypEuMnc5=nJQUiDzUCb+CbsJS6kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2-stu91bgZawx_AaypEuMnc5=nJQUiDzUCb+CbsJS6kw@mail.gmail.com>

On Sat, Mar 22, 2025 at 02:50:15AM +0100, Jann Horn wrote:
> On Fri, Mar 21, 2025 at 9:41 PM Kees Cook <kees@kernel.org> wrote:
> > To defang a subset of "dangling pointer" use-after-free flaws[1], take the
> > address of any lvalues passed to kfree() and set them to NULL after
> > freeing.
> >
> > To do this manually, kfree_and_null() (and the "sensitive" variant)
> > are introduced.
> 
> Unless callers of kfree() are allowed to rely on this behavior, we
> might want to have an option to use a poison value instead of NULL for
> this in debug builds.

Sure -- we have many to choose from. Is there a specific one you think
would be good?

> 
> Hmm... in theory, we could have an object that points to its own type, like so:
> 
>     struct foo {
>      struct foo *ptr;
>     };
> 
> And if that was initialized like so:
> 
>     struct foo *obj = kmalloc(sizeof(struct foo));
>     obj->ptr = obj;
> 
> Then the following is currently fine, but would turn into UAF with this patch:
> 
>     kfree(obj->ptr);
> 
> That is a fairly contrived example; but maybe it would make sense to
> reorder the NULL assignment and the actual freeing to avoid this
> particular case?

Ew. Yeah. Reordering this looks okay, yes:

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 3f8fb60963e3..8913b05eca33 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -473,13 +473,15 @@ extern atomic_t count_nulled;
 
 static inline void kfree_and_null(void **ptr)
 {
-	__kfree(*ptr);
+	void *addr = *ptr;
 	*ptr = NULL;
+	__kfree(addr);
 }
 static inline void kfree_sensitive_and_null(void **ptr)
 {
-	__kfree_sensitive(*ptr);
+	void *addr = *ptr;
 	*ptr = NULL;
+	__kfree_sensitive(addr);
 }
 
 #define __force_assignable(x)	\

> Another pattern that is theoretically currently fine but would be
> problematic after this would be if code continues to access a pointer
> after the pointed-to object has been freed, but just to check for
> NULL-ness to infer something about the state of the object containing
> the pointer, or to check pointer identity, or something like that. But
> I guess that's probably not very common? Something like:
> 
>     if (ptr) {
>         mutex_lock(&some_lock);
>         ...
>         kfree(ptr);
>     }
>     ...
>     if (ptr) {
>         ...
>         mutex_unlock(&some_lock);
>     }

Yeah, this would be bad form IMO. But it's not impossible. This idea
was mentioned on the Fediverse thread for this RFC too.
https://fosstodon.org/@kees/114202495615591299

> But from scrolling through the kernel sources and glancing at a few
> hundred kfree() calls (not a lot compared to the ~40000 callsites we
> have), I haven't actually found any obvious instances like that. There
> is KMSAN test code that intentionally does a UAF, which might need to
> be adjusted to not hit a NULL deref instead.
> (And just an irrelevant sidenote: snd_gf1_dma_interrupt() has
> commented-out debugging code that would UAF the "block" variable if it
> was not commented out.)

Yeah, the heap LKDTM tests need to switch to __kfree() too. :)

I'm going to see if I can build a sensible Coccinelle script to look for
this. It's currently getting very confused by the may "for_each" helpers,
but here's what I've got currently:

@use_freed@
expression E, RHS;
@@

(
        kfree(E);
        ... when != E
?       E = RHS
|
        kfree(E);
        ...
*       E
)

It is finding a few, though. For example:

--- ./drivers/md/dm-ima.c
+++ /tmp/nothing/drivers/md/dm-ima.c
@@ -584,13 +584,11 @@ error:
 exit:
        kfree(md->ima.active_table.device_metadata);
 
-       if (md->ima.active_table.device_metadata !=
            md->ima.inactive_table.device_metadata)
                kfree(md->ima.inactive_table.device_metadata);


-- 
Kees Cook
