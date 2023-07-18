Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2302EB64DC
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Jul 2023 19:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGRTEh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Jul 2023 15:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjGRTEg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Jul 2023 15:04:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8259CFD
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jul 2023 12:04:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-403f21d3c2dso365061cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jul 2023 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689707073; x=1692299073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP4E+krXJUqcP/XL8AvesdP7FQu4JyJQ3RJDPmgOZF8=;
        b=21v6dXrULsCH8KDeCheN7Pz5gu95bHxPXaU2t1wV8WDWMJA77Iz6q0xb8xHeB8eBNK
         zBajR7tCwfn41oLjzTQRqjX4Hxyfa3QqUZKBAGEuS24b0VN+RcHrf+aNZjohziD/rmKw
         9vJBch+0p3qJNDmsj+Twj5JT7Y/zjc5mpzoknWLforM903oigoaouaveKT4ZgDFuBtGl
         MsyxmPg4xZberTUdczm/quU9iQabGH6LJ4h5gtlztS2pkC/5JC3xJmGf79W1tVmrpxJG
         qNt+YDelDSvg7wVBL2a4tJ6l6o3+BAKSN8yEWd7GUIcw/UQtBVFPNsS53HB5hg/1z/u2
         qomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689707073; x=1692299073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UP4E+krXJUqcP/XL8AvesdP7FQu4JyJQ3RJDPmgOZF8=;
        b=PJKbxE4X3SG0w4I/yiinuQJ+y2LI+7dMC7s2aNvzlNkqJtrVJ/rGIbL7wYytEFrB4U
         Ln+S4C2sc18gvQQYSrl/gXVWQfUkPil02xjSy+kK+eCqVoNux6fSeKMoS8CzJzmWH0wt
         NwMwVb8Df01/eut3ZzrxpQarAJKLiTQ9D/1HqTBhsW4r7Qy2M8TaXyWh587exp/VGQLp
         y1VS+CqqY+RaboiqvNr3RclbTxm9ZumSgDbnd4L6oLVy4wgokN/AvFBop1qwUOZZKja5
         W1GS0+knu9LSMVJ5jsSdvO+sO8bmTeI9EE/Oc/oVVgH5kpvcDCZ9eXuNiSagg8KdGYXD
         lqCw==
X-Gm-Message-State: ABy/qLYJ+supAJ3WWMdZLJbHlaLLtSUs6I67a/gtTHBGAEODT7GpQWCo
        2iyFhXk4ODInsRfateGWnV4xwlmLmg86u3IDobSxQQ==
X-Google-Smtp-Source: APBJJlEqTCm929lAwWSFDX8sdYEaCp3/sAVGWtRDWQbwohxt/YNaKGxUn5vTLiOLRpmy5hemXBjhYQqtkuV9q1y42Xc=
X-Received: by 2002:a05:622a:1882:b0:3f2:2c89:f1ef with SMTP id
 v2-20020a05622a188200b003f22c89f1efmr288088qtc.5.1689707073502; Tue, 18 Jul
 2023 12:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230714114753.170814-1-david@readahead.eu>
In-Reply-To: <20230714114753.170814-1-david@readahead.eu>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 18 Jul 2023 12:03:57 -0700
Message-ID: <CALmYWFsjy2jOfKyM3Gd3Ag+p6u5ejDoBp6RhqcXkcAkMiby4SA@mail.gmail.com>
Subject: Re: [PATCH] memfd: support MFD_NOEXEC alongside MFD_EXEC
To:     David Rheinsberg <david@readahead.eu>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi David

Thanks email and patch for discussion.

On Fri, Jul 14, 2023 at 4:48=E2=80=AFAM David Rheinsberg <david@readahead.e=
u> wrote:
>
> Add a new flag for memfd_create() called MFD_NOEXEC, which has the
> opposite effect as MFD_EXEC (i.e., it strips the executable bits from
> the inode file mode).
>
I previously thought about having the symmetric flags, such as
MFD_NOEXEC/MFD_EXEC/MFD_NOEXEC_SEAL/MFD_EXEC_SEAL, but decided against
it. The app shall decide beforehand what the memfd is created for, if
it is no-executable, then it should be sealed, such that it can't be
chmod to enable "X" bit.

> The default mode for memfd_create() has historically been to use 0777 as
> file modes. The new `MFD_EXEC` flag has now made this explicit, paving
> the way to reduce the default to 0666 and thus dropping the executable
> bits for security reasons. Additionally, the `MFD_NOEXEC_SEAL` flag has
> been added which allows this without changing the default right now.
>
> Unfortunately, `MFD_NOEXEC_SEAL` enforces `MFD_ALLOW_SEALING` and
> `F_SEAL_EXEC`, with no alternatives available. This leads to multiple
> issues:
>
>  * Applications that do not want to allow sealing either have to use
>    `MFD_EXEC` (which we don't want, unless they actually need the
>    executable bits), or they must add `F_SEAL_SEAL` immediately on
>    return of memfd_create(2) with `MFD_NOEXEC_SEAL`, since this
>    implicitly enables sealing.
>
>    Note that we explicitly added `MFD_ALLOW_SEALING` when creating
>    memfd_create(2), because enabling seals on existing users of shmem
>    without them knowing about it can easily introduce DoS scenarios.

The application that doesn't want MFD_NOEXEC_SEAL can use MFD_EXEC,
the kernel won't add MFD_ALLOW_SEALING implicitly. MFD_EXEC makes the
kernel behave the same as before, this is also  why sysctl
vm.memfd_noexec=3D0 can work seamlessly.

>   It
>    is unclear why `MFD_NOEXEC_SEAL` was designed to enable seals, and
>    this is especially dangerous with `MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL`
>    set via sysctl, since it will silently enable sealing on every memfd
>    created.
>
Without sealing, chmod(2) can modify the mfd to be executable, that is
the consideration that MFD_NOEXEC is not provided as an option.
Indeed, current design is "biased" towards promoting MFD_NOEXEC_SEAL
as the safest approach, and try to avoid the pitfall that dev
accidently uses "MFD_NOEXEC" without realizing it can still be
chmod().


>  * Applications that do not want `MFD_EXEC`, but rely on
>    `F_GET_SEALS` to *NOT* return `F_SEAL_EXEC` have no way of achieving
>    this other than using `MFD_EXEC` and clearing the executable bits
>    manually via fchmod(2). Using `MFD_NOEXEC_SEAL` will set
>    `F_SEAL_EXEC` and thus break existing code that hard-codes the
>    seal-set.
>
>    This is already an issue when sending log-memfds to systemd-journald
>    today, which verifies the seal-set of the received FD and fails if
>    unknown seals are set. Hence, you have to use `MFD_EXEC` when
>    creating memfds for this purpose, even though you really do not need
>    the executable bits set.
>
>  * Applications that want to enable the executable bit later on,
>    currently have no way to create the memfd without it. They have to
>    clear the bits immediately after creating it via fchmod(2), or just
>    leave them set.
>
Is it OK to do what you want in two steps ? What is the concern there ? i.e=
.
memfd_create(MFD_EXEC), then chmod to remove the "X" bit.

I imagine this is probably already what the application does for
creating no-executable mfd before my patch, i.e.:
memfd_create(), then chmod() to remove "X" to remove "X" bit.

Thanks!
-Jeff



-Jeff

> By adding MFD_NOEXEC, user-space is now able to clear the executable
> bits on all memfds immediately, clearly stating their intention, without
> requiring fixups after creating the memfd. In particular, it is highly
> useful for existing use-cases that cannot allow new seals to appear on
> memfds.
>
> Signed-off-by: David Rheinsberg <david@readahead.eu>
> ---
>  include/linux/pid_namespace.h |  4 ++--
>  include/uapi/linux/memfd.h    |  1 +
>  mm/memfd.c                    | 29 ++++++++++++++---------------
>  3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.=
h
> index c758809d5bcf..02f8acf94512 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -19,9 +19,9 @@ struct fs_pin;
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>  /*
>   * sysctl for vm.memfd_noexec
> - * 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
> + * 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC
>   *     acts like MFD_EXEC was set.
> - * 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
> + * 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC
>   *     acts like MFD_NOEXEC_SEAL was set.
>   * 2: memfd_create() without MFD_NOEXEC_SEAL will be
>   *     rejected.
> diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> index 273a4e15dfcf..b9e13bd65817 100644
> --- a/include/uapi/linux/memfd.h
> +++ b/include/uapi/linux/memfd.h
> @@ -12,6 +12,7 @@
>  #define MFD_NOEXEC_SEAL                0x0008U
>  /* executable */
>  #define MFD_EXEC               0x0010U
> +#define MFD_NOEXEC             0x0020U
>
>  /*
>   * Huge page size encoding when MFD_HUGETLB is specified, and a huge pag=
e
> diff --git a/mm/memfd.c b/mm/memfd.c
> index e763e76f1106..2afe49368fc5 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -266,7 +266,9 @@ long memfd_fcntl(struct file *file, unsigned int cmd,=
 unsigned int arg)
>  #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
>  #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
>
> -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | M=
FD_NOEXEC_SEAL | MFD_EXEC)
> +#define MFD_ALL_FLAGS \
> +       (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
> +        MFD_NOEXEC_SEAL | MFD_EXEC | MFD_NOEXEC)
>
>  SYSCALL_DEFINE2(memfd_create,
>                 const char __user *, uname,
> @@ -289,11 +291,13 @@ SYSCALL_DEFINE2(memfd_create,
>                         return -EINVAL;
>         }
>
> -       /* Invalid if both EXEC and NOEXEC_SEAL are set.*/
> -       if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
> +       if (flags & MFD_NOEXEC_SEAL)
> +               flags |=3D MFD_ALLOW_SEALING | MFD_NOEXEC;
> +
> +       if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC))
>                 return -EINVAL;
>
> -       if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
> +       if (!(flags & (MFD_EXEC | MFD_NOEXEC))) {
>  #ifdef CONFIG_SYSCTL
>                 int sysctl =3D MEMFD_NOEXEC_SCOPE_EXEC;
>                 struct pid_namespace *ns;
> @@ -366,20 +370,15 @@ SYSCALL_DEFINE2(memfd_create,
>         file->f_mode |=3D FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
>         file->f_flags |=3D O_LARGEFILE;
>
> -       if (flags & MFD_NOEXEC_SEAL) {
> -               struct inode *inode =3D file_inode(file);
> +       if (flags & MFD_NOEXEC)
> +               file_inode(file)->i_mode &=3D ~0111;
>
> -               inode->i_mode &=3D ~0111;
> -               file_seals =3D memfd_file_seals_ptr(file);
> -               if (file_seals) {
> +       file_seals =3D memfd_file_seals_ptr(file);
> +       if (file_seals) {
> +               if (flags & MFD_ALLOW_SEALING)
>                         *file_seals &=3D ~F_SEAL_SEAL;
> +               if (flags & MFD_NOEXEC_SEAL)
>                         *file_seals |=3D F_SEAL_EXEC;
> -               }
> -       } else if (flags & MFD_ALLOW_SEALING) {
> -               /* MFD_EXEC and MFD_ALLOW_SEALING are set */
> -               file_seals =3D memfd_file_seals_ptr(file);
> -               if (file_seals)
> -                       *file_seals &=3D ~F_SEAL_SEAL;
>         }
>
>         fd_install(fd, file);
> --
> 2.41.0
>
