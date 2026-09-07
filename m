Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2145FFDF
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777268; cv=pass; b=BZmo12ssWLElcslxIonCkZAGxi+esLWk3PuV1uHbUlZWf48Jvldf0jw7CkuNEKDJW70Ts18IfTFJ2xFdmpfdlIstXy7LdQjt/r0UqOQmHX8kg878FySVA0h9JwPV00ssCGpwhzeyByliVl3Olfx1MNIU5+zpa5O3NgGFtpOhyh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777268; c=relaxed/simple;
	bh=+yS+OWDWHgj8L1bOSAbU79jIY2VHoZj62mLc+Oc2Vlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ttfv8PWheK6Z/rwp02YGuxMJl5DQmp7ljA+cXiMQn/0CEPHw/IRZHo5eotN5W9/HyErbSWzQUri3RO4ovutSNurMvqkbuUF2Cmw2F8hqprbOZ5Rk356qvr9yGGqZAASG623LZ8b528baEaCGx5Xab9T3w2QEdrzkIkgAg8aWAf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZn095UM; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZn095UM"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f8694a7so1828866b.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 03:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788777264; cv=none;
        d=google.com; s=arc-20260327;
        b=EvsE3TKvQz3FalRS0SoMwmngZrZCm7Ku9WirjZ/78Kn3xlZQfzEgVntldyF4Q5QTFZ
         alLd/3+bzOhzJR1oASnbAQnh+ZqXH6NEbGGyDOFkx7wYR8uywO6kIeNm0Q71HOnw4njy
         o5WPf7QFSncVsP8arqHCYFGcINpp8rH1swDaS+Q6LC422CWp2JaagAhFCV1bSZbV4zF0
         6pngtpy1fGzIpQPIQxrwh9Mv6z+6n+m9l20eUC5SJ0yM5XPDzdO8OXZVtYwK2xR1qAEC
         bYShbUt1rS+21MflLVdygO7SvYDa8D93MD3bXxdu625iXU1HRg+Y+5GFVQfhxLDoq+vs
         xObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+yS+OWDWHgj8L1bOSAbU79jIY2VHoZj62mLc+Oc2Vlk=;
        fh=9LHWT8s84qpJCC+MHqUqDKkcBlHXW4oZWr7uDZAuH64=;
        b=OQfdnFWIH6h84NR82PZ458t7eQaeXld0S3u3mQcZ72vvn8p8zBE6Xx1Fu8YtokJTBk
         abWl0Rd3b/AXOqMS9Koucd8NwE2tWVexh6sdA+Hqv+Id2YcwMpF94eqhKDGB+Hpvh/22
         vZzlrxhxFbM/DMQsjQ5l5GrCKa2DwJCk1KSrUsdKMmqiFSBtfxrDN675B8PzdED3XfnU
         Msbrb6OyY1UbdF9WCNb51baHhdRz9QItI9d8jB/cr+zV06G3EyfbyhgK3oQscaF2R0ti
         Bukf5otTYnOgVlSHDFGFjNczWUek3+4nPNjy+8uJlU40/O2SHiAICk5HGZcNILmpD5yL
         jDUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788777264; x=1789382064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+yS+OWDWHgj8L1bOSAbU79jIY2VHoZj62mLc+Oc2Vlk=;
        b=IZn095UMZppKejO7xWluUfNsRQLG6pAamNXLKTIH8yO7tK/QVLuFjrwSdRrBorK/1/
         nAYqJdjWITzkwcm8+S1MY+Z/TYzPDSvgaDNCij9ZKn1Vf4ziNGArQCDnbknFXi29vkJm
         7FQXbeKLq5IWR0cQ62+OElB1VDCEPLFcUMG3C4xunXDYNST+jfWnPMQ1rDVr8YPQLUbT
         xwdEgaDFTh5rd/L55cZFMYjbh7z04qsMGNBwy2Am6jmbjPyvlHI4ZPQ8gFv/nrU/Nzi1
         Eft1RbDsdx38C8W8Jfv5SKAEdbwbCKRVud0dOl7wGwP9DN3MrSKKWkE9H2mJ/bw5RHzX
         Bopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788777264; x=1789382064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yS+OWDWHgj8L1bOSAbU79jIY2VHoZj62mLc+Oc2Vlk=;
        b=oIPRnd+7ig7JxAAD6oDov/kbiJWM0D8L/S5mUwA5WFXSTja/D4QXj5nk1rbRcexiQh
         vkAl8dLqZZmjRXn3Q2IhHTytGQkdeGuwAArN75YRbd+xJOPJRokDysH3U2WNR0x1yuqT
         olKUsa8ciLzQhBeacNAAGJcFtx3EyzAeEHqWMKUM4ugIqI58UhKH8Pa3vxNvV9M+ap7l
         ESRwft5A/GGFku6wpzK9k+1yU5ubiDx9H6ME0fkC3oD7/VHPn/gAW2h9Ly3D1c/qG/V9
         DUsrHvQAvDO5vbnP5WoUYedldVXwzzxEf7bfH71jRIjnvfUU09Tnb8PeLTbpmgzfIT6O
         PN+w==
X-Forwarded-Encrypted: i=1; AKwUvBzDWT+eRHJcu4OkxRP81j3A028SbSxF7E3KMrjTp57oEUd6yj1tyM3ybnUh3UNZQzpj8++1FURzY3nI3Ve9YE8=@vger.kernel.org
X-Gm-Message-State: AFuF++ltH5zdR0Ekknm/d+YaERJGdeWzBb+G7KhQu3ntO8NroVXF8Ygm
	rtC2rqB+jPo4IXfJPd4XcwUrj8Lq7zkBgq5M/HnIipYyNZqWRA/KbJqk7vQjOuoBveQibZ/StXN
	r0Tg9ZaVqVmmrjdZ9AUuJun9xxkNBII4=
X-Gm-Gg: AYBFou1LpM12QGOqW71feDxNXxzMjI8TWU52JUTr4GaZc2w5V3cChC5SsMc+yr6MZax
	E5YXp0wXXNHHsF9gbVjG90Le6pvU+uZiZVHrWvx7BiSmH0ft7NFg55P1/9F7NUi5YMX1AuWYsuq
	65G7U0dawT52Bdn8z0l8IjMp31gy8zBPhAYJyagszusJu97tHEqU3mkM2uvW3xbGBmJvifZqM/E
	trzVZgrZiKlSwfOwh+G+40lB5vzgExbDyFlpiX9sVwUVp3jpI59M/126zqfcj2VcoAdFZFTJp0W
	DKW61rwYhC9jvCq6s0IFlXv8gTua5XP7NfOcMcfyy628LmavqAB6H/01nO5jnUM0RbcG9hz9W9h
	p8oL/Wtud6FsddIx42by6vzC2edTktnIiF3XEMCFSMgxI+X0y9LRvRMe1Weba4AG3ING4tc9MZo
	+rUtjliqrum6VrdjTNei4RdryTtb4IcPYm
X-Received: by 2002:a17:907:3f09:b0:c25:f7db:4bea with SMTP id
 a640c23a62f3a-c290446b88cmr6398466b.16.1788777263623; Mon, 07 Sep 2026
 03:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907084319.351688-4-blum@kernel.org> <20260907084319.351688-6-blum@kernel.org>
In-Reply-To: <20260907084319.351688-6-blum@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 7 Sep 2026 13:33:46 +0300
X-Gm-Features: AcwNN1VffgvnaRhRlD6uHBYo6Fl574uE4g4_q78txLgAdLn8cRR-VrD4lzKeSJo
Message-ID: <CAHp75VdrNu_7JzfrXFEv=ALoY4x07xD=Um8NxyVPNdiOk2fmGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/x86: thinkpad_acpi: Use
 str_supported_unsupported() helper
To: Thorsten Blum <blum@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 11:44=E2=80=AFAM Thorsten Blum <blum@kernel.org> wro=
te:
>
> Remove the local str_supported() function and use the common
> str_supported_unsupported() helper.
>
> Debug messages now use "unsupported" instead of "not supported".

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
