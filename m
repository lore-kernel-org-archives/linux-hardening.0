Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FD81D529
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6HVdGER"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A9126
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 10:40:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso1500870e87.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697823625; x=1698428425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF0w62trqYcHCfLDfzhxkaTZFMEm0P6zCkg1/3Jkv8s=;
        b=U6HVdGERQBUwTjwgHPHRCTgtRZk6v0bM6gVi76tzanFxli2DE+r7O3vvMgSx7UO4N/
         SNeJgQner9QeEZHZBIGseSlcf5r8bFdP+QHL1xhckgb+R0vVmdoJsuYokOvWl5eERsrL
         0R/IXc+oXnA/XLtjPk5M3uo4xAn8wdBi+uZDpokfi4A4Tsw+QBDn5hU9L5zKsBrQL7Kt
         mztkXAZ4JaWSqwYbjG9B3NZZCwYA9rGJchDuf3/LUHyOzsiA+yXwahrb02LWxZyxrpr3
         a64hkVDoFRugBqRvzdepROzc1LEs7jjvaLoF9UhhG1kgbZfSNKF/xz23qGnTre0V9DtK
         0u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823625; x=1698428425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF0w62trqYcHCfLDfzhxkaTZFMEm0P6zCkg1/3Jkv8s=;
        b=GjzKghfwTJZUI4EVDf8Ivr3VVdmkF6n2ZjMMlM/TnC8gXxHQVg3+U7Djxw+FSvYQol
         PASjdiP5Gqxhu/EQZ4RxVIbHXs6n7sazo3tBncMk1zI7w3HoJB7/NTfeYHHs9Soktt/W
         ASRx9jNFjYhNw/ceY0UtVOqt1FjaoGOWgvHW4Lwv+nT79FhnFOkuzsloVVE1wnuEtvpi
         z2gghZ8TDgcYVJoul314YwWPfW+PQLD9b7cGR0Jejdei7t7p18WIlAyJYvCn+F2JERKc
         YLbT9eVCwFWthQsrFDWhmNvgkf6fOeHE/06RIPJ0e5v9e60UjZBtS+mHtN8nNxCjMITe
         VKFA==
X-Gm-Message-State: AOJu0YxoXbe0TsOPw/ZJQ6jmK4yATMWA7UBuyr4Y5MwneQpIja/NqD7c
	NxNR4vhdd/einPO125U7weDtz1cU54XGpyBzRptigw==
X-Google-Smtp-Source: AGHT+IGa8/lJXmLSId1P+cwpoUCl//EotM3rxi6/MgjhAIod6PDU4OLCGZng6oGIb1YJJRHEDd4b0KgzHntGWUqAxb8=
X-Received: by 2002:ac2:4573:0:b0:504:3807:22a4 with SMTP id
 k19-20020ac24573000000b00504380722a4mr1925746lfm.23.1697823625262; Fri, 20
 Oct 2023 10:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook> <20231020044645.GC11984@lst.de>
In-Reply-To: <20231020044645.GC11984@lst.de>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 20 Oct 2023 10:40:12 -0700
Message-ID: <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
To: Christoph Hellwig <hch@lst.de>
Cc: Kees Cook <keescook@chromium.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 9:46=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> > Almost all of the remaining strncpy() usage is just string to string
> > copying, but the corner cases that are being spun out that aren't
> > strscpy() or strscpy_pad() are covered by strtomem(), kmemdup_nul(),
> > and memcpy(). Each of these are a clear improvement since they remove
> > the ambiguity of the intended behavior. Using seq_buf ends up being way
> > more overhead than is needed.
>
> I'm really not sure strscpy is much of an improvement.  In this particula=
r
> case in most other places we simply use a snprintf for nqns, which seems
> useful here to if we don't want the full buf.
>
> But switching to a completely undocumented helper like strscpy seems not
> useful at all.

There's some docs at [1]. Perhaps there could be more?

[1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify=
-string.h#L292
