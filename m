Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qD16Vi4K"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACD183
	for <linux-hardening@vger.kernel.org>; Tue,  5 Dec 2023 14:05:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3331752d2b9so99289f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 05 Dec 2023 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701813957; x=1702418757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9JeQfipl8UW5TVzZ70ugB2PN1r+4JCceO2n9SgysLY=;
        b=qD16Vi4KejSqGDYOx23NXTJYKywjUWnbXqM/gpZX2JzNkLY4Nhqi47lLXJJ8ajcE8f
         8zpQFv/D7fPNGmZLiF4MuzWDMjjOJJTv8HyPv9iTmv1imIcAFhFNV5l/ApRasLIYKLXa
         LROQmDPpkIKB8Zw0LxudzqiCjqQLgHdXJIpu3B0i6aUlTr6YvuqjuDxejqEsYlyVgBrm
         2PzDqp6Lr9x4D6dYldS2GmgBA3DZ7DpKZgs0E2vTFnJshWOlAjfRSeZlSuuRG3Qx8Ji+
         Pqn6Q4QCI7CASKeG74cHdWt79CLSReU/yeg0uI5826UtQb2QML0qc0WfLiP07mRbMED7
         6cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813957; x=1702418757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9JeQfipl8UW5TVzZ70ugB2PN1r+4JCceO2n9SgysLY=;
        b=boYRk+5LlBUEHqM68C30qnc8K8BH9OQNB+eGEtrpraPM0BFQhLltzvdsFkgc3OmB/j
         ia7BjLA+f3zh3zymF1ixfYvtl6Qau2cduD2wUHnQ+HQ6CWBlJQhOHH4Ne8YaZUgzVl/o
         BFxQhTQQYrOY4DqR4Ofgr1DQ26oUd7RnJmX4pNVOqyyGjNvDoJ0AQU1SUan9HcftiuQ/
         tuHaqCjzw6SaWre7Ei+i/8XLFj3Xb9zwe0eLJZgySvx3mrPyEkOJ/a+bX4W+uw9qgK1f
         2xrsemdpMWbs4x0jCzOIseEvxITtyG7WdsRM6NrlkPSIoFJDedl8mMOhB0SlJYcMPCE9
         WTzg==
X-Gm-Message-State: AOJu0Yw3o3a6+6K7UI1gr2Yjl2ruDYEJ0G2LhBKxuyewpUpelMDyBdXn
	U7Hv3gJ/zWi9bqm5GiTTG24El/k7TrxeqH8xce+v+OXmvlSwxqTonQXzXQ==
X-Google-Smtp-Source: AGHT+IHkAJabxfpBjjJ7hbUgdJBd2Fen0CGawNzwxwjbFMg7jrNg9K9f8rvFT5xK3F8ap3VfXxDmTj52qvUE57KRoM4=
X-Received: by 2002:a5d:66ca:0:b0:333:2fd2:8153 with SMTP id
 k10-20020a5d66ca000000b003332fd28153mr4348200wrw.112.1701813957199; Tue, 05
 Dec 2023 14:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
 <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
 <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
 <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com> <ZW-b4l1llqPXW-el@smile.fi.intel.com>
In-Reply-To: <ZW-b4l1llqPXW-el@smile.fi.intel.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 5 Dec 2023 14:05:43 -0800
Message-ID: <CAKwvOdk+JpEC-=27EkB7inOUfB+6tLe_NREz7tryHu3vmXq7DQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To: Andy Shevchenko <andy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, tanzirh@google.com, 
	Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 1:53=E2=80=AFPM Andy Shevchenko <andy@kernel.org> wr=
ote:
>
> Have you checked Ingo Molnar's gigantic series (2k+ patches) for the head=
er
> hell clean up? Perhaps we need to apply that first.
>

We missed you at plumbers.  Tanzir gave a talk on this, with the
raison d'etre of this work was to see if we could help automate Ingo's
work.
https://www.youtube.com/watch?v=3DeFq_oqLiXPM
--=20
Thanks,
~Nick Desaulniers
