Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B848424C
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076772; cv=pass; b=eR2kvgnbY3W3+gOBrQqW8Nij5xKzQKJTYU5LuUAGcIgtIcbPWppVqFw4OOdWepbV27hDFHcXUoV1AjEOSk4EkhVtfMd92T+unp+Y2rl9r6siyRWWEbTFw6KqoCxmX2wcenubIS2/y1PGv/0/lbhJ5HqJ5qLMp3w0OdeFKA5gVPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076772; c=relaxed/simple;
	bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkfeqcBkr6mx89+TWQ8iE3xeamLkYHsR9GYGVg/o3Oul4n4L7TDcugk+f5KsgHHQrLIArOkl7oGZBN+/jUuCa04DhbePWhKIgJqUiqrwqI8GQ/2YM3kYonJ6KAgk4joRTyEfagImMewg59pTAcGN99gZsDaNXVgnHOY0SWZI7Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI9EFXIq; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI9EFXIq"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b3119957f0so189214e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 11:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787076769; cv=none;
        d=google.com; s=arc-20260327;
        b=DatJb1FPp+n7MRjwhwpy8sv2+uo+cSX1swMrz5HINpQVHCEHXYO5v0IKFr8EqxI4V9
         TmbCUdjR6yZxQFzWa+NfVvLhM7Wuxde1SMWzfLkLGWIR8WwtSY3wZ431xWekcu8lTGQA
         oUybRhNfYMk+I2iDGj+rTZSCSgSLVUcuciUc8wk1cQik+fd5/hnvzuyswzgNNaTQwEX3
         GLaTSOi6uVSYOux3z5MgxbFP/wYKTFchcheqcTtI2lVpLmL9Phe+6TuR7Qkzx1sSUK+I
         s56vuriBeLmhq67a3fiShztxDGuIH1DQd87MeQhbp63nkwJegE0Ur4Ohdsk1z9Rmef7b
         niUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
        fh=cSAD5lAhf+uHTukZ+E2AvS1DcrKQpRcFTVUyFpD8aJo=;
        b=S3vXiC1uQC1KtRI3JH0gjgQxtXNnLpYmToSUIFf1URCaVyl9XxkEs6z3FAtG9gZht3
         6itSJBg7TrdqRmRKyTKBBg96QEJUlwmDMx92etLJfB7YgvsonSUaSHSH6ZYh1OluPs7q
         GylS84WUioGFENTYw+4fKeCZanvfT8HDyNWa72bYywq0T1HNwRqj4vkOAzFebeDGtmQn
         bYhVt6rUJYkMh7+kRhOv/Xj2lvG3Xbhlez2eonPwD8D1wvXerNwVFgOOKEEzafzWQn7b
         PHbV01FicBQDNSRy+v6CpJcwNPQTnGPqSpOfxR+O5rBI5Ctpzf+Pu8AFt/0T2BYOKRrm
         ohLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787076769; x=1787681569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
        b=cI9EFXIqLZtxOwbcPy1n/SwOyM97CkaCGCO32tIyKapOrco9zYL8GSxSqEz+0pdZGl
         eRdXau6DWUtlljJX5siu+Qa4bBcPCG2x78BsZc/yP3+b9T8627tXDp96yST3gpI5hvZj
         caDeUzz8f5mECkDvRl3hldBuC/OB7cRpdQoNHql5Kr6EiWVncMXq8di57OMtoeMBexNt
         YG9n/9LxlrQKTaFLS4JgSd+h3XKqo0PrpL9w6SClRm4TrP3HGB+bmyC5bInfa9fMZ/vg
         J8c1uHVEz2GO5NlDvOb6H4HpGMNfjXOhzQLinkPd0kTG5qQOn23C2UQ7MuzDFev2+ayU
         hdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076769; x=1787681569;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
        b=q0iCQ9wb08Wc1xkxpC1udZfJyoPJYjPcaKqqP2nySV/Pw477YYZ4myahwHMBGyqgXq
         /PJ1R2f+F81ZUxqqnfSCpS5Iwcni0dJ2kPEip3WuU/QsiO7E489Brg06Df1Dovww8EcI
         19pAceT7f3rWQnWFGJ+BahtpF2T6C60YTu1BO4VVQHfMOJ1Uk61Hgf+Z2tLiBWlPW9xD
         DLS7Eks6lDR73FWJNNFZrnAQdmKCznW8sPWZ7E/CAmU3LKzP01iiU2HPeVy2nIRPLhsn
         YHtZb4SUkpLOIgdc2cz0CnwbRJUrHzn+B60/3SnbwEjySrLhuuVMDDgpeTSQaXcitaKw
         laBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqgQtgticsf01BiIZ3c3UF6sbxxo9vUJUTksCH0qaOq+QPjx8bUxV3Db/aPb2cbtkLRnp04E/j7/00m2i2lpsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGZ02hvDJl2DIH1mavCrOk9BboZXoJAFTatsn6a3euxaTTS3S
	MZvPibciHSkf57oCp1TPGIT5ahwWW+CxhC6DTGk6l+SfSk0GDEk6RgXdGyjesdvUmyykavW32NB
	TiSB9R2+H2hWpq6zmJUdYPwUHgIwKY5I=
X-Gm-Gg: AR+sD12hmwVfspfNRYuiTUS3++tP8e73/u3GkWjRJpZx+iApheAj+unPo325MeIWavq
	k900hxZxEGbFOiSPCetoxpMaRGFAEJC4nvcS8gAnhfKZR+IIDNQChuP1L1hJcGeTf4+sE8BblDk
	n7NjttpxyqEwHo5fAp20I+DZ17B6re8bR7H4kSeX5q27dWn3HcEuGQQdBmuLNwqtqTd/1yBhtoA
	L0P31/Tta0kCly8iC3KZljWjb8Ehl2qsIPTf62bsns1PBQIPrbQax7sXVK11sVxe2Yl5yN43Uui
	1UP49bBsp6jd/K0xzwxPohXv5lIDNTEOhqjk1V73ZtwxeNrYreGM3XGMhUkQMJKL3AsQZ5JVvBB
	DGwjYkD7a1ZFuQpeIgKzoZAKOCQ==
X-Received: by 2002:a05:6512:10d6:b0:5b1:5ab5:ea09 with SMTP id
 2adb3069b0e04-5b477c6091emr111830e87.0.1787076768577; Tue, 18 Aug 2026
 11:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786746757.git.ahmadexp@gmail.com> <20260818095654.5357db1d@kernel.org>
In-Reply-To: <20260818095654.5357db1d@kernel.org>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Tue, 18 Aug 2026 11:12:35 -0700
X-Gm-Features: AcwNN1VFdbc7wToCDqu6OVpR2tD_blBihPQ30U0mvdmP813mFMsjtyFeEMH6kL0
Message-ID: <CAOQiBWM57ZBafMcj9MaegHBuM21313O5PqAAGXdHfvmHxHp48g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/7] ptp: ocp: Add R4006 and V9 I2C peripheral support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Nam Tran <trannamatk@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

These RGB LEDs have been part of the Time Card hardware since the
original design, beside the four SMA connectors and the GNSS inputs.
We never had the opportunity to add Linux driver support, so they have
remained unused under Linux.

There is recurring confusion about which logical SMA number
corresponds to which physical connector and how each connector is
configured. The LEDs address a similar operational need to ethtool -p:
they help an operator correlate a logical interface with the physical
connector. Their colors can also represent the SMA input/output
configuration and timing status, together with GNSS fix or lock
status.

This series exposes the LEDs through the standard LED class, avoiding
board-specific raw I2C commands. The generic LED controller driver
provides the standard interface, while the board-specific status
policy remains outside that driver. The second GNSS LED supports the
card variant with a second receiver.

I should have stated this existing hardware and end-user use case
explicitly in the cover letter. I will add it to the next revision.

On Tue, Aug 18, 2026 at 9:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Aug 2026 16:10:48 -0700 Ahmad Byagowi wrote:
> > Add the generic LED and I2C-mux support needed to describe peripherals
> > behind the FPGA I2C controller, then use it to instantiate the R4006 an=
d
> > Time Card V9 board topologies from software nodes.
>
> Ahmad, could you explain why? What are you going to do with these LEDs
> as a end user?
>
> The influx of the LLM generated patches has a hugely negative impact on
> the community.



--=20
73
With best wishes / Mit herzlichsten Gr=C3=BC=C3=9Fen
Ahmad Byagowi, Ph.D., Dr. Techn., P.Eng.
Phone: +1 (650) 924 6653

 Please consider the environment before printing this e-mail.
