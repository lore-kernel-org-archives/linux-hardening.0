Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D361A8409
	for <linux-hardening@vger.kernel.org>; Sun,  9 Mar 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512982; cv=none; b=L7QriH6iS/UnyBQ3ijaVrq3LvdGWAXNyxKkox25JmRDZABXb5EWfx9t06ieErJWPGUYq+oceuP0Lt9YGn+P03PHScH7aUiNcbTsDUPyXPZmLsjuf2D0Cq+TPpaQg6IX//id4oOCzajFOdnlHbRHO/1I63FMnrBryaggePu4Tl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512982; c=relaxed/simple;
	bh=RVfu8DAMzXPHxXwHgpPDG4/bBTmqwuwrt/l5NUmzylc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuyL6kr2MYzQKbQAom4YinJYd900NeDQqCg/zUytbbBEH+0nVr68RuJFGf7dlxigO3rZLHm6aVmqlR3eXyXf7OlHdPoEU9tjTRlLTUQ1rW3gJVOyD8+sPvXV0h5FGt/+94yUzavC1XfsiEpSYm2yROhHJDSTwi1AW27S2cEECeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RMagQJTR; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMagQJTR"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso22183171fa.0
        for <linux-hardening@vger.kernel.org>; Sun, 09 Mar 2025 01:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741512975; x=1742117775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qv7t9LAWFlrZnh/h1qzmcLb/WgGltOmnbPS1Sywm160=;
        b=RMagQJTRI0VuKI6kR+3xBVVqMfQWa9rJjUQfZlWWZMTzEm0N8Y/wGNpGD+I1aeQNFZ
         o04lA0H4vIX0OHiXZ3IC8vzEcgQli+gWNEsqJd/yII7xDni0BFpXCr7HpnWHhgD2YfcV
         xOiNS2T+GrAD7u78FgXkb5Hb1j69CKz3FSk0APN5lhEQrPhKLFs+Vu9Eivq5D2JxompA
         YFTTsAV9lcKjU1cvsE46Wsy2ZbXm4oy/sJVX8ylg0E70iyGQGL3njhw1SVlkvoecm4Yd
         SFgmjYwI/ggtlpxYLeHTqeg535+3ewLV9KJJrKTTyBV/Z1ORCE8g80cm8K08S+0PHC/S
         L7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741512975; x=1742117775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qv7t9LAWFlrZnh/h1qzmcLb/WgGltOmnbPS1Sywm160=;
        b=ihD85nVg1Bx0p8P8ICf72LLhEKiv/p8kuiAHT8mBVs12Muxs5ThBNM+tPMzZwDls4o
         FfMVOIzWbNY35F3+3avn8U5FvjFMUC7f2vmlpeA6/Jxdz39KfGqNpHPNgyD1w0x+CqhX
         cYwfyOv6pVXdWScgBgfC87/6uZ6DD3TQoCDD5OkzCta80CC1yaQHXOgstvWEW7npULc3
         nWtIZOsJVPL+67Btg9q99tze9JWtDiQ3uirNJYrLn0XOqRpXpUqBxvzDsYXVtKFhzjCz
         T6G4mMDEBysNqDWkgsSSsAN/UFUVm/9ya2adk66nR1DIt+WvahURCo6wXHpuwNvSiN8f
         7/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjWWHJ1RdLAWTB4oKVgqC8yxP7JH/0R5hH66ZE9mz4WDovQk5IW73x3m+7aB7/H9CuTeLCdvpjeH4LT0QE/t0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8s4AvUwQQkUNk8hmu+w0Cabv32TAwdLMMA/gVCJ6kgeJRgh4E
	3rSjkgW72pI+hyPq7KahSTbRBkGayujCrQh9NQXeYb3I6T4t1YxVxMksCGFdQCEYzGqWdfZLyG0
	lUms=
X-Gm-Gg: ASbGncutz6ehrGC4dNnExJc2v43CxhZYU3y6AGudbb55CQDtmsVRfIzTfNrxC2CQ1Ru
	TH/8D62zSqKs6cidRBPYxGkdG5z4X3UP4NhzuDbTcI/62K4Wk3JROY2aAwP1FcIAH7mlD3pQcY8
	B5/OtEUZ5xLwHWVki0+Oo/huXMQBrgt1UXNSWOcwz8/5M/ZvfZV716S0pystQRX62isu/6pIt/t
	4vtQ4hfXKJiWip2z859lS+eFjNGEf0TN6V7KqGSLyo+SJFxaRYbFi+Qhx89Q1mHOsIr+WaEuAsv
	cpAoZUvjmyijfr82aEzhlZhwDkeUKpDsXYhOOjcScoIX/BPmEQ5U8amD0+yt7tV26dUHaW3pHWQ
	V0qC8Ydb7ZUcr+6En4v+jkWvo
X-Google-Smtp-Source: AGHT+IFQyC6l+Pw1P/BVH/g0erUa7GdcnXNOr76Jgy50Rjd/lC1C4UYs/hv4IKjbXl6NI52mEWrsnw==
X-Received: by 2002:a05:651c:1541:b0:30b:d63c:ad20 with SMTP id 38308e7fff4ca-30bf45e28fbmr31911591fa.24.1741512974977;
        Sun, 09 Mar 2025 01:36:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c00e42dbfsm5573811fa.89.2025.03.09.01.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 01:36:13 -0800 (PST)
Date: Sun, 9 Mar 2025 11:36:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Ivan Belokobylskiy <belokobylskij@gmail.com>
Subject: Re: [PATCH v3] ARM: dts: nexus4: Initial dts
Message-ID: <qu5w56bp5yurdgbhjpeiabn5pvpoov7xfyta5j7djnnrveak42@povbs5bddtsz>
References: <20250309-lg-nexus4-mako-v3-1-1dc2807df296@ixit.cz>
 <l4lv22oi2ktubf7aveqxqtwb7zz7cfrzdayuxxgwdj46ygubfs@qpl6ut37taoe>
 <88da307c-0403-405d-8356-c8baeb18eaba@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88da307c-0403-405d-8356-c8baeb18eaba@ixit.cz>

On Sun, Mar 09, 2025 at 10:17:29AM +0100, David Heidelberg wrote:
> Hello Dmitry!
> 
> Thank you for looking into it. See replies.
> 
> On 09/03/2025 09:33, Dmitry Baryshkov wrote:
> > On Sun, Mar 09, 2025 at 01:45:51AM +0100, David Heidelberg via B4 Relay wrote:
> > > +
> > > +&riva {
> > > +	status = "okay";
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&riva_wlan_pin_a>;
> > 
> > Where is it defined? Also pinctrl-names should come after pinctrl-N.
> 
> definition is kinda aside in qcom-apq8064-pins.dtsi .

Ack, missed it.

> 
> All other suggestions incorporated, if it's OK otherwise, let me send v2

I think this also needs several supplies in the riva device itself and
in the iris subdevice. See qcom-apq8064-sony-xperia-lagan-yuga.dts.

> 
> Thank you
> David
> 
> > 
> > > +};
> > > 
> > > ---
> > > base-commit: 0a2f889128969dab41861b6e40111aa03dc57014
> > > change-id: 20250309-lg-nexus4-mako-da0833885b26
> > > 
> > > Best regards,
> > > -- 
> > > David Heidelberg <david@ixit.cz>
> > > 
> > > 
> > 
> 
> -- 
> David Heidelberg
> 

-- 
With best wishes
Dmitry
