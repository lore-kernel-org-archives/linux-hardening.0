Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CC3D75A2
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227071; cv=pass; b=KxyIm1Zsp4/caGaACVs9Y2UpqnULIgEbyxpWUlxAZ8ho98mOLCUgKn9Yfj/g4FZ+8BOialWPNSGh1S473gclA7kQdjabdlSViY6d2TqJHTx0i5cEZlKky/bKRN3aC1YVxtNfPoN7ujIfSs0Wow1Ysb1OYts0jbfipIpSe7TBcDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227071; c=relaxed/simple;
	bh=moeCOdPL37pA4Cm3YLyMgOX7Ltv+HpIq0MYYOWohN7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ+84+/88lo8SEvmF4B2FdbB/WYrctosimsnPfuLOXSfzEvpIzbWJukkq59s5ye0xr8szxirslrRIvXrO9G3/n+4c+3lxb1tLQxwtrTTnwYFCbH4ABk+GbqqQSq9tlD+o19OXuhO5+guVrCI1He9VtN65pHSX6+XPscn+Mg0Btc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljlhXVsY; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljlhXVsY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c6bb8a5980so38863135ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 08:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227068; cv=none;
        d=google.com; s=arc-20240605;
        b=BMiQAfNFP7Wzpv5NjXNabh+mLvm14OqNbRLbaWeP6h7K40L7ZnAhobgWmS2wim5MZj
         pB7c56wHODUozn0SlNIN/3Cc03ssXwUU+yUqd57/MJhGuvAvz+4F5Gc9Ga+8xStVQzH5
         Y4o+d3fpD1sIrNS4YsMlTLxKfw2CEVfW1BgJzHXRpj6TTrqik1i8pOSVSxmPNE+bSGRt
         1HksCsuILv7HStjMyIISRLJkvYOLhBx/oVPQiclZmik0fCF7X2hXEySBF1oH56Zz8zfB
         l9viSuG+WIHT4BJxyFMp7MD6833HK3oKtL5F80S2Y5UoDyAnUtz5p2Ed/1LaxaMloZvT
         fv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IJElps7NxqPdAEp+fqfuwfl85ZtuPfQzjPdU/8ZfgH4=;
        fh=LLGICw5kRL3E6MK9pPo+xXDe0xJR1Uru9b5bhApzJj8=;
        b=ZzDCsir7mZ2f48ykNLKpjzrcmzB9r7m/Bx1G7njpKYVZs+QHgcgNYsVHwH1O+xdJ9S
         fHb9d7xUmDOO0ahZNBxukgZarN/T3Cm6P2pcoA7jltjo8NUI+rlyAYwBXcGmsfALsZ3C
         e4CLZi9wTeWCBCGucV1FSgTJDRbo7uI8sw6/lHUaMYiSThaYkzVMSTwodbHz8SVYO8ZE
         RlGjjo7IRY95of9YgrrR49/mVH3HwqfeY7dzk6et3Lg7b0mRjzSBjvxknUFIQVEjtHKB
         XcrvtCPy2jsznnzM7e90B+Ebs5/O2nbCtlEU71R63can0Vw2VWBbDLra7gEPSrH3rP9Q
         TxJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227068; x=1782831868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJElps7NxqPdAEp+fqfuwfl85ZtuPfQzjPdU/8ZfgH4=;
        b=ljlhXVsYCpGsyZbnkJcg/0eT9Xru+hcotyJ4XdhnrFqYqdTnP15PIzzjcird/GuhBA
         Ah1Xxsr75TAu5Tmyu7Z1WOT4v0aKwHAinIT3fB+M2UC8T/sBhzcyd4f0XGrpV8tB36Vs
         cSgZuFiUs5DC21rt9mxV6tEm2XcDAXUieHdm0gi6eP1Otra/BXR4S5zFC8IbVfs/evxc
         CMStJwjj8JIyOFcnvdoj4OjuTadohNnl9JWN6a16B19aQFv6wIqOhl/6vDLoYSGFRtrY
         fGM4cKciYzXxqs09zLF4Petw+yiruL8YQnxhjloNRUfk+aL2CzSaHsiE6NGRbFGszIDf
         7saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227068; x=1782831868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJElps7NxqPdAEp+fqfuwfl85ZtuPfQzjPdU/8ZfgH4=;
        b=UGjD3lrecciBdvkqXqxkExcxycuZx0seWCkgpPJuGavDG1sY8EK7bsvwVjDYOyBXJu
         MmlrNkg4uVHhgUBFbvj7jlJBu1aCqfhVOlKIk2t5/mTwCzx2J0+z550i6thhH+1RDPz8
         tbxVSquN7L0u3okSsLLIE6Cbe9T88Fcd2B1CkvkWJOewwoBWysfkbayc6vD+OtQh1HXD
         LuuqsjrNpICbNKulkAWUpGfeArQfj+LIRPkfSNkM7hLDf3cy6WryA97gSQgwykVdMPym
         wjbXyG9tGspkJJ+hVZl9HeKc94dYJqyxpVEy/wBnd+yHng+jMdSZMZ5FKMoK8+V8taGJ
         hWhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPTq8Kq2kxi6vXc76XW5wwihAanDQrLwZOzMirVtu8Qkcigbns6GVyKKAvXEkUwha0RuMnMpn5FExw8dhfoMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWzxvyI+d4nEnVJ613+FiXJj3VJYZxa9yD+M38wcvW/DCnzmoi
	mmGEWuFEwzFxQZ9UACzF2gJR5TwOz5hVxCjFYocJ/9wWKqPHarV6OjmNLD7xArQ2Ajrd0ECoC1Z
	3RDP8dMiX7HBU+gd+iuGdeDbSAz0M56s=
X-Gm-Gg: AfdE7ckKWaK6U+kxx+EHe+srQ4jx567bfMdJJC0GUeB4BXo/Vr6knZLAix70Pz21O69
	AsKMEIXVdrSwWb7QayV2B7AJtZovLu7SV95eeb2llVkWXyhiogJ9tg4UfBgGvZGYPMWgLpoPfFe
	j9tC/pAcO15j3Uv40U2f0LMw3V8YUer7xTV8Zt029NsbyeUjZFX6T7zndis1A6EmFuX19ZdN/ee
	W04Tw+opFdMUqPZ+oLp9kziHBcpnoaU8h2yG0mxBT1yC54kmHCvLnvMUsXKJOMXPeKQFGODjvtm
	Dc2NSBZEyMhUvBnpCnjq/QJ67GhLiVW+EVbIJalV4lK0z/s/Pw2I9IQ3I7c=
X-Received: by 2002:a17:903:2281:b0:2c2:7e17:39f6 with SMTP id
 d9443c01a7336-2c7c9a9c706mr29568135ad.36.1782227067798; Tue, 23 Jun 2026
 08:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622234803.6982-1-ebiggers@kernel.org>
In-Reply-To: <20260622234803.6982-1-ebiggers@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jun 2026 11:04:14 -0400
X-Gm-Features: AVVi8Cfvovxh_AcIOv0_5Ttgx9HUcmTHdvbTOTdPXaEunw3IPLjFGMbE1c6ysnE
Message-ID: <CABBYNZ+QLvkYkn_EcBZ4+GopyhKqJLcfCoABYcw1VamavbSvhg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Mon, Jun 22, 2026 at 7:50=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> AF_ALG is a frequent source of vulnerabilities and a maintenance
> nightmare.  It exposes far more functionality to userspace than ever
> should have been exposed, especially to unprivileged processes.  Recent
> exploits have targeted kernel internal implementation details like
> "authencesn" that have zero use case for userspace access.
>
> Fortunately, AF_ALG is rarely used in practice, as userspace crypto
> libraries exist.  And when it is used, only some functionality is known
> to be used, and many users are known to hold capabilities already.
> iwd for example requires CAP_NET_ADMIN and has a known algorithm list
> (https://lore.kernel.org/linux-crypto/bcbbef00-5881-421b-8892-7be6c04b832=
d@gmail.com/).
>
> Thus, let's restrict the set of allowed algorithms by default, depending
> on the capabilities held.
>
> Add a sysctl /proc/sys/crypto/af_alg_restrict with meaning:
>
>     0: unrestricted
>     1: limited functionality
>     2: completely disabled
>
> Set the default value to 1, which enables an algorithm allowlist for
> unprivileged processes and a slightly longer allowlist for privileged
> processes.
>
> Note that the list may be tweaked in the future.  However, the common
> use cases such as iwd and bluez are taken into account already.  I've
> tested that iwd still works with the default value of 1.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  Documentation/admin-guide/sysctl/crypto.rst | 36 +++++++++++
>  Documentation/crypto/userspace-if.rst       | 13 +++-
>  crypto/af_alg.c                             | 72 +++++++++++++++++++--
>  crypto/algif_aead.c                         | 11 ++++
>  crypto/algif_hash.c                         | 24 +++++++
>  crypto/algif_rng.c                          |  9 +++
>  crypto/algif_skcipher.c                     | 20 ++++++
>  include/crypto/if_alg.h                     |  8 +++
>  8 files changed, 184 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/crypto.rst b/Documentation/=
admin-guide/sysctl/crypto.rst
> index b707bd314a64..9a1bd53287f4 100644
> --- a/Documentation/admin-guide/sysctl/crypto.rst
> +++ b/Documentation/admin-guide/sysctl/crypto.rst
> @@ -5,10 +5,46 @@
>  These files show up in ``/proc/sys/crypto/``, depending on the
>  kernel configuration:
>
>  .. contents:: :local:
>
> +.. _af_alg_restrict:
> +
> +af_alg_restrict
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controls the level of restriction of AF_ALG.
> +
> +AF_ALG is a deprecated and rarely-used userspace interface that is a
> +frequent source of vulnerabilities. It also unnecessarily exposes a
> +large number of kernel implementation details. For more information
> +about AF_ALG, see :ref:`Documentation/crypto/userspace-if.rst
> +<crypto_userspace_interface>`.
> +
> +Starting in Linux v7.3, AF_ALG supports only a limited set of
> +algorithms by default. This sysctl allows the system administrator to
> +remove this restriction when needed for compatibility reasons, or to
> +go further and disable AF_ALG entirely. The default value is 1.
> +
> +=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +0    AF_ALG is unrestricted.
> +
> +1    AF_ALG is supported with a limited list of algorithms. The list
> +     is designed for compatibility with known users such as iwd and
> +     bluez that haven't yet been fixed to use userspace crypto code.

Is the expectation that we go shopping for userspace crypto here? This
would mean the Bluetooth stack would use 2 different crypto stacks:
the kernel for module parts and a userspace library for components
like bluetoothd, resulting in 2 different sources to audit. So, while
I agree we should restrict it to just the algorithms in use and with
capabilities, I don't think we should assume the current userspace
users are broken and need fixing.

> +     Specifically, there is an allowlist for unprivileged processes
> +     and a somewhat longer allowlist for processes that hold
> +     CAP_SYS_ADMIN or CAP_NET_ADMIN in the initial user namespace.
> +
> +     Attempts to bind() an AF_ALG socket with a disallowed algorithm
> +     fail with ENOENT.
> +
> +2    AF_ALG is completely disabled. Attempts to create an AF_ALG
> +     socket fail with EAFNOSUPPORT.
> +=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
>  fips_enabled
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Read-only flag that indicates whether FIPS mode is enabled.
>
> diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto=
/userspace-if.rst
> index ab93300c8e04..d6194346e366 100644
> --- a/Documentation/crypto/userspace-if.rst
> +++ b/Documentation/crypto/userspace-if.rst
> @@ -1,5 +1,7 @@
> +.. _crypto_userspace_interface:
> +
>  User Space Interface
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Introduction
>  ------------
> @@ -10,13 +12,18 @@ code.
>
>  AF_ALG is insecure and is deprecated. Originally added to the kernel in =
2010,
>  most kernel developers now consider it to be a mistake. Support for hard=
ware
>  accelerators, which was the original purpose of AF_ALG, has been removed=
.
>
> -AF_ALG continues to be supported only for backwards compatibility. On sy=
stems
> -where no programs using AF_ALG remain, the support for it should be disa=
bled by
> -disabling ``CONFIG_CRYPTO_USER_API_*``.
> +AF_ALG continues to be supported only for backwards compatibility.
> +
> +Starting in Linux v7.3, the set of algorithms supported by AF_ALG is lim=
ited by
> +default. See :ref:`/proc/sys/crypto/af_alg_restrict <af_alg_restrict>`.
> +
> +On systems where no programs using AF_ALG remain, the support for it sho=
uld be
> +disabled entirely by setting ``/proc/sys/crypto/af_alg_restrict`` to 2 o=
r by
> +disabling ``CONFIG_CRYPTO_USER_API_*`` in the kernel configuration.
>
>  Deprecation
>  -----------
>
>  AF_ALG was originally intended to provide userspace programs access to c=
rypto
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index cce000e8590e..34b801568fba 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -6,10 +6,11 @@
>   *
>   * Copyright (c) 2010 Herbert Xu <herbert@gondor.apana.org.au>
>   */
>
>  #include <linux/atomic.h>
> +#include <linux/capability.h>
>  #include <crypto/if_alg.h>
>  #include <linux/crypto.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/key.h>
> @@ -20,14 +21,32 @@
>  #include <linux/rwsem.h>
>  #include <linux/sched.h>
>  #include <linux/sched/signal.h>
>  #include <linux/security.h>
>  #include <linux/string.h>
> +#include <linux/sysctl.h>
> +#include <linux/user_namespace.h>
>  #include <keys/user-type.h>
>  #include <keys/trusted-type.h>
>  #include <keys/encrypted-type.h>
>
> +static int af_alg_restrict =3D 1;
> +
> +static const struct ctl_table af_alg_table[] =3D {
> +       {
> +               .procname       =3D "af_alg_restrict",
> +               .data           =3D &af_alg_restrict,
> +               .maxlen         =3D sizeof(int),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +               .extra2         =3D SYSCTL_TWO,
> +       },
> +};
> +
> +static struct ctl_table_header *af_alg_header;
> +
>  struct alg_type_list {
>         const struct af_alg_type *type;
>         struct list_head list;
>  };
>
> @@ -108,10 +127,43 @@ int af_alg_unregister_type(const struct af_alg_type=
 *type)
>
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(af_alg_unregister_type);
>
> +static bool af_alg_capable(void)
> +{
> +       return ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN) ||
> +              capable(CAP_SYS_ADMIN);
> +}
> +
> +int af_alg_check_restriction(const char *name,
> +                            const struct af_alg_allowlist_entry allowlis=
t[])
> +{
> +       int level =3D READ_ONCE(af_alg_restrict);
> +
> +       if (level =3D=3D 0)
> +               return 0;
> +       if (level =3D=3D 1) {
> +               for (const struct af_alg_allowlist_entry *ent =3D allowli=
st;
> +                    ent->name; ent++) {
> +                       if (strcmp(name, ent->name) =3D=3D 0 &&
> +                           (!ent->privileged || af_alg_capable()))
> +                               return 0;
> +               }
> +       }
> +       /*
> +        * Use -ENOENT (the error code for "algorithm not found") instead=
 of
> +        * -EACCES or -EPERM, for the highest chance of correctly trigger=
ing
> +        * fallback code paths in userspace programs.
> +        *
> +        * Don't log a warning, since it would be noisy.  iwd tries to bi=
nd a
> +        * bunch of algorithms that it never uses.
> +        */
> +       return -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(af_alg_check_restriction);
> +
>  static void alg_do_release(const struct af_alg_type *type, void *private=
)
>  {
>         if (!type)
>                 return;
>
> @@ -504,10 +556,13 @@ static int alg_create(struct net *net, struct socke=
t *sock, int protocol,
>                       int kern)
>  {
>         struct sock *sk;
>         int err;
>
> +       if (READ_ONCE(af_alg_restrict) =3D=3D 2)
> +               return -EAFNOSUPPORT;
> +
>         if (sock->type !=3D SOCK_SEQPACKET)
>                 return -ESOCKTNOSUPPORT;
>         if (protocol !=3D 0)
>                 return -EPROTONOSUPPORT;
>
> @@ -1220,31 +1275,36 @@ int af_alg_get_rsgl(struct sock *sk, struct msghd=
r *msg, int flags,
>  }
>  EXPORT_SYMBOL_GPL(af_alg_get_rsgl);
>
>  static int __init af_alg_init(void)
>  {
> -       int err =3D proto_register(&alg_proto, 0);
> +       int err;
> +
> +       af_alg_header =3D register_sysctl("crypto", af_alg_table);
>
> +       err =3D proto_register(&alg_proto, 0);
>         if (err)
> -               goto out;
> +               goto out_unregister_sysctl;
>
>         err =3D sock_register(&alg_family);
> -       if (err !=3D 0)
> +       if (err)
>                 goto out_unregister_proto;
>
> -out:
> -       return err;
> +       return 0;
>
>  out_unregister_proto:
>         proto_unregister(&alg_proto);
> -       goto out;
> +out_unregister_sysctl:
> +       unregister_sysctl_table(af_alg_header);
> +       return err;
>  }
>
>  static void __exit af_alg_exit(void)
>  {
>         sock_unregister(PF_ALG);
>         proto_unregister(&alg_proto);
> +       unregister_sysctl_table(af_alg_header);
>  }
>
>  module_init(af_alg_init);
>  module_exit(af_alg_exit);
>  MODULE_DESCRIPTION("Crypto userspace interface");
> diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
> index 787aac8aeb24..b9217f9086aa 100644
> --- a/crypto/algif_aead.c
> +++ b/crypto/algif_aead.c
> @@ -32,10 +32,15 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/net.h>
>  #include <net/sock.h>
>
> +static const struct af_alg_allowlist_entry aead_allowlist[] =3D {
> +       { "ccm(aes)", true }, /* bluez */
> +       {},
> +};
> +
>  static inline bool aead_sufficient_data(struct sock *sk)
>  {
>         struct alg_sock *ask =3D alg_sk(sk);
>         struct sock *psk =3D ask->parent;
>         struct alg_sock *pask =3D alg_sk(psk);
> @@ -342,10 +347,16 @@ static struct proto_ops algif_aead_ops_nokey =3D {
>         .poll           =3D       af_alg_poll,
>  };
>
>  static void *aead_bind(const char *name)
>  {
> +       int err;
> +
> +       err =3D af_alg_check_restriction(name, aead_allowlist);
> +       if (err)
> +               return ERR_PTR(err);
> +
>         return crypto_alloc_aead(name, 0, AF_ALG_CRYPTOAPI_MASK);
>  }
>
>  static void aead_release(void *private)
>  {
> diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
> index 5452ad6c1506..a8d958d51ece 100644
> --- a/crypto/algif_hash.c
> +++ b/crypto/algif_hash.c
> @@ -14,10 +14,28 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/net.h>
>  #include <net/sock.h>
>
> +static const struct af_alg_allowlist_entry hash_allowlist[] =3D {
> +       { "cmac(aes)", true }, /* iwd, bluez */
> +       { "hmac(md5)", true }, /* iwd */
> +       { "hmac(sha1)", true }, /* iwd */
> +       { "hmac(sha224)", true }, /* iwd */
> +       { "hmac(sha256)", true }, /* iwd */
> +       { "hmac(sha384)", true }, /* iwd */
> +       { "hmac(sha512)", true }, /* iwd, sha512hmac */
> +       { "md4", true }, /* iwd */
> +       { "md5", true }, /* iwd */
> +       { "sha1", false }, /* iwd, iproute2 < 7.0 */
> +       { "sha224", true }, /* iwd */
> +       { "sha256", true }, /* iwd */
> +       { "sha384", true }, /* iwd */
> +       { "sha512", true }, /* iwd */
> +       {},
> +};
> +
>  struct hash_ctx {
>         struct af_alg_sgl sgl;
>
>         u8 *result;
>
> @@ -380,10 +398,16 @@ static struct proto_ops algif_hash_ops_nokey =3D {
>         .accept         =3D       hash_accept_nokey,
>  };
>
>  static void *hash_bind(const char *name)
>  {
> +       int err;
> +
> +       err =3D af_alg_check_restriction(name, hash_allowlist);
> +       if (err)
> +               return ERR_PTR(err);
> +
>         return crypto_alloc_ahash(name, 0, AF_ALG_CRYPTOAPI_MASK);
>  }
>
>  static void hash_release(void *private)
>  {
> diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
> index 4dfe7899f8fa..bd522915d56d 100644
> --- a/crypto/algif_rng.c
> +++ b/crypto/algif_rng.c
> @@ -48,10 +48,14 @@
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
>  MODULE_DESCRIPTION("User-space interface for random number generators");
>
> +static const struct af_alg_allowlist_entry rng_allowlist[] =3D {
> +       {},
> +};
> +
>  struct rng_ctx {
>  #define MAXSIZE 128
>         unsigned int len;
>         struct crypto_rng *drng;
>         u8 *addtl;
> @@ -199,10 +203,15 @@ static struct proto_ops __maybe_unused algif_rng_te=
st_ops =3D {
>
>  static void *rng_bind(const char *name)
>  {
>         struct rng_parent_ctx *pctx;
>         struct crypto_rng *rng;
> +       int err;
> +
> +       err =3D af_alg_check_restriction(name, rng_allowlist);
> +       if (err)
> +               return ERR_PTR(err);
>
>         pctx =3D kzalloc_obj(*pctx);
>         if (!pctx)
>                 return ERR_PTR(-ENOMEM);
>
> diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
> index df20bdfe1f1f..2b8069667974 100644
> --- a/crypto/algif_skcipher.c
> +++ b/crypto/algif_skcipher.c
> @@ -32,10 +32,24 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/net.h>
>  #include <net/sock.h>
>
> +static const struct af_alg_allowlist_entry skcipher_allowlist[] =3D {
> +       { "adiantum(xchacha12,aes)", false }, /* cryptsetup */
> +       { "adiantum(xchacha20,aes)", false }, /* cryptsetup */
> +       { "cbc(aes)", true }, /* iwd */
> +       { "cbc(des)", true }, /* iwd */
> +       { "cbc(des3_ede)", true }, /* iwd */
> +       { "ctr(aes)", true }, /* iwd */
> +       { "ecb(aes)", true }, /* iwd, bluez */
> +       { "ecb(des)", true }, /* iwd */
> +       { "hctr2(aes)", false }, /* cryptsetup */
> +       { "xts(aes)", false }, /* cryptsetup benchmark */
> +       {},
> +};
> +
>  static int skcipher_sendmsg(struct socket *sock, struct msghdr *msg,
>                             size_t size)
>  {
>         struct sock *sk =3D sock->sk;
>         struct alg_sock *ask =3D alg_sk(sk);
> @@ -307,10 +321,16 @@ static struct proto_ops algif_skcipher_ops_nokey =
=3D {
>         .poll           =3D       af_alg_poll,
>  };
>
>  static void *skcipher_bind(const char *name)
>  {
> +       int err;
> +
> +       err =3D af_alg_check_restriction(name, skcipher_allowlist);
> +       if (err)
> +               return ERR_PTR(err);
> +
>         return crypto_alloc_skcipher(name, 0, AF_ALG_CRYPTOAPI_MASK);
>  }
>
>  static void skcipher_release(void *private)
>  {
> diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
> index 7643ba954125..4e9ed8e73403 100644
> --- a/include/crypto/if_alg.h
> +++ b/include/crypto/if_alg.h
> @@ -159,13 +159,21 @@ struct af_alg_ctx {
>         unsigned int len;
>
>         unsigned int inflight;
>  };
>
> +struct af_alg_allowlist_entry {
> +       const char *name;
> +       bool privileged;
> +};
> +
>  int af_alg_register_type(const struct af_alg_type *type);
>  int af_alg_unregister_type(const struct af_alg_type *type);
>
> +int af_alg_check_restriction(const char *name,
> +                            const struct af_alg_allowlist_entry allowlis=
t[]);
> +
>  int af_alg_release(struct socket *sock);
>  void af_alg_release_parent(struct sock *sk);
>  int af_alg_accept(struct sock *sk, struct socket *newsock,
>                   struct proto_accept_arg *arg);
>
>
> base-commit: 1dc18801be29bc54709aa355b8acd80e183b03cd
> --
> 2.54.0
>
>


--=20
Luiz Augusto von Dentz
