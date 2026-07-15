Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6B42FCCD
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140244; cv=pass; b=ZbLfMxLlcb6GnjkhcQBuy3aMIY3hYqPEUEBmwJD5/D7Wvq0I1j+3NIslf18RqMF+KWbUMGUpHSdOEEEyStZnzWhkZY1dEzwqnxKz9jPCyd28ZDsV/6x58+uCOihtaoiUqMPY9cso7xS9hlV/GfGJU6IhzyYOPbbayGG8NyAqgZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140244; c=relaxed/simple;
	bh=LqZQ7GhvjznYU5Bodyh7xffu+f6vi+N9hg5ldo+B/i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAK18RrBRGuQtURJIZU70YkC0WfC0Agra2OYEii5bsU5uOz/IRExu4Y0xnWXe7oXl6AMU7f8qX47KvWtsBbPpS3GQ9HIemvejp/9lb9gGRWjW46GI/AGip/8mjPfLCY/PxALPHYQOv8F/WhgNNZ56GQRqttChpO8rNM2W8ouCeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9lDK2rb; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9lDK2rb"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso39409875e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 11:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140233; cv=none;
        d=google.com; s=arc-20260327;
        b=HU5JcWbT3po5jqJxCW3d/S1n/67R6fFAgx8Pgtu8obH8rJwRmB0ku4/PDyW3s0Dx+n
         s37fuP0XOWH+eOouJO9RHP92t+3seSahyv8MrBb+sl9ZkNu+sbYnYRtRbodYKnMfZsTm
         YhodJemL40tzKZxAX2v5EjjN4QhD7P0yqD2Z7HcoJwQ0Ltqi8/Gq+DQMe5cVgx08gJ59
         1xX6+f/W6vkBzP748SDGLcpHfko1/cgTP0Lj04MMbaUEP9Elm8lMm+rxRKT/l4PQG5XD
         ryh7JUt0L1uFdva0vKM0pvEemiWqZrUyPwyB3V0BOmF+CNt6dLO6b3MCrQ/qJ74DdnQq
         d/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eflNygwkucfn8rSal3UDLFQ6W9vndZUg982/8SGMCAg=;
        fh=6JMAxIDOMWEdosWsyoHml1rjuB3efieoM7tWjej375I=;
        b=S47aPIx86qT00KWmmr7VMbbc20FSPowC/nsnXPHQJ+44u0C18Fw7DDE3IJ5EPP0TRT
         eCCO078MPLzXwaPs+HVbu2XdnKQtPsZ9jVByze/WH52rpQ8QvA3bxbZFxUyPcZbXJlTJ
         vzNyKl9eU3AekS8eSfzrJRAyGN/wo8IL1UrB09I8oUmUQqMKTxvFH0YYm3oBcOnzCc1z
         2BPl5wtgDpQsGIoVseWz9Vqr5iBLyI2JYZidICwzvt8mjHbK2o4FMh7Zd/kt3oSXOWmw
         yb05VOCXP15CJEz6stMf7aaLznorznIrS6LaK5T+vS26Y6/12JZCk6biPfY/9aXYyeaA
         ogHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784140233; x=1784745033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eflNygwkucfn8rSal3UDLFQ6W9vndZUg982/8SGMCAg=;
        b=h9lDK2rbq5wUM8wtk2YsXnGw4qzoqeJ3EsIDY/pVR7XozbzSKQyUtRi8aySNUnu9Ro
         1OTbhU7VqSIrhVpk2LsX2AjHbAm2oyKG6Y9uP0Kgdk50TH87//v/9TWXv06HVWImIC7f
         i9vgyIZG3k/3SfNByQZnYvoVRYc6X4+ADNaCYLzCjGy09eGj4eJkZsUt7OLg3QiejQZK
         TRIYH5Dbo05hTZXJa16QIzCBUKIlRQbVRhdNbH4lY4DdFQvXoVSU1y/9DbFZ0ls/8sxw
         g1SbhX4cdfzcMiEBI9t3yfdaNszZNo/toDaHkRMirviaiD7srqweQ1i+37JM0gYjwI0F
         8Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784140233; x=1784745033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eflNygwkucfn8rSal3UDLFQ6W9vndZUg982/8SGMCAg=;
        b=VbWZ2t3mRoIsX8/6pXzRvsp4rsV5f2V+T7yGhIWP1ystt+iNTBfd06UkXKI83SuYf/
         HBx6dmSyZF+GUSTMYJJvlihCa5z0ew3tP3OyC+jqJisys1C3Sj9b4yKunwCud0VYkP/k
         PPuwWXH3GwjM5rniHjdoDvKrEiqto5SjqvqZDA93kFFX1G5bQcs0dkoIqf3CAjXeDLmP
         qe1E7ar0F2SmN65MnZkVYDOiBKuCVQdWKrsABRPvQhoQCuHp7d1L4rDlR0u13iSNlB6V
         brEluG1gQWA5PYThI6RCIFjIh8/xAVF7qHgZScdgacFSecfp92jE0b7qh3fJZ0nnZff5
         kNpw==
X-Forwarded-Encrypted: i=1; AHgh+RoIbWXT183FCshzeT/9AZ4AnKg5yXnD8hopSYiTGcUM15M+n1bzQZYfFHS3xKTlO+PSN2z7xqCyR/tJ61/CrQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LgpN0HVVHD7xaA8K9pWH3G2LOQ9yB7pVdx+0ONM+aQM97WRQ
	Jf5J/UUiMIpH5nKC0AsgvcA5NCLqBTIwwZBIcpdGZEirCbKvtzYmtvClSDRjres6Q5ALS7ZvPft
	jgPRoEsfC27qcpS9uUmPdi5P2fTcUJuo=
X-Gm-Gg: AfdE7cnXZuzZ0Wf4Ov53ey7unGQsOfyyziSov63VH3Q2v0QX/YmxICOQEUEaOJOIDIY
	miAeTy3LzExpvJ/pqtllW/lAs/cCxwkbx3pRS/TammV94+jIdCRToXcId/744Q0NJa9S7vOwjwT
	7OQ7ksyq4AHicY+iHANubhwIOYTmeveSFshcJ20a45V/i/OyHVVQ/y0co/2DwI8dZ1c9835B3kM
	12QzSOWThfzl0Fzmkyg6AHPv85x4lrqHKWEDEfjRjyyuJOxKlF4VnjdVVjzX/2qwm+F4p0BqXOM
	erWHUXS9k0LJqX++pVI4FsNX7nwG7R2c1zpIk8eFUHPai5aRDV3/
X-Received: by 2002:a05:600c:58d6:b0:493:f262:b8 with SMTP id
 5b1f17b1804b1-4953c147474mr38215745e9.1.1784140233078; Wed, 15 Jul 2026
 11:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714235408.1666063-1-xmei5@asu.edu> <20260714235408.1666063-3-xmei5@asu.edu>
In-Reply-To: <20260714235408.1666063-3-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Jul 2026 11:30:20 -0700
X-Gm-Features: AUfX_myhxLCfqR4n7aGibfgh8m6ozVVwNoTPdhZMyVsgCsfFwX4PP36R6t_ZV1Q
Message-ID: <CAJnrk1YRmyaPeeBgd2HQSfmwDYm08cev__Y8LgyPyTqaTZE1vw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fuse: deduplicate the oversized-request error selection
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:54=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> fuse_dev_do_read() and fuse_uring_args_to_ring() both pick the error for
> a request that does not fit the server's buffer, and both special-case
> FUSE_SETXATTR.  Move that choice into a helper so the two transports
> cannot drift apart.
>
> No functional change.
>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v4: introduce fuse_req_too_large_error as a helper
>
>  fs/fuse/dev.c        | 5 +----
>  fs/fuse/dev_uring.c  | 2 +-
>  fs/fuse/fuse_dev_i.h | 7 +++++++
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index b8e43e374b35..56c38aca7389 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1584,10 +1584,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *f=
ud, struct file *file,
>
>         /* If request is too large, reply with an error and restart the r=
ead */
>         if (nbytes < reqsize) {
> -               req->out.h.error =3D -EIO;
> -               /* SETXATTR is special, since it may contain too large da=
ta */
> -               if (args->opcode =3D=3D FUSE_SETXATTR)
> -                       req->out.h.error =3D -E2BIG;
> +               req->out.h.error =3D fuse_req_too_large_error(args);
>                 fuse_request_end(req);
>                 goto restart;
>         }
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 4529505b2bca..cebd8f871627 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -729,7 +729,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *=
ring, struct fuse_req *req,
>         }
>
>         if (fuse_len_args(num_args, (struct fuse_arg *)in_args) > ent->pa=
yload_sz)
> -               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;
> +               return fuse_req_too_large_error(args);
>
>         /* copy the payload */
>         err =3D fuse_copy_args(&cs, num_args, args->in_pages,
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index b511aaab6bfc..4958158c0f02 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -13,6 +13,8 @@
>  #include <linux/workqueue.h>
>  #include <linux/fs.h>
>
> +#include "args.h"
> +
>  /* Ordinary requests have even IDs, while interrupts IDs are odd */
>  #define FUSE_INT_REQ_BIT (1ULL << 0)
>  #define FUSE_REQ_ID_STEP (1ULL << 1)
> @@ -367,6 +369,11 @@ static inline struct fuse_dev *__fuse_get_dev(struct=
 file *file)
>         return fud;
>  }
>
> +static inline int fuse_req_too_large_error(struct fuse_args *args)
> +{
> +       return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;
> +}

Could you add a comment to the top of this function? Maybe something
like "A request whose payload size exceeds the transport buffer size
is rejected with -EIO. The exception is FUSE_SETXATTR whose value may
legitimately be oversized and is rejected with -E2BIG, matching the
vfs setxattr path".

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne
