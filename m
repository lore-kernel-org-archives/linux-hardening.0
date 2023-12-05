Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hWbA1Hj0"
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00D4188
	for <linux-hardening@vger.kernel.org>; Tue,  5 Dec 2023 14:25:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3316bb1303bso125283f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 Dec 2023 14:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701815154; x=1702419954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlRvcm7L+cBAIszdYTxuMdD16SmRomd1bg4ss68VhyI=;
        b=hWbA1Hj0zQde/j+2EwawUBS0XHnLSu/c82WtM7myLO+MXlqhjJHhTSNFyKTEqgvgDR
         aZPAa4Dgd9Gys0QrX/SYaXHHndDSEYUfHp9gl3hBYWKr1SOtcu9hL5pdAAf3N8x8f4oV
         Gr5x+pMoW6F/nNJ6EhSgHliJY1OoISW3LHsK8Z1/7wxPFe9dscWJfB4LTYz2/RF6elTp
         Qk8DpnxlYtsOsTSEt07QZCHkR3VOrLeLPPpTGvxayqCrh3EitqO//zuambyQTrl3Lk4T
         6RIa6AGNzWHws4pIdszu6NvX8fLiXTtDmDG2KcQ88GRvXk2kPB90PwxQFsN80cr8YZIO
         NlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701815154; x=1702419954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlRvcm7L+cBAIszdYTxuMdD16SmRomd1bg4ss68VhyI=;
        b=wo1RAPBSfEELF6i79ov5CUs56f78SDHuP/4ePrtBegn7EgX7Ca8ev8ik3m2nneCdv8
         ncMHAkNZ7x5wB7bs/6bllyKAXWAIlTPi3ygSXXo8z8G3/TPtkhe5pHhYJpKQMOEsNICA
         0UG5RGTyXsMwdVLk2CJpNEXzIHakJQEeiipv7P04kcSFU9Aq65rx+nnh/a2RVfB2Ue6c
         8v8rryHgbHYjr9AraGQpXwT5pkbek/0gfTdnpNlnTFiBvpmFsD3CVxOfmTq4HMUc1UYA
         w2eMWZY+E0XWzqyFq/+5/dYyfd/63Z4wARpe0fey0M3bO4qqVhTFnPeEoovX1YlGeFMr
         lHOw==
X-Gm-Message-State: AOJu0Yz3LxdS3hUMq3S4NIA5EcDWv3ynwJOsd09h/KBmZfYynRVNoycY
	ggt7DlboIBPysVAJDQjGHWYjWz6uFdzE8biHpJ7XTQ==
X-Google-Smtp-Source: AGHT+IHF7C4eMuQFihFrv8+8ynBjYGzdmiqKV5qMKe3JCWHAeoQ6T/vXYIaLbgU2DeTIXJ8mWuYYqhOravlOhhfavug=
X-Received: by 2002:adf:ed12:0:b0:333:2fd2:813d with SMTP id
 a18-20020adfed12000000b003332fd2813dmr4815585wro.90.1701815154097; Tue, 05
 Dec 2023 14:25:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV> <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <ZW-d1NZRIvmJlfcW@smile.fi.intel.com> <34e27c57-fc18-4918-bf44-4f8a53825361@infradead.org>
In-Reply-To: <34e27c57-fc18-4918-bf44-4f8a53825361@infradead.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 5 Dec 2023 14:25:43 -0800
Message-ID: <CAKwvOd=bZvLz4yRqet6Hv2O9iZYfGr=xiwfk+-MAasPjK7XnWA@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andy@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, tanzirh@google.com, 
	Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 2:10=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> I have an unpublished Linux Best Known Practices txt file with
> this "rule" and some other info that I have collected over a few
> years. I wouldn't say that it's up to date. Anyway, it's copied below
> FWIW.
> Generic drivers should not (do not) #include header files from
> <asm-generic>. Only arch code and arch-specific drivers do that.

Ok, that confirms my understanding.  We had picked up on that
convention, but had missed the one below.

>
> Don't use <asm/header.h> in generic driver code. Instead use
> some <linux/header.h> that then #includes <asm/header.h>.
> asm/ headers are implementation; linux/ headers are API.

Ah, yeah, that's what we missed.

---
You should publish you doc somewhere, it can be helpful to refer back
to them when you're on a different machine or to point someone else
to.

I keep notes like this myself for debugging LLVM:
https://github.com/ClangBuiltLinux/llvm-dev-conf-2020/issues/3 (and
recently gcc: https://github.com/ClangBuiltLinux/llvm-dev-conf-2020/issues/=
4)
--=20
Thanks,
~Nick Desaulniers
