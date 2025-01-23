Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B11CAA9D
	for <linux-hardening@vger.kernel.org>; Thu, 23 Jan 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669062; cv=none; b=K0h5EupcOcpL2H5xktvB0HxLyO0whjRzA/7ieWYCjPY9NLa4RN4hXmmSRzH/3iMwQQBu9/sBIzwq28tZ9DeVG4C22pqBCFXnzi2e+SXObcGPFRfzl4tFT9mfD7BMqpXl0pacAYT4eQdeBqhrb4C8+qo0IqXMCQs1I3esb+tBkrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669062; c=relaxed/simple;
	bh=P9/oJwOPRefOEMkVFNk0UJLDtHfvClx4Iyy9SyFrE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYBLMLNpBXmS4Fh9ePCGHg1e1J9q2o8E2Wif/uvbB5kJXXPByZWhYFMVmoNKdwQupYn/Vhb/gI+7T0KtW41e9toT1M/Jphwq944V+s91PA/lRQIoyFch2RdQK2VVEJ/c0HknrnR6XFW5MdPpznyus+eBjTdcl/9hnXcDUYdKiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhJwQUDr; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhJwQUDr"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d92cd1e811so22591876d6.1
        for <linux-hardening@vger.kernel.org>; Thu, 23 Jan 2025 13:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737669058; x=1738273858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNeH/Vwk0WxnvmxGVA+MQY7eTIFt8El+y7lX9sdBBHQ=;
        b=EhJwQUDrGDdwT5be6RbQ6XVfaHhLkqUoAnv65Sd/75MpMNqoaALOuJvKNFYymAoOpG
         CjYD+2M21xOBOMW97NwMxCh1p72rWWVxN+hxUq6a0YsSmdb3dLw7tnj50Z5CnzdXa8S/
         dzye+bG196qu+jTDrS81gnWOuyXLwEijoDbkdJz+Xl9Ohf5oECMMetiGgQJg9RVtYPGE
         WU9V3uSu20P1lfc1nE98WGaw3RPk/QN+NnXeqdz/dAalWSRmyo8lIcc8WbDYH3ohE827
         JJG0PEnRotGfUcwN8f6jVbT1dOl3CU2/v71uAGn4fjtAKWFO16xMDFRIfWk/fWCAb9HD
         bKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737669058; x=1738273858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNeH/Vwk0WxnvmxGVA+MQY7eTIFt8El+y7lX9sdBBHQ=;
        b=XmYlh/sZT+mzuZs402m7lY8anyqEtgdnN3Q2ljoIzwu396pVPqNTYVEj8TVPmffckc
         1TJKpIgACIblJi+DNrgGhHfy14gkaSlEZSKULGN91apMau0aEqTcC7G1ANi9EDS9Y7bI
         HrA4Zz7nBFVcFVF/bbgyKpF9jrS0QVHsvJUdp7UnWJMAF5SSqyJDZhnxiOjbpLEBIqmC
         a+P3GZZBFdelKSi98zkaPuM94DXvbj9QcoJXxrC574Ky2aPhQqti9FUP9WA8814Jg1VK
         Dp+Ptv/Dr7IPQMcT8bUNM6vl0294AJCXedvY66xi4aSefhPCWcKeuTbkBslwFmlV8yl5
         4LTw==
X-Forwarded-Encrypted: i=1; AJvYcCVl5Hpgu5zHk3F51qmSKzkSiEVcrReldwaOomi3Ly/P06wEFnL+E6jha7LobpFkc41setBckwu5rZLJZXT1tls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMTzDgAdYnLuy0Czf2XoSt2RbVAV9Wc7NaXYHsNW4VIuy4gZ0
	gcjAFYjjp8xkHTyfnlC06FpEZac8yxGgJLQk7ZJizCYHi8dKgR2rbm+ceZPp/16IfmaeKhqAVig
	+QxOl4miI9Gc+PjSfDtthjNHH0z+QKDGynkcv
X-Gm-Gg: ASbGncuMnQEp+zd6eOhxI/zpaZ0R3vmi1hvS3KCXHWsn8qbx3lioyGo1NNqPlBlOZhw
	nd840IPi3WVJbnfSwJVTkyzd1Ta1Rhy3Re3EOWhQUky4XIyoz5L6skhA+C6s=
X-Google-Smtp-Source: AGHT+IGjQLySf5h15b6EUt2+AojQPd7nFAI3klSmKwAgNbfD03RemFTK5I7CPHB5HkYURLTU16uxH/wLjwcvVxxyEPw=
X-Received: by 2002:a0c:ae82:0:b0:6e1:b610:e495 with SMTP id
 6a1803df08f44-6e1f9fb9c4emr61264266d6.14.1737669058024; Thu, 23 Jan 2025
 13:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local> <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local> <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
 <ocstrhpyoyxzurvvxbrbnlzfqzo6hiqt7dxj7vu45ipj4min6z@ffnpao72slda>
 <CAJgzZopv+jKmDncYDJEQTymqQ1oRpy8HNpOsmcoM7Chb=uBJzg@mail.gmail.com>
 <l7pexkoo7t7p5u6gobgc46lxvpgpe2lywaqwa4b6vjddt3ccnq@mh6x72cxfhyv>
 <CAJgzZopiyhq9Wpu+gxUssoNhQT7tNjiey0JGsKPJAXjraEBRiw@mail.gmail.com> <881c3558-1101-496e-9ef4-5bef13f3f233@suse.cz>
In-Reply-To: <881c3558-1101-496e-9ef4-5bef13f3f233@suse.cz>
From: enh <enh@google.com>
Date: Thu, 23 Jan 2025 16:50:46 -0500
X-Gm-Features: AWEUYZmZy44XkynCXJBk1cTdRc_83YgpLifVoyOW6uF3V0AfXoCnVqEoSr1EHzE
Message-ID: <CAJgzZoq29GzVsqAMrGiKoUpXFPVjPRQRO87SiagaQCVXfH90Lw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Benjamin Berg <benjamin@sipsolutions.net>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, 
	jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	Christopher Ferris <cferris@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 3:40=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/22/25 23:29, enh wrote:
> > On Wed, Jan 22, 2025 at 12:24=E2=80=AFPM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> >>
> >>
> >> We are making changes in this area.  Can you elaborate on the 'awkward=
'
> >> part?  The locking or the tearing of data?
> >>
> >> The way you state the page, it makes me think it's the tearing that is
> >> the issue?  I think the ioctl would be worse for the possible tearing =
of
> >> data.
> >
> > there are two main styles of use of the /proc/<pid>/maps data i've
> > seen in userspace:
> >
> > 1. i need to know about _all_ the vmas, so i'm reading the whole file
> > and stitching it together.
> > 2. i need to know about the vma containing a specific address, so i'm
> > reading line-by-line looking for a match.
> >
> > the former is typically just for humans anyway (to be added to a crash
> > report) -- so the ability to sendfile() or whatever would be something
> > we could use there (though i've no idea whether that actually solves
> > the tearing issue) -- so those use cases mostly tend to ignore (or not
> > notice) the problem.
> >
> > for the latter, tearing is a bigger problem because what does "not
> > found" mean? do we try again? how many times do we try? so i think the
> > ioctl() would solve those problems. plus it would be a lot cheaper,
> > and in particular not require [or at least "strongly benefit from"]
> > dynamic memory allocation like parsing a text file does.
>
> IIUC tearing can only happen in place of parallel changes (mmap/munmap et=
c)
> by another thread, but if it does not affect the VMA in question it
> shouldn't lead to skipping it. If it does affect it, the query would be
> inherently racy anyway.

yeah, at this point i should (a) drag in +cferris who may have actual
experience of this and (b) admit that iirc i've never personally seen
_evidence_ of this, just claims. most famously in the chrome source...
if you `grep -r /proc/.*/maps` you'll find lots of examples, but
something like https://chromium.googlesource.com/chromium/src/+/main/base/d=
ebug/proc_maps_linux.h#61
is quite representative of the "folklore" in this area.

> One corner case I can however think of is a modification of a previous vm=
a
> leads to merging with the vma we are querying but even then IIRC the race=
s
> could mean the previous vma could be reported still as separate, but then
> followed by the merged result, so the virtual address range corresponding=
 of
> the previous vma would appear twice in the report, not that a range would=
 be
> skipped.
>
> But if you have examples of a different experience, i.e. where a vma woul=
d
> indeed be missing, we would be eager to hear that!
>
> I think the ioctl interface lets you "seek" to the address of interest
> quickly, but I believe it also can't eliminate these racing issues comple=
tely.

i wasn't thinking of changing the "i inherently need to read the whole
thing" uses out for the ioctl(), just the "i need to know more about
the vma containing this specific address" cases.

> >> Thanks,
> >> Liam
> >>
> >>
>
