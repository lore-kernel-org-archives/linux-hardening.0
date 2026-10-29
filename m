Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283531;
	b=ZkeMOTnibaEFUA7yLpsI9mu54Vd+WoEGq9vC68PLtj5HxmbK3cr0D01cWdghhGROMi2u
	 SPYDtfgwoy9lzDjEqVd1NpZmowu+31V5EOPvMluzCbZ4lAz7GLzMGQTOQui0FLhSFFBtZ
	 8AL/NmCIzgJf3xw0zMJEsXlhgyqzaL3km39RnOrQtzHrv3PSwjWQcUetrvltTv949CvJU
	 sEMhUJH51Q3AtzqBoXSiH2f53mvyVtaL5xrQow83WWrKamJlkrRyKbvaWk6KuZRKwIzu/
	 xbR0E8L9l5KvLFqMEXmqQZjiisLolCxy9KhM1A7ANcQv30c0SwtalNxGaBPQUH8Nh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283531;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=yjBsJBzmhn2xTB2gXD+mUnafcbwXoR+74vIvVz7S9tM=;
	b=jtyiu+gi5OdYHCUrrqhzxzEuoFm2dUhs0HEsZ2aNQlaohfuSR7KnGi4r0EDlDgypDAIn
	 sdAmLWh9BzfEQ5b/EcF9tbqy33psOdsz22lRpPDm/fgjX8dM9Ja4TLf2Tgl/0YZvB+lbw
	 xUQWV27UtoaUnZKh65IEkBBP58mAG/EVG3KMyRda3JjU+vJvZjT0q2nZDK6euxgV4KkNE
	 pyf+r97URkTzgtSIG94Q648iozmUZ376iGaXuVjk3hvSC+xNGqZhyQSZ2gy1bD2M0NkWS
	 cGCedG6RMkDrLFWTAbvOy7qG3ze4l8o3GwwcgRj0gjiPEq7HQTFuWUPb5V5WE1h/NRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="MiYVU/6t";
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCD60A2618;
	Thu, 29 Oct 2026 14:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9FCD60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=MiYVU/6t
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7101F1A041D;
	Thu, 29 Oct 2026 14:18:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 4758A2002C;
	Thu, 29 Oct 2026 14:18:40 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:18:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr
 Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Shuvam
 Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Mark a seq_buf overflowed when terminating it
 loses a byte
Message-ID: <20261029101838.7c34a2f2@gandalf.local.home>
In-Reply-To: <auNNcmUuR8DS7Hys@devuan>
References: <20261029053250.i.220-kees@kernel.org>
	<auMwo_T_FsZp5UsB@devuan>
	<20261029091845.21464a1a@gandalf.local.home>
	<auNNcmUuR8DS7Hys@devuan>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: as3y68ba6epsjyiw7pmi4ats8z7ecdyo
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 4758A2002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18UKqmOfY1nCf3ZWjmkztV0xD4xw/NVK6I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yjBsJBzmhn2xTB2gXD+mUnafcbwXoR+74vIvVz7S9tM=; b=MiYVU/6torKsAdXEljxYbPg6j85VdAq3xEANUTuqWbv6fmBGrD4B2kB9ElgScSxkmOKHeLfmigk+szD5ZCfNJsn6PsoKj4sa8h/REMGt/msZqfV/yd+fIK6FwXFAUJNqe4NUBWwuLsAx8l25S5AZhuP+Sx+iDeAMENdiuSOuMg0=
X-HE-Tag: 1793283520-281996
X-HE-Meta: U2FsdGVkX198uM8ZNCY2U7CsZ6Xo32ASAg9wO8VDiwPVK+wBDG7C2ulOiPCOztoLK+ZZKNwE4Xwf72RuRVNogMhZjy5bc/p0lmpPu4Ylaa6ZBzn5GBAdtN2r4uqAnEoIbw04aMHtUpgWWF8IXgfzGN6dAXozGk3l0EY6B6Ndp9XQwPnnlMT71MJ7eEHQPFUfbkd0ixKtCA7a3W2SyWlNmRX3ABwr3jTS/CfXyj3DQThu3TB2BmcSIKl4KpMGmh2Hc5VV9r8uYkFfGZd5X5U0BvmPYm2rwNGBtfh/W0vrA6A5yeU3PGUwOa5Ds+gUNfGmkgr2PD390ecSF1ObrwcOIyiKFEuw+MSv

On Thu, 29 Oct 2026 14:52:47 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> > 
> > This only happens when the user expects the string to have a nul
> > terminating byte. Don't think too much into this.  
> 
> Hmmmm, sounds reasonable under the point of view that users shouldn't
> expect these buffers to contain strings.  Then, seq_buf_str() would
> obviously be a write operation, since it transforms to a string from
> something that wasn't a string.

Right.

> 
> > > > @@ -137,10 +137,16 @@ static inline size_t __seq_buf_terminate(struct seq_buf *s)
> > > >  {
> > > >  	size_t end;
> > > >    
> > 
> > Hmm, I was thinking that this should first check if the string is already
> > terminated with a nul byte. Why add another one if it is?
> >   
> > > > -	if (seq_buf_buffer_left(s))
> > > > +	if (seq_buf_buffer_left(s)) {  
> > 
> > 		if (s->len && !s->buffer[s->len - 1])
> > 			return;
> >   
> > > >  		end = s->len;
> > > > -	else
> > > > +	} else {
> > > >  		end = s->size - 1;  
> > 
> > 		if (!s->buffer[end])
> > 			return;
> > 
> > Otherwise this overflows the buffer even when it is already terminated.  
> 
> If it is already terminated, s->buffer+s->len points to the NUL, right?

Not necessarially, a seq_buf_putmem() could have added the NUL terminator.
Then calling seq_buf_str() or seq_buf_terminate() should not overflow it.


> Is so, then we'd only reach this second branch when the buffer has
> already overflowed (seq_buf_has_overflowed(s)==true).  If the buffer has
> not overflowed, s->len<s->size, and thus we'd fall in the first branch.
> 
> If we have already overflowed, we shouldn't be concerned about further
> overflowing, right?  And on overflow, if there's a NUL, it certainly
> must be at s->buffer+s->size-1, so overwriting it with another NUL
> wouldn't do any harm.  If this helps us avoid a check (and thus a
> branch), it would be worth it, right?
> 
> BTW, I'd very much suggest renaming that 'end' local variable to 'nul',
> since it is the offset of the NUL byte.  'end' could be confused with
> the end of the buffer (as in ARRAY_END()).

"end" is just fine.

-- Steve
