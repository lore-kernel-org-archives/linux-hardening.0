Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC6219E8C
	for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904320; cv=none; b=CibK0oqP96I+G57eMd5/iqs76tuYvVqRFweAiNhTA8hy6kv2JNB2wJ/JaVm1pcSwifbvEmcpdVI9jo6r+HHYd8p30DuG9TRldOzBMhzpc2asu2+q9S5LzkpvdW07xb/Z7hsDrXTe13L6H1mDu6rUb6MFGEKfcjELeAl/o7shQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904320; c=relaxed/simple;
	bh=C1qeDwfEftv9Qtc9NbKtJwR0I8PI7F8FTKOgTziQCs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAx3uv/6SqCWFtlqtinNTmP2BNWDQbX0TdGE2dK1wjhV/LUDE5me3pp7BnHP0s70tIp4InvOkBQPUpmAICPGMRoGQwPnPWU/9I+R59qBhaKYfE04Nx83q0Uz7BWa3eaAvmclif3ZvkU1Da8nshlxJ3gjvBOthkHWI2mKQaLupI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wDTP8Tc/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wDTP8Tc/"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b82db8fd4so4823661e87.2
        for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754904317; x=1755509117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1qeDwfEftv9Qtc9NbKtJwR0I8PI7F8FTKOgTziQCs4=;
        b=wDTP8Tc/xSAcV3FGVSEZUXpg513zrACzLoc6f0idkbwpC/MlqlPzktfUIDkz6raifg
         /zLdKEEMCgEA2tzqk2srcKx+gDeSeEZKev1tkQRqW4KT/KMUasctixOSzCEiqkyHbPT0
         NommpQ7GKeyyuKeRd+HtEGmx/sBGmV/4V0HSshZsTVgzDjJjzt5PqEZrggIxNJ7tdcr0
         bRwZCo70bADHyJIT0orxARooOvhJ+WlyWo/SMVdLUhoQCc52GPUHd12FeXrXEQevtbqM
         MsEu0q8JxYKDT/wv2v2NOSgwURR+WPsTvaVCX1Vdg+A8RzQkUlcgA1HhJ+j0lDB0Bi/3
         PZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904317; x=1755509117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1qeDwfEftv9Qtc9NbKtJwR0I8PI7F8FTKOgTziQCs4=;
        b=si+IfFdtXzgoN/otJ7CO3LkpTFSAA8fBy8JzZxZjTtSO/+6RQ1ZqwUV3ZYKoW8RCNQ
         EzRBOeSd+MFbrzApIqEwtdX89r5ETb3ugxUNYcmEMN5V8IFZKadbsO2AWaY20eBu7ex1
         UNmDpqEyE6LWBft+jnpOt9BqDeKPs6bd+ETPkaGh52dilJjFTHIEEyWSpn70j1DBC9I6
         MfQG9KR/TNpMqgXonw0DXIRzux+EZhsBWbs/n9D8hNvt6OnAUcaAaZ4QnAiA/t92hB40
         kdHsCHxP1oMJ0Xvofntwagus771N7Z4E/CnWhUCjOAMCQjXhu28UZPrMCRe6eBU+Ql7Z
         BhFw==
X-Forwarded-Encrypted: i=1; AJvYcCWJjZXqCm6ErzGc7BIK+98eFNQIqcnqQcWsHpR+KMZhBC9+OAJEPwNlPIkmol7g7Ngt++2N/OO62emUKpuQG/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1XJBHY7rplNF2vVEpbh1j11S5IbKIo1mpeDbCkolyPOJZO4Bw
	ptyHL1J368jSSbW74z8a88/d8Q9lnwpIPad91+iBKBbt5LDT1FpSKMpu4Nuax1sGZuI/8HAgNA4
	yY+sIQSk90WyGxjhHU1lG7L/t/HAE9wOYKzMYZ8cClg==
X-Gm-Gg: ASbGnct6YvsnHsOMBe3WhdS17JtEMw40BXgjeAZmO28daB24gDY02wrGDK9uTQS4oVT
	nLC6x+wNJ+k7rVThTMbvaXtOsAp7+rDq2l+U4YmLRHUc3DLutlTskoSZUkIVfTG2iiIHfN51cyW
	CgD+W7BwE4YzHPTXx+k9biSOTxHpLNoPExEjJpFo5Fhb4EdCI6XmSo/GP8qeLm0KE7cGhB7AF7t
	Wo9txBwQ1opigFa4zmkP77KoHUEhvmeP3bkRvo=
X-Google-Smtp-Source: AGHT+IFEJ8Kr/7UZFUl5DP8ogOjUFv7USaGLp1Up0YSuMufZWuE20hE2f9lNt4hFnaJMoKk5CyywiZa15bQxtX2o7xc=
X-Received: by 2002:a05:6512:1582:b0:55c:cbf0:9f2 with SMTP id
 2adb3069b0e04-55ccbf00abemr1611941e87.39.1754904316634; Mon, 11 Aug 2025
 02:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
In-Reply-To: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Aug 2025 11:25:05 +0200
X-Gm-Features: Ac12FXyxTrtG2C5wrpdI0tEHXQwjM85EraScv-lGtxmCx_tl-04aa508XaY2bDg
Message-ID: <CAMRc=Me54AmqRJ3pZFfP3L=Ua5qqk2z_ZwR6FRfafOoTCxmy2g@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:00=E2=80=AFAM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> This is the eighth version of this series. I just added a missing header
> file in gpio-aggregator driver to fix a build warning reported by a kerne=
l
> test robot [1].
>
> [1] https://lore.kernel.org/oe-kbuild-all/202506092324.XqSwWl1z-lkp@intel=
.com/
>
> Best Regards,
>
> Thomas
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---

Thomas,

Can you please rebase on top of v6.17-rc1 and resend? I will pick up
patches 1-9 and provide an immutable branch for Linus to take the
pinctrl patch.

Bart
