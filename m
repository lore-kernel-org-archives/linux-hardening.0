Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2625DB12
	for <linux-hardening@vger.kernel.org>; Mon,  9 Feb 2026 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672527; cv=pass; b=gWefRYNJU5xMM4wY/WcKUvwCQiVQB34BiPwlRidLuGcOGVXBHgOkXOufZ58YX7opqmirI01SC+zEusZpbK6exx9XIhfVnpDdk2AQs9fYn2ydT+t5mrrCY3wNHj2CFUmR9EIj6uO03dVshWIeT1Em0TLbnHoPJGI9taEL0OZONKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672527; c=relaxed/simple;
	bh=7VxxRCEOKnnPs1JTdwiGqaK47NG0gxr65sECLL3hgHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8Mlvx8f2MSoOrOU5JpgDzPvIcKeGEJ6oOZGajfTTFyklStkPXhwCDs+0ryu4JuH/C9Gh2ES+6jcn6XpVb/q5cTrJERreWN/5FKbSm+H7TB6SkoineZYxln343sfrVYN3sKrh549zPMwiGNgU3JgolWnjgkSck7boaRdFbK1Msw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lliXtfSS; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lliXtfSS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a102494058so27184445ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Feb 2026 13:28:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770672525; cv=none;
        d=google.com; s=arc-20240605;
        b=GyXBGk0oP5Ka/XAbUOnov1mjVshzVciembpD5bvxPea+cge5UsqFAriOVccT6JHMe0
         7KDB0HvL228LhnqXEJhfrsp2waSGcU597SZzLX48g5+L9cdHuxAONNrLJYS/Ta1ZTRMC
         fITcdfaGdNa9VhRcVYauPGl/rzBjdFuabjsW9NX/XYM/On0LFO8kJ49L76jSRNYT3wXT
         GkofxsebODUABv3WdaSH2LNsZHaIuwbK1Ftcqjri5Pf/0/Xd+GNmIEf1vQ1bJasTANLr
         k0T6bZ4wVt2P7Ip2X2y6W29Eq5cO1YO7E7VFXmhGpN0rNCWjUEfOg9pcfQiIPkfw382z
         Yycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k5FyOhy1MJGzIJn1ngR3+3z96yOozaG6Ty++CDkfdvU=;
        fh=eXTufkipJuRrxVL2AYgXLrYrWC7Fx601DEOEaxhjXCs=;
        b=BleRKl07I9odbUB7or3AuDcXAkcHtSGekKjUv2Jo+SCF9QrFmkGXUn78XZbDO2aQKv
         B0mB5xhPNAIgY00uVR6M/hAPPUWVJcG5xP6qqrivo4PFsWvK0vC5G0LOnjw4+6HHd2yN
         gn8C0JCbnUyulm8dLzmvrufqGjWVIx2MfEl+liPpXOfLRiFDMmZxchI6WuIVKQOM0pgu
         yxlBCUQM7mZeGRGd0lydipAAH1YAnBVmHSGoY07o/AHc6J9BiTYF0tA7sdTDtI2LfqSN
         7ikJ8NeuSG2DVzTqJ+5oDv0acgCJ9HcR67yzR/CYUUzWtW0kjTPXb3UZJFiELtbxBsi2
         FVkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770672525; x=1771277325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5FyOhy1MJGzIJn1ngR3+3z96yOozaG6Ty++CDkfdvU=;
        b=lliXtfSSblamQDZpJMmNHXYwt3eEpHfg8DqTJk78TXldCuOK4mD3+g1XSfiD1S5sa6
         SbsUo8h7tipmgGHUfBI7Bi0rmrCnuKfws/MbrDSLO3VSskxygc3k9FE/niTPoq2UvmVV
         SBMnmR53t/eDil6s+kBGn+JRvdy3+pGpcrcXZl82G77nT2Z0jc3w4FWszNOI5zWQsFny
         Dl3DqbvCZCP6rlHHGY0WAOhnCo95baHiM0siE/jyuAo5lCQ3J75KWS86H6MAn+rPnf7U
         FM4wkM79jH/Bs76Rg2UytbzqH9FtH5RW1Mk8K3VVWmY3YVNACkC8mWTUolE7WI2MfkO5
         vD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672525; x=1771277325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k5FyOhy1MJGzIJn1ngR3+3z96yOozaG6Ty++CDkfdvU=;
        b=NEE3ZNJprPm/6UpWFjCYogO7/69vQs8GSCo+qXGrUSDgfbLwdbI9qymJVGVxs1utYy
         NykpbSot+aKhRyNkCu7KT7MZgkZII2DqMRBJm7/ACsEzWPYKmd5VtlYs8mgRbuw6+Wm7
         HqpXW3sxE6dmy87TXwaBAzj6jrH7zK35QkNLfq8Gkmb2oEo2sNq044QjGWdySQ+fWW/9
         e2beAlHE7Eede72oEL9ZXKQXYtnPtSyMJ4cHmzy4iIQPLx3IZJljZopT8vtY4g40QViQ
         jrfRqxXUeU24KTuBiiUICB+iEl0SRdZlupX29VM9sAO2a3o27lk5V1gGqSRonzs/r2PW
         0cYA==
X-Forwarded-Encrypted: i=1; AJvYcCUIdzuEJ0CqEjIc9hDdY1Oh9Fqz58SUj+8lHpEQebqhh27dbqeCxIxSvEera2wqGo5VC8ojnXgIy7Emlx2c0Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeHI7mXsBrHSVMq1aIHhv5Qh/TOEBDzxFjThMGJnzxxVqWBbhq
	EPs8y8aa4WY4Te8fdUf4veGZQbbDEASJHSD8XzF9CNnkLCMc/s3aNvsUtY51jjewIIlHauwD2Ss
	k8DIdQ5cdHpMVw3us4EOkmctv8G6UeHk=
X-Gm-Gg: AZuq6aJjWa0sNElPmDz0A5otHqo1b5k90nMDpCQIgGtn2x+mIDw7WDq1FKShEmzuj4l
	WIdr8XMYgWL2Ag7uUxH+VHWZudOsXsdFFyuu6MQQs8EaQIOQ/fqXy8CmTKYeXRusYVCGjnfF8xr
	s0OxlXPEA0nn+ya4i9nqcBrwMf9T4yRL4u7kCIn8qgQUNol1LSAFbiH80CI1dEYSdxBiDN02AU0
	jTA88n+QMvLVoZ9BmQG0g2wpiKbD+xYkzPasg+RXtSKTQeWa0kai7moCICy1SsCGJLBBDQO6d6U
	kD05Fo7aA7t5fr71RP5Ot+P9Q0p4
X-Received: by 2002:a17:902:c942:b0:2a9:5ac3:a925 with SMTP id
 d9443c01a7336-2ab1005a1ccmr1466005ad.3.1770672525352; Mon, 09 Feb 2026
 13:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com> <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
In-Reply-To: <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 9 Feb 2026 22:28:34 +0100
X-Gm-Features: AZwV_Qhsvy9MKoHxeyazUY3RMdma2GB_qfE0DFHV76hqeFYCbzBl5BWm6SyiZlo
Message-ID: <CAFBinCD5ZzjQc6ve-zZJ0MqN-a0rrp6pHYf3X_0ao3MRwi2Jrw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dma: amlogic: Add general DMA driver for A9
To: xianwei.zhao@amlogic.com
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-amlogic@lists.infradead.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xianwei Zhao,

On Fri, Feb 6, 2026 at 10:03=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
[...]
> +       /* PIO 4 bytes and I2C 1 byte */
> +       dma_dev->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES | DMA=
_SLAVE_BUSWIDTH_1_BYTE);
I have not seen this way of writing two bits before.
Should this be:
    BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_1_BYTE)
instead (similar to the line below)?

> +       dma_dev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV)=
;

Best regards,
Martin
