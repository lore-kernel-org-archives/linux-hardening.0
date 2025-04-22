Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8F28F92A;
	Tue, 22 Apr 2025 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335506; cv=none; b=gRPzi1sDGp8RWHIYX6ztSOOvo0nqTZEf/IeX3y1PYMGzPGEMMQ3WHnh+pOh4Nv6iZBODvfxI8ERU0MImYTVjdcASkA1TmWE64QbikV5CH6ngm2cJbOe3++0mKf6WV4s51Kk2/u7gT7f4+tjdudRJJu11cN0Qzl/ogb0foFlWi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335506; c=relaxed/simple;
	bh=b9bfDXv0Z2DbK700HYsmu4Rp3CLg65fpjxDmG4VIWFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c50bUN17wW8U9WaTVm5l+xvBwslLJtEjmZVZLzvn1C/WaqWjJPDo6GX948v/FMZm2STjNbQFrNgLyrkMaHlU/uqtwU8tVMwvJKBu3qlL0KzT+JUtOBg8cKXmCozD3AoYXpjjBirHDnGc3lZO9PW8vQKUC2rXD6rTHGEh2pUC6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkOGJcGs; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkOGJcGs"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b1276984386so109423a12.0;
        Tue, 22 Apr 2025 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745335504; x=1745940304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vDqQdhlV6K1g44V2MO+orh6zIAZuQgVJU448hs2xyg=;
        b=gkOGJcGspHIwjc0RjQD4/CCcmbVhlWIGRqzEXWFxBFDyZpjnLnaGzdQbsnPs7eYvJS
         9Ui8gl/8UuUPNdhheGHC7bjiXsD87A3CLU42p9obqowUfyQP5Pmog5tv2VFU9oRZCO+1
         A4jLrUWxjFJaatFNvu6LfHjNU3xK1nyaZHDOfkER9U+eDxaLwxyw7uHqXYmdZQ4tcJDo
         2DzV0yyUvLACN+hSKIcfWAC+EWiGA1HJeS0HQbpPtnCquhAcReaPsVjzzzkvxX4Cg1Kz
         jkuJsKoYteWOi4Danoj4/8bu4svtjrlikOtqmmjL/yTK8G4GOU/yeDz54ion2bFFVnVN
         Wqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745335504; x=1745940304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vDqQdhlV6K1g44V2MO+orh6zIAZuQgVJU448hs2xyg=;
        b=gK+odeQSAqiy8Uwgc1nZCrgrjk9qenpsMewwbQBoz9eiSrF2efTRYRQVh9VX79Wg05
         z/fvIz6wgs61m/hyiRllKtesOxr0ZgOvhCIw0uYoDbbo/89nMwVaXxOuFfSQbyb1LY5I
         RHCZWfOesUWuJ0IXNbgD+76WRoohQeU1xkuwsf7YJh6yuurAR7j6Y6EUR+eD0UGhiyUg
         sJVE6oumD4N+u8BhXkP6Mg2wYQ9ajugG7Qj37gYhKK+DCzhtbFbpTvgfLAtjVzPWDw/W
         znQuOYi6c8i4t7xyLVsuvVeeI7BWFPhnFKLUdFjMzdX3VHZsHaBlxOf4V6yIHyKeb7Bb
         Nvkg==
X-Forwarded-Encrypted: i=1; AJvYcCVuLfOXt4YFEr60iKgiMSNq76yVDvnnpSRVhvzDgh4AJSDx+R/kXl1mjFa0/K8HQvHGEQULKb0VAixJoMqtoR4=@vger.kernel.org, AJvYcCX0IDFK5wHR031GiAw3ShyxOwc43QDwFPngzkmpuRKtt3M6yTd/1rP4NWWPfTCmwCKOUqWqAPQhqkxn81Zf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4nocyOlohl9O1hOxP0Q4sj5pv4imkPAV5ZSeWOp498q1zrQ4
	8G6MXA6JZHH450MkFN2so4FZQFTCsiNwovxaO7pnSX3hLz8paug+bMoD15xXIofw3U0AgxZRYnw
	F0udCEhfJdiRy7xdoY4qH1qaK52U=
X-Gm-Gg: ASbGncuMNKhRfhwBAo3YbJahD7SbpSTfBYBZpBAHOOXbxfq/kmUXMX898zlSkOpbVeN
	kTRC9HEv6o+zVgduAId36eJeCHe3SLx1OzLvnFb916V9cx4RHL578wCxc8JiJkl/Jdx+N6qPQp0
	5YooEhvKajP/W10JDL8+/d5w==
X-Google-Smtp-Source: AGHT+IE0mBEY5TL7BdwUTIPiJoEE3w4k5pGY2WN1PZHGIVPpSPR667SNMI7xE+LINKJpITF5xTTsY8zMQltqeALGF6w=
X-Received: by 2002:a17:90b:33d2:b0:305:5f31:6c63 with SMTP id
 98e67ed59e1d1-3087bcd50b5mr9034048a91.6.1745335503645; Tue, 22 Apr 2025
 08:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421215833.work.924-kees@kernel.org> <CADnq5_MbGS+DBRZhQccqP-o50vvv6uiT31msefRTw5bMydAAKg@mail.gmail.com>
 <202504220755.179FD11DAD@keescook>
In-Reply-To: <202504220755.179FD11DAD@keescook>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 11:24:51 -0400
X-Gm-Features: ATxdqUGzNJyWfxfrM2voJs_-V9FhvQHWxBTvwOEbE9UpStQwCBAP4Mn-zzvaJO8
Message-ID: <CADnq5_OmuPFE5KvHsUAFMdT4irNKK8zrwsiVXVk2au2mPWpHkw@mail.gmail.com>
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

On Tue, Apr 22, 2025 at 10:56=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Apr 22, 2025 at 09:22:26AM -0400, Alex Deucher wrote:
> > On Mon, Apr 21, 2025 at 5:59=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > GCC really does not want to consider NULL (or near-NULL) addresses as
> > > valid, so calculations based off of NULL end up getting range-tracked=
 into
> > > being an offset wthin a 0 byte array. It gets especially mad about th=
is:
> > >
> > >                 if (vbios_str =3D=3D NULL)
> > >                         vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
> > >         ...
> > >         if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
> > >                 vbios_str++;
> > >
> > > It sees this as being "sizeof(BIOS_ATOM_PREFIX) - 1" byte offset from
> > > NULL, when building with -Warray-bounds (and the coming
> > > -fdiagnostic-details flag):
> > >
> > > In function 'atom_get_vbios_pn',
> > >     inlined from 'amdgpu_atom_parse' at drivers/gpu/drm/amd/amdgpu/at=
om.c:1553:2:
> > > drivers/gpu/drm/amd/amdgpu/atom.c:1447:34: error: array subscript 0 i=
s outside array bounds of 'unsigned char[0]' [-Werror=3Darray-bounds=3D]
> > >  1447 |         if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
> > >       |                                  ^~~~~~~~~~
> > >   'amdgpu_atom_parse': events 1-2
> > >  1444 |                 if (vbios_str =3D=3D NULL)
> > >       |                    ^
> > >       |                    |
> > >       |                    (1) when the condition is evaluated to tru=
e
> > > ......
> > >  1447 |         if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
> > >       |                                  ~~~~~~~~~~
> > >       |                                  |
> > >       |                                  (2) out of array bounds here
> > > In function 'amdgpu_atom_parse':
> > > cc1: note: source object is likely at address zero
> > >
> > > As there isn't a sane way to convince it otherwise, hide vbios_str fr=
om
> > > GCC's optimizer to avoid the warning so we can get closer to enabling
> > > -Warray-bounds globally.
> > >
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> >
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Thanks!
>
> > Do you want me to pick this up, or do you want to take this through
> > some other tree?
>
> Whatever is easier for you. I'm happy to carry it if you'd like. :)
> There's no rush on these -- it's been a long road to getting
> -Warray-bounds enabled. ;)

I've picked it up.  Thanks!

Alex

>
> --
> Kees Cook
