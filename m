Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C718A6B6
	for <linux-hardening@vger.kernel.org>; Wed, 13 Nov 2024 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731533926; cv=none; b=PDIW0O+lhpL2he7eYTIByeQl/S4uMphUuAwCIIGlG4xHFZbsVIZ8dl9hcgoxwFiVvePmVDGbcOedR0xexLYxVTeYKcTar9jkrc2ElmomZUG71nrLX3ymGcLVb1g+2bEt7uF5xQ7DSD1V34L4jLElVEfrjtP2pyfIwsEQ1j7fkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731533926; c=relaxed/simple;
	bh=mheZ/wAtNmDrNEQcufpZUfuBjuWJINKYM9G4xxTv/Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mXDBUx4TPfq84P8rF0Jg+kXIn2zAtwBCo6BUwo9HgwlpQYcJZsLkkike7ZpcHx6ZA3jXY/BTrv/N882tteOhjMxjc/Ved/1toVlCLulSSsOhLt4QeFx95bDAU/RR+96qLAzSPG/yEiyB7Y3hVOgBCFaM6g6ptbO5TUmK3znmKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J5KxD2Xx; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J5KxD2Xx"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ebeca94c87so197028eaf.2
        for <linux-hardening@vger.kernel.org>; Wed, 13 Nov 2024 13:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731533923; x=1732138723; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1HLez0Td9c7uyIaeN8KOf70EzxAV/9Y0VBaG+sRDN4=;
        b=J5KxD2Xx1YOOfurGVvyei+mYegUqDEF/DWZHLXLiTO+CoLGsa0ut4UyAylkTUIPj4i
         pI6IyUY9tl8y8mzX0QWXnmbGydDkNqOU97mapZIwtee4ykAVeDyMt4mejFHbLONUKmic
         IIFeMiEwCjodN8dM9sF1notRXtyC7V6fcQTIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731533923; x=1732138723;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1HLez0Td9c7uyIaeN8KOf70EzxAV/9Y0VBaG+sRDN4=;
        b=OpA9AnQ+NVDlScICT+X0tjQoGTModtgvqU99xVEAnvbXl7bR/c72zMl3w++BtH7FUo
         oJpZIPRO/hiWPisOUn4pHsYeeGz4Nhd6kBFL2rVwqIc5QF2ZAiAbH9BCbGDbuqLEf6xv
         RaxNp8o81bCIeQMJuGrfv2sl7FEUmQNOVjSJk7DFSPK3rIeAgIyEY9yz4rLZ1ve8XqYA
         H7sW/oYZKQJbJi8EfzU3rDXde5tVxLLG+4lvf8Fj08EjDl5e3dDZ4+kV6b4aWWueyITM
         rGkDmi35ikZWFqWXiddxmnCLUYxP7dDXoQZLDrV6cciIax0R9Pd/OhAzc7eHJhAw5u4+
         w1kg==
X-Forwarded-Encrypted: i=1; AJvYcCXb2Btg+Z6vie8cb884pkyU28m3Z0y8agpndvCrwChiAaUL1pdbvyG30/9+IPgkQzTs6XP9xu61IRcf67+UZLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDAJnre+hdRnVgF8R+cJwd7btxNUxEx5WHgfWNGKyLZ02+GdT
	x/grCPXG61nZkVGHPVkaybLt4YZwwfKeSG5FkHuIQnIB9ihbyq7JeWQowQpE1GAAHpFU/f4zpea
	nWUx/JDv7Lu+gBE1dBptsYXTHA1UzlAli42j1
X-Gm-Gg: ASbGncu2tEzEHTHL4kTtupzR2QerERB+ZmERTpxOCtyerEYAqC5CB7toq+/3IJAysJY
	R5fYSP6p14mMq1Py7zJurUUtylx7zEJh4
X-Google-Smtp-Source: AGHT+IHx0rYafwheHrgh+R02YLA3PsYr8f7geW3TKeFbn9zyqsBnWTS3qCE09qHmhyurf27HCRIU2KpvGII3C/Pg7xA=
X-Received: by 2002:a05:6870:8e07:b0:27b:b2e0:6af with SMTP id
 586e51a60fabf-295600d07c9mr4371531fac.2.1731533923524; Wed, 13 Nov 2024
 13:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014215022.68530-1-jeffxu@google.com> <20241014215022.68530-2-jeffxu@google.com>
 <6r5sxlhfujr2expiscsfpdjtraqlvy6k3cznmv25lo6usmyw7x@igmuywngc5xi>
 <CABi2SkUfXrRLg7+ZrLjMEQzh4FtU0EAfckdiDuza1mFKzi0SAg@mail.gmail.com>
 <agkliam473nmhxirk76psryxh5qkrncdhwzyoyf4w4efkxnubw@vkeini5qa6xw>
 <CABi2SkW-cWJQtT2E_vO40bFi7Qrr+At3Q0jFVVQt+WZP=jaHHg@mail.gmail.com> <5wpwj5uokivgcwfcpjh7lbi4g64gecsajfn6glghfmc2lvzrgd@2fz7zhgmsduo>
In-Reply-To: <5wpwj5uokivgcwfcpjh7lbi4g64gecsajfn6glghfmc2lvzrgd@2fz7zhgmsduo>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 13 Nov 2024 13:38:32 -0800
Message-ID: <CABi2SkUn5pTwU9yc+6UCOXW_Q1CoFE4t1BdGQs1wq73TLvGW5w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] exec: seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:35=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> > To make modulization better, I can do below adjustment:
> > if (seal_system_mapping_enabled()) <-- implemented by fs/exec.c
> >    add_vm_sealed() <- keep in include/linux/mm.h
> >
> > However, if you have a strong opinion on this, I could move the
> > parsing logic to mm/mseal.
>
> Yes, please move the parsing logic together with the other mseal code.
>
Sure

>
> I am not sure what one you are renaming or what these functions would
> do.  I think you need to look at your overall design and try to fit it
> into what exists instead of putting a call in a wrapper function
> (_install_special_mapping) to alter an argument.
>
Please see V3.

> >
> > > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > > index 57fd5ab2abe7..d4717e34a60d 100644
> > > > > > --- a/mm/mmap.c
> > > > > > +++ b/mm/mmap.c
> > > > > > @@ -2133,6 +2133,7 @@ struct vm_area_struct *_install_special_m=
apping(
> > > > > >       unsigned long addr, unsigned long len,
> > > > > >       unsigned long vm_flags, const struct vm_special_mapping *=
spec)
> > > > > >  {
> > > > > > +     update_seal_exec_system_mappings(&vm_flags);
> > > > > >       return __install_special_mapping(mm, addr, len, vm_flags,=
 (void *)spec,
> > > > > >                                       &special_mapping_vmops);
> > > > >
> > > > > If you were to return a flag, you could change the vm_flags argum=
ent to
> > > > > vm_flags | mseal_flag()
> > > > >
> > > > passing pointer seems to be the most efficient way.
> > >
> > > I disagree.  Here is the godbolt.org output for gcc x86-64 14.2 of yo=
ur
> > > code (with some added #defines to make it compile)
> > >
> > > seal_system_mappings:
> > >         .long   1
> > > seal_system_mappings_enabled:
> > >         push    rbp
> > >         mov     rbp, rsp
> > >         mov     eax, DWORD PTR seal_system_mappings[rip]
> > >         cmp     eax, 1
> > >         jne     .L2
> > >         mov     eax, 1
> > >         jmp     .L3
> > > .L2:
> > >         mov     eax, 0
> > > .L3:
> > >         pop     rbp
> > >         ret
> > > update_seal_exec_system_mappings:
> > >         push    rbp
> > >         mov     rbp, rsp
> > >         sub     rsp, 8
> > >         mov     QWORD PTR [rbp-8], rdi
> > >         mov     rax, QWORD PTR [rbp-8]
> > >         mov     rax, QWORD PTR [rax]
> > >         and     eax, 2
> > >         test    rax, rax
> > >         jne     .L6
> > >         call    seal_system_mappings_enabled
> > >         test    al, al
> > >         je      .L6
> > >         mov     rax, QWORD PTR [rbp-8]
> > >         mov     rax, QWORD PTR [rax]
> > >         or      rax, 2
> > >         mov     rdx, rax
> > >         mov     rax, QWORD PTR [rbp-8]
> > >         mov     QWORD PTR [rax], rdx
> > > .L6:
> > >         nop
> > >         leave
> > >         ret
> > > main:
> > >         push    rbp
> > >         mov     rbp, rsp
> > >         sub     rsp, 16
> > >         mov     QWORD PTR [rbp-8], 0
> > >         lea     rax, [rbp-8]
> > >         mov     rdi, rax
> > >         call    update_seal_exec_system_mappings
> > >         mov     rax, QWORD PTR [rbp-8]
> > >         leave
> > >         ret
> > >
> > > ----- 48 lines -----
> > > Here is what I am suggesting to do with replacing the passing of a
> > > pointer with a concise "vm_flags | mseal_exec_flags()" (with the same
> > > added #defines to make it compile)
> > >
> > > seal_system_mappings:
> > >         .long   1
> > > mseal_exec_flags:
> > >         push    rbp
> > >         mov     rbp, rsp
> > >         mov     eax, DWORD PTR seal_system_mappings[rip]
> > >         cmp     eax, 1
> > >         jne     .L2
> > >         mov     eax, 2
> > >         jmp     .L3
> > > .L2:
> > >         mov     eax, 0
> > > .L3:
> > >         pop     rbp
> > >         ret
> > > main:
> > >         push    rbp
> > >         mov     rbp, rsp
> > >         sub     rsp, 16
> > >         mov     QWORD PTR [rbp-8], 0
> > >         call    mseal_exec_flags
> > >         mov     edx, eax
> > >         mov     rax, QWORD PTR [rbp-8]
> > >         or      eax, edx
> > >         leave
> > >         ret
> > >
> > > ----- 26 lines -----
> > >
> > > So as you can see, there are less instructions in my version; there a=
re
> > > 47.92% less lines of assembly.
> > >
> > vm_flags already  run out of space in 32 bit, sooner or later we will
> > need to change that to *** a struct ***,  passing address will be
> > becoming necessary with struct.  Since this is not a performance
> > sensitive code path, 3 or 4 times during execve(), I think it would be
> > good to start  here.
>
> No.
>
> I have pointed out why this is not 'the most efficient way' and you are
> now switching your argument to 'this will be needed in the future'.
>
> Please fix this.
>
Sure, updated in V3
