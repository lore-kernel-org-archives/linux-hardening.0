Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF41F2390
	for <linux-hardening@vger.kernel.org>; Wed, 11 Dec 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957221; cv=none; b=NKj/GSn1rS6vbhB8kdzZ+LttNHSMXQiHtrW5kAVXstF5jUr5JPxJ3Gx5J6WnA2kUhUac39JmSA6xadQN7lBcu4X3PbTzbAlGTONm0gfhFsNeCrD89Yet2OlXIflFXzbTQr7QVzaU4iil3OReccd2I7IAdQDetb2tdJpxjRQYgrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957221; c=relaxed/simple;
	bh=MUeOcweFsS8Pfn+9wMD7kP0CT49piC/TvWQQMjPg/qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlgABTeNnLfMnJKZEghNdonLg/o70exXagtueujSQfYPEBVC6ni6VdmoVzAI9GfE6pYI7hHdOzDzJf2gRbZYTnIqVhbo7hQdcprjKXXFcN0ozeF0Id+9FCk0cY4kk4rvrARbxOeluGC/9D7rsfFyjxvLB+CEKD8iXdvKvG7/Nfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dW0Xyfpw; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dW0Xyfpw"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-268d0979e90so737301fac.3
        for <linux-hardening@vger.kernel.org>; Wed, 11 Dec 2024 14:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733957219; x=1734562019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95t+hQrjG4o8vA5zoKM7vBXIQf303T8EyerxMKuzCW0=;
        b=dW0XyfpwLFCaMqU80wexhQmJGtEBOxdUP783RpOF+l715Ti9ccYSUhUVLSmvbmOETC
         cfHURi76bAmYRBnhmj6g5UZ9U2gj2UMwtIIPfc7LOnLW185JL0GRbWsp0dHyBLeK7waQ
         su8Xihkun3sCLktdfl33N2NM7+lerbWxe/GGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957219; x=1734562019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95t+hQrjG4o8vA5zoKM7vBXIQf303T8EyerxMKuzCW0=;
        b=sYTnVNDLsAbYyJywD0FpntQZyB7mLgIE40pdR3ZAr83L31wJXNU1v9QB9RocU4E4EK
         LMumbAwSTwVbwbaGidbGJrCY8Mb4VpK+g65rUXodnbrV+3UdCA4oBrmp+sHPkZGKd/gL
         POXvbVwdHayDqVei2SCo2a7aXWFjD72NOtwFwSIbeJPqaV9ALXV/GPq9MJ8KfW58y7yR
         QPJDig+s22SBkTa3L8bREU6E+LzRD3i20XMnMs03lZpB7MaVeN/n/38xtBbnrwMTtPjR
         NPBStXGLQwpCdPw7PMcJHQqm5FmPiKvGmOdQ6eQcBc+AypNsIvaOA43zCrg5SlF3aCtY
         I/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIfcjNe5cg9VR/t9ojACZAXPHNA5+8cMysFRCwzjtzAD6OB1YaiEUhrghJugB8UGY32VCSN1N06BMpds33Sq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRyHPAbOhOApnfumeIPIx95WGvXA0tS5viUFtVt3Twj615QdS
	uI4T+1ba87NnqVxmfz/tP+BZEULc/1kVKxSLGvXVXIxzOjwsk3a8+9xVwuSnVk76U1dEWEXQY0U
	m3z6l+DUy6R01WQXkhEO8U5GnUeXsXMQqT4Bp
X-Gm-Gg: ASbGnctUqzVzD0yDzNTbInK0StalHhRBo+HNWCJUe/TBqmmOQg6h/9ubt73wURyUNEq
	fMjpRc0OyPa4Lxk7vPT/+8J7VBjPMkCncpFYECQsD91sxYaeteRiiP+ByCLjxdDIUuf4U
X-Google-Smtp-Source: AGHT+IGGAl854VSncgoC5QYcMwCe/wplU8p9SZbZDX9VPPxk/mMJOrsZauN7UyHwuYU9Xy+TkG+mx2GwsIIFItQ6pkA=
X-Received: by 2002:a05:6870:40c7:b0:277:e512:f280 with SMTP id
 586e51a60fabf-2a012d2c8d2mr906248fac.3.1733957219184; Wed, 11 Dec 2024
 14:46:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <CANaxB-wvHERPBu+17b5GP3pVv7pC8J0dkK9MUG1tSir4PQx=ZQ@mail.gmail.com>
In-Reply-To: <CANaxB-wvHERPBu+17b5GP3pVv7pC8J0dkK9MUG1tSir4PQx=ZQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 11 Dec 2024 14:46:46 -0800
Message-ID: <CABi2SkXgZfTvyPX_rcb8KTKyeHxpZrL9_2Wr+vJ1q3K3_1rwoQ@mail.gmail.com>
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

Thanks for your email.
I was hoping to get some feedback from CRIU devs, and happy to see you
reaching out..

On Mon, Dec 9, 2024 at 8:12=E2=80=AFPM Andrei Vagin <avagin@gmail.com> wrot=
e:
>
> On Mon, Nov 25, 2024 at 12:49=E2=80=AFPM <jeffxu@chromium.org> wrote:
> >
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
> ...
> >
> > +config SEAL_SYSTEM_MAPPINGS
> > +       bool "seal system mappings"
> > +       default n
> > +       depends on 64BIT
> > +       depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > +       depends on !CHECKPOINT_RESTORE
>
> Hi Jeff,
>
> I like the idea of this patchset, but I don=E2=80=99t like the idea of
> forcing users to choose between this security feature and
> checkpoint/restore functionality. We need to explore ways to make this
> feature work with checkpoint/restore. Relying on CAP_CHECKPOINT_RESTORE
> is the obvious approach.
>
I agree that forcing users to choose isn't ideal. I'd prefer a
solution where both approaches can be used in some way, depending on
the situation and distributions. Hopefully, with input from CRIU
developers, this can be achieved.

However, it makes sense to unconditionally seal vdso/vvar for systems
like ChromeOS and Android that don't currently use CRIU, so we will
need a KCONFIG for that.

> CRIU just needs to move these mappings, and it doesn't need to change
> their properties or modify their contents. With that in mind, here are
That is an important detail to know, thanks for bringing it up.

> two options:
> * Allow moving sealed mappings for processes with CAP_CHECKPOINT_RESTORE.
We could try to propose this under a new KCONFIG, e.g.
CONFIG_SEAL_SYSTEM_MAPPING_WITH_CAP_CHECK

IIUC, You propose allowing userspace mremap vdso if the process has
CAP_CHECKPOINT_RESTORE. However, I believe this approach raises
security concerns. During the RFC  for mseal, initially, I suggested
sealing mmap, mremap, and munmap individually, but Linus rejected this
proposal, for a good reason, mremap could leave an empty hole in the
address space, thus allowing the attacker to fill it with attacker
controlled content.

Furthermore, CAP_SYSTEM_ADMIN allows setting any capacity,  so this
would become a by-pass for sealing.

> * Allow temporarily "unsealing" mappings for processes with
>   CAP_CHECKPOINT_RESTORE. CRIU could unseal mappings, move them, and
>   then seal them back.
>
We could also try to propose this under CONFIG_SEAL_SYSTEM_MAPPING_FOR_CRIU=
.

It's important to note that temporarily unsealing a mapping from
userspace is not permitted. If a mapping has the capability to be
unsealed, it fundamentally does not provide the sealing property.

Perhaps the intention was for these steps to be carried out within the
kernel? e.g. the userspace could instruct the kernel to relocate the
vdso mapping. Since the kernel can ensure the vdso contents are not
manipulated by an attacker, this approach could offer a viable
solution.

I have been thinking of other alternatives, but those would require
more understanding on CRIU use cases.
One of my questions is: Would CRIU target an individual process? or
entire systems?

If it is an individual process, we could use prctl to opt-in/opt-out
certain processes. There could be two alternatives.
1> Opt-in solution: process must set prctl.seal_criu_mapping, this
needs to be set before execve() because sealing is applied at execve()
call.
2> opt-out solution: The system will by default seal all of the system
mappings, but individual processes can opt-out by setting
prctl.not_seal_criu_mappings. This also needs to be set before
execve() call.

For both cases, we will want to identify what type of mapping CRIU
cares about, i.e. maybe CRIU doesn't care about uprobe and vsyscall ?
and only care about vdso/vvar/sigpage ?

> Another approach might be to make this feature configurable on a
> per-process basis (e.g., via prctl). Once enabled for a process, it
> would be inherited by all its children. It can't be disabled unless a
> process has CAP_CHECKPOINT_RESTORE.
>
> I've added Mike, Dima, and Alex to the thread. They might have
> other ideas.
>
Thanks. Please feel free to chime in, I will also add Mike,Dima and
Alex to the new version of this series as well.

Thanks!
-Jeff



> Thanks,
> Andrei
