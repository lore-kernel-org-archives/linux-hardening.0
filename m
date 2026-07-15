Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A4545039
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073754; cv=pass; b=nOxE4Wi2GK+G8tWgxoEGabhBhcs75N6nub8R0Hmq/4pAUAZ5N0g+XyIO/uRzjWR9x30yPOp6/7fR33fNrWzTYdVznwPupl1weLlzypvQNlw2zWjAX9A+1/wBJFShvxnLerOqylpSM5lVFwSIJiVsa5hpRHo5yRouER7VcsnjBdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073754; c=relaxed/simple;
	bh=h+FfThwhAtsKLjTsiDbJn8yrjEOO6qbw5Lehz7z8BF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVMVN+CZ9SU1fkilxwW4azpXgu6N1VW5x23v/3CWb5zzjZkAPYX5R9nqSNhcqnnmBsIcj/DOB7oM4PVxj2TdocvN8fl/de3YKNz/VlCLd04TetLnV129CJeCnr2Nsna24AaWHuQD2V6ZhL2GdDJIPjuQCflRf33E3/jNyjp/XRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=F/kK9AfI; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="F/kK9AfI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1675392a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 17:02:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784073752; cv=none;
        d=google.com; s=arc-20260327;
        b=WoclAcyu8eFaqKpE4LSPmxwwfbwGfgB8W/kDMtwhGBzV8IlBJihGfx7x5Nt4pe4lp6
         nmj9fQoPHGv0GpTLHbLF1JPqrkJ8vBk3jQHFASuixNGchH0jZxmL686EMouKAPVPUuFm
         BN33ZSFVge1owsq+Tlqs7JOiAhpuh7Tczdr5SGNODdqUWi/iOK3TgttnjeC3lQdL2h/J
         t8bTV2PMvW1qFGkaarg1SHla/1K+665seAL/P9YF9eANuPs9qRiRVwJ7DD6EF9fkAcJ/
         EUkmZY7giW6BpG78J37CWtpLMhg7+Gi5FhK5MEgG4RoMuMLbkJAa0GUJMtOG2xG+GNjn
         D/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UnuTjnmFgMfuo6740K3Eupo1lRWLWkcBXrjIjKbCV6Y=;
        fh=RKa9B4wbxaewxjD1zxdV2DWfrJ6p+3UKHMIi20Jk18c=;
        b=f9o2YEg3yQOgLdHD3FBQZKB2WPHocO7F6Q3L+ugNAUgbXCIj7UClTBi9glzmUZE8tC
         AxVKMtTyz200Xst8Zs1TDr6th4KSmwkh7eopkPR2MXlYzQo9C70gV0Y8EuoPOsS1HLxE
         Y/9y7yBZjvcWW1VuUpXpFCnTzR7sQyvX3BoAuAOO2SSVh1AoaJfu5jAKBGS9y6GVy6EV
         iz6+GCf8EOfqh7Te1kWXu7xqtG6RR7EWvfyWJKePS5BnFH7r+XfiMNtTTolFUXQka7ED
         i+5Xfq8n7pp4QIA2Sx53TL+cJqjQ/tlHL5GieLBgZWHJYVQLJl9JY41XsEvsgG/sCWcj
         hE8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784073752; x=1784678552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UnuTjnmFgMfuo6740K3Eupo1lRWLWkcBXrjIjKbCV6Y=;
        b=F/kK9AfI6vcRzpxycO2Wvfng06ZYk5cYEBGtI9uEeOFrR1P/j5IC5SlUIAQJLZcYJh
         6AFx/y28yX8TOwo787sxZOmYnTigdNrd+ZEKKHHaWKW4fuJAzJoxdlpOyF7m6lxQYxrx
         vMpTJIHt6gRWzyr05dXyTIGJKR+gn78fmye/wfdw9FO87vAbjpUZgwjqQtCkF60E7X30
         mduuMbvwTcu1/kSc7Z2PoMs1wB3XO1z3xCuVPG5OWiAqL/tu6uimDL+ZYs7md1zBw6e/
         5y8gGg94xTPOcitj5OEf1zvRS7zFdCeSJwfdiNUrDWvDMY9RFyAUn0aHn3rNjeo80LHW
         u6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073752; x=1784678552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnuTjnmFgMfuo6740K3Eupo1lRWLWkcBXrjIjKbCV6Y=;
        b=R8u37xrr4izQbmrs7raCfUtywLjQa4TLE+s26UqxjNsXldOV9vU+g0AOgWm7baWsKY
         QmHBWThj1sBte30ztrZTDygznulwKbIJqtPAaILFTfy5SiqvvTjgO9WoLu0wPNIArcEF
         8iQDv9ZWEW1lz/asweV7u2hAlrPqW+/oslSv66LeNWLE1VClh+hGo/StzUP+AdeGJtlG
         q9Qo9Oc1cjT2oTAXIVsYHDQI41lge7iq7SZIS1a6lFPbaVbZR6ff2Z3tYL1jLNey9MCZ
         aAyW84cdt3pUkGZRMcHFTvsLWAub6/o1OFmso583PsqqbMND6BD9M40yoeIz1HzfY95r
         5Ahw==
X-Forwarded-Encrypted: i=1; AHgh+RpfpXghvxHp5vO4QZvrYIaZFlDxC3D/7s3kkxmDwlUdCQ2dD4Dch00R2Oet7F2drDNQl9V/hr3jlGYY/dGysUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYy9iHkjf8lsqwjoVwzBwJuRUouvenInu31gBW2CFyVaD34gu
	9wJQSwUAhnv/6mL34DEFEz/gY3QaZaqaOuPGoJDiC5ME31/gpAOQCukMyA/6kylJprBPZ5V9fbi
	eTta9zut2MW6QOcWPD5Gy0SvWFDadm1d0ycAGYqda
X-Gm-Gg: AfdE7cmgP/FIFx6uWUdTLT1hwmrPX8Mt7JQS9XX3c7lMA7bEaenZrT/asxp9VX/QVWj
	1bEJ4HvaCJ70ygA6at3lR8f1rJGuROpyFXc+4aSgqnPbF9YRq/x7aKnBF/muoWzkhlzHI2AIvL2
	l68/ilq6l+0DQC+o60JQPLjFm355r1+IgvzNSuZeReXRP4U5++LT0two9x9SfYADW7Ua4VSO3TW
	F10H97pK5f0v38dWCBVL5l2CY2XRLsSV4/vrvIPc9X20FGz6vwNu6FRSfyhnBv+G6UcTDap
X-Received: by 2002:a17:90a:d888:b0:38d:e442:901e with SMTP id
 98e67ed59e1d1-38de4429227mr11151009a91.27.1784073752604; Tue, 14 Jul 2026
 17:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709211130.543773-1-xmei5@asu.edu> <20260709211130.543773-2-xmei5@asu.edu>
 <CAJnrk1Zek9hHOehCjfmR42+Gc=K6vixmyn5977ZHv3J5fUUS_A@mail.gmail.com>
In-Reply-To: <CAJnrk1Zek9hHOehCjfmR42+Gc=K6vixmyn5977ZHv3J5fUUS_A@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 14 Jul 2026 17:02:21 -0700
X-Gm-Features: AUfX_mzd0bNUZ1WrqBewM4QFIpp6lYAazaXnydYq8-EXrZeSN8zxpdJ6-98A3gA
Message-ID: <CAPpSM+QQ0BRuVizUePYBj9+UJC0Sxsg1RpEa_u1woShg-TkRhg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fuse: bound io-uring payload copies to the
 registered buffer size
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:24=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Thu, Jul 9, 2026 at 2:11=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > The fuse-io-uring transport imports each ring entry's payload buffer at
> > ring->max_payload_sz and bounds both copy directions against that value=
,
> > ignoring the buffer length the server actually registered.  Both the
> > server-supplied reply payload_sz (fuse_uring_copy_from_ring) and an
> > oversized request payload such as a large FUSE_SETXATTR value
> > (fuse_uring_args_to_ring) can then overrun the imported iterator and hi=
t
> > fuse_copy_fill()'s BUG_ON(!err):
> >
> >   kernel BUG at fs/fuse/dev.c:1053!
> >   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >   RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1022)
> >   Call Trace:
> >    fuse_copy_args (fs/fuse/dev.c:1329 fs/fuse/dev.c:1351)
> >    fuse_uring_copy_from_ring (fs/fuse/dev_uring.c:686)
> >    fuse_uring_cmd (fs/fuse/dev_uring.c:1226)
> >    io_uring_cmd (io_uring/uring_cmd.c:271)
> >    __io_issue_sqe (io_uring/io_uring.c:1395)
> >    io_issue_sqe (io_uring/io_uring.c:1418)
> >    io_submit_sqes (io_uring/io_uring.c:1649 io_uring/io_uring.c:1934 io=
_uring/io_uring.c:2057)
> >    __do_sys_io_uring_enter (io_uring/io_uring.c:2646)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall=
_64.c:94)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >
> > The request path overruns the same way, via fuse_copy_args() ->
> > fuse_uring_args_to_ring().
> >
> > Store the registered payload length (payload->iov_len) in the ring entr=
y
> > and use it for the import and both bounds checks, so the buffer the
> > server provided is honoured and an oversized reply/request is rejected
> > (-EINVAL for a reply, and -E2BIG/-EIO for a request, matching
> > fuse_dev_do_read()) instead of panicking.
> >
> > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v3: propose the patch fixing another issue found by Bernd by Joanne sug=
gested way
> >
> >  fs/fuse/dev_uring.c   | 9 ++++++++-
> >  fs/fuse/dev_uring_i.h | 1 +
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 0814681eb04b..248e5a3e340e 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -650,7 +650,7 @@ static int setup_fuse_copy_state(struct fuse_copy_s=
tate *cs,
> >  {
> >         int err;
> >
> > -       err =3D import_ubuf(dir, ent->payload, ring->max_payload_sz, it=
er);
> > +       err =3D import_ubuf(dir, ent->payload, ent->payload_sz, iter);
> >         if (err) {
> >                 pr_info_ratelimited("fuse: Import of user buffer failed=
\n");
> >                 return err;
> > @@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ri=
ng *ring,
> >         if (err)
> >                 return err;
> >
> > +       if (ring_in_out.payload_sz > ent->payload_sz)
> > +               return -EINVAL;
> > +
> >         err =3D setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE,=
 &iter);
> >         if (err)
> >                 return err;
> > @@ -725,6 +728,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring=
 *ring, struct fuse_req *req,
> >                 num_args--;
> >         }
> >
> > +       if (fuse_len_args(num_args, (struct fuse_arg *)in_args) > ent->=
payload_sz)
> > +               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EI=
O;
>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Not saying you have to do this, but if you wanted to, I think it'd be
> nice to have a separate cleanup patch that deduplicates this setxattr
> special casing logic between the /dev/fuse path and here.
>
> Thanks,
> Joanne

Thanks for your review. I updated my 1/2 to make it an elegant patch
and added your suggested cleanup as 3/3.
1/3: drop previous tags; reserve the fields for user copy
https://lore.kernel.org/fuse-devel/20260714235408.1666063-1-xmei5@asu.edu/T=
/#t
2/3: no change
https://lore.kernel.org/fuse-devel/20260714235408.1666063-2-xmei5@asu.edu/T=
/#t
3/3: add a helper to return the correct error code
https://lore.kernel.org/fuse-devel/20260714235408.1666063-3-xmei5@asu.edu/T=
/#t

Xiang
