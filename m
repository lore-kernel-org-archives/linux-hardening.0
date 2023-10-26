Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C942D791
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4EF1BD;
	Thu, 26 Oct 2023 06:59:44 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so666359276.0;
        Thu, 26 Oct 2023 06:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328784; x=1698933584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20XxON5XilTKGJ9SIc8r5pwdKYtKKocsfNkQqf5x/4c=;
        b=cbmERCUbJVAVwi7Zw09fZCKC41emrIJ/q6zEkjNd4AB7WPBx1p3JIJE0aLPtKu1NmW
         CIBOkcXtYmSqQV7lcK7yrvgn8R9HPVZfFgpp+dVJEA+dhVnhMQ9fJ7csAUFmdduyUp9O
         28snVZO5SfJ5THEurfjZFDd7AT5joFTKipM125LNECLi1a/xtOp7TXPdc4M1+MBTfe8A
         16atRoT/0hegulgTStUFBgZ9aEfG/Rmbt1R/2DfzD+ecOotyJ+ep68d8W7vDCSDXd3GV
         Vz5AurDEbIQDoKA8Xh6kSlzdIpsEbo7PVzbGhKz3qTaAGc5qpxZ77yIE1qXJVueURly+
         OkbQ==
X-Gm-Message-State: AOJu0Yw32FjCGRyzxinJ3wCRqw0F/WmDRU8GvAWQKJNi5eo7H/VT7np2
	jjZhmHnM6r0V5OmfsdJ4By2DHVMeB+1/uA==
X-Google-Smtp-Source: AGHT+IFmIlZ9QCTk6uE4so3wg2spv6XHyYnYWc+a9V3sH9yScBc4exiHpBUBtVsE0xn1biQ1nmy+uA==
X-Received: by 2002:a25:cad6:0:b0:da0:4ee7:bd44 with SMTP id a205-20020a25cad6000000b00da04ee7bd44mr7847988ybg.5.1698328783738;
        Thu, 26 Oct 2023 06:59:43 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id u98-20020a25ab6b000000b00da0501b497asm2010057ybi.18.2023.10.26.06.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 06:59:42 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d9beb863816so654398276.1;
        Thu, 26 Oct 2023 06:59:41 -0700 (PDT)
X-Received: by 2002:a25:ef48:0:b0:d9b:4f28:4f7a with SMTP id
 w8-20020a25ef48000000b00d9b4f284f7amr19582865ybm.55.1698328781289; Thu, 26
 Oct 2023 06:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de> <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
 <202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
 <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com> <20231026095235.760f5546@gandalf.local.home>
In-Reply-To: <20231026095235.760f5546@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Oct 2023 15:59:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9CcjGkpF=FGe_U5XtbF08bKTEYkPSxArO1zBwnug0Wg@mail.gmail.com>
Message-ID: <CAMuHMdV9CcjGkpF=FGe_U5XtbF08bKTEYkPSxArO1zBwnug0Wg@mail.gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
To: Steven Rostedt <rostedt@goodmis.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Christoph Hellwig <hch@lst.de>, 
	Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Thu, Oct 26, 2023 at 3:52=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> On Thu, 26 Oct 2023 07:39:44 -0400
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>
> > While it's nice in theory to have everything documented, it's not much
> > use if no one can actually find the information ...
>
> Does kerneldoc provide an automated index? That is, if we had a single fi=
le
> that had every function in the kernel that is documented, with the path t=
o
> the file that documents it, it would make finding documentation much
> simpler.
>
> Maybe it already does? Which would mean we need a way to find the index t=
oo!

ctags?

Although "git grep" is faster (assumed you use the "correct" search
pattern, which can sometimes be challenging, indeed).

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
