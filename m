Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14131DFE00
	for <linux-hardening@vger.kernel.org>; Tue,  8 Oct 2024 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399665; cv=none; b=izKRrP1m9txpTv9O5goSU2kwiZcBTXrLT4L3qqffEnhlHHZopXfvOa7J3TeRCTciXC9YucahdzecLaqQkO9m5eZ0ulYBesE0TzoG5GgB3pFsTOqEtp3yhNOElYD54AGm32bYZWVCZ2ykVevZ3Y6BZGBc8d9aS2LBuIn+B4ncQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399665; c=relaxed/simple;
	bh=ISDycBoROB1PogJNHrlA/nfpzEIank8h3YISvLhTIkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=C+lPvgmuF4AXvWNYP8dHuJstOFQ21VdK/gNlK1bbPpv6XM8jcBvBOcigS2ESEVdRqFARtDxQYpXc0CFSJ4sJEuUFNryZ7NNnDgx+vacqurWvf2IeBMNpPaJZ2qaxkqEGQ+E/zPu6T8y/EbGEwNoAi1jRprQ7hEgfb2eSSjrwn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hp5MyPO7; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hp5MyPO7"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5e1dadb257bso227108eaf.3
        for <linux-hardening@vger.kernel.org>; Tue, 08 Oct 2024 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728399662; x=1729004462; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNaoqE9iLYEqaxmKhH8Fh/36izXlvroo3qs4o9RMtlo=;
        b=hp5MyPO7JjB4qWlDwAg/dQIbZGLiX7Q0a8567zYdsEoUHkWglsQAohUa2lV6fltlL5
         BGoKoQzSVfLKIZVp1+X63tPgCceyD8PYHUnb6+eq/f9+OeEi/lqfrhaR198fGyCBRbkX
         Z8r1sqWgG1kiS0tuSVFGR86yYNBKvk/ZiD1mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399662; x=1729004462;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNaoqE9iLYEqaxmKhH8Fh/36izXlvroo3qs4o9RMtlo=;
        b=HF9ktY5O8TdOXgzSwYnuem7YG/YtETzPlHIlvraAv3oLW9v1MUuBEG/EedLySlHMsI
         QdLuiciJQfD5EDH9IQsBgRKeAc8Q7c6a9VUkvgmMpoqcK7xnvt27SItEGPrIuflHp04o
         xtcjaIjqu3RAUjn4Rq+jvh38wWgcBFR10u272vm/ht6xZko2cucd4PbX3ytkS1bHiwsd
         Jvi3B56kCPR6zWyulAXpYfQ3WOEBoTTqAgJL3GtGt9pU+/1D3/9MJA7QgjzRcOHGgns3
         yAqb1hYcFNvqtsCv/V1W5ojtd1fr5dYDq433h3i72692UPXCnWoOZmzOUzQFc+d9a1R3
         GtFA==
X-Forwarded-Encrypted: i=1; AJvYcCUB4fWh7DeoommefVyGzzgyvL2H+d/VmFvMrYzycFk8nyXv5qPrAoRIRhnh0k4lOEDowiwXC+0inv0YEXcTomw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyFROHqP2KNaetLVqMb0wApPyyoDwfc9B4uNTEGp1We/vA19cw
	YDP7vzZDzgUCWNnK7jNB8JU2cuafFjZwEnmiIGYoDRv/Z0XQredI0tj865aslI9JONX9EO3754W
	wPCv0JOW0NoOdrjKN6E1D2hT2oYZ5je9vo4Av
X-Google-Smtp-Source: AGHT+IFMtDvnSOLpJ2+MdayuHbe1zXaSJRKropnN+uC9XI1mdmCdWI7HRfFEHmxrAvMu2kyjkRI7+J9N6QbI9kV3qvE=
X-Received: by 2002:a05:6870:b30f:b0:27b:9f8b:277d with SMTP id
 586e51a60fabf-287c225aee7mr2608151fac.12.1728399661695; Tue, 08 Oct 2024
 08:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004163155.3493183-1-jeffxu@google.com> <v32x3rszfq7twguleqpj3xejsh6gtupput4dgfmvv357lxznqs@dy6fzjuhrs3v>
In-Reply-To: <v32x3rszfq7twguleqpj3xejsh6gtupput4dgfmvv357lxznqs@dy6fzjuhrs3v>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 8 Oct 2024 08:00:00 -0700
Message-ID: <CABi2SkVfPjfbAMVEK8KFzS4RsZefCo8LAW9r7BkiSweUxVeJpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/1] seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	mike.kravetz@oracle.com, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, peterx@redhat.com, 
	hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	nathan_lynch@mentor.com, dsafonov@virtuozzo.com, mhocko@suse.com, 
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, enh@google.com, 
	rientjes@google.com, groeck@chromium.org, lorenzo.stoakes@oracle.com, 
	Jeff Xu <jeffxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liam,

On Mon, Oct 7, 2024 at 7:19=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [241004 12:32]:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing during the life time of the process.
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization. These mappings
> > are designated as non-writable, and sealing them will prevent them
> > from ever becoming writeable.
>
> But it also means they cannot be unmapped, right?
>
> I'm not saying it's a thing people should, but recent conversations
> with the ppc people seem to indicate that people do 'things' to the vdso
> such as removing it.
>
> Won't this change mean they cannot do that, at least if mseal is enabled
> on ppc64?  In which case we would have a different special mapping for
> powerpc, or any other platform that wants to be able to unmap the vdso
> (or vvar or whatever else?)
>
> In fact, I came across people removing the vdso to catch callers to
> those functions which they didn't want to allow.  In this case enabling
> the security of mseal would not allow them to stop applications from
> vdso calls.  Again, I'm not saying this is a good (or bad) idea but it
> happening.
>
> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [1], thus sealable.
> >
> > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > _install_special_mapping() function. As no other mappings utilize this
> > function, it is logical to incorporate sealing logic within
> > _install_special_mapping(). This approach avoids the necessity of
> > modifying code across various architecture-specific implementations.
> >
> > The vsyscall mapping, which has its own initialization function, is
> > sealed in the XONLY case, it seems to be the most common and secure
> > case of using vsyscall.
> >
> > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > alter the mapping of vdso, vvar, and sigpage during restore
> > operations. Consequently, this feature cannot be universally enabled
> > across all systems. To address this, a kernel configuration option has
> > been introduced to enable or disable this functionality. I tested
> > CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS, which doesn=E2=80=99t=
 use
> > CHECKPOINT_RESTORE, to verify the sealing works.
>
> I am hesitant to say that CRIU is the only user of moving the vdso, as
> the ppc people wanted the ability for the fallback methods to still
> function when the vdso was unmapped.
>
> I am not sure we can change the user expected behaviour based on a
> configuration option; users may be able to mmap/munmap but may not be
> able to boot their own kernel, but maybe it's okay?
>
The text doesn't say CRIU is the **only** feature that is not
compatible with this.

The default config is "CONFIG_SEAL_SYSTEM_MAPPINGS_NEVER", and
distribution needs to opt-in for this feature, such as ChromeOS or
Android or other safe-by-default systems that doesn't allow to unmap
or remap vdso in production build.

Thanks
-Jeff


> >
> > [1] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkR=
kL-NrCZxYAyg@mail.gmail.com/
> >
> > Jeff Xu (1):
> >   exec: seal system mappings
> >
> >  .../admin-guide/kernel-parameters.txt         |  9 ++++
> >  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
> >  fs/exec.c                                     | 53 +++++++++++++++++++
> >  include/linux/fs.h                            |  1 +
> >  mm/mmap.c                                     |  1 +
> >  security/Kconfig                              | 26 +++++++++
> >  6 files changed, 97 insertions(+), 2 deletions(-)
> >
> > --
> > 2.47.0.rc0.187.ge670bccf7e-goog
> >
