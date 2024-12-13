Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A276154430;
	Fri, 13 Dec 2024 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734071617; cv=none; b=nK4pCPr9Bi55fKTTr5t6vJ58ltLMA4gOIrfG0RBbg2yhlqjpjm1UuvcljqRGLz1JBDMb8430Kl/wVHpmcS9pc/rFyzxHhXqbVheB13B15BkHFOzOWXbMvamRJCraxgjPBMem7mTkzIi0ji2La9ICIEjcBJI0JruLqKKn+21EWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734071617; c=relaxed/simple;
	bh=xYIvsHxH7se38EeDikVXFcZrFt1/XFiLDY/jZg7BdAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yz8x48mRu5T/4UlVi4m4x4y7mB9wXzjKP39IBLzuboF7Wd18l/Nt5SP8JlXEPSkiVeNP9AWpH4ZFr/JLazT6Ul0rPKYhaoNT+aWuYJjcowgsKhmJxbfLYRkhmNLB9bGM+aI/TmsBpbonK7ndM3xKgcex2reGl3teq0VE3/LqmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSZTmjPN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSZTmjPN"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3023c51146cso13869581fa.1;
        Thu, 12 Dec 2024 22:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734071613; x=1734676413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYIvsHxH7se38EeDikVXFcZrFt1/XFiLDY/jZg7BdAo=;
        b=YSZTmjPNlDAu7omNFqKhyooJa7M9O1u/oqEw+lVVjZLwT/SFONEawmdFho2d73A1Cm
         LxG/RP7LyiHtRjS3m2GaJk770eK8K70YN3X0VaY/nJvdJMIFc3DtVPXL3GkWjt4H5VuE
         nvxfCOjL0AKDWcKu0YpKIf2maBbvuyIZ22LhKZyOh4qRm1SCJzeFzvXB3cqlC4S4HtGO
         bOu92rJhfdt7BAtmVQJ1Wf7ty5vG5x2+RrmfAKeuwOvp2I84cobj1faGh2nWO/b04Jz8
         ZAJFd1VCutAMSUtZHcyB25Td2sNbmhJyTHMseClAScWNAOg0QIU+2v1L8Hfquq2+U0Q7
         YExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734071613; x=1734676413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYIvsHxH7se38EeDikVXFcZrFt1/XFiLDY/jZg7BdAo=;
        b=WrrG4hLuX5TevtjUzQo8n/P4v1598upmgH7YgJ6J3rX6/2DwRjziIImHWKXH0Vrn5v
         8aKCGYFzZLwzngpJDAuQM8MKNkMJX474HQeUBOGrQKkzo+FULid07qJLsTQxMPVpvsXh
         SWjP1VCb4C/7mDiEBFZzOwAQhdML6SDb5GQmtf3FUedQnSYaZsCkhpQTyf8c2aSLj6LZ
         wYmSuL2SWgvj5OL1dKjN4pE+8b+moZdCk0wmnpS7FkSjVzVjBhJxt2EVbD3A4loH/8Vv
         zi6gJQuzQmT2fUwb9rfhowtbmlTDFGcswzvIpL014w7mwIi8jKbQT6nuKIj3G+jleAaU
         8ICw==
X-Forwarded-Encrypted: i=1; AJvYcCWukPwo5eKe7KrlNxG5HC/rgo8iJ6dLhhSXpIg9T7KeKoa36nn0cFAd5XQo6uFmKgCnvDCT2CFOmePgkLJt@vger.kernel.org, AJvYcCXlG4We2ubQbgMK0vUU+NtC2R+3/+DVHySWShlF8KltLyTIEjozQ6zb6CZ5c230tdGqnkO9ZFtMr4grO0Visok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmD1HHM8gPepfYH9yrKP2cgmrIBoXKqFhiHeMRyUZwEYp6TcgE
	9JH0lAW2m6RnHJxfTb7YAwGcrl7HwE2kJyeuHWkKLb/bPuMvpMENphvWZTbFO4vhzhykoyrYr+j
	1fbto52H52nvqtshXqQz1OkU9iX0=
X-Gm-Gg: ASbGncsgPgHfs8FHTJsArcg0RBX3hoGgh4Y5IIuBeep5lgfDHE6g/3CPBLQo7Aln8cU
	kBkM7EMIN3/U5wK7ApGbLc0HGuT9L+EBdsYzY9as=
X-Google-Smtp-Source: AGHT+IG60gjH59y1ipLf4Mpjxc9vIhcULTmWu8GwANVED51paeYo7DrLnE/DQYHZWJsxmrfq2IiddT6NWk4sSLXVVbI=
X-Received: by 2002:a05:651c:515:b0:2ff:4e4b:cbe2 with SMTP id
 38308e7fff4ca-30251c8c51fmr8337151fa.14.1734071613125; Thu, 12 Dec 2024
 22:33:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <CANaxB-wvHERPBu+17b5GP3pVv7pC8J0dkK9MUG1tSir4PQx=ZQ@mail.gmail.com> <CABi2SkXgZfTvyPX_rcb8KTKyeHxpZrL9_2Wr+vJ1q3K3_1rwoQ@mail.gmail.com>
In-Reply-To: <CABi2SkXgZfTvyPX_rcb8KTKyeHxpZrL9_2Wr+vJ1q3K3_1rwoQ@mail.gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 12 Dec 2024 22:33:21 -0800
Message-ID: <CANaxB-z57KoCNawGEkmpoiHV_iCaYr8YiOc2zQiTHM4fso0ABQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:47=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> Hi Andrei
>
> Thanks for your email.
> I was hoping to get some feedback from CRIU devs, and happy to see you
> reaching out..
>
...
> I have been thinking of other alternatives, but those would require
> more understanding on CRIU use cases.
> One of my questions is: Would CRIU target an individual process? or
> entire systems?

It targets individual processes that have been forked from the main
CRIU process.

>
> If it is an individual process, we could use prctl to opt-in/opt-out
> certain processes. There could be two alternatives.
> 1> Opt-in solution: process must set prctl.seal_criu_mapping, this
> needs to be set before execve() because sealing is applied at execve()
> call.
> 2> opt-out solution: The system will by default seal all of the system
> mappings, but individual processes can opt-out by setting
> prctl.not_seal_criu_mappings. This also needs to be set before
> execve() call.

I like the idea and I think the opt-out solution should work for CRIU.
CRIU will be able to call this prctl and re-execute itself.

Let me give you a bit of context on how CRIU works. When CRIU restores
processes, it recreates a process tree by forking itself. Afterwards, it
restores all mappings in each process but doesn't put them to proper
addresses. After that, each process unmaps CRIU mappings from its address
space and remaps its restored mappings to the proper addresses. So CRIU sho=
uld
be able to move system mappings and seal them if they have been sealed befo=
re
dump.

BTW, It isn't just about CRIU. gVisor and maybe some other sandbox solution=
s
will be affected by this change too. gVisor uses stub-processes to represen=
t
guest address spaces. In a stub process, it unmaps all system mappings.

>
> For both cases, we will want to identify what type of mapping CRIU
> cares about, i.e. maybe CRIU doesn't care about uprobe and vsyscall ?
> and only care about vdso/vvar/sigpage ?

As for now, it handles only vdso/vvar/sigpage mappings. It doesn't care
about vsyscall because it is always mapped to the fixed address.

gVisor should be able to unmap all system mappings from a process
address space.

Thanks,
Andrei
