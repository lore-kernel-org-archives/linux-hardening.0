Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD513F4DF
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GufGVWIZ"
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D8D8
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 15:01:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so2516834a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697148078; x=1697752878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odwr8eDy5SCBmCoOrVqIA/yNf2FEEwKvqJwp3o31tFQ=;
        b=GufGVWIZMUS7kr3IyC4izYXap+cKiYLwfoYZ/dvXYGG0UnTeKIbXufmRXbcK2XCE4E
         wWZSOyFnsU6uF9sOB4u8dZttGoUJ1a3SBSpD3MO1WaT9vj2b39P7ZYx4sWWBnG1gKgdz
         Krht4U7UrM+tH6PUoBhgNyou152hTZ+V1unZw2Vc5orixBhmhHNRX0OJSa/CQ2vR2cRG
         F301Wi62seOdctwQ8JQao3gwmuqz5YB+6hYpKeG3NRxeQVBNNzIITSuc2OOqCIrtY5eX
         eWnofK6Bdem2v1dHlqlcODhk1vccdwwHFO/Y/NG7Rqf8ISJ0Oq8RAmzM1nrmGp4aDLpB
         PtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697148078; x=1697752878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odwr8eDy5SCBmCoOrVqIA/yNf2FEEwKvqJwp3o31tFQ=;
        b=cEkNY1+QibpGqrc2/KAn3GiR7laPn2HAdAhaPjRK239Ht5DdXsCIuUM8XHmPN1YE6r
         lf9IwhHT7DMg4C6zVPMsjxHj9M4k0RqrIft2xuYVMHaXBbhP3fXKfsw8tZw/xv0CQCUZ
         FOjE/ynPW2B2Vk0oZnCDdV4ywIwGFEMGSxwJ7VMEt3RC2S908N1mJQ9RxH6AapI3V6G+
         5KtsP44N0yLNGXm4ZQy9d9mw+fZuM+p1oEI8M9HdSSG39dOAATw3ETkqgIkLzl2JkrVj
         nF7LcTLw4IbW1dV9BqMSPuOKMUWCxsv7IC72ojHWZ6LJ5XZLHQxH2i+QhWZKOxxOS9PB
         VE3g==
X-Gm-Message-State: AOJu0YwPsz6tYIQO5qafJpX71//W8Qxy9phLA4HH1Va9Jsb0dswS8imj
	AAl2O+u7ot9H3JDFlM89tJLvHgl3J97tb/TdzF0YFg==
X-Google-Smtp-Source: AGHT+IHkRTS5Quw20yMh+SqaVjNY3XB88DzaTtUMhrYwgnSHDbh2ArUGSmO9mOxhUHP6tq7BOTcPgHl87BdqzOm0Vr4=
X-Received: by 2002:aa7:da84:0:b0:536:2b33:83ed with SMTP id
 q4-20020aa7da84000000b005362b3383edmr25702236eds.24.1697148078438; Thu, 12
 Oct 2023 15:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>
 <a86149c3-077c-4380-83ec-99a368e6d589@lunn.ch>
In-Reply-To: <a86149c3-077c-4380-83ec-99a368e6d589@lunn.ch>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 12 Oct 2023 15:01:06 -0700
Message-ID: <CAFhGd8qAfWiC0en-VXaR_DxNr+xFfw8zwUJ4KgCd8ieSmU3t5g@mail.gmail.com>
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 2:59=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Oct 12, 2023 at 09:53:03PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
>
> Hi Justin
>
> You just sent two patches with the same Subject. That got me confused
> for a while, is it a resend? A new version?

Yep, just saw this.

I'm working (top to bottom) on a list of strncpy hits. I have an automated =
tool
fetch the prefix and update the subject line accordingly. They are two sepa=
rate
patches but ended up with the same exact subject line due to oversight and
over-automation.

Looking for guidance:
Should I combine them into one patch?

>
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew
>
Thanks
Justin
