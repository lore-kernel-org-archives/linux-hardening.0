Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672503;
	b=iRJJa2R6awazBVL61PtuEqsM9DUNBDA7sJriC+uDUuq0xZ0rojB1HacFMfuh+JuGyLnk
	 HHvb3feEC6YVkNeSyoG76vjTW6dLvaw0I3sPEW2owUslzh4UKin3JJJ/rCQkdyev4Do0m
	 5NQKhel+W+hilo7sbGfQk+cYdYY2hVn+3/mR3ZBifEjdaSF/uUX/3AbQPGBJYod3HlrV0
	 RBAc1je8YnZNjll+/CqrLCmhz/R7mYPqyqV4o57Rn1S+w/3N8ornTCZ0ScEytMzozptzG
	 xAU59TcgD85M+r74hl2T3aCQR8Rv+YNA/15d9XLMVlKhpo//OqHJCiArS0d0l57Z7Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672503;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SsXnkh9rZiup8TkTxbsw+huciahwayKl9nCe3uqM0fY=;
	b=CUELOcJXN20awHeFQ5qNpHdFF3jcakZSRAO03+qAU9vKeNLNIoYjbuVan7xjz0DDyweM
	 GXID8vsrQ58rQWJBlVYpjfvi4dBy9ScSOSBxDBO/O1827yDcNatmPLFcy76IZYWBKa/89
	 747uj/PiI7eY+VeQoYjHSCN0zDWySrmMSs/xT2tD/G9TdwmR3aW5lUUNyHbeBDs++NU+n
	 fvE8RilvMl+oKJQW8TKcBz6OghDHGeQwhijEP3kQWdwevOpMFHmOBn7LuOQfBVO9WEjLt
	 c6TmHusnqB/1kLQ75tyEXi6b6WF90d/m5OqprVYS+WxRGeStdWqn5NWlxehO8/o3Z1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CspZqle+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD00606A31C
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CspZqle+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED051F000CA
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 05:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795672502;
	bh=SsXnkh9rZiup8TkTxbsw+huciahwayKl9nCe3uqM0fY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CspZqle+6/NpEdNZ0XRYOcy3DQM56ynq8GgPFnEww1nIVojCNilLh7XDN96ZKY2FN
	 luhytLuBN3/zPrOFGgNbPB4YHK+qi+Y6yVKhcsD9eok/bv7Fn9/0JEz4OyJ5H9lDTT
	 LUWGpKp6wjqyIO2KB0cnxNivSzvl5nz/Ck8uWitSkBJnQ4tYaQK1r1w8tYtOnMVdam
	 Q2/3vAsiaTJhAOmyWZE5z/U+P6BiZRoGxvAr69hhbxdEqUVDGWTAKLhwd1O1qVNANS
	 6/iAnM7Apr2h+z9OiKxeuDR2FgSJsZgM/LWbwHBIr55h63YS5SjE/RoKB3JyGC7yC9
	 OL06PzZyyexLw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c51bf011392so108037266b.3
        for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 21:55:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF1e2Kny+26oUxpxGGGmmGmiKba3I8n9iZIHEqkjkN+R2HTeX4wzwW+5w6TR1MQnbaXpH+leGutj/BkRriN4bw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W99ZpLw/pSD95zA6kL+0i+9IN3Qmd02RuuYM35dnDMKOwkK4f
	P6eCtpi3JNjwZRFzubjB4wLvRAmfsNzwwXvd+YuRPimHt3XsFMtR9MQPlVanVievshg8spF4YRk
	9YCzIsvHAxk1ya4+O48HyyMEojI3X5oe6JIUsb+UE4w==
X-Received: by 2002:a17:906:4fc8:b0:c51:ab6:1c73 with SMTP id
 a640c23a62f3a-c513aaff9c8mr1746636066b.23.1795672501752; Wed, 25 Nov 2026
 21:55:01 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795439990.git.lianux.mm@gmail.com> <9f3715ab29bc9ee4aaa1bb92bff47c7584b73ee7.1795439990.git.lianux.mm@gmail.com>
In-Reply-To: <9f3715ab29bc9ee4aaa1bb92bff47c7584b73ee7.1795439990.git.lianux.mm@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 25 Nov 2026 21:54:50 -0800
X-Gmail-Original-Message-ID: <CACePvbXWL-CHKiG6hw6vFKbERDXLU_v3mfi7V=6hbaW1y8hs8g@mail.gmail.com>
X-Gm-Features: Aa3M54oBQMzNvzYM2e4PD29_5XhYK-wobZpG4mQp3FDlOc_DSnwaHTsE7U41QGs
Message-ID: <CACePvbXWL-CHKiG6hw6vFKbERDXLU_v3mfi7V=6hbaW1y8hs8g@mail.gmail.com>
Subject: Re: [PATCH v5 01/19] mm/swap: remove unused parameter for reading
 swap header
To: Lian Wang <lianux.mm@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Jihan LIN <linjh22s@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Thomas Gleixner <tglx@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 6:16=E2=80=AFAM Lian Wang <lianux.mm@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> The swap_info_struct argument to read_swap_header() is unused. Remove it
> and update the swapon() call site.
>
> No functional change.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

> ---
>  mm/swapfile.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index d59fa8220862..c06f9f532e74 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3630,9 +3630,8 @@ __weak unsigned long arch_max_swapfile_size(void)
>         return generic_max_swapfile_size();
>  }
>
> -static unsigned long read_swap_header(struct swap_info_struct *si,
> -                                       union swap_header *swap_header,
> -                                       struct inode *inode)
> +static unsigned long read_swap_header(union swap_header *swap_header,
> +                                     struct inode *inode)
>  {
>         int i;
>         unsigned long maxpages;
> @@ -3863,7 +3862,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>         }
>         swap_header =3D kmap_local_folio(folio, 0);
>
> -       maxpages =3D read_swap_header(si, swap_header, inode);
> +       maxpages =3D read_swap_header(swap_header, inode);
>         if (unlikely(!maxpages)) {
>                 error =3D -EINVAL;
>                 goto bad_swap_unlock_inode;
