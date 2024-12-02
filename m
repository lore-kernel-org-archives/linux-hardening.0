Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED921D63CA
	for <linux-hardening@vger.kernel.org>; Mon,  2 Dec 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160511; cv=none; b=le4k5PQAJaZA44x1TRCA5bXggWohx8VbMHNWYmeKZEjxCBkbmVReIy2DE6KRnI0aBdAp41Mw7E28QdOJAuG9BRZZEWpF9bkp2jGhJkkd5PhJZwk4oP+KhbK+J9+yL94XwiJp7SdV/1q5uBb9YJWrrTtuMZH8sbx/fgFMdOZiiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160511; c=relaxed/simple;
	bh=wJFBfBmHYj+r40PWkie06frhHQy8OBlRzQJ5xiTFB6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qF0GvKlUVhWvOwJQ/saJSncf0WiOyXigTTCDZKP/pqupW87Xs6jDAW7A4Ii0HXHGVpakMhisq5it148FU7VQBf+H/ey7nTL0YPH+bjJSEbFlOiO/VKZP5dBDy9Va6kqgtxYrBtP4G4rLl5zJp0eiG5OrvWikNGX050qNmxxNIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bEcBcu5Z; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bEcBcu5Z"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-295e9f795dbso242185fac.1
        for <linux-hardening@vger.kernel.org>; Mon, 02 Dec 2024 09:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733160509; x=1733765309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4g52UpJ3PmxcvI/j7zwPPdBS0T11At54rD3c1xjjOY=;
        b=bEcBcu5Z0ChiZ1asgoL75MV59zPDCw5NSd4R7E8tKyueEqxJWZhOi37VMhZz3roBOV
         ONLSvp3soSHLCZldgVKot+cyICXa1oWZrpMErNdP9/4H3LFohRay7CaJ8gh5E5rNg2Zd
         hQkrYNRifEjbTN3GXB5Senz6I2CgHSP+T31oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160509; x=1733765309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4g52UpJ3PmxcvI/j7zwPPdBS0T11At54rD3c1xjjOY=;
        b=VfoOPuoUZeiG4jPyYp0Myl3ZdhUUswTQ9y56ay3aixdyc+or3AFsrGG4qtINyXyWDZ
         tNMADsBxftLDxk+d2QfQBrvGN+QUL7XdM8KTV25XGWpqyxqhz7rRsmoIP7ntKccufmFg
         +942HeZUMjsX/YEkb5SJF6REtbhRBx6Nx+xcrCSWO6K515GWPsluyKABfV4EPb8vCs1H
         ulLue+9t67jlkfR+ikEWsBzG+YmYl97enhJQhLy9iSwYCE5CQJk/AGoI6BQF720R+ZWg
         kacwXvsGtA0FMnpD6Z1dNeBIxsDwze1EmvwaMUXss06IPqmVtqS1R+zr8YzRTJBuul2M
         ogVw==
X-Forwarded-Encrypted: i=1; AJvYcCV/UG7wPIvZcmSsisHTFGb8btwubJRz56PCtvOzZcG4HCRiu3XT300p3comx3Pv7zoot1UNmvRX/6Hi93yLxoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMphPifxa5C51gdxemcbOlsdRWsbJg37QF5vPBpuSkAmlJMZgK
	Br8eAv12RNeFW7NUWfapq9to1y5b7ZPIWIu4bNllBfwticaEFNAdnB4iZp6HX8BQct9aLqitZjq
	xlzSk+m/SXx4TNONKgmXMR3BrUhhXatQho85P
X-Gm-Gg: ASbGncthzKVx6hGWrc7ALYflP89FUQCuCuOZjWIq44mkPRh0+VHcxNQsiKlgrMvadhg
	kqbspBJSzT4j1YBTPwlOh1lvlWBwHurJtRIbmq3F5ZeRDj/AxO/U/wRUp9MKY
X-Google-Smtp-Source: AGHT+IF0l7ckRLP+aVl+IekfkudYe/vLczB8xykS3zl9D27IHSlG37LSEt2alDzPQKCTxcNozOrr3kQuCvLEOD1SXnI=
X-Received: by 2002:a05:6870:170d:b0:295:c1ca:b99a with SMTP id
 586e51a60fabf-29dc3fbe9f0mr4690677fac.1.1733160508981; Mon, 02 Dec 2024
 09:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <7494c3aa-378f-4bb6-bc44-59ea49ccc5e6@lucifer.local>
In-Reply-To: <7494c3aa-378f-4bb6-bc44-59ea49ccc5e6@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 2 Dec 2024 09:28:17 -0800
Message-ID: <CABi2SkV1kSgUpXTfiGOLy2CazzQrJd75=Uwa40CvuE-JRqQfnA@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Seal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
	groeck@chromium.org, mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:40=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +Vlastimil
>
> Jeff... :)
>
> Please review
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>
> You didn't cc- mantainers of code you are changing. And you reference my
> name without cc'ing me here. I'm sure there's some relevant Taylor Swift
> lyric...
>
I apologize,  this shouldn't happen again.

Thanks for reminding me
-Jeff


>
> On Mon, Nov 25, 2024 at 08:20:20PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing or unmapped during the life time of the process=
.
> > For complete descriptions of memory sealing, please see mseal.rst [1].
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization, and are
> > sealed after creation.
> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [2]. It is sealed from creation.
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
> > across all systems.
> >
> > Currently, memory sealing is only functional in a 64-bit kernel
> > configuration.
> >
> > To enable this feature, the architecture needs to be tested to
> > confirm that it doesn't unmap/remap system mappings during the
> > the life time of the process. After the architecture enables
> > ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
> > CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
> > Alternatively, kernel command line (exec.seal_system_mappings)
> > enables this feature also.
> >
> > This feature is tested using ChromeOS and Android on X86_64 and ARM64,
> > therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
> > Other architectures can enable this after testing. No specific hardware
> > features from the CPU are needed.
> >
> > This feature's security enhancements will benefit ChromeOS, Android,
> > and other secure-by-default systems.
> >
> > [1] Documentation/userspace-api/mseal.rst
> > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkR=
kL-NrCZxYAyg@mail.gmail.com/
> >
> > History:
> > V4:
> >   ARCH_HAS_SEAL_SYSTEM_MAPPINGS (Lorenzo Stoakes)
> >   test info (Lorenzo Stoakes)
> >   Update  mseal.rst (Liam R. Howlett)
> >   Update test_mremap_vdso.c (Liam R. Howlett)
> >   Misc. style, comments, doc update (Liam R. Howlett)
> >
> > V3:
> >   https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.co=
m/
> >   Revert uprobe to v1 logic (Oleg Nesterov)
> >   use CONFIG_SEAL_SYSTEM_MAPPINGS instead of _ALWAYS/_NEVER (Kees Cook)
> >   Move kernel cmd line from fs/exec.c to mm/mseal.c and misc. refactor =
(Liam R. Howlett)
> >
> > V2:
> >   https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/
> >   Seal uprobe always (Oleg Nesterov)
> >   Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg N=
esterov)
> >   Rebase to linux_main
> >
> > V1:
> > https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/
> >
> > Jeff Xu (1):
> >   exec: seal system mappings
> >
> >  .../admin-guide/kernel-parameters.txt         | 11 ++++++
> >  Documentation/userspace-api/mseal.rst         |  4 ++
> >  arch/arm64/Kconfig                            |  1 +
> >  arch/x86/Kconfig                              |  1 +
> >  arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
> >  include/linux/mm.h                            | 12 ++++++
> >  init/Kconfig                                  | 25 ++++++++++++
> >  mm/mmap.c                                     | 10 +++++
> >  mm/mseal.c                                    | 39 +++++++++++++++++++
> >  security/Kconfig                              | 24 ++++++++++++
> >  10 files changed, 133 insertions(+), 2 deletions(-)
> >
> > --
> > 2.47.0.338.g60cca15819-goog
> >
