Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FC12BF2E
	for <linux-hardening@vger.kernel.org>; Wed, 31 Jan 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723369; cv=none; b=AqPiFDPPLew5flWsEJ4+c5oFXBb70bJIFZZuvbpf7vwndd5MYh6z66mGoFPK3X+/7EHxg/jc4RX0c8HO2d7ZSjjc47J6pLgwGy17WLB1Ib1qEhYdCLIANgmjMA5CORXK+RbQF+jxxLhe2DzlueSqMkVS07uZzbicpMzA1pc4x2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723369; c=relaxed/simple;
	bh=5BE3rI48gPKiRyCIeJRFwhcAnE7+fiHlRXlKvQEgPZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrzLirlWFJKxUTwhzqvCeLdMJdEOhuzKtiX0qWlz64pLxEzxlIRCI5wuNy7kdzGWAwu5DaCZtLx2EljZ7JFiQ99oydpYdR0OHdCS2Od6wFDE330yko8hnvr7I4AXU9UyHrfBqr1ABqp42dFNkY8VIR0WiJwPxflC7PG9Fr8glsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K7UFPQwu; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K7UFPQwu"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3beb7ce6fbfso30727b6e.0
        for <linux-hardening@vger.kernel.org>; Wed, 31 Jan 2024 09:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706723367; x=1707328167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6RF6oHOyisdh7IJgSnB/tHRIU7aiX32oELeK+JlnUw=;
        b=K7UFPQwuK50txT0dyMiEMKTKgx7Z2zsoZ3NiO6iV/EN3kd+/vKdZ+ziyQ4Lf946SOm
         +cUFQPivS5eYEdOCeA00F1Lh+dAqi+8cDfMhoYJE6cqYE9NFBSD5jx4gPXFTcZ4CR85A
         eSv8249ppndhm33Si39J9tt2ingE3m0vCuFJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723367; x=1707328167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6RF6oHOyisdh7IJgSnB/tHRIU7aiX32oELeK+JlnUw=;
        b=M5Vt5+qRF45JVRMbSML38tk9ZwVihMT4uh9K8oNSUJHJKq12kl2bNP+fJ5isNHQ/er
         +bVy3MxpzjapRni50glMLtZbA+imyJGaSlFz7yFEKge9bO+lm0jtMbRV/SNulUPx/h03
         5b3cv1t0/Tb7Bi/mC3slaQVOtcf3CctcDiJpd/BmOMpHgpJCH4Ov3gKoGgft1hKrNyft
         CNzzL6zzF8o9unEhVgXkLNLHEbzLcFb83NJXUUiWDgkm94zZVjtDZYYx2V0DuzfD2nfT
         MLeAur5OYNYeIoPySPwYuqlvQH7Y9Tcs48tZ0rvBUM9y7K6+aEu2rIHNDWxPxdUOP4bI
         G+OA==
X-Gm-Message-State: AOJu0YxSehdZ1Uhzdy1zF1j7zw7cGxnvoPlFQ7Kf2T3cJkftccB3Pjva
	6eAnk8b4UOPQdWu3MX0flFa73afTnSUQs+4VH8Sqe122oKYOdQByYZA+W9r2Q87+w3IVKQoXqob
	p0g16gtKXMlyM1GhzXiWVwjnqx0s+SNjn//yj
X-Google-Smtp-Source: AGHT+IHnJRdqnxvCutvLC4CPZ65xhd3+S1jtMi5yO+DNT4ZqNiGF46C9Z/p9lddl/TYEn8l461KQ37DNu63A69cIhuY=
X-Received: by 2002:a05:6871:5a9a:b0:218:888f:54c7 with SMTP id
 oo26-20020a0568715a9a00b00218888f54c7mr2620332oac.47.1706723367499; Wed, 31
 Jan 2024 09:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122152905.2220849-1-jeffxu@chromium.org> <87a5ong41h.fsf@meer.lwn.net>
In-Reply-To: <87a5ong41h.fsf@meer.lwn.net>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 31 Jan 2024 09:49:15 -0800
Message-ID: <CABi2SkV4Q9CY+vb+t_+7RN_EtFB+FUi4ObHaZWo_+KMt7u4yDA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Introduce mseal()
To: Jonathan Corbet <corbet@lwn.net>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 2:37=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> jeffxu@chromium.org writes:
>
> > Although the initial version of this patch series is targeting the
> > Chrome browser as its first user, it became evident during upstream
> > discussions that we would also want to ensure that the patch set
> > eventually is a complete solution for memory sealing and compatible
> > with other use cases. The specific scenario currently in mind is
> > glibc's use case of loading and sealing ELF executables. To this end,
> > Stephen is working on a change to glibc to add sealing support to the
> > dynamic linker, which will seal all non-writable segments at startup.
> > Once this work is completed, all applications will be able to
> > automatically benefit from these new protections.
>
> Is this work posted somewhere?  Having a second - and more generally
> useful - user for this API would do a lot to show that the design is, in
> fact, right and useful beyond the Chrome browser.
>
Stephen conducted a PoC last year, it will be published once it is complete=
.
We're super excited about introducing this as a general safety measure
for all of Linux!

Thanks
-Jeff

> Thanks,
>
> jon
