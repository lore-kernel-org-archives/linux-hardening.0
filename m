Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79F15E9B
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBq4SWQ0"
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA767A9
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 02:08:58 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d8195078f69so5702544276.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696928938; x=1697533738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jEqkMdeti3/W7asExaM9e6RjY0pKBFJER3TES4A1Is=;
        b=DBq4SWQ08unPLaN9XsjfjRECOUzfr5cljl/e3fnsZJBm+UUBle6SRqkD5pFLN1xvmA
         WvZSWd8tTgpwQ1ilrHgoEbbQPtD9yBhlJp7eRSf+w4EXkLFy2Uszqi3xrqay8g82lpSM
         8FrpMbWP8x+Ift4vkRWpuPuqG4UzMPz9H8A33z2TRK7bTO7jlIeBtHlX01lKhhJfUszy
         yo2YjWbO+dawxg83FRWTAoA57LXmJzCpyUIDtv9wjjamre+EY/fQmwErFhU8wVIlkmZB
         PiTV/6RtqzIc/gw/TIs8MJU7hQRyH4ASYaOeQHfpXS2xy08GhVbLArxVD6BYQOTwC64I
         Ti6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696928938; x=1697533738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jEqkMdeti3/W7asExaM9e6RjY0pKBFJER3TES4A1Is=;
        b=jyLLCDhT4q99xv2ifWPtDX7nrDx2Ut8L3lR5898a32udQ4qLIBv64xOXNF0ZPGROiR
         mw1gQprhO9ps/Qerb7NSH1QFEB8USE9cwYjFXtrsg2ikJpNbdy0ChTXS7lNVWOUQVFBy
         iKC/cTsfxmbCvIGwG1w0iQ8Gz35JGj7KxMp41xQeN1M8uS/INnmiktfnaNX6qiGpZGok
         zwk27SCL2z0WWQQOYw4FC62Hi2g6TDjXV138FmK9/L8cFL0rCdu0hfTouT7NX/jRYltV
         Pt7wtmUwlVDbCrIJxbJM+IPAiOWGecfjs2KPmay5Zy4Y9QZI0Ah+m9wCud2+2e0CMt4l
         oM3w==
X-Gm-Message-State: AOJu0Yzvnz1QQVVwZBouxozLZ898bYgzM553CXfGw2C6H/u0tdpGThZ5
	KWfkuYPOMp/eP2XrGMWea7bapZUw235uOcaezbeghA==
X-Google-Smtp-Source: AGHT+IEr03R2VHLnNmgsuzntFl4LOazSy5LqhaQqB8IedsfEF3OGb4A0GJMrSUBOxjapz9jpzm8eXqKGDbKWo0GoSnk=
X-Received: by 2002:a25:6a85:0:b0:d99:d1b8:672f with SMTP id
 f127-20020a256a85000000b00d99d1b8672fmr6036146ybc.33.1696928937928; Tue, 10
 Oct 2023 02:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Oct 2023 11:08:46 +0200
Message-ID: <CACRpkdbkhQZn5zF1Qx9JyoW8p6KMuMx9PkOrYEzKVs2xAOzH0w@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: replace deprecated strncpy with ethtool_sprintf
To: Justin Stitt <justinstitt@google.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 12:47=E2=80=AFAM Justin Stitt <justinstitt@google.c=
om> wrote:


> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
(...)
> -               mib =3D &priv->mib_counters[i];
> -               strncpy(data + i * ETH_GSTRING_LEN,
> -                       mib->name, ETH_GSTRING_LEN);
> +               ethtool_sprintf(&data, "%s", priv->mib_counters[i].name);

Not only does it harden the kernel, it also makes it way easier to read!

Way to go.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
