Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E97281502;
	Tue, 22 Apr 2025 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328160; cv=none; b=gI/qy8tC4UDMl1Y7AAitBJDywutrM6dR/is07SSUtjA9QsvVx3kywl6MABEDIZEDDivALGuncAJ/1V+4AiBIzoUZD5b9JTV5S8d1Rc5+K+GW82HpT0QtEXKP/rdZLqtkLcpL6KjwXTZJmmwLx0Aw7AhkeSYsDGTCjJdCpTadaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328160; c=relaxed/simple;
	bh=Jl9Jc8N7Hy6KUWaz+6+PADzLOfw7WYyXtvlJj/sN+Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dATY+7JSD9kgkwNlHY2bODwxR5+Uw8hODKJ+NoUUFofG3cb7Qnj/okEqiCHhrqwVd4viN7qK0ZHUQJPvBTjezSkgdFeqWm+iMjfqwxllcI7Yh7hCPdg7ER9fEKSvodu8f4IrpRBbOImY5Ar6HwwxllnJsJn41SNhF5xD1nNd+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP7BU4Fk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP7BU4Fk"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so614908a91.3;
        Tue, 22 Apr 2025 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745328158; x=1745932958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBILyizekAjPCmmmdo2HKqcc4V7w+tmXlAj3jy+pQkY=;
        b=OP7BU4FkibX7F9X2DUUZf/L2/9SdTEy/Dg/5pBwt/fYbJnfDX9iIl1IOYNuo0YnIsD
         RRSpBKPdjZ9xxUU0m5jdVvOzJClGsbInJN6ByGHcGeFkbEldOv4pEBLShAQfkZTjrb7Y
         jMMWQDUP+IetivAIXMIi7ygVpfNdfhl65OnK0ZCHemNz8d+nacUvUgRsVYTS2KzdArEB
         RRmxFbhuO7tWp53qF1+N3eSUk0497HWKSP8tn83uTY1EZ76priRlaPMdTZj/c4HetlvA
         JOHZkoCiHMafdSEj2iNwHaes9IS8zfMjAxHgmdYLhsbPlK2554Aw4lr0Q1NlLJppEPu9
         hM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745328158; x=1745932958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBILyizekAjPCmmmdo2HKqcc4V7w+tmXlAj3jy+pQkY=;
        b=o+/K5wSWsNlvKaspJ529Vm4gzdfIW5k7i27+ZuaFSyu6Ue4B25CPGMHh40IbpEVceC
         rc5+j80cdG5uuXVwpgEefCXexo959Uam4W018kkzwZU9RfEPNadHVFYEmFmvNSyDh6rr
         1iYzcMPpEVoQ2LsloHt+kU9h35bGfD/uuA6WhAv6fhP8U/sFJaSaTEptXhWQcTZ5GP9g
         f3BLhG08MoraZPsXWRJkV2b15yodQskit8qKhijGBfizrAU82U3WKh8YCLcFmfauWQDK
         OHTEL93SFrs2PoX0+hl6t6CpfBIIa+yVHQ2qRlkvgVJC/C2+IwRLW6MU0HbTK5iu2fLN
         SC2g==
X-Forwarded-Encrypted: i=1; AJvYcCUMjlsCcbitaYnaQBjZxI1UpF+rZq0znbMMO4rTSLa9NTtpxzcCB+MlrX3jL/tcEckdDufJaX/8XN+k98l5@vger.kernel.org, AJvYcCXMaf0vHQWMHccjRw96gk6j1nZKTn3AnTKHyrGnhLSQBgzuuCup3+FTexjZoXfassoLWld3xZaK8wqFm5rTIOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYaXYBK8YSBRvQIdKhie3g3UwEONknnlxjHW5gH22Xdlo5IcPn
	lek1B4e0lrGWeH4+OyStC+YKbhoX4c4rr6OQ0qPhNK49TbVBNkWFsprW8GIc/dLR2R6OJt50MSq
	uw/jj/9ON2pzPN/aleppOBiARtr4=
X-Gm-Gg: ASbGncs3DEUx1sMz6xBdtqgsPwe3n/Qnjs32/MIOKQXZml4ZGb//rk4qhpRuCZzBJcm
	IxQzRdgvCywONbvN5hR70JQBNkqWZ2eM5B8RrsUZ6WxasUI2bKQP5IYbe31NMecyjixsjWZpXqY
	Gg0JqVwsAy/qILyqrN3QvtIwzN6XmC21S0
X-Google-Smtp-Source: AGHT+IEHxIXJ57o2vAr1MKjS3Ux5RQVm7gJxKy8BTvCUtNN6vjof8j5ax/+3hlrY42ZuLwk/zzHCuS0iACWxFSW1XL4=
X-Received: by 2002:a17:90b:3b8d:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-3087bb426aemr9258177a91.1.1745328158110; Tue, 22 Apr 2025
 06:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421215833.work.924-kees@kernel.org>
In-Reply-To: <20250421215833.work.924-kees@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 09:22:26 -0400
X-Gm-Features: ATxdqUGJQNgaoaG-hS1nqNwSeL05Pe4-dnmCjl-rEQJYX-mGdL9-b6jNGkZx9D0
Message-ID: <CADnq5_MbGS+DBRZhQccqP-o50vvv6uiT31msefRTw5bMydAAKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atom: Work around vbios NULL offset false positive
To: Kees Cook <kees@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jesse Zhang <jesse.zhang@amd.com>, Tim Huang <Tim.Huang@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Alexander Richards <electrodeyt@gmail.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 5:59=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> GCC really does not want to consider NULL (or near-NULL) addresses as
> valid, so calculations based off of NULL end up getting range-tracked int=
o
> being an offset wthin a 0 byte array. It gets especially mad about this:
>
>                 if (vbios_str =3D=3D NULL)
>                         vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
>         ...
>         if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
>                 vbios_str++;
>
> It sees this as being "sizeof(BIOS_ATOM_PREFIX) - 1" byte offset from
> NULL, when building with -Warray-bounds (and the coming
> -fdiagnostic-details flag):
>
> In function 'atom_get_vbios_pn',
>     inlined from 'amdgpu_atom_parse' at drivers/gpu/drm/amd/amdgpu/atom.c=
:1553:2:
> drivers/gpu/drm/amd/amdgpu/atom.c:1447:34: error: array subscript 0 is ou=
tside array bounds of 'unsigned char[0]' [-Werror=3Darray-bounds=3D]
>  1447 |         if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
>       |                                  ^~~~~~~~~~
>   'amdgpu_atom_parse': events 1-2
>  1444 |                 if (vbios_str =3D=3D NULL)
>       |                    ^
>       |                    |
>       |                    (1) when the condition is evaluated to true
> ......
>  1447 |         if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
>       |                                  ~~~~~~~~~~
>       |                                  |
>       |                                  (2) out of array bounds here
> In function 'amdgpu_atom_parse':
> cc1: note: source object is likely at address zero
>
> As there isn't a sane way to convince it otherwise, hide vbios_str from
> GCC's optimizer to avoid the warning so we can get closer to enabling
> -Warray-bounds globally.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Do you want me to pick this up, or do you want to take this through
some other tree?

Thanks,

Alex

> ---
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Jesse Zhang <jesse.zhang@amd.com>
> Cc: Tim Huang <Tim.Huang@amd.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Alexander Richards <electrodeyt@gmail.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 81d195d366ce..427b073de2fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1444,6 +1444,7 @@ static void atom_get_vbios_pn(struct atom_context *=
ctx)
>                 if (vbios_str =3D=3D NULL)
>                         vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
>         }
> +       OPTIMIZER_HIDE_VAR(vbios_str);
>         if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
>                 vbios_str++;
>
> --
> 2.34.1
>
