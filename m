Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE420629F
	for <linux-hardening@vger.kernel.org>; Mon, 16 Dec 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374122; cv=none; b=ZQPX7wENazwtuEtVAxfo13tLiaedFhEt+X/rY05Np4KvMJRVw49RTqGNJBW7Tb8+dWbF68RLgmL8jR3ekPd9N3eIS+h3JIIsqbNpndI7OBuicAqga4WylueZgFwC0QZtufmb792YfjJDQGsFbUUJC4XaBYEz5U+qwxkQn5+6yTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374122; c=relaxed/simple;
	bh=ZXCZa1S/4LkUPEXrXl7PNDO7FmMdW8jJpnyAg7E7XI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnv9HbsApOa8jmEJ25rI4YaS7Ij32n1OXiHGaB+P4xFiBmS1mIEoI84UP4UHSe7nqWJPx/y2f1mHybnHvHo8cadWioE2ytT0F9o5w+4rRRctYOyOAsMquwrz4JhdH3EcCItPUkoAADGyz/OFSAiIAWpTK50yyjy9eTNh18gCUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aF6gmnas; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aF6gmnas"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f2e32b44dfso240400eaf.2
        for <linux-hardening@vger.kernel.org>; Mon, 16 Dec 2024 10:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734374119; x=1734978919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXEK7Vse6aakb2JheJS8WYLCYFeLAE0epOYSkGGSTqM=;
        b=aF6gmnas2bfKkL50w1Flbs/FRIrMM3c2KStYJ9crbWGOzcs5ylqpju3bTU3rbiVvKN
         lempJFk3/ptE4ebEutg1QNE7E6NCuQ9BDhMQOsQtNrrRMI35RlnGXQjA7sQyiT/bPSVA
         tNVC6akMqo8aOrqgVmX/pW4RoO8nd6IwLOYic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734374119; x=1734978919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXEK7Vse6aakb2JheJS8WYLCYFeLAE0epOYSkGGSTqM=;
        b=YOy4XeMjLBIFJ1CUoi5Z3hsr1cOjojCtr4PXfMBl20MRoB+t9OnB5mQuo0TeHHcHVU
         XjHC3ds+EbrANs3U/nQDRnED+0mYU8HFLMO5Va6DoB0qXLVnf0pxrswNT50BpyIgjcxf
         4JwvMdrV6lrQH89NUuWJK3Lpyg2Qlpnji8qyEZnHc4GwjTs9JUyVl0c4RfOMyPKtmeB+
         PcYrBp32SDJxmAsOTFk+cOsRm+k1chVzREjpslgIKBLaGiuA9Yg5HrnWmdA5cOoH17s6
         V1jU/z0b86mgP6e/9hK+qhnOs6YVQ3j38fgfDQsv9+lnzcN42+AQIF68RO0UX+hv1f6L
         wnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4RZpdpUsFnSBVkC045kzXzpHvWEh8bwod7eALFQckBDQLGy7/Ow/G9bxwOv4Qd0oIjyfd/ry42kayoTwg3EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzym/kYS/sTj2TSst8L1L4h28yeJ8B8JlVwgsifAXTWJliZiyG7
	gP3Dh04iCTOrc49Gudn1aBWmi3es3REXk3k6SIEQJijnvItWi8xNnKK/4GAJZH5JYlGwyTM3NrZ
	Kh7Xwu516Wsmv94v1wzrnsCaC/vuOYBHl8BoB
X-Gm-Gg: ASbGncvM48rj73mjjTUyx+MLQ/OyQuzI2Fwpla38fvBmxEHbvSAX3+kQ1cN9qKy7rMP
	IHK2UVOd2aHGIVfc2UI9DtAtPWS5gofyY7Gcv2MTywfJWUqbZfuSthm0vOtjRzuWaGg==
X-Google-Smtp-Source: AGHT+IExY3RjjFLn3tPMx9+giIoAqAfP5Lu05qFPLELxlUn5L2uO9fAM5yo6LSyh1i1i6mjZIwzEf4LGOzkSZN571NU=
X-Received: by 2002:a05:6870:9688:b0:291:cb6:f3cd with SMTP id
 586e51a60fabf-2a3ac77e492mr2908435fac.8.1734374119592; Mon, 16 Dec 2024
 10:35:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <CANaxB-wvHERPBu+17b5GP3pVv7pC8J0dkK9MUG1tSir4PQx=ZQ@mail.gmail.com>
 <CABi2SkXgZfTvyPX_rcb8KTKyeHxpZrL9_2Wr+vJ1q3K3_1rwoQ@mail.gmail.com> <CANaxB-z57KoCNawGEkmpoiHV_iCaYr8YiOc2zQiTHM4fso0ABQ@mail.gmail.com>
In-Reply-To: <CANaxB-z57KoCNawGEkmpoiHV_iCaYr8YiOc2zQiTHM4fso0ABQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 16 Dec 2024 10:35:06 -0800
Message-ID: <CABi2SkXYjq0ACYkFf3e35DoOJP6d3TEpLEU_RCTmNLHQ_YJq6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Andrei Vagin <avagin@gmail.com>
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

Hi Andrei

On Thu, Dec 12, 2024 at 10:33=E2=80=AFPM Andrei Vagin <avagin@gmail.com> wr=
ote:
>
> On Wed, Dec 11, 2024 at 2:47=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wro=
te:
> >
> > Hi Andrei
> >
> > Thanks for your email.
> > I was hoping to get some feedback from CRIU devs, and happy to see you
> > reaching out..
> >
> ...
> > I have been thinking of other alternatives, but those would require
> > more understanding on CRIU use cases.
> > One of my questions is: Would CRIU target an individual process? or
> > entire systems?
>
> It targets individual processes that have been forked from the main
> CRIU process.
>
> >
> > If it is an individual process, we could use prctl to opt-in/opt-out
> > certain processes. There could be two alternatives.
> > 1> Opt-in solution: process must set prctl.seal_criu_mapping, this
> > needs to be set before execve() because sealing is applied at execve()
> > call.
> > 2> opt-out solution: The system will by default seal all of the system
> > mappings, but individual processes can opt-out by setting
> > prctl.not_seal_criu_mappings. This also needs to be set before
> > execve() call.
>
> I like the idea and I think the opt-out solution should work for CRIU.
> CRIU will be able to call this prctl and re-execute itself.
>
Great! Let's iterate on the opt-out solution then.

> Let me give you a bit of context on how CRIU works. When CRIU restores
> processes, it recreates a process tree by forking itself. Afterwards, it
> restores all mappings in each process but doesn't put them to proper
> addresses. After that, each process unmaps CRIU mappings from its address
> space and remaps its restored mappings to the proper addresses. So CRIU s=
hould
> be able to move system mappings and seal them if they have been sealed be=
fore
> dump.
Thanks for the context.

> BTW, It isn't just about CRIU. gVisor and maybe some other sandbox soluti=
ons
> will be affected by this change too. gVisor uses stub-processes to repres=
ent
> guest address spaces. In a stub process, it unmaps all system mappings.
>
> >
> > For both cases, we will want to identify what type of mapping CRIU
> > cares about, i.e. maybe CRIU doesn't care about uprobe and vsyscall ?
> > and only care about vdso/vvar/sigpage ?
>
> As for now, it handles only vdso/vvar/sigpage mappings. It doesn't care
> about vsyscall because it is always mapped to the fixed address.
>
Given this understanding that CRIU intends to replace the current
process's vdso/vvar with that of the restored process, and therefore
doesn't want the parent CRIU process to seal the vdso/vvar, a prctl
opt-out  for vdso/vvar is reasonable path going forward.

The sigpage mapping also should be included in this opt-out, for the
same reason as vdso/vvar,  it is created by the
arch_setup_additional_pages() call during execve().

However, the uprobe mapping shouldn't be included by this opt-out, as
it is not created by arch_setup_additional_pages() during execveat().
CRIU should simply restore it from the restored process, if present.

vsyscall, which is created when the system boots, and maps to a fixed
virtual address and page, shouldn't be included by this opt-out.

So I'm proposing to opt-out vdso/vvar/sigpage with a new prctl:
disable_mseal_criu_system_mappings =3D true/false
What do you think ?

> gVisor should be able to unmap all system mappings from a process
> address space.
>
Do you think this opt-out solution will work for gVisor too ?

Thanks
-Jeff


> Thanks,
> Andrei
