Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78D18732A
	for <linux-hardening@vger.kernel.org>; Wed, 16 Oct 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116384; cv=none; b=afdy+m1mF8rrO3ihK3bpR9KSZI1sVD5HFI0M08vUL1JjX62st5rigpOCwTxfQ/N5UdeTv5s3/DveOAyUJL2rV9/GuJmUTG4t8IVli+jiPA/UeYG3HFf4YBKP8b64Dg1+qMZsVV2KTSPZF/pFasNI/6/jmq1I9GVvGGLEzgZmEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116384; c=relaxed/simple;
	bh=9z9XLQJrLQVtIR/5T/wjdf4LyvHylSASgTUT1DwjjG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apkBptLBQjgHTo449A6X3IqFKztOzoiyzbOZoPcSTgVKprvY1AjDQyG96xZhHtMkVqQH48EkBX4aUws37b9i8QSydCcH5EScinP+C+hl8mUBlMZdaMocErdHp02AxWFr8iP+0FiLyqVmYCPoMwJoZRQNGwDBDn+PPDENq3hrPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bFn/q6Dy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bFn/q6Dy"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c933d5bdf1so50791a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Oct 2024 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729116381; x=1729721181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVn1K517MAjCXR8P0mvWMgPXqBdZpbwDnil5HsjO5Jg=;
        b=bFn/q6Dyr52mw+UeMGlMgUmQiuBnA7Gdos7EgCjhI3i561k6SmCkt4xa6GQYSn7h0A
         MNc8psRNZYwtNm0UkuU7l//pPhDEdOQ3sSB5gLO9LgXYyTxP8JCoHHSkEG8G40Ufwr6f
         ThjjgVFd+lzSPfzApan8cY+CtOTmwg7AljnGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116381; x=1729721181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVn1K517MAjCXR8P0mvWMgPXqBdZpbwDnil5HsjO5Jg=;
        b=IzhWnYAP4czUz8L/ve8OH/XOnzjKKK/1v9Ap4Fp4vGSw7dt2P7ov0qoQ92YkIraRan
         kFQ2cPjYZavYNwvlD05VhU/7n8fv4KA5RSNY30rdhJocO3Y6nJibb3HQBCT3KyGKMzNn
         cVk1b068nG0MWGvX2YLPA88anwkfUbvR2esgQPO53izt90JbIxySFopwDMxdNIZZvKlw
         9z+bZBNP7m9TMene/eEJFaiDXKgltSYiJlQyxmpKGUJQdFUimdv2FgSXikQuAe99Wss+
         ZHvHc6+pC2EcLzdUBn1hKbwWPhAnzgzOTif6nqp4Omhn/aM3s4XOzLXDcynu/v5JXj6v
         rwVg==
X-Forwarded-Encrypted: i=1; AJvYcCU/hGTgisEZMVFzPXyzhcr6AFxk84D4JrOfWN3Tj4GnybfoLTgc66SdAxvUOLmUOsqaZds1rKNWT2nbWGZy1KI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw9DcXASAaSJoyweYa/XhNkNK72goj4/DgRuTpy5mKV1H8TvO9
	xRwHbnfDwtRtILbOdiUtF9n8f0qRrhXq4/3zd/HVHkSUHcs1+PIl2Bnn06ZXwEV4aXV+P5PmQhl
	OYvv3NR1V053lH0kAFB5L461SuSKwqIoXhOhS
X-Google-Smtp-Source: AGHT+IFux0KGOB5OrxvTmpIOCJi7nqCbOOzCsZCtqUl4EdsEpk7mHjMU3PyF91Eca1JTkFWm3Ub8BbwsnyYuHKor+CM=
X-Received: by 2002:a05:6402:35c3:b0:5c8:8381:c2a0 with SMTP id
 4fb4d7f45d1cf-5c9a5e39d63mr247360a12.2.1729116380681; Wed, 16 Oct 2024
 15:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014215022.68530-1-jeffxu@google.com> <20241014215022.68530-2-jeffxu@google.com>
 <202410161424.FA6DBA7D91@keescook>
In-Reply-To: <202410161424.FA6DBA7D91@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 16 Oct 2024 15:06:06 -0700
Message-ID: <CABi2SkXKWGuvttUWHH+CL-MnKDvF=o6i2nGz55r+-6WvSJex5Q@mail.gmail.com>
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

On Wed, Oct 16, 2024 at 2:26=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> (I don't think this needs "RFC" any more)
>
> On Mon, Oct 14, 2024 at 09:50:20PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing during the life time of the process. For
> > complete descriptions of memory sealing, please see mseal.rst [1].
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization. These mappings
> > are designated as non-writable, and sealing them will prevent them
> > from ever becoming writeable.
> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [2], thus sealable.
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
> > been introduced to enable or disable this functionality. Note, uprobe
> > is always sealed and not controlled by this kernel configuration.
> >
> > [1] Documentation/userspace-api/mseal.rst
> > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkR=
kL-NrCZxYAyg@mail.gmail.com/
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 10 ++++
> >  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
> >  fs/exec.c                                     | 53 +++++++++++++++++++
> >  include/linux/fs.h                            |  1 +
> >  kernel/events/uprobes.c                       |  2 +-
> >  mm/mmap.c                                     |  1 +
> >  security/Kconfig                              | 26 +++++++++
> >  7 files changed, 99 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index e7bfe1bde49e..02e5eb23d76f 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1538,6 +1538,16 @@
> >                       Permit 'security.evm' to be updated regardless of
> >                       current integrity status.
> >
> > +     exec.seal_system_mappings =3D [KNL]
> > +                     Format: { never | always }
> > +                     Seal system mappings: vdso, vvar, sigpage, uprobe=
s,
> > +                     vsyscall.
> > +                     This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPIN=
GS_*
> > +                     - 'never':  never seal system mappings.
> > +                     - 'always': always seal system mappings.
> > +                     If not specified or invalid, default is the KCONF=
IG value.
> > +                     This option has no effect if CONFIG_64BIT=3Dn
> > +
>
> Any reason for "always"/"never" instead of the more traditional y/n
> enabled/disabled, etc?
>
Yes. I like to leave room for  future extension, in case someone ever
needs a prctl for pre-process opt-in, e.g.
Format:{never|prctl|always}

> Otherwise, this all makes sense to me.
>
> --
> Kees Cook
