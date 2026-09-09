Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736723A1E8C
	for <linux-hardening@vger.kernel.org>; Wed,  9 Sep 2026 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981604; cv=pass; b=UnS1Evmc05X6PJLQ1jHAFbXdCBXz9XN8HZcQn29ndFaW2XFfU/p6asPmrXbh7+XMu3U0vt2oiypTZMJdghA2HMqxaaoQ2qhUYeWS26gfxdHBu32Us7fDrhkLtIZ2xfrMnYApMfaQ9HAKwJfbTrZ76GZ9/dZn9ZEqSCotVn8gbBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981604; c=relaxed/simple;
	bh=Ajiydw3L25W781rT08oBIgJWAfLm/lQwQ3vUJDLb5Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qh29/EGwycp+iiop6OzOJLFLAhkESX7M8o+3ZDaGVdpEJR0TqDzzY0cIOfuHQ2MBzqYtKeP3JHq6zUj55CeYuBdQlkedHO2y8tPBBN3ajKe/MSiRB3T+GVRw8Sb/cH0FMR2knuxP4z1CKm2OvY3ravv8q96Syaxhu/mNRRUDutk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mcz+yyym; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mcz+yyym"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-482e257a23aso4236159f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 09 Sep 2026 12:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788981601; cv=none;
        d=google.com; s=arc-20260327;
        b=UyO4/AhYW+C7YhuyVyjne8TpbU3iYJXbzaTnSrv5Iq0fh+ieJMTaNQXWmwu3zyUI22
         YcU9gxjZBQz0bdNraPB/5KfaxsJ3cZYBjMNOTBzrl/JY/09AY4NcCQtrMJfNe42Y1PNo
         /Gwx9Q0A0FSYaBk2gLJfoQ7aMv/6OGiMKVe+0ofK/5dJ57Cnaahtg5CzNLfpFfvouz5l
         N2XK5sUE54zmKX6IpvieUflxu4vsWryEGcmL366Tfp4I/4wIFgjOsaJ6U/bCM0Q+VcJg
         Ih3KqdkET1PGRJRVoBTT1BSQ9CriJ8nijH/doG+JMd2JJuUFy1gtObMS0Xe31reMn8f7
         Ntlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5FRm+Wk/CzcgkkZNM6le/ovLDE/1ge45ZLQJ5VGLwHc=;
        fh=DuOoRLCQMc8la6kYsYF9pPmgctyzRDAqtSEMXK6LNMw=;
        b=AJBkULEjLfmVUx3iIMJPhXIPN4VFiQSY/Y9Tk18FH+CWDXOTfO1qhj7uo5Ff6wBngy
         5wdG2BE85w5fWOc6XEMpUhNxxAtG1aCa0+7lxznVN3m+9rCOKYNV6bCS/6UicwI/NfGg
         sloYENqpdgEFsRuAtvpSRx5N95N5ehlU+1tBuVMrnm+rY8q4/WZsbXdjLln7mgUCmKI7
         ggvFMRhCnkESitC69hDEyYzNEa5TQrHg1rZ4tYd1rYA9fqD670ocY13fl1Xyipjdwtdu
         qtetUBwZ5tBMGtSbhsxhXMnUMyLwW5ytZCePdGTIwLrm05Y3QCR2/OXBKBNaaXSCy564
         V73A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981601; x=1789586401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5FRm+Wk/CzcgkkZNM6le/ovLDE/1ge45ZLQJ5VGLwHc=;
        b=Mcz+yyymtajFDKDJK/Y42w2jiYBaeGNxNF50vBrQ0l+gnNfMW0J+sioh8S9eHQEyAM
         /J3tVAcv4iadezS1FOpbZyLGgujj3DnG0KPjndUNOetidOXvoYVeEuLjgKAn97956jXD
         n2s+kCFofFWr2k66eOrbE3mAocYTpZPqmx5gtTJgj1T4sUU2Mp1XuuhSrhHhliSUJxnB
         B5jao7RU/xbEfVZFQfCgR9mjEyQ0m2QIWCe4jWf4AFUnhLkKV8feYzSd/ktsZMCMoeE3
         WN8BYBfY0ueUZxWG5OT/BFfX+ypBqsaNSKTPvmd+mLojpL14u3WzGjs6iuZjOFwAiROR
         9WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981601; x=1789586401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FRm+Wk/CzcgkkZNM6le/ovLDE/1ge45ZLQJ5VGLwHc=;
        b=OBTQxLM/j98mzefl4INwxzaLwOtUOhTyXS1O2xy+8Z9LEB7qZSXiInO+X3q83/NbWf
         anZ2DILdxunvTM7fS5BSVoJY4f+eY3BnWx0xtvZRtqwvu780MMHX1/dudHABJk4LbNeS
         FqPvCm6TiP+yeDh4wy/cpO130Db/VfMeCqqFULhMo62kRMGcWelXYJoTU1vfDZhv8zFy
         kYzKvNa0RU6N6CNr8P/Ozr2Nil+MQikQ/TzK9fbEz9vYSrrEE1Pe4vAXsvsUON/Dzyv2
         f01J28sGWrhryH6dLc2JoeGOMU0/NeuX1wSRuutAj7KiAhpVEn+YMEbFKMKIZmcbgXb1
         BSLA==
X-Forwarded-Encrypted: i=1; AKwUvBxd4KoUtOZWASuAlE89Vo6ULV1zz5KqNoCQEdX2key9GVCHYTBNOT2RhvKskAmnWrZlBdcmwf9KSBQzpYKF2ko=@vger.kernel.org
X-Gm-Message-State: AFuF++kjrXCnKDioNg9yzxyj76HxV+HsMNaWnMZULDKH8Du6qRUXPXYq
	14fjCodYlkKfvtdTcEy6p2hurEw+rYghvpLz46/TeJTt72vnYAq2sEMgfa2xn6HLOBZS/QqIy5h
	fFYR9O6gobEUSny4rDPDZ0pb6rFQS3oo=
X-Gm-Gg: AYBFou0vlAGlJsjfr2HBIayM/81WYGC9cvb5r1yFaFzVbvFhoAjRB1jCk5eIvjvlA/z
	tTN3Bc98w3hQ77vO9CUmXGKkX4I9OU0HofEGNDcr6IhtFJGtCxzgyCDshO7HjGRsk8a17W0yE+6
	+WPaXHbqU8TiZJWwZOZSQTyRtGpiztdKnbJaLig7Kb7RoPgKdT25KmMro1c6usgzH2lgWhqIqaH
	3MlfKeow8/N7Ro/PjkKn/VQoWRbmUwbHfP+W21mWYM7rmU6RAP/gTo8lbaIHscJMPwjpUBbztyY
	TmA6Dk6zPpEqiZVMKyvxY9Lzyv4Vd0sfjjlcQR9HWynrudG0l4MRZrQK7qJmI7oehTcEC5YdMk/
	vtr7phmJei+/0wPO86PDx9lwI0S2wlXbRZGP+yJim61QhihmT
X-Received: by 2002:a5d:588b:0:b0:485:ac96:7263 with SMTP id
 ffacd0b85a97d-485ac9673b3mr6592105f8f.12.1788981600320; Wed, 09 Sep 2026
 12:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906012924.1928316-1-xmei5@asu.edu>
In-Reply-To: <20260906012924.1928316-1-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 9 Sep 2026 12:19:47 -0700
X-Gm-Features: AcwNN1UbD6k4LeCepkUvjqBr96R-weQxM4XVCQGN4UqRnGUCJVeyGH44lDLJG20
Message-ID: <CAJnrk1aXL9QuW+USSbx2La9qgNYU8jybqqpoSSRo6wEAAZqxAw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: bound io-uring payload copies to the
 registered buffer size
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 6:29=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> The fuse-io-uring copy paths do not check that the data they copy fits
> in the ring entry's payload buffer.  fuse_uring_copy_from_ring() passes
> the server-supplied payload_sz straight to fuse_copy_out_args(), and
> fuse_uring_args_to_ring() copies the request in-args without comparing
> them against the buffer.  Either can exhaust the imported iterator and
> hit fuse_copy_fill()'s BUG_ON(!err).
>
> An unprivileged user can trigger the request side by mounting a FUSE
> filesystem that registers small payload buffers and then issuing a
> setxattr() whose value exceeds them:
>
>   kernel BUG at fs/fuse/dev.c:1064!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   CPU: 1 UID: 0 PID: 148 Comm: exploit Not tainted 7.3.0-rc1 #2
>   RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1033)
>   Call Trace:
>    <TASK>
>    fuse_copy_args (fs/fuse/dev.c:1354 fs/fuse/dev.c:1380)
>    fuse_uring_args_to_ring (fs/fuse/dev_uring.c:891)
>    fuse_uring_prepare_send (fs/fuse/dev_uring.c:940 fs/fuse/dev_uring.c:1=
057)
>    fuse_uring_send_in_task (fs/fuse/dev_uring.c:1745)
>    tctx_task_work_run (io_uring/tw.c:96)
>    tctx_task_work (io_uring/tw.c:133)
>    task_work_run (kernel/task_work.c:233)
>    io_run_task_work (io_uring/tw.h:84)
>    io_cqring_wait (io_uring/wait.c:278)
>    __do_sys_io_uring_enter (io_uring/io_uring.c:2676)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:61)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>    </TASK>
>
> Bound both directions against ent->payload.iov_len, the length the
> server registered, so an oversized reply is rejected with -EINVAL and an
> oversized request with -E2BIG/-EIO, matching fuse_dev_do_read().
>
> On a zero-copied request the last page-backed argument is handed to the
> server as registered pages rather than copied into the payload buffer,
> so exclude it from the request-side sum to avoid rejecting valid
> zero-copy reads and writes.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: add: Cc stable and Reviewed-by tags
> v3: propose the patch fixing another issue found by Bernd by Joanne sugge=
sted way
> v4: no context change as v3; add Reviewed-by: Joanne Koong ...
> v5: no change
> v6: rebase on fuse.git#for-next.  The ring entry already keeps the payloa=
d
>     iovec and imports it at iov_len, so only the two bounds checks are le=
ft.
>     Skip the page-backed arg on a zero-copied request, it does not consum=
e
>     the payload buffer.
>
>  fs/fuse/dev_uring.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index c6dd420c4034..981b7c295e5e 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -775,6 +775,9 @@ static int fuse_uring_copy_from_ring(struct fuse_req =
*req,
>         if (err)
>                 return err;
>
> +       if (ring_in_out.payload_sz > ent->payload.iov_len)
> +               return -EINVAL;
> +

This logic will break fuse zero-copy reads (ent->payload.iov_len is zero).

imo I think the cleanest fix for this bug in general would be to just
remove the BUG_ON in fuse_copy_fill() and return back the error, eg

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ static int fuse_copy_fill(struct fuse_copy_state *cs)
              err =3D iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &o=
ff);
              if (err < 0)
                      return err;
-             BUG_ON(!err);
+             if (!err)
+                     return -EIO;
              cs->len =3D err;

This would cover both the request and reply side and get rid of the
special logic here and below. It'd also make backporting to stable a
lot easier. I think it would still be worth having the FUSE_SETXATTR
errno fix (eg returning -E2BIG instead of -EIO)

    if (fuse_len_args(num_args, (struct fuse_arg *)in_args) >
          ent->payload.iov_len)
              return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;

as its own patch, where that check is only about picking the right
errno, not about preventing the BUG.

WDYT?

Thanks,
Joanne

>         err =3D setup_fuse_copy_state(&cs, req, ent, ITER_SOURCE, &iter,
>                                     issue_flags);
>         if (err)
> @@ -854,6 +857,7 @@ static int fuse_uring_args_to_ring(struct fuse_req *r=
eq,
>         int num_args =3D args->in_numargs;
>         int err;
>         struct iov_iter iter;
> +       size_t copy_size;
>         struct fuse_uring_ent_in_out ent_in_out =3D {
>                 .flags =3D 0,
>                 .commit_id =3D req->in.h.unique,
> @@ -887,6 +891,16 @@ static int fuse_uring_args_to_ring(struct fuse_req *=
req,
>                 num_args--;
>         }
>
> +       copy_size =3D fuse_len_args(num_args, (struct fuse_arg *)in_args)=
;
> +       /* a zero-copied page arg does not consume the payload buffer */
> +       if (cs.skip_folio_copy && args->in_pages && num_args)
> +               copy_size -=3D in_args[num_args - 1].size;
> +
> +       if (copy_size > ent->payload.iov_len) {
> +               fuse_copy_finish(&cs);
> +               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;
> +       }
> +
>         /* copy the payload */
>         err =3D fuse_copy_args(&cs, num_args, args->in_pages,
>                              (struct fuse_arg *)in_args, 0);
> --
> 2.43.0
>
