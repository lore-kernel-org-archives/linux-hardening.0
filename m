Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2755247
	for <linux-hardening@vger.kernel.org>; Mon,  6 Nov 2023 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JXkEYDEu"
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3907F11F
	for <linux-hardening@vger.kernel.org>; Mon,  6 Nov 2023 13:53:21 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo8255915a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 06 Nov 2023 13:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699307596; x=1699912396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNAdiaf7CFJFGR+XgzzaLNcE9ebdwuse14Opfb1nM5c=;
        b=JXkEYDEugqKvyhezruwgFaSx7gSW2M+7AAC6hKFcPA1SvASIWqYrjpnB9sIoQTSdyM
         xP+hR+45THPwDfmnPguSlSHOGmhq4q/Ob4AgcsL8S9SWxEBfpd7RXU+Ey4BTAWYQ2f9W
         AwNG9Qzhpt+0XSxgKGgdJTvuJ0rXKjoN4xXIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307596; x=1699912396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNAdiaf7CFJFGR+XgzzaLNcE9ebdwuse14Opfb1nM5c=;
        b=pD2J/5++2gIp70SbHWDFJ+5SLIYYYXFC3EXfzDzDQyC0trtwd6NM1yqj8w28lxE4t1
         Wvj/I6VYx9i3k6vjLdPeZnpprUz33rrVAXx4XFUFZpa54LCmBAKn5bR6B7TyHZBBOL03
         splUAtcyI/rzh5dSuXHVfQeyP18elIedH9obgf522gaCoO4X9Pah2KVuWp7KtCgGS3E0
         e+NcRcCKGzrnq3KoJketi3OCpGKUnsw2AGnDOqM6MU7/7xNE5mAG+DCEBA31aOpiq5Ri
         ePVFnLciorzhl9taNdAVF9U8owzYfud4057FyVz3Xsoo0bTJhV/iyJ8eAFCtGnEb2gDT
         Ia1Q==
X-Gm-Message-State: AOJu0YzWX314KpbX+c0/VKgKVRkb9IIe633GfHVj+U6nR/HckplQ2n/t
	/O7ryrtF96/1nMWEKqXNiGZK3AxkviV4egFPIY6xw0bm
X-Google-Smtp-Source: AGHT+IE3Eqr6i9ZxCYgZwU58WReqJPyTgk1vHfX6w+hTYVP+067ES0NK6Vq4VjIwfHNgQ9llIHiSPQ==
X-Received: by 2002:a17:907:318d:b0:9c5:6cf5:448a with SMTP id xe13-20020a170907318d00b009c56cf5448amr15091904ejb.44.1699307596428;
        Mon, 06 Nov 2023 13:53:16 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709067e1300b009b94fe3fc47sm285384ejr.159.2023.11.06.13.53.15
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 13:53:16 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so6965e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 06 Nov 2023 13:53:15 -0800 (PST)
X-Received: by 2002:a05:600c:a005:b0:408:3727:92c5 with SMTP id
 jg5-20020a05600ca00500b00408372792c5mr40609wmb.2.1699307595154; Mon, 06 Nov
 2023 13:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <CAE-0n50vtad5hkkAuV-hvsnm+tTevd_4OSr3iGofBa5L8A0RQw@mail.gmail.com>
In-Reply-To: <CAE-0n50vtad5hkkAuV-hvsnm+tTevd_4OSr3iGofBa5L8A0RQw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Nov 2023 13:52:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UJE6VKrjFJ2g=4qRHLdnqymossWSAFeKyUykxm1sTCtQ@mail.gmail.com>
Message-ID: <CAD=FV=UJE6VKrjFJ2g=4qRHLdnqymossWSAFeKyUykxm1sTCtQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] arm64: dts: qcom: sc7180: Make watchdog bark
 interrupt edge triggered
To: Stephen Boyd <swboyd@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-watchdog@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Andy Gross <agross@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Kees Cook <keescook@chromium.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Tony Luck <tony.luck@intel.com>, 
	cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 6, 2023 at 1:49=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> w=
rote:
>
> Quoting Douglas Anderson (2023-11-03 16:34:27)
> > On sc7180 when the watchdog timer fires your logs get filled with:
> >   watchdog0: pretimeout event
> >   watchdog0: pretimeout event
> >   watchdog0: pretimeout event
> >   ...
> >   watchdog0: pretimeout event
> >
> > If you're using console-ramoops to debug crashes the above gets quite
> > annoying since it blows away any other log messages that might have
> > been there.
> >
> > The issue is that the "bark" interrupt (AKA the "pretimeout"
> > interrupt) remains high until the watchdog is pet. Since we've got
> > things configured as "level" triggered we'll keep getting interrupted
> > over and over.
> >
> > Let's switch to edge triggered. Now we'll get one interrupt when the
> > "bark" interrupt goes off we'll get one interrupt and won't get
>
> "We'll get one" twice?

I like to make like to make typos. If you hadn't hadn't noticed.

I'll wait another few days and send a version with the typo fixed
unless Bjorn tells me not to (because he didn't care and applied it
anyway or because he fixed it himself while applying).


> > another one until the "bark" interrupt is cleared and asserts again.
> >
> > This matches how many older Qualcomm SoCs have things configured.
> >
> > Fixes: 28cc13e4060c ("arm64: dts: qcom: sc7180: Add watchdog bark inter=
rupt")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks!

-Doug
