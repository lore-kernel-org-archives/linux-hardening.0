Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04652D2D5
	for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060963; cv=pass; b=mCUH9WQ5CJcnvIOEJRyWW6ooDdLOnCShEpfkRkIKBs7ePGKjcjkxQ3TlYPNntuJBgKJfwYNkqA9K2vt5DVaySCoatVK2QczZZiojblhtufvvIMRoOBN58jq+wyNJTQGUWCWERAYRQsdaVJ6Od29GBsDRaI0vCndKVjymiaup4+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060963; c=relaxed/simple;
	bh=IFR4nKdEOKKYPNJProJ/LoqY8uLWMn1OZMkBxks7z6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/lbdr1sdelmciB+oplr8w3EQYljyNtx5psiZp+wAW3h7UQH1VF90ZTyUQe1MG8QPIAxdfioc+4eJCD2wU7T/da8nXze7akU1eF8AvgGCJmHYtG++M+d0YwsTBwv2r/3w5UomqQvetDd1FFiaOEMTSnQk+tqAIBuJGCdW38KInU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz1rGn7Q; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz1rGn7Q"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso818025e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 10:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789060948; cv=none;
        d=google.com; s=arc-20260327;
        b=ARdGWXkIQA4+vSzzDwJLtYokN7k8wtHhT/6xl0/mGu1nhLa6vZ1p18ptstFQjawVBx
         VL/7Gvt+mj6dPi/8dUtou0V8wzUOyt2G8K5+G1BT/opPDUi5yZgb5ZALzIiBApSWrGy9
         2tXTgdbSdyY5luntAFGureSiLa8+KC6H3lx8wuZuvZAzMQiXvplxfbuovs7Weep6Y2c4
         VbZ2L2CRpNqJKSH7tIViZosbKYR7o7iu7JQapiWN5LvvRrJYPmYbrFP+L1hs79Ux9YMU
         pB/DeFwfJ2yJPPZfuPA+4TpPLzeTSMa8BKTBCA7IDq3F5/NW4z/eNfQIwNzTdt+7ugBx
         xRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4I3/z0Z834sx5ZQDBMDFhlcKX3jNWqo3Yat82eHYo8=;
        fh=9a6JHBPw/BCUazMBkUh4tR0O5jJixwuzY1T3u6VR4Sc=;
        b=rqdNRxiAWw5bwtTJJEmOFy5Ii0v3ljnZ19EnDtwreuasxWM0AWyvK4Ro6Vp3hiKgUG
         lMox67lkIWbiVUrbB7/0Zjq5vktW+P4GmRBLPX4NNyUBoB8Zgu+brr0oGK31mlRaZnxb
         IbHnfKLC/tdpuwRq6QULIQkgo3wD4pMSHg5Hw9L39mJqcbRcvZnZaZmi5lFigokakZsm
         qnqQizDdjdA2ft1l/iuWRMj+hj2x+UUahpTW2pi5oNveMn3wmdO7smuCwaTqgWPTYUO+
         Leakw3rvoxg2Fnhe6rEDS4J9JrM1YNJQk+zczPoBMDaVeiWJ2jgxPf1uJ24+1wkVIvSZ
         ezYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060948; x=1789665748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h4I3/z0Z834sx5ZQDBMDFhlcKX3jNWqo3Yat82eHYo8=;
        b=gz1rGn7QAKE9OEvSMgCuo7Os9QeOAqpxNj6m6AAvr1kLlolE3N/AGiA8Al9aR+nw1L
         s5bD8yrLrlElG4HI+KBRpTsV6DPRlyOvymL2SOROCbRUf1cpjcrZWS3pwtMmLpWAB6Gz
         YP0NPNbzGzdK4DBMUbQc+k7ng+NJT0e5mxWjkQaOr6E4dGrW43mc2QRHTQlAmSE9l1gV
         4FliB+EDN0PYHPkS/BU6MJEiISeZQir7Qzbz1XsR4npgHTZ7Unvp/XhiBoagTNxJ7V5M
         RbaecXs+3i6ZgPu1Fd41m1QqWAklbNU+M8iC1vD5r5JCm9wTmm+bGpw3aLK31pVdwgHP
         QOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060948; x=1789665748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4I3/z0Z834sx5ZQDBMDFhlcKX3jNWqo3Yat82eHYo8=;
        b=PLQA3vqMEym2EtbGqM/F0OWIX1eeD/or+iU17DPSlctlcH9pMCurKM5rMmuc2Uc2P/
         UaHFH4l0IWhi6666sZTNyKORr7u9jm6nJtj9dG5GBDPgB2ilxl06nmA2KVn3r9qM9wiF
         WlVWOqIRa7NmI5MYV7t6R8lg9Ej6Mg8ZpE35sJaG97wGgq2YSi80Sbswq1ms061rvEko
         2RBUaVaMVjIRCjhLV99yapjmq14e8mBPxGlvvtksPxkYXeVI1vx6/RYFR/wplYyS+KNU
         cZMonvhSL3BvKLhY8EcxtVbp2JVPbCtmCrMBWx8D0ssDoCgMTaQMM/AbY0KtoOztc2gY
         14Eg==
X-Forwarded-Encrypted: i=1; AKwUvBwVyF0iAA2RbrdJeJFTgXUv1jXWyrM/h3nf9klxTjJPKJJAdDO4VmsvTomYaamM4FwIH/RVY8huS3DDjgqV2fU=@vger.kernel.org
X-Gm-Message-State: AFuF++mqd3eVCWiBpeSSVg6050lkp3sltYq6V5m6aWMouzeaGWST0y0E
	NY+Q1IiGYnqTp+M+nxAP4AMiH99whsvPeHUG0/RSciMidV2EqTD8oqespUQ9uUKLSKjh284sxoL
	xOg9g6syNu7XXbrBNtkdKEJoPc1QnzG0=
X-Gm-Gg: AYBFou2BtD6q4AqkczwS9CdPQXXyE6yoDdwE3s+jcWTm9sidtmFKrhnbwKlivy5crzd
	IILDVBQBOoLjMU4PbYoGCu2KnCLbRvep282bMpYdvmIycGtJWDJzma87PY2bHxhjEQV5UrTgNVn
	JnKV3nG21nRSME9y9n2Aepyr6vIBrlQWPHLoLHspSFGyAIno6C8wntkxNP2H1+6KnhBkAG4Ru4T
	0L1THTFFCK4mAfReCnOoFzdibLQXnIhSah97A33DChfl2n6xr4K0Ituocapoa51BAHZlOYv1vwx
	1aEeX21IfeVFp/8JLQVwAFuRmE00yohm89CUcwjjG6VWPiQbPgxG9eVnLRMvqK2AuQSqcY0Ldj6
	xdtnkoUhVS/Ja7w+JOQcHCDMpGzX9iqjnDxctrQ==
X-Received: by 2002:a05:600d:8646:20b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-49e619c079cmr485295e9.19.1789060947517; Thu, 10 Sep 2026
 10:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910022442.3594649-1-xmei5@asu.edu>
In-Reply-To: <20260910022442.3594649-1-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 10 Sep 2026 10:22:14 -0700
X-Gm-Features: AcwNN1ViYMaLgvTSlyD77nmlLTiqiJ9NADONiy9rDk9d6ocZ1sATbKbnTXWESp0
Message-ID: <CAJnrk1bVwezZwMFmOE-4T6KTa5SzQFapkATS2LVeo7+bMcjdbg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] fuse: don't BUG when the copy buffer is exhausted
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 7:25=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> fuse_copy_fill() hits BUG_ON(!err) once the iterator backing the copy
> runs out of pages.  Over io-uring the amount copied is not bounded by the
> payload buffer the server registered, so an unprivileged user can drain
> the iterator and panic the host - mount a FUSE filesystem with small
> payload buffers, then setxattr() a larger value:
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
> The reply path can drain it the same way, via the server-supplied
> payload_sz in fuse_uring_copy_from_ring().
>
> An exhausted iterator is recoverable, so return -EIO.  All three

super nit: imo, the reason for returning -EIO is unrelated to an
iterator being recoverable.

> fuse_copy_fill() callers already propagate the error.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Suggested-by: Joanne Koong <joannelkoong@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Thanks for your patience with iterating on this fix!

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

> ---
>  fs/fuse/dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 4fec31fc0b84..4148e4488d77 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1061,7 +1061,8 @@ static int fuse_copy_fill(struct fuse_copy_state *c=
s)
>                 err =3D iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1=
, &off);
>                 if (err < 0)
>                         return err;
> -               BUG_ON(!err);
> +               if (!err)
> +                       return -EIO;
>                 cs->len =3D err;
>                 cs->offset =3D off;
>                 cs->pg =3D page;
> --
> 2.43.0
>
