Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548320C016;
	Thu, 23 Jan 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621660; cv=none; b=C522NNqntOD8iWzhn7f8BiMD12U+PGuozFrGXBJLoK0u2n4BxORi9sHKhHtIJc/fSh+7FsAYnze5PFLuE8FuVJV+pTmnRsMC4o0MBxCUH0j0jNsSZk8IXlvc6IwxlK2tnFJhXIi3lctpTrXkGLAZK1kbwjhVVIXotlS9FH2dxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621660; c=relaxed/simple;
	bh=cicN/aV0IsV4TlT0Tr1Af14QADBQMswa5OQ9DMZ913w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lk7aDT1BetCVdCrIqTY5Swm3FGSK1vLDCEagyUUx6ZGvTMwA7+S6f/gjqBOqGlGWrWT4uFDFOAlUovGX5zUfn5Fa+VsepRug2SES9NKp61QHWy66MmpOrXs4o4CKgtiXTOBpdn2XgEKmVIhK/aS9K7K4+istWXtXvZITFZzKT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lIElzstP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NAGplU0n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GHN12Wcc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/E2hU6ad; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lIElzstP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NAGplU0n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GHN12Wcc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/E2hU6ad"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60DCF21164;
	Thu, 23 Jan 2025 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737621650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JefnDf6WuVBS8kZnuvf/lDpV2dzD8PDqU2nfkrVchZ8=;
	b=lIElzstP9DoZwv1acPGRhF3qOZQ5/ncxXOqrh63uw+mPImZGsHUSQky2WemKPN/2B9AoSf
	Y/HDIPG+pi/5uvUtPsx6bJ/GmwP039xbFA/RrPaQMWDb67RZMDisXOmb9SiBQ6flUF67UB
	oVfxQGmhDvG5Bpx1kM4Jbfa+b2MTAf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737621650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JefnDf6WuVBS8kZnuvf/lDpV2dzD8PDqU2nfkrVchZ8=;
	b=NAGplU0nSzV+eT28Lwz+Ba/9wn2MsWNMpdydvqJ/zjd6LjUr1vBEkExQ+xQBxaT9/q441e
	cWj7zED3ZH8AqdCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GHN12Wcc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/E2hU6ad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737621649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JefnDf6WuVBS8kZnuvf/lDpV2dzD8PDqU2nfkrVchZ8=;
	b=GHN12WccRDBxE54bjBpp0oyIv4cmgil6TwWW7/j8E5JPaeBwqvWVzmb3HS4QwvaSW4VNmv
	BkieE9IKaU/DqAo3zFXYNOgLOYY3gCmf54aMtzWWs4+K2RlzjngGLEGFIwm/r3wia3vT6u
	d0dFohTfzRLgZ7wWnI8aiO79qhmN0r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737621649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JefnDf6WuVBS8kZnuvf/lDpV2dzD8PDqU2nfkrVchZ8=;
	b=/E2hU6ad6GGpgql+rTtaeuWtXRZE5boryzH4FTwKh8pzkMlkuLPvmvJCIC7QQUAdst6NLX
	lEaB+5AxysAhR6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2E6C136A1;
	Thu, 23 Jan 2025 08:40:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VJf9OpAAkmeAXgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Jan 2025 08:40:48 +0000
Message-ID: <881c3558-1101-496e-9ef4-5bef13f3f233@suse.cz>
Date: Thu, 23 Jan 2025 09:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: enh <enh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>,
 Benjamin Berg <benjamin@sipsolutions.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>,
 akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org,
 adhemerval.zanella@linaro.org, oleg@redhat.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
 ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
 mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
 deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
 peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org,
 dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org,
 mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
 rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au,
 Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Mike Rapoport <mike.rapoport@gmail.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
References: <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
 <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
 <ocstrhpyoyxzurvvxbrbnlzfqzo6hiqt7dxj7vu45ipj4min6z@ffnpao72slda>
 <CAJgzZopv+jKmDncYDJEQTymqQ1oRpy8HNpOsmcoM7Chb=uBJzg@mail.gmail.com>
 <l7pexkoo7t7p5u6gobgc46lxvpgpe2lywaqwa4b6vjddt3ccnq@mh6x72cxfhyv>
 <CAJgzZopiyhq9Wpu+gxUssoNhQT7tNjiey0JGsKPJAXjraEBRiw@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJgzZopiyhq9Wpu+gxUssoNhQT7tNjiey0JGsKPJAXjraEBRiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60DCF21164
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[google.com,oracle.com,chromium.org,gmail.com,sipsolutions.net,kernel.org,linux-foundation.org,linaro.org,redhat.com,vger.kernel.org,kvack.org,linutronix.de,arm.com,zx2c4.com,gmx.de,infradead.org,davemloft.net,lst.de,linux.ibm.com,linux.intel.com,suse.com,ellerman.id.au,canonical.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[45];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL63kxeufebbfchdakdyrqufr3)];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 1/22/25 23:29, enh wrote:
> On Wed, Jan 22, 2025 at 12:24 PM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
>>
>>
>> We are making changes in this area.  Can you elaborate on the 'awkward'
>> part?  The locking or the tearing of data?
>>
>> The way you state the page, it makes me think it's the tearing that is
>> the issue?  I think the ioctl would be worse for the possible tearing of
>> data.
> 
> there are two main styles of use of the /proc/<pid>/maps data i've
> seen in userspace:
> 
> 1. i need to know about _all_ the vmas, so i'm reading the whole file
> and stitching it together.
> 2. i need to know about the vma containing a specific address, so i'm
> reading line-by-line looking for a match.
> 
> the former is typically just for humans anyway (to be added to a crash
> report) -- so the ability to sendfile() or whatever would be something
> we could use there (though i've no idea whether that actually solves
> the tearing issue) -- so those use cases mostly tend to ignore (or not
> notice) the problem.
> 
> for the latter, tearing is a bigger problem because what does "not
> found" mean? do we try again? how many times do we try? so i think the
> ioctl() would solve those problems. plus it would be a lot cheaper,
> and in particular not require [or at least "strongly benefit from"]
> dynamic memory allocation like parsing a text file does.

IIUC tearing can only happen in place of parallel changes (mmap/munmap etc)
by another thread, but if it does not affect the VMA in question it
shouldn't lead to skipping it. If it does affect it, the query would be
inherently racy anyway.

One corner case I can however think of is a modification of a previous vma
leads to merging with the vma we are querying but even then IIRC the races
could mean the previous vma could be reported still as separate, but then
followed by the merged result, so the virtual address range corresponding of
the previous vma would appear twice in the report, not that a range would be
skipped.

But if you have examples of a different experience, i.e. where a vma would
indeed be missing, we would be eager to hear that!

I think the ioctl interface lets you "seek" to the address of interest
quickly, but I believe it also can't eliminate these racing issues completely.

>> Thanks,
>> Liam
>>
>>

