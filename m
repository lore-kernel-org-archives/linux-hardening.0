Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2428E22
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 23:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF245C433C8;
	Tue, 26 Sep 2023 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695770239;
	bh=Hx5q0X6p+d0LIi6fY+AaluSPneQQ4+sDt0fmIZmmu50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T67r0BI8aRoDL8IwCXP7IJmDQXV4D32Lv1WpwdIhVxHaa404HJBSZIbvGjT9nBE+L
	 0++VqThkAltnkmVUESk768kFI3Aq1aHyxqLjAe1aowyUYeLpQSU6qDH/qn0Uo+Pyof
	 fsdyQ8pZTv61xuhjqfyjbRQU+VUyWcf4b4UTG+vlQKC8H/nToETYK3s9tUGvA+wdf9
	 RT/l+8OnHerziunqeWYU8GW12Du/PZS4egXsmHPzvlDVwJzuGM3yi0BANb1fzGDdm+
	 TGmMMWpaE0yFuqkMwIDUNyTERxKoxOupVnayFAI3iuRm9MU5QE7ytb3JLbZGHNaXqD
	 s9o3cXg5lYJTQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5041335fb9cso15874785e87.0;
        Tue, 26 Sep 2023 16:17:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy2DkglQWI+imszMx+5rcksD5shG+h/Rqxky3ZwbFPdPPi7DtGs
	nAVJLrZhwq7iizPffc8jzIQYz/NUtrdtbuz2yjw=
X-Google-Smtp-Source: AGHT+IFeQf3Z7lYgOfsmxkyHI8Ar4AHjFWstrfAjs0ZUWK5+nLdfE9piS+uWe3MXamZtlhWr90MkmX5oj+FlziEorII=
X-Received: by 2002:a05:6512:12c3:b0:503:314f:affe with SMTP id
 p3-20020a05651212c300b00503314faffemr157768lfg.17.1695770238000; Tue, 26 Sep
 2023 16:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925-strncpy-drivers-md-md-c-v1-1-2b0093b89c2b@google.com> <202309251122.6E3E678140@keescook>
In-Reply-To: <202309251122.6E3E678140@keescook>
From: Song Liu <song@kernel.org>
Date: Tue, 26 Sep 2023 16:17:05 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6MGr=ZA1yoHSH3YdG4Z5x5+qcJt8cMoNqG2cb7EqJYcg@mail.gmail.com>
Message-ID: <CAPhsuW6MGr=ZA1yoHSH3YdG4Z5x5+qcJt8cMoNqG2cb7EqJYcg@mail.gmail.com>
Subject: Re: [PATCH] md: replace deprecated strncpy with memcpy
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 11:22=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
[...]
> >
> > So really, all these instances have precisely calculated lengths and
> > purposeful NUL-termination so we can just use memcpy to remove ambiguit=
y
> > surrounding strncpy.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> I agree on the analysis of the replacements. Thanks for all the detail!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied to md-next.  Thanks!

Song
