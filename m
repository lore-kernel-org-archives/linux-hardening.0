Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C19B14A4FB
	for <linux-hardening@vger.kernel.org>; Wed,  7 Aug 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066490; cv=none; b=rOYRlhC5GMhH4Ztt9ea0ZsBLJPsgPVJ5BqM7jMvDinZ9Gs7ViFbSxpWVybyq9Kr53VAVAqrMCWX3NjOoaGXG5Zvtymabkgl+md1+XEJFvisP3DA9BqvlVg/eMsNPixGws539K33T5e+8xism+IOUpWVu3GP1L+y8ZARBZ4VhUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066490; c=relaxed/simple;
	bh=IfTmzCgemNzO1EeqL3QXq0dVMqNRi+5qQivEFOVJ1VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BF+2XLdJSFHyzzW94Dx/VIKa6BhAk2LyJsEzqLuAhDJ7vvFm0/rov5fD5mYiT9yhj83xf9QH64oChLcCpwIjZZEnJH4mxbnAywrMFb/UtWddr01OwIh6U1p9XH1RuUXNSho48X9tB+CLC/QeIueV9aUHvIZskFr6JpmyX5earFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mcRL2ecq; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mcRL2ecq"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-260f057aa9bso227520fac.2
        for <linux-hardening@vger.kernel.org>; Wed, 07 Aug 2024 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723066488; x=1723671288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfTmzCgemNzO1EeqL3QXq0dVMqNRi+5qQivEFOVJ1VA=;
        b=mcRL2ecq0/dMdPe3hEsVX7V6M5CgVFjU8cSQNOg8q0N4Ha/5rLaIFr3dw42g0QRa0N
         RTBhG6681NRFKpeF32jzoo+qiEUi7CWCGwCkTwIoo+/xbVM2/OZFd4WRYqozPWHwr+S2
         Oao5Zu03Z3fHHaJXM28134rS3lrayL8It7k1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066488; x=1723671288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfTmzCgemNzO1EeqL3QXq0dVMqNRi+5qQivEFOVJ1VA=;
        b=vZZ/065lr3xNePiGUt9w/ts5FvDDiQ+zw7kzTOUzrHroAMBK+pjlhe2Aotgl/2/qD+
         ydl9A4I9otGUOymoyY91oD/vZyWF/VCdoFJZrhmMqpRA3vYX7xyIJ+2p2o/D9f2PbL5X
         3n387kWbBqkaJbeNO35y8wMHkRmWwhxJfbO/kYak1UbvGfl7KqlnjEe5xFlFxEN4WSg6
         zMIb4AGsI/vnBry5zC7/UnMm7vvKmGcFooAwEYJbRSfRbwyEKznvp9GzHRZpjITQcIUu
         OIuAOrUmj/WyCWZyScOxWICWjYCm9YK84+Go621Xldv27oJ1z6RoByvPSLXMazuK4vji
         +W7w==
X-Forwarded-Encrypted: i=1; AJvYcCWIwWEiwmvfehShfnsXduku1SrnV5tTNajyNEMnFo1vqfwbI2Bx8lw68+xSfiLDWAHTTQ2EjNmjUovhSJ0jVzB0gznKpIzYhD6mEqC4FqLg
X-Gm-Message-State: AOJu0YxeqKoe8dBcs6SJuftrTABrPTkUAvzkZxabDsnW/Hh9jzCTJEZM
	yUe9HKVaNknxU74xbe/MFRcMTs0oFDnR0ItkHINOugPj5RoUVHczWrtR296ECdEWeT0Rym2LAQ1
	hIsdgnCYIt/cQyjW66ivF4Y/NkU0otuU73tyI
X-Google-Smtp-Source: AGHT+IG5ES7X4tgKDJv9g84tk9ALZ7Sp67s0jLTzG1Iz9nJGWu6UaYHks+HxXA4YIPNwg8kjSy39pOHEV1+hFz8rf/M=
X-Received: by 2002:a05:6870:3051:b0:25e:b732:a913 with SMTP id
 586e51a60fabf-2689175a388mr24548521fac.0.1723066488042; Wed, 07 Aug 2024
 14:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153544.2754247-1-jeffxu@chromium.org> <CAKbZUD2xDdbxOTvR3-P=636jvhG_JPO3h79tgB59dfPmv046hg@mail.gmail.com>
 <CALmYWFvDH=8U8wsaSjMrfCg1__S66SS-9Zo0f826XJDJT7hOSQ@mail.gmail.com> <CAKbZUD0JuEwfd2VnY_Kbv2Mr0g0KN2T2mYCLhPuS8j6PhbCNiQ@mail.gmail.com>
In-Reply-To: <CAKbZUD0JuEwfd2VnY_Kbv2Mr0g0KN2T2mYCLhPuS8j6PhbCNiQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 7 Aug 2024 14:34:36 -0700
Message-ID: <CABi2SkVX7nFwPDAQaYWn2Y33OnJRs8NJQv0oW-QJUcSYB8a6tQ@mail.gmail.com>
Subject: Re: [PATCH v1] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:20=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 7:03=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote:
> > Do you have any suggestions here ? I can think of two options to choose=
 from:
> >
> > 1> use 0xd0000000
> > 2> allocate a memory then free it, reuse the ptr.
>
> Personally I'd prefer 2, if you really want to keep the test. It's
> also a strategy used elsewhere (e.g mremap_dontunmap.c).
>
V2 is sent with 2.
Thanks for reporting this.

-Jeff
