Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456C429036
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448390; cv=pass; b=I4lrUELaRO6YzJlYZTfJMmp4SODqXHnfklAHWnCs0ASNYb8vuLc+61lKtvupmT+LhMV45ufic82GXqhy31DGGcMrTFPnvQLp93t7MubkB+LU97CC+t3/6+iOlifbM4+tnQN2LvFLfOyfO0LCCjoSAvSWc2zsqPna/1d6asPmCZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448390; c=relaxed/simple;
	bh=2NC3ZI0tO5C6E8BTeagCEoT7beDj2YO+MbV8ihJjJzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goPpyyWaVdG+12SFL7fDW5daA/Qg629MAohg1ut1swLt08Tsv/o08J6E84GUQBt+ztSdqC0s5YTidkisVU9OWxw8qOVkgtHSRYbItltxL4P7ZD43ybldZgP2gNSGmOW+6xudg+VMae45R/tCuWToww8ovG7gTwgJSi5McPNjy0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VIKgW9KC; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VIKgW9KC"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-668c1b780e5so3980394d50.2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 04:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786448388; cv=none;
        d=google.com; s=arc-20260327;
        b=Wj2ZeBd6oRV/hIBeZl+mYmOXNemfyokJCl+q1ImxX9KGxkza9yiQgSdDWnzGPengWW
         fjM6SoOaXGUvGeOddpOzdR3CXHlpa5W7+chpb0QFrsfC5FzIH/HZ+DDr7BOcRxkoFg05
         QWwfTCzxXQN0EJ8i4Djwr6Mi1m7skDQLyREmQAzZ+mBCw+i2pjpuRY/5Ke10Jd53bqSx
         p2xHebhngFRBI1+sbaYUZf/cAtFFLDocsdCVb4mz8ipKf9VgxfjJkgVOCRnnPp3y2VCC
         AEkOIBY90YwizMv8qHIHRKqP7vWQ5XMvOnaicQ0jFGsGYWptyFXy45eJFMz8buoYm3qi
         RGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2NC3ZI0tO5C6E8BTeagCEoT7beDj2YO+MbV8ihJjJzg=;
        fh=WHCNdLkfWRa6/Q38ts+aESrGpw3ko4XaytR1BPsWico=;
        b=czNsriBrwNOlTkdFvaFjl5c+Akoj3BVlvFAczo+3uOkvjRFGMhwnBCfiLC5oFkHpIb
         JO7LCHazru/ESD9op5wVJn0wl/RN6nxuwn5xcqyU8AoNQTGDv35smLshlTFtKEUtuqXg
         /U52XN7z4R1z9WlnD+sFe00vLmN7RHcUTOSKkqStf0hRqH5Kf+3YQs0+RpF/+aRzKJP/
         UulOLp3sHyswfoJLcfCFkX88iRc6Fo2HI3lcdVUorZPDOBBEyOX42GdbvDg/jCdBWS3Z
         Kfmxet8IN/2HKDsRuT3bOZY/Fzt2FRA92HBQvi6Kvh/fCeklyA2mM6G9/D4J57i39YTN
         l2lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786448388; x=1787053188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2NC3ZI0tO5C6E8BTeagCEoT7beDj2YO+MbV8ihJjJzg=;
        b=VIKgW9KCwZZcVzG/Ya8SKvXrQkQI5l8gjy4bD8Cry2WBOW36OSXHKAkmbX4QWAqHBp
         Q4jyns/VECLbauq/YDdZ3HHu3PD2nTVo4749lkUyTRtNhe8XYhVaXT5LGfVPiFnsPMPo
         lWRC6ObYTfj7cv9acrlrGMy88eyIVGmneQM+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786448388; x=1787053188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2NC3ZI0tO5C6E8BTeagCEoT7beDj2YO+MbV8ihJjJzg=;
        b=PkG4uEgDHSqPHKUXnD/YQzQ1WsiFzWdBOo+gMH9XFSDmNUnw+nW/PoAbmedRaNfEcW
         cKrpKx+Z9S9C7hAtv1qHjj3gxmj3+DncZQ6hhJrAoAXyCp1HHlBWwl+EINEGO0KUN+qs
         U6pyQu9N1taQA+u73aai7dhXlwCUm8K04wiPYDUmO57EAW0NBzdkcymiblO96M1IGiUd
         ki+SrER68a7hLPqsyYoOOmRvOwfvvGcIrVSrO2JdkU7zvnlEKMM6uPjAZ1PgLaWo7hNh
         Bhx5okgXhJzmGQmK+weVsPoNiilOpT2xI7hFnEJmyMHygkZQaA+U6qt615gsc3C4f2Fn
         1biQ==
X-Gm-Message-State: AOJu0YzzyL3xZs/Weqt4ZqHhZoLrDGESvqfJOnalGKDAJoMaXfBuXpbC
	NHXcmYu3v7s9YkFMA1+abuX84FBlIn8V056sbJq3zWGQtXJr2DTxBhet3yZx8OZx24Bl6KySgNm
	e2Ok/aeB2j9GM5QV0r5bUFlTk778fPPwOVtQQnUbW
X-Gm-Gg: AR+sD103Glj0MWYq8MowqFnyZHU7TJrqowgmPrtCizYtwDCNKGav7CPIAgySLuXwXK6
	0sGBpl/09sc2TDejKcAc04Rol1eGNnxdiIu43B/2udFTplZTXTNBpmKUWXkokXB1SGuydbT+VO0
	d3tIlw0qr+kngrRtHKJzqvSr0wb2jaYW/yEJJuWpYAcK7/aoe15CfaTmKo+ARAvF9ywqo2A/Q2E
	XQDWLTxNsrxRo/N2/IJv7CaHsFekCvKj4EFy54l4kVdT9Ibc2woUkvzwhddt1S6gX1FFDtG/4J/
	vlKQ9ka7g+A6LgCW686qdXN3BFgVSi588Ekjb0ORhe2WUqG6g2gl7lMuqHZ+uMc6LPtrf1zlrpA
	=
X-Received: by 2002:a05:690e:454c:20b0:669:805e:39d0 with SMTP id
 956f58d0204a3-66b22cda1a8mr1278871d50.8.1786448387844; Tue, 11 Aug 2026
 04:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811071319.1352016-1-andriy.shevchenko@linux.intel.com>
 <CAGXv+5EKtcEy29oy=8Qah=1=PXXMds3BvR08u7DQ656FB2u95Q@mail.gmail.com>
 <anr_ItiTKL3pjJH-@ashevche-desk.local> <CAGXv+5FoNEPu6kUKg7C6vgMCbmyFRbRxin=tH7o-=RQHp0jE1g@mail.gmail.com>
In-Reply-To: <CAGXv+5FoNEPu6kUKg7C6vgMCbmyFRbRxin=tH7o-=RQHp0jE1g@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 11 Aug 2026 19:39:36 +0800
X-Gm-Features: AUfX_mw-Wk7Xa0qUgxOyrHZ0nGgk5qrJOCpeQIGU9wXUOciVgXDzzKobPjwQaqM
Message-ID: <CAGXv+5HAzdGf7r=9PJ+Wczn6RdT4k-Hi9g-Wdk--xA7rw8cW5g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] string: Introduce __free(kfree_const)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 6:58=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Tue, Aug 11, 2026 at 6:53=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Aug 11, 2026 at 06:42:51PM +0800, Chen-Yu Tsai wrote:
> > > On Tue, Aug 11, 2026 at 3:13=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > Matches what we already have for kfree(), so
> > >
> > > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > Thanks!
> >
> > I think you can incorporate this to (will be) your mini-series. But let=
's hear
> > from Kees and others if he is okay with the idea.
>
> If folks can merge it for the next cycle that would be even better.
> My series already has three cross-tree build dependencies...

Ah, no, I got it confused with my other stuff in-flight. This one is easy.

Anyway, will wait for others to respond.
