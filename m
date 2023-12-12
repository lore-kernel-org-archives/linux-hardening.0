Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CacnCAzw"
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CC7A5
	for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 15:51:16 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4b2cdf382d9so1556810e0c.0
        for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 15:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702425075; x=1703029875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDJv/MdPWACPkzPDU+UdHfxT6bKwGCJYIve5sJRmC4w=;
        b=CacnCAzwSbudmwwYJOMgYdksuVWzV/PGJjKuKG4M3a615cLK/lglaxwE9zk5hFFLo5
         +CqOmBQkgfnp+8zkSWZPaEYV2GPASHFAN0D/DVDYAcvWKYf6BsFnTuqXOIo5xD1gxawY
         JHRdJIBcuHHuqOuh2uRLB5L1jEmpvSNMxTbVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702425075; x=1703029875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDJv/MdPWACPkzPDU+UdHfxT6bKwGCJYIve5sJRmC4w=;
        b=FtaNptSCPfwvZXO5LzWM7DjHNQPYsZXBYbNABbKBdLn78uw5b0sXQrevcxG5u8Ub9j
         OfyUED1riD5tfRPewbx+MQrj8JQgSwMlhyiaGwPa29DpE1rS81YuOcM+gWyJf3j4KVCG
         P+6YVBR4/ABeDI5pDFGMqoVMGhu+uKJ+GUswTnXq4tlEh2EKIIZv6o/icOT9oB9KYssQ
         UKAdVnBX5gbmM6zvSDX0HLwI8IJeecSwLUouXPZ0v6qOeH7Kxha4H4JHiemhKABYxM/0
         4RxVEtD6nSasssmb27g7iYppFZER1zxP5aGn7/AXFjqt6s0Mu4OGuoRUS5oGOpv4RyUX
         MGmQ==
X-Gm-Message-State: AOJu0YxA5Qxs/p6Z9Hr4e6UJIKstkOj8qPuWoc488ew167GYBF+9ZmpW
	CRl11wD/ca4mqg8hEz+9AIUyt3cOKv2XFlKJK2XfLA==
X-Google-Smtp-Source: AGHT+IHgzY6TxuyoNkpl2aQeyRJYTpGY2b/Uli21Z+t7hU04lfjLJQ/88/mR7DldxbjQ1RCBksHpytK1u9KPLiGxHEI=
X-Received: by 2002:a05:6122:31a:b0:4b2:a7a9:b2a with SMTP id
 c26-20020a056122031a00b004b2a7a90b2amr5285959vko.11.1702425075124; Tue, 12
 Dec 2023 15:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
 <20231028162638.5b477ded@jic23-huawei> <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
 <CAFhGd8p76R-oaPWR0G6wESe7kgM--2bzU88j2vz4QGy8wKNffg@mail.gmail.com>
In-Reply-To: <CAFhGd8p76R-oaPWR0G6wESe7kgM--2bzU88j2vz4QGy8wKNffg@mail.gmail.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Tue, 12 Dec 2023 15:51:04 -0800
Message-ID: <CAPUE2ut0gbSyzUQ+m=760kXeOqKoi+9OwaExXTSgg8S=bWhUvg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
To: Justin Stitt <justinstitt@google.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Mon, Dec 11, 2023 at 4:46=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Mon, Oct 30, 2023 at 2:44=E2=80=AFPM Stephen Boyd <swboyd@chromium.org=
> wrote:
> >
> >
> > We need to free it in other places too, like if the count doesn't match=
.
> > It may be easier to extract this section and just have 4 string
> > literals.
> >
> >         switch (reg_def->reg) {
> >         case SX9324_REG_AFE_PH0:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph0-pin");
> >                 break;
> >         case SX9324_REG_AFE_PH1:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph1-pin");
> >                 break;
> >         case SX9324_REG_AFE_PH2:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph2-pin");
> >                 break;
> >         case SX9324_REG_AFE_PH3:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph3-pin");
> >                 break;
> >
>
> I've submitted v3 of this patch [1] trying out Stephen's idea. I'd
> appreciate feedback.
>
> [1]: https://lore.kernel.org/all/20231212-strncpy-drivers-iio-proximity-s=
x9324-c-v3-1-b8ae12fc8a5d@google.com/
>
> Thanks
> Justin
