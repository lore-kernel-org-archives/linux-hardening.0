Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71060322C63;
	Fri, 14 Nov 2025 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132193; cv=none; b=Z0YVfbogdJvqtEpYiudeO+0wmbYdQe9Ugu0RMQnmesjDKM7Pwt6+/MVyDd7LOvnjGlF/ZZL4aofqJbDm1sJJcVpmp1WB8jWPw2DxSJlWTAmUXlCBKUyG17TA0zPUtioMhRHCyKJRVe8eCUoUhv+yMqmg0+3CyvRl3yfWgZn2LGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132193; c=relaxed/simple;
	bh=xdSvwqEtlpvYE+sDW3Tr0Rs5yVrL+10AzEHsj/r1fdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQsopoNinuNmuJfB6rmMofLVjR+QRrtJqxjVftL46JVBwWh7ENVd4ylZk+0nWxI/RSgIS+WM8D8mnXHzw/9IqEZt8HhU+l7yBa2/xWkvo8XheuHxUIHQoGWAKAFj92slsaJOE6vEuGZkplYxKdkVsNfe2FpQGxJgh4iF2rXlRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id ED68A58D0E;
	Fri, 14 Nov 2025 14:56:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 049CD60010;
	Fri, 14 Nov 2025 14:56:26 +0000 (UTC)
Date: Fri, 14 Nov 2025 09:56:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] unwind deferred: Annotate struct unwind_cache with
 __counted_by
Message-ID: <20251114095644.116a767d@gandalf.local.home>
In-Reply-To: <20251114143104.0d1aead3@pumpkin>
References: <20251114122748.222833-1-thorsten.blum@linux.dev>
	<20251114084346.6469edc0@gandalf.local.home>
	<20251114143104.0d1aead3@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: u9d8j9gqunin8t36wjox1tfachqywetf
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 049CD60010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18temwqSHLqjxcKjtoiPzEuK6N7P/2/qxA=
X-HE-Tag: 1763132186-585628
X-HE-Meta: U2FsdGVkX1/Ht8r715N5++cI5hX0Z2zC2wc0sCn+xoef0CLuwJQf3oaK4dMZm3J9RqVthizD9VoOnAQIbdIdXgqJikc3HVb4rnGPmDqoMOCXbV1Pe6JTzti0gZP7HrzAm7LUjvjNflvglWseo+DxCnTBdPvwiQGwDAhGBR+Bssw01OtgFmpTTpqf37JZqBpBC/tgabksdgHhd/snonzS9Do+2DpK3vXgun9MzD8qQaTFhyFj65RDnIy+QIHVFtqivp9RLLp6U0t7vI5e9WaxSV/Hip8Fvt5+y5qEHcMPZ3/eS3BV2sp48DV0poGgpVPxeSEhfCz3PHaVdeNykoHV+ubK7FNM8yUUY7z+YrdSfglbAph9yRBP5NbjVQXkTeaLKNu1uB6N/w1FcAtpZ5LezYh2sqXOQdaOpWbXO5nHbBs=

On Fri, 14 Nov 2025 14:31:04 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Fri, 14 Nov 2025 08:43:46 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 14 Nov 2025 13:27:47 +0100
> > Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >   
> > > Add the __counted_by() compiler attribute to the flexible array member
> > > 'entries' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > > CONFIG_FORTIFY_SOURCE.
> > > 
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > ---
> > >  include/linux/unwind_deferred_types.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> > > index 33b62ac25c86..d4b67f0116f3 100644
> > > --- a/include/linux/unwind_deferred_types.h
> > > +++ b/include/linux/unwind_deferred_types.h
> > > @@ -5,7 +5,7 @@
> > >  struct unwind_cache {
> > >  	unsigned long		unwind_completed;
> > >  	unsigned int		nr_entries;
> > > -	unsigned long		entries[];
> > > +	unsigned long		entries[] __counted_by(nr_entries);
> > >  };
> > >  
> > >  /*    
> > 
> > Wrong!
> > 
> > I need to add a comment here that entries is not bound by nr_entries.
> > 
> >    https://lore.kernel.org/all/20250730093249.4833be14@gandalf.local.home/
> > 
> > Maybe this?:
> > 
> > diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> > index 33b62ac25c86..d05409bb14fa 100644
> > --- a/include/linux/unwind_deferred_types.h
> > +++ b/include/linux/unwind_deferred_types.h
> > @@ -5,7 +5,7 @@
> >  struct unwind_cache {
> >  	unsigned long		unwind_completed;  
> 
> Does that need to be 'long' - 'int' would fit in the padding on 64bit.

We could make it 32 bit, then the number of tracers attached would be the
same as it would be on 32 bit archs (which would be 30). Maybe that's enough.

> 
> >  	unsigned int		nr_entries;
> > -	unsigned long		entries[];
> > +	unsigned long		entries[]; /* Fixed size, not bound by nr_entries */
> >  };  
> 
> Perhaps it should be:
> 	unsigned long entries[ /* MAX_UNWIND_ENTRIES */ ];

Whatever would keep the coccinelle folks from sending more patches.

-- Steve
