Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3543FB25
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 23:26:51 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C9BB
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 16:26:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a9f139cd94so252299666b.2
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 16:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375608; x=1696980408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkOmFORPNdegsvUzletDdGNQTS/35DzAQHoVxYp5MXg=;
        b=g8BdXQY2ymaa+Ax1z7Lecj0GB4zjvxggDOmeVtM/kQn/8YBjYIz0I07RM51X9bcp2x
         MZvnbvAQz6x5X9OlSeEJe9ec6+OQyqFNPktZvPfgDVieDIfOjLZAV+mWjAD3xSza3tnK
         d5q20wEOwJLmLUMru5coi3WCU1T5UgAoIk7GyDWXMkwu5JkkzwDoKMufZILEweUSBgn5
         g26ShFblNyVG1xMHe1WgXzU8wXr3h7yi1UafE9HwEB/tbu9QcD2lrDEEzxpMidIFQsrc
         JIuRF4cGFXwlXPUGx4vTsZSRzb5ac7kwQBCm+svodMikpQx7VV0DnBG3rHGGFr+vSlxp
         FyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375608; x=1696980408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkOmFORPNdegsvUzletDdGNQTS/35DzAQHoVxYp5MXg=;
        b=VdhdPCOzlIUhpZDskFIONXdHe8GH0NDOcq8NWC6gmB8xp1lAYa9MJav6gyMroaSJRc
         uRCKGB953+XlBLo1Ogc31lcXVJ+Tg9/NZ5+HYlD3d2Jyzqia3kNKGzSk51o6wahlZco+
         Jc+MCdXeLIMrPnR5OJZVMesMD0rY3x8i0GpqR6Jhxnbroa4bizjNlrdNOnd99qjNqaFt
         zpgNvR8rnHDKG0+pBlEiRamZcwricTsInS6J/nhJzB94RKEbNQkZhlCLck6pAx/TvHOZ
         IwLZOpsZ+SnxXXNKLFf8w36WNgnhEUPblWre9IgbjJq64Pk/cf5WrHI1NvGbeqF710DF
         ZtNg==
X-Gm-Message-State: AOJu0YyniOnWGdEVzjzzmeN4eTJsUNSufwJhnw6M512vqBf3S3sqsnrp
	uQBcLVzJ0/tZ/hpgdaE0OC4llZTvwqKOiw/xku1X2w==
X-Google-Smtp-Source: AGHT+IF1d5AjAJYgdKzsBfMm7uGg6I8MvuOFlaYXOCXzffRCV1Xz22bcMhb3NFM3XTYkvVVirGgXazVoYcInwB6GX3o=
X-Received: by 2002:a17:906:da8c:b0:9a2:139:f45d with SMTP id
 xh12-20020a170906da8c00b009a20139f45dmr657784ejb.43.1696375607793; Tue, 03
 Oct 2023 16:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003231730.work.166-kees@kernel.org>
In-Reply-To: <20231003231730.work.166-kees@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 3 Oct 2023 16:26:35 -0700
Message-ID: <CAFhGd8qFcusVNabygT2PuuzqaeFH27BJP9BfWiF7Keo-j2RVQg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_flow_handle with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 4:17=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct mlx5_flow_handle=
.
>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples=
/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/=
net/ethernet/mellanox/mlx5/core/fs_core.h
> index 4aed1768b85f..78eb6b7097e1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> @@ -181,7 +181,7 @@ struct mlx5_flow_rule {
>
>  struct mlx5_flow_handle {
>         int num_rules;
> -       struct mlx5_flow_rule *rule[];
> +       struct mlx5_flow_rule *rule[] __counted_by(num_rules);
>  };

Great patch!

handle->num_rules is properly assigned to before handle->rule
has any accesses.

        handle =3D alloc_handle((dest_num) ? dest_num : 1);

then

        static struct mlx5_flow_handle *alloc_handle(int num_rules) {
                ...
               handle->num_rules =3D num_rules;

then

        handle->rule[i] =3D rule;


Reviewed-by: Justin Stitt <justinstitt@google.com>
>
>  /* Type of children is mlx5_flow_group */
> --
> 2.34.1
>
>
Thanks
Justin
