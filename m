Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFE38910F
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769827; cv=pass; b=WNhs4eqq+xwsD6e+oZ6LUWOsJFG/Z9fMSc2Vde9swKrPIBmj3Auz/7R1P0PgAJcfSSc98IO9YgL2l0J0iLu2QEkW+Tvt6Kbq7pkaQ9D42gGB6rhHMu6I95abM5OWY2PA7YcEFSQ4Oz7KEWWL5ESdzb3SVNnr5T6kT0OQqRc5IeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769827; c=relaxed/simple;
	bh=cFUXsIx/2Ydwy7tUWGAmtxCngDDjyoHzTD4ASi70g7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvHkFgKtgesJqifVMScnAY2d+clf/zKW/64ZjFPBcdUNfNTa8kiW+s6SBHa5nnKcz+4W2XfSxWYKxYzWwtOtUh7jW02SN88jr4iBN1++2wrgYx49XMZPKngTnC8wohO2TrgQHLjn5vLj8tycNqaI6Xgr+kQd0Q+xqdvk8cYdJM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=JK+pjJZe; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="JK+pjJZe"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37fad5eca09so1607735a91.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 14:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782769825; cv=none;
        d=google.com; s=arc-20260327;
        b=EOY6n2Sc9haFag7gX1HDCD0pYbPVNqZdxTxX75+WzIrYC9DsBOchE69V6p+2hc1NIV
         cdFfuOp6pZkpkkyip4e2q7gfJog8pd4/oC3toRuwwwmUJxUrQ6PaeNMKb9GgtWR35t73
         jxeQNHevI2U4LB/124PHiHM0p4fxpQ55w7stQOgmNuNs6idFvvO5nTGKUJShZwWjfGmt
         8S6KQ9GqqRGI0osGTTqKxpBXteZeXS4EzerFV/yeIY/3mnX4rC9L094pF/9BZguoSz0M
         q4+YLitEwhfi7pMoB4tgxKTNaqLMEsjUp9zuMmbSJyRfDTk0k0UDj5u93Lo4eNEjva5c
         ZK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2llOgQYBxpmnTUq9sCCQre1s4FqkjHrXxMuD91zMJhQ=;
        fh=0jrLJ9riIJsFq3M6DHF3C9aOODDPXfdrvy7GQsaLUgc=;
        b=sdY+OIke44cTD5aY8RK6/CgYfv+Es02AqusMLAqafOEf7oxaxUe2tnotNp1hiE4X31
         W102itx/toqTuWUSFH0PxiU5LtLAT+b4hl709Y/bxaQ/JkxmR36aM0NTQQd3wHaZW/EL
         PuUntDNT4kTFvbqeF9nRXMwjLD122wSkgS0NCJ1EZDNQWYIDHB2N44Nzl5+pqoeLoRHY
         op/aAd43metrNrACCKMetIjVUnRMJGoLGMOXxUsnhz243Wz9nRN3Mo+zK7wbkw4w6JRX
         4KQVZ4JnJvbhTKWAU5MftvUAv955WUJEkFG9naTQrGdmzDRBHiSb0HCP8ni5mMGi24db
         oz2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782769825; x=1783374625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2llOgQYBxpmnTUq9sCCQre1s4FqkjHrXxMuD91zMJhQ=;
        b=JK+pjJZe7Qm31a3J06qi3ZkTr1kRkrTuTbLtv+RIAX44t2K+QSVbPISpFr5urHuWEn
         gRz5u7CXembu6LrR+Ocw8jIrKNUfJ78xnqzCjfTR7vrQWMGQEWM+ibg2Apha0YABskBg
         fFlhDId2aV6o9WbnihHcMon8KjG8DWJxYxfhE5H7zJlUN+UV6mWMO88yaipwSSH2tLUh
         6/Yi9O3SXDKkKh7k1nwKAXwyDQSc+alyEqZxirnHgRBWz2OR3Twhuu7wrosZoheOIvIL
         b5rrmGrrxyzado3q0AlZFo/wKFZ1Iv2jnD+In4yIxmwA94FO0MxktV6G8JIalSblPVpr
         ZxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782769825; x=1783374625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2llOgQYBxpmnTUq9sCCQre1s4FqkjHrXxMuD91zMJhQ=;
        b=WWXpV4TU/7Id0K3VGBWJDToNrTNO5e+EXFjoUX9q3Df5bvEG7mGR31fJurmkaWte/X
         ixhF0pbYKZMw5+oEFk8EaBrTypxa0gdt4Pw4h7aukUTVkdEX8j3n/NcFKMewJC1V7zWY
         l2zypGtca5C/0ARIxNN4+9k2Rs14V6nfINqauWAsAowCWj4E4Od86uGsQwGhbGYMWXxU
         yPsXisaLx/gvJVHkuEVK1xbgMxKCQ2krefJgC7vCNJ/YoI2320XbwTpFWRj/Rp6Z11Ep
         KLw0SJ0hk/peWslTjLM6ZEYNsYwg91i42KNCz+hUZ06IVMF0k/Ab0Kupbe3RdM/KkBbK
         mjyw==
X-Forwarded-Encrypted: i=1; AFNElJ93xOekhdKnDrDiAujPcFNsLRai2oJpODSEY/TL8mUWQ9lPvqDwmfm7p3dSJ2np3FjvYBh5ZBN8Hd7BMQOPbV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO4j0gftowEqrPd6Vz8ykUHGxX9id7IZ1waRuZMheXndpbi1Sy
	Y4RqxEC1H7GW5sQNe8e1sBsXKuwoo4JSAS7HPsuQS9K3ytWsTRluR8oorTE4qejdpY71WVDlNV+
	aHLA/Q4zcQm5MM+UrQ04PpSY41pCfMubaNfDKrTyv
X-Gm-Gg: AfdE7cn4ZGegiMgVqkX7GuI7H+dcO33fC1Ju4PhORBMaP4EqqPEXzCPNb3Ypjxk+Jss
	Gmlqo9TIjZYugVS1ZJLv6VsgUYR9jvEBafcv2LRjWNaOi7ebEvHnf1WjUIagLt0VdR7OBFNTgCx
	g4HC74zzgcf1/6uzIXFAtD4iH5lJAAj6Kxz6VYuB2r+MlQ46gPGe48/ftLv52MUugEN27FTt7Rq
	tkAiSd5OZjBtExioFuLAONKl7k9xJI01CIl1wvU2mOroHhAtfeW0hN6thXNY1JXd13JQaggagtB
	+jIs0VO3r3NoSQ+shmqR5jdLU9IECE8=
X-Received: by 2002:a05:6300:2208:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3bfc6d9d5c9mr715479637.19.1782769825442; Mon, 29 Jun 2026
 14:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626173444.2252041-1-xmei5@asu.edu> <aj7UNceukU9zYeGH@pedro-suse.lan>
 <CAPpSM+RVFDOYJFT2iwgNYdjbwqF-MmrbYizpLYksd1SLb5bT9g@mail.gmail.com>
 <499a4e15-34a4-421b-946a-c855199fdbf9@zytor.com> <akH34ycu5-q2Yc_D@casper.infradead.org>
 <3c4094d8-ae5e-4ffd-b28a-0c10db50296c@zytor.com> <CAPpSM+TA6ECyCO4J3c9CrezbApMO66Fm5u8z6djDaFj5Wtagng@mail.gmail.com>
In-Reply-To: <CAPpSM+TA6ECyCO4J3c9CrezbApMO66Fm5u8z6djDaFj5Wtagng@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 29 Jun 2026 14:50:05 -0700
X-Gm-Features: AVVi8CcXquKjNGGEs37RhJuoKAaonZ0o2UeH9tYWgQXG4kXrQ8gmEx7u0A4Wai8
Message-ID: <CAPpSM+STqnUmzdx13rxya8_7z860st8R4oj+30TRJP094zQY6Q@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <willy@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
	Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>, 
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

An AI reviewer found an issue:
https://sashiko.dev/#/patchset/20260626173444.2252041-1-xmei5@asu.edu
And that's correct; we added one more change in v2:

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3217,7 +3217,7 @@ struct vm_struct *__get_vm_area_node(unsigned long si=
ze,
return NULL;
if (!(flags & VM_NO_GUARD))
- size +=3D PAGE_SIZE;
+ size +=3D VMAP_GUARD_SIZE;
area->flags =3D flags;
area->caller =3D caller;

v2 was sent: https://lore.kernel.org/linux-mm/20260629214712.1198680-1-xmei=
5@asu.edu/T/#u

Thanks,
Xiang

On Mon, Jun 29, 2026 at 10:21=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> On Mon, Jun 29, 2026 at 5:50=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wr=
ote:
> >
> > On 2026-06-28 21:43, Matthew Wilcox wrote:
> > > On Sun, Jun 28, 2026 at 07:09:37PM -0700, H. Peter Anvin wrote:
> > >>
> > >>> 2) `enter` is not rare since we can take part in the instruction.
> > >>
> > >> This sentence doesn't parse.
> > >
> > > They mean that we can jump into the middle of an instruction, and it =
is
> > > not rare to see a 'c8' byte in the instruction stream.
> > >
> >
> > OK, I see the point now. The main difference is that ENTER doesn't requ=
ire a
> > REX prefix, whereas ADD/SUB/LEA do (otherwise it truncates RSP and ever=
ything
> > immediately dies as a result of SMAP violations [you are welcome].)
> >
>
> Yes, Matthew's explanation is correct. (Btw, thanks Matthew!)
>
> Xiang
>
> > This means that an offending bit combination is far less common.
> >
> >         -hpa
> >
