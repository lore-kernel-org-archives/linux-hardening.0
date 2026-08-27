Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8185E3876D7
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 04:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804318; cv=pass; b=rRoyYG1JuRTMOi8bDgXzkxSdB0uht7b5qaLZOiAvLipje5iXUmptmgtgANR2I3bvCsNXY/RIRbbAFnIqZIXD1b+t+qJJsEvB60nXI5h8Wwm8V/Q/jFS/C1L3SOnOe3ajEQt2R2+vVxnxKFaQhzIhro/emEVUNifK9lnw7cB4oU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804318; c=relaxed/simple;
	bh=vAkpENEL+aCJBuN6dUSQpHeziG23/MMgcrkzCZbrvzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVoH8GPJMPPOoEEG3EZ7m4xnf7/o9Z3K3TFIXVEIKpWRPPPAX1/bZZZgcFo5NOXnJVEztOFSjuE8yUOc6y1DOBf6PQtnTCKprKnmrEo4kcQS+2CrYbSZZm7AvkSeGhoynLEeOUuYO3WKViHs9nfwmPv1T1h6xV8PltqV1z2AO0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqajruhA; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqajruhA"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-97bf8f10ebfso984019241.0
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 21:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787804315; cv=none;
        d=google.com; s=arc-20260327;
        b=VTixwSA3+jWGH2xb+YcWaHbBZHHpo1CSxZXrN01LbkWm/mk6fqxKhK6BqLOPaav2Yv
         BOE35DxIcW/sjA9x8DvdN9eTK3M101J+n/mrnL5nfwlFI70NJ8xYMupedmwgkqG774jz
         F1WqOICO/sRzzNZM7V/YKhMGpEfiCVIeAVKTUMcvRyXaZGwnih39RtQrc89vowJWcZVS
         uK+YCY119MrmPxHEov16vtfytdDDR0PHb8NluZQwDNfTwnyWR/ZrgtPIC8T9vr1J80RQ
         R5m9hPr/ZmnuusW2XSMg+cheO6bdLkrWitI/Kx38Ax6b14Vv8HZkhCElTB80tyJKsdtV
         fkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tdkvt93wxjyIEopPoQNCDcgWpKE+IyMU/m+EhcZoeq8=;
        fh=UaEmLdqdZR8RGDiGRN9Fl/MWb4A3ITtPP6zhTPF8WGo=;
        b=lPNoWUm01U1EyNGVEi827lYp1oh+v+VjfCSX5etrxhuH5D5dlvjBvbSqphb5TbmLXN
         9psk5dpnhpu/w0V+CH24N+EasGgrHenE6mI0ZAu62qC6Jw+CAFVeMdh48fhUQmkcVM23
         2PEDG1I1G+FHy6i3nszsyOA0B6IYejjH6c8AAKZEeRTimCIYe4fCnsZh+x1udNyez7Nm
         pGIAztr49fXfRoNCdV18vbC9a/nT4cH0GMwPeV/kOmyZaEF2AHAdC7rQWgHPyZK0Huz3
         1gKZZzpRfrt9+H4Vsl9Yr0cT++wzIjSEvM81Y9oyszFGNoMJLRxcme/xzj4Eg7ZecEAM
         AkiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787804315; x=1788409115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tdkvt93wxjyIEopPoQNCDcgWpKE+IyMU/m+EhcZoeq8=;
        b=ZqajruhAAWYYYQhMXzyhdyG+si8j3ZjzLPNpHv2Gym4Qzb8APtcj1L1VHDVXvgdJ7Z
         kY6lKx6FDw9/o9EqV4eQKJ/C2P0LoaI9Nk7dGd69MxwbCvfvv84f7Y9UTguNRjdC53p5
         RnGJL1uNIbZomZJNDlG7VTtG0B64QV2rqcfMstCAhaQO/4URwy76MncEmbn/tuX5peNw
         aix2Mm9S18vsUK+cvCkGffXpYkz2Y+Tvd9jzTb3E15cQP0htXsfaMrwJuCVMu5fbP9ID
         ae0Xm4S5GGm+KJ7VKOKyXeqmbfsH+ngbI5ztE4mhpihqoFoQHu3p7015mqVQrNtmdIo9
         Rb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787804315; x=1788409115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tdkvt93wxjyIEopPoQNCDcgWpKE+IyMU/m+EhcZoeq8=;
        b=lnLh62YX+EmWDnhvha5ZZXMvKtGU6EyU7T4XmP3UXUj1kDoHYTxrmutTBZKdLEN6G7
         4vn4irwTZ5eQw7cdAf6msODQYGeV3kfDh0HqBnbDfzWZf3Y7czPqNOeIz+Lns17pVpuO
         phV7cXUS0tlz042xb2O5DmaB5TweDi6KlMUjqVExbyC+P/ha/5vQCwyyGBMaqHSpSKfR
         C99ylfuzHHqgTdlUlY12vJpjmTGy0LnkocEQ+COWRoJCioFMYE5uk1AzSJ45f4buwlzh
         UMbOd6zr0tjVrU1MrUi12amaDYllPr0Npyje7+bbzTx4pOIyAt5lyj+hVME8dMpaRWqe
         aftA==
X-Forwarded-Encrypted: i=1; AHgh+RqtBUqxAWM941ZFYrpE+nOSzBujWtlMfDCxa0UsT8lkcmBbWQI4XXxZ8d5Pkr7u+db/HVwZdJEU9W0lbeaIGaA=@vger.kernel.org
X-Gm-Message-State: AFuF++lsgCvzQfqzy/RKXRT9xA84h5SIuIc5fmTmgKRECTCjhPE09qtQ
	mI3A+5EPp/8DqMI8DCprHO0OO4vKusHfdxUy58iZk+A6uyu7LDXNtqOp2bLn6vcaPodezsdXHc4
	dH+ItFZwTkBd24h5uzHLvv+TI9TVz4r3YQxJCTqWRYj34BRQxrxGvDNo=
X-Gm-Gg: AR+sD133cvnCpGfBu6PcCVIngTVRR5sfrsLdvrUzAOsUk1PbjeW0khh8DE4owxIwKJ4
	Wyy+mqdNri/5L0oi5wfKZrjwQ47sffJ+EJgoh5jk3fjFWw9SLyrF8uTVFxhEQOXoOoBKc5KJPnj
	GXvPbsOrRVFtQI+hoISohh50nPtD8pTSXFMVReF4VwAJ5dJlNus6d4vc2Nmrdsb/YQNxHBVJ3LS
	/+HMuXmnP4EC3K8AK4EeXjtbp/a7dT0jEDZfe6SFW8+UIu7gT/DoESv993lL4SBU01klWBv+2H1
	ANpWgfOWh12ajn9l02Ik2Aee2E6sdWMmFGGk3KmGlcc7O1INZHNEVQNbTj7LuV2EVKJq/AXtb4A
	de7jVCWlf+A==
X-Received: by 2002:a05:6102:848e:10b0:783:cba3:cf0c with SMTP id
 ada2fe7eead31-783cba3f1f3mr1743406137.6.1787804314889; Wed, 26 Aug 2026
 21:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com> <20260810204118.1981755-2-morbo@google.com>
 <202608101716.FB6205EA50@keescook>
In-Reply-To: <202608101716.FB6205EA50@keescook>
From: Bill Wendling <morbo@google.com>
Date: Wed, 26 Aug 2026 21:18:18 -0700
X-Gm-Features: AcwNN1VUOYfbScz7X7OOfAgR-_09E5r2bsRAMzD6g11t2BR6ucealC6FacdfVSY
Message-ID: <CAGG=3QWmzsUtO2NMy4d_=qpyEfmeaojt8mjZh63V4Ep5vGLmMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: Annotate struct fdtable's fd field with __counted_by_ptr
To: Kees Cook <kees@kernel.org>
Cc: codemender-patching+linux@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 5:18=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Aug 10, 2026 at 08:41:12PM +0000, Bill Wendling wrote:
> > The 'struct fdtable' holds the file descriptor table information,
> > including the current file descriptor array 'fd' and its size 'max_fds'=
.
> > To harden the kernel against out-of-bounds accesses, we can annotate th=
e
> > 'fd' pointer field with the '__counted_by_ptr' attribute, referencing
> > 'max_fds'.
> >
> > The compiler uses the '__counted_by_ptr' attribute to track the
> > size of the memory allocated for the pointer field, enabling
> > runtime bounds checks under KASAN and fortified functions. There are
> > three places where a 'struct fdtable' is initialized, and in all of
> > them, 'max_fds' is set before the 'fd' pointer is accessed or assigned
> > in all allocation and initialization places.
> >
> > No accesses to 'fd' occur before 'max_fds' is set, preventing any
> > potential runtime false-positives or panics due to uninitialized count
> > fields.
> >
> > This patch was generated by CodeMender and checked by submitter.
> >
> > Cc: codemender-patching+linux@google.com
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  include/linux/fdtable.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> > index c45306a9f007..3a5c88291125 100644
> > --- a/include/linux/fdtable.h
> > +++ b/include/linux/fdtable.h
> > @@ -25,7 +25,7 @@
> >
> >  struct fdtable {
> >       unsigned int max_fds;
> > -     struct file __rcu **fd;      /* current fd array */
> > +     struct file __rcu **fd __counted_by_ptr(max_fds);      /* current=
 fd array */
> >       unsigned long *close_on_exec;
> >       unsigned long *open_fds;
> >       unsigned long *full_fds_bits;
>
> I see the alloc_fdtable test, that's one max_fds assignment, but I also
> see dup_fd(), which does the assignment after the newf allocation, so
> that looks safe too, but it might be nice to add that allocation path to
> the tests too?
>
Hi Kees,

I added a testcase for the 'dup_fd' path.

-bw
