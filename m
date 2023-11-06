Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532E5381
	for <linux-hardening@vger.kernel.org>; Mon,  6 Nov 2023 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dy62QEtq"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422CCC
	for <linux-hardening@vger.kernel.org>; Mon,  6 Nov 2023 00:47:36 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40837124e1cso83635e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 06 Nov 2023 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699260455; x=1699865255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSdh9aVbvYJU/GlJs9OpXtR3as1eL/wmBH+XlHFyTXE=;
        b=dy62QEtqpJVO2ztNFZX4EAFPPHWQa3/P+9cwiDUdhDyPizttWHGQ9MzRD67V/NMhv8
         0g/AQda9YUva8f3WXjwS3Smd3sbWSeOHADxIo1QbFP4Kaq+hb76lLdl8LYiM6r4vaeWe
         Xiig033d2KC8h/sz+t9fUmudF3bsLEy8rTny8k1iscauI8zyUa3T64nEVMHv8VtUcwsQ
         Z9kHOgafbq60CQvbBBigMaploeWsBrg8fp4YBeov1+5g13q+RqTnlmxtFiTSrQ5JpklS
         hCpj4C2tqhwGbH9JYM+GJnN6Y8cEoRqTNtbvI/QZcmEqbGreguQVJ9GFLmPOLBD9ZKea
         RwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699260455; x=1699865255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSdh9aVbvYJU/GlJs9OpXtR3as1eL/wmBH+XlHFyTXE=;
        b=PX667IUEONvtWSfyX2JEFU3qERhxiObzsEksgnAwmiosU0axBuVxwIDDh5n8lfkmwp
         a0FdNiprXuAItgUipkHEbjOpilBda43HbPo2QcCAR6WyKVXfetTSz1v69ZslRlRv6lu4
         YuOVCd+bt41sqG9Oa/dqkQoZs+TqnT6wUuA0B0JWSoAEd3SMY9BuUilgcrL/IL6e5S+G
         FWSMdQGqUUdVj4cMI0BqjcJrFKiHyVbtajDNyAoPi7lUBmrhcGL6OP9H4eDqHk+0vtjj
         V7utp6Xv9XIUlFfMma+HOzEDY2twMRMb8hCAu3td0TkVTDJr15jBPlWRT1WxwlqsqEw8
         iE6A==
X-Gm-Message-State: AOJu0Yw5gJN/LsNnYvR7s50frVt81XHYo45pcLY94XR8DSW+aQZS4K7m
	E1/mseJqdghfMqoUgJh4EsVQOugZxhZzk8e8z/q3AxuHWUWH79IOzQ==
X-Google-Smtp-Source: AGHT+IFjXQo0PLW9gw8Q2YKPL+L1TqM4JvXj1Ok6lDJPEm3xegSNCTzZfYeZeWcdkpno4hNdNMtanwweUdv6h/AUNC8=
X-Received: by 2002:a05:600c:3b06:b0:400:c6de:6a20 with SMTP id
 m6-20020a05600c3b0600b00400c6de6a20mr94311wms.3.1699260455014; Mon, 06 Nov
 2023 00:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104204334.work.160-kees@kernel.org>
In-Reply-To: <20231104204334.work.160-kees@kernel.org>
From: Bill Wendling <morbo@google.com>
Date: Mon, 6 Nov 2023 00:47:16 -0800
Message-ID: <CAGG=3QWX0Koj3xNHiRHdiYupy4bFsJ6nNWWcCJkqbu8-GnmfZA@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: randstruct: Only warn about true flexible arrays
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-hardening@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 1:43=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> The randstruct GCC plugin tried to discover "fake" flexible arrays
> to issue warnings about them in randomized structs. In the future
> LSM overhead reduction series, it would be legal to have a randomized
> struct with a 1-element array, and this should _not_ be treated as a
> flexible array, especially since commit df8fc4e934c1 ("kbuild: Enable
> -fstrict-flex-arrays=3D3"). Disable the 0-sized and 1-element array
> discovery logic in the plugin, but keep the "true" flexible array check.
>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311021532.iBwuZUZ0-lkp@i=
ntel.com/
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3D3")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Bill Wendling <morbo@google.com>

> ---
>  scripts/gcc-plugins/randomize_layout_plugin.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-=
plugins/randomize_layout_plugin.c
> index 366395cab490..910bd21d08f4 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -278,8 +278,6 @@ static bool is_flexible_array(const_tree field)
>  {
>         const_tree fieldtype;
>         const_tree typesize;
> -       const_tree elemtype;
> -       const_tree elemsize;
>
>         fieldtype =3D TREE_TYPE(field);
>         typesize =3D TYPE_SIZE(fieldtype);
> @@ -287,20 +285,12 @@ static bool is_flexible_array(const_tree field)
>         if (TREE_CODE(fieldtype) !=3D ARRAY_TYPE)
>                 return false;
>
> -       elemtype =3D TREE_TYPE(fieldtype);
> -       elemsize =3D TYPE_SIZE(elemtype);
> -
>         /* size of type is represented in bits */
>
>         if (typesize =3D=3D NULL_TREE && TYPE_DOMAIN(fieldtype) !=3D NULL=
_TREE &&
>             TYPE_MAX_VALUE(TYPE_DOMAIN(fieldtype)) =3D=3D NULL_TREE)
>                 return true;
>
> -       if (typesize !=3D NULL_TREE &&
> -           (TREE_CONSTANT(typesize) && (!tree_to_uhwi(typesize) ||
> -            tree_to_uhwi(typesize) =3D=3D tree_to_uhwi(elemsize))))
> -               return true;
> -
>         return false;
>  }
>
> --
> 2.34.1
>
>
