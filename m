Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7513AD06
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729137411; cv=none; b=Vs0Y7DP7JKbb4h+Msew4GWxVY2fEFzCRJBcycujnc/zEiikg5c+mfuKVFXRggYfkEswskzaAzfsTVMs2PL9f1Pen/ShPk7yNXiRf+/Fvc+PukYyY2uarIWAttNTANKtTFOVpyuNLOhVX+DiXiHGT6QJWFVtfjxVsK8hMQAz2ksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729137411; c=relaxed/simple;
	bh=2Sc+tjISrvqUTEFy0Kq866Vkx6YKhfGRK1exiXvwA98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3CqoMtf/hgY1dY7c71qNwRuazmyBnbJdLLupuNEUK+o/leAYfc/z99OLUNSRzNDaHe96H05gp5laqez2zY9hunX8xr4Yj/ZCsRK6UrG5r9Mcve5hNcf1IulHKAm276v4c+6sH3qxstzz+QXhZUsTwo7hKXAgyT8LBrGZkstz6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oabdYSpr; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oabdYSpr"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-288a6df82ebso56349fac.2
        for <linux-hardening@vger.kernel.org>; Wed, 16 Oct 2024 20:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729137409; x=1729742209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xDplWMnrkVDTOjcZzbsa+PFQJ46/uurWYdS279WZl4=;
        b=oabdYSpreclV8vKQJB1QNe4xZIMlqe1Ow49iJ7tN5A0ocHM5grHFXYi+UQdFxRDZaK
         SYYLOwMiWTmN6Z7OC82DrcudllMuGl4vtZE6BDLv2ceARYm4idHUFyXgmABV/Dxqkp7L
         7qb68Q36BweKBkq8eRLuHoznA2W8b7LV2gVxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729137409; x=1729742209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xDplWMnrkVDTOjcZzbsa+PFQJ46/uurWYdS279WZl4=;
        b=bCz5x/ux/+/v6xd2J6nsIsQ0ttydQzWOnEA7fq9iB9x/9tPn7pXFPPxsbpfqaLalbb
         5ceUFWzrVZFteUrXimC2ojUPskAtdl9j3JeqAweErCv/63uUO1O9aHmEvbACH+wcs11i
         r5EOt+z+zy3qBA6ysRouPueZnW1vSyLSC0viRvaWn+m8koZN+58vpqJe071q8zv/q6oz
         gFTcG0U87+vBJRgpyAl5CVkn2dmIhRnBnq+JOm52WoUlz43RP/NI3LSmBbVcJWSw6Q5c
         hRmtCeV2b0jCfCr4kTEJBA549fmhTkoO9tljLRBdfILc11HqhOZY9dYCYGlrPMGe9vEA
         imsg==
X-Forwarded-Encrypted: i=1; AJvYcCVWL/0Cp0TpfZa7hlZ4vn9G/mODRqeL99VoOV7BxflnWjjEWovBsvMX8xdFZ/cID9Vvt1ksdIiMAQ4I3Ca4/+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEbUY7EQ9nuUZ0oWyit8Kw/07CJluVQncIXBgz6V2pY9qBJvG
	M9KBYQjHRoaV+RbSELpBeoZjBPibFlV+4FwUFhJZmv6cw0ukcyAGCw6J4s1uBTPSlloCGCy7lRH
	OlqJTMZW0w+acskXltrb1l0TMtnS7bL833FKs
X-Google-Smtp-Source: AGHT+IE4fYg26EfQyIf9BSs4rRYOM6MlrMuoB3kGUvuKZrktYleCB72ksfvspyqDROopedVLIoje8kkW2ksT2pf691A=
X-Received: by 2002:a05:6870:2012:b0:268:bd85:ff9a with SMTP id
 586e51a60fabf-2890c60b148mr504819fac.3.1729137408676; Wed, 16 Oct 2024
 20:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014215022.68530-1-jeffxu@google.com> <20241014215022.68530-2-jeffxu@google.com>
 <202410161424.FA6DBA7D91@keescook> <CABi2SkXKWGuvttUWHH+CL-MnKDvF=o6i2nGz55r+-6WvSJex5Q@mail.gmail.com>
In-Reply-To: <CABi2SkXKWGuvttUWHH+CL-MnKDvF=o6i2nGz55r+-6WvSJex5Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 16 Oct 2024 20:56:36 -0700
Message-ID: <CABi2SkUfKzutFJLv0q42LRU-YDjNzMBmmZ0NKXNwGhQVoJ_bfg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] exec: seal system mappings
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com, 
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, enh@google.com, 
	rientjes@google.com, groeck@chromium.org, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 3:06=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Wed, Oct 16, 2024 at 2:26=E2=80=AFPM Kees Cook <kees@kernel.org> wrote=
:
> >
> > (I don't think this needs "RFC" any more)
> >
> > On Mon, Oct 14, 2024 at 09:50:20PM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > >
> > > Those mappings are readonly or executable only, sealing can protect
> > > them from ever changing during the life time of the process. For
> > > complete descriptions of memory sealing, please see mseal.rst [1].
> > >
> > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > generated by the kernel during program initialization. These mappings
> > > are designated as non-writable, and sealing them will prevent them
> > > from ever becoming writeable.
> > >
> > > Unlike the aforementioned mappings, the uprobe mapping is not
> > > established during program startup. However, its lifetime is the same
> > > as the process's lifetime [2], thus sealable.
> > >
> > > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > > _install_special_mapping() function. As no other mappings utilize thi=
s
> > > function, it is logical to incorporate sealing logic within
> > > _install_special_mapping(). This approach avoids the necessity of
> > > modifying code across various architecture-specific implementations.
> > >
> > > The vsyscall mapping, which has its own initialization function, is
> > > sealed in the XONLY case, it seems to be the most common and secure
> > > case of using vsyscall.
> > >
> > > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) ma=
y
> > > alter the mapping of vdso, vvar, and sigpage during restore
> > > operations. Consequently, this feature cannot be universally enabled
> > > across all systems. To address this, a kernel configuration option ha=
s
> > > been introduced to enable or disable this functionality. Note, uprobe
> > > is always sealed and not controlled by this kernel configuration.
> > >
> > > [1] Documentation/userspace-api/mseal.rst
> > > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4X=
kRkL-NrCZxYAyg@mail.gmail.com/
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         | 10 ++++
> > >  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
> > >  fs/exec.c                                     | 53 +++++++++++++++++=
++
> > >  include/linux/fs.h                            |  1 +
> > >  kernel/events/uprobes.c                       |  2 +-
> > >  mm/mmap.c                                     |  1 +
> > >  security/Kconfig                              | 26 +++++++++
> > >  7 files changed, 99 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docume=
ntation/admin-guide/kernel-parameters.txt
> > > index e7bfe1bde49e..02e5eb23d76f 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -1538,6 +1538,16 @@
> > >                       Permit 'security.evm' to be updated regardless =
of
> > >                       current integrity status.
> > >
> > > +     exec.seal_system_mappings =3D [KNL]
> > > +                     Format: { never | always }
> > > +                     Seal system mappings: vdso, vvar, sigpage, upro=
bes,
> > > +                     vsyscall.
> > > +                     This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPP=
INGS_*
> > > +                     - 'never':  never seal system mappings.
> > > +                     - 'always': always seal system mappings.
> > > +                     If not specified or invalid, default is the KCO=
NFIG value.
> > > +                     This option has no effect if CONFIG_64BIT=3Dn
> > > +
> >
> > Any reason for "always"/"never" instead of the more traditional y/n
> > enabled/disabled, etc?
> >
> Yes. I like to leave room for  future extension, in case someone ever
> needs a prctl for pre-process opt-in, e.g.
> Format:{never|prctl|always}
>
I copied the pattern from:

        proc_mem.force_override=3D [KNL]
                        Format: {always | ptrace | never}


> > Otherwise, this all makes sense to me.
> >
> > --
> > Kees Cook
