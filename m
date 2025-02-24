Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553BE1FDA6A
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424979; cv=none; b=tBBfqR+/mgS6OmdTIoZpRfV6zdQKPtHVbDlvH9hCTwMOnPAlpSCCdESBjg8wzalpKB+nEYI/J8XUpjchICu64/txxfiruYbiSFLLrdxziOT47LlXTYkLuSRVPMk/FbYXrDG7Hkawpg+GvL/Hir8wXPpN+i/xlV66EEh9mYCD2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424979; c=relaxed/simple;
	bh=NVVZW1biKB93ICvSyhdAaemTbk+2VE2aDTLCsvAIJ1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=diPJaTDRW1vugnas1HweRaM7B65ex128XSKSPhHjjvAFXx9TFp8EfE4wwo3gwbo465WfqVPoo0f4eA8w9Mvj9H0Snhh1BwteMvNj/AyHMencJT8wtkWjiQRxARJtVtm8EscrkahwJw7CPyHetxyiHEEgy0qNmKELIIC8L1jMxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KuHzbDYB; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KuHzbDYB"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7272b51f677so644359a34.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 11:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740424977; x=1741029777; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXK4pusQDOpb1msPI4OVIWLwIn76adglBrjHmVv7AwI=;
        b=KuHzbDYBuNzw+nwxo6bSqFgZr9GxYaOID41W+UiBT7fsANQcDkoL3sdPKG1fYFwpww
         /Oiw12pBwpAGTtzCdFsNbM5hfIyTfnPV+TozcZ2V22Lae2pnpGgs2x2f7PvoSm/d956H
         Q4SFG7G5iUXE6wfWD5+R8j5l0GVX5Vcbty6Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424977; x=1741029777;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXK4pusQDOpb1msPI4OVIWLwIn76adglBrjHmVv7AwI=;
        b=JuAc3Rf64+yHThFrFU9uQYDS6IMJmZ6+P5dwRMXY9gFdxL2St7nbb5aiWw1M+M9ZFw
         Pb47pdcmqtA5lWYXuK7x8TP4GkGUWJ2McqGbNfAYrVIx27k8tDURBXq17vtYXgWck7+/
         1f5wO6EcE2eCIOC5cp50WKv8i6qYLIL90zRuvp0McjwK7ZpgCnhOcOe4sczqdXfz8qhy
         cfNt8zNi3qTxuThc/JM7zBW3h11YDqOnbQwiVxct4gpMcD4MVjijKLYlY7lAVSL5GPcY
         PDKloYXH51+KesHZlmep8ubSoKu9V7CxZ6LLfj8gIn0dRvHAGmqfJ+WD8z6tqE+wmRdt
         fWww==
X-Forwarded-Encrypted: i=1; AJvYcCXdq7x0t4tykkc1x6QdYxrBJH2O+NOZytAmlmIJ8+1NpE1kB2OSIc9Xe6FzxZqU0f/QURSEavP5htcxnKvDURM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCJr68SyKPkQ7ixtro6AcHZPr0UJKZ62++JELKT7k4t2kBzys
	i4dg/JCGsBg6fbwPDl2aKZl4i6MpdzMDxLr43h3LxIb+R8d2nXo2u96LP5o4qz9Y/G9s3vGozsj
	/Ogt/PGg9u18FOZDDgtHUCtsoJIFeZY5gbYbr
X-Gm-Gg: ASbGncvAKKO5+bggf+LSJeem3TtKYnnOkx8MxcJEuE9yhDOG5LpxIy5XpJnARYKZBSU
	KKTAWX7Jn/S2pTrtoY8O8jvLnyL4f1meNX5cTPXr/+1dFQv6Wb+eKfMmxGMEfnUcuQvl8EgGzpl
	GKFffYQBvNLdk1ntCULHN979BH1sF7X5dyF1RX
X-Google-Smtp-Source: AGHT+IHipYHEOTCDEd2oudfYkZmByZ8wUE3mOt21qoQhPydciadDU5SB9PbFol9qbsi30OsFwazNrvcjzZv520w6yrk=
X-Received: by 2002:a05:6808:228a:b0:3f4:210e:c0f2 with SMTP id
 5614622812f47-3f42455c800mr4106821b6e.0.1740424977301; Mon, 24 Feb 2025
 11:22:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <385e1498-2444-4a7a-a1b0-0013b0b8fd68@intel.com> <202502241053.1FF33D5B0@keescook>
 <lvzy3x2tv4uskn7dmatdqwqhhs4xv4vumk5f46thunndxqro6q@egremlepcgo7>
In-Reply-To: <lvzy3x2tv4uskn7dmatdqwqhhs4xv4vumk5f46thunndxqro6q@egremlepcgo7>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 11:22:46 -0800
X-Gm-Features: AWEUYZnmw26icYzliC0vlQAFEP5swDpKIia7nNj2plZNiKvZKlNhikDMcD2JAw0
Message-ID: <CABi2SkVv8+hNt-WjO2jp8zUNOiabncU35vNXApQi8yhBxcf86w@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:11=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Kees Cook <kees@kernel.org> [250224 13:55]:
> > On Mon, Feb 24, 2025 at 10:52:13AM -0800, Dave Hansen wrote:
> > > On 2/24/25 10:44, Jeff Xu wrote:
> > > > For example:
> > > > Consider the case below in src/third_party/kernel/v6.6/fs/proc/task=
_mmu.c,
> > > >
> > > > #ifdef CONFIG_64BIT
> > > > [ilog2(VM_SEALED)] =3D "sl",
> > > > #endif
> > > >
> > > > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the proble=
m
> > > > in case that  "#ifdef CONFIG_64BIT" line is missing.
> > > >
> > > > Please note, this has been like this since the first version of
> > > > mseal() RFC patch, and I prefer to keep it this way.
> > >
> > > That logic is reasonable. But it's different from the _vast_ majority=
 of
> > > other flags.
> > >
> > > So what justifies VM_SEALED being so different? It's leading to prett=
y
> > > objectively ugly code in this series.
> >
> > Note that VM_SEALED is the "is this VMA sealed?" bit itself. The define
> > for "should we perform system mapping sealing?" is intentionally separa=
te
> > here, so that it can be Kconfig and per-arch toggled, etc.
> >
>
> Considering Dave is the second person that did not find the huge commit
> message helpful, can we please limit the commit message to be about the
> actual code and not the entire series?
>
> I thought we said that it was worth while making this change in v5?
>
I include the cover letter's content in the first commit message to
clearly communicate the purpose of the entire patch series, saving
maintainers' time when accepting the patch.

Should I still include that, and add what the first patch does, and
separate it from the cover letter with  "----"? What do you think?

-Jeff



> Thanks,
> Liam
