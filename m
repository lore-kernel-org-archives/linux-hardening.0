Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06CB381E8C
	for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558558; cv=pass; b=L8rtlOG7m5bvbQdtnsLn6GLUB0NdNoCK1FH6/OEJosK4iFhGl4JK9Lj1heDueYT87nVLm4C6jGgq5I0XQ5EdKHyMehafwuLUExaAKtyeBo36Ku1Kav3QuYsiOtbYnJNKYjgQBvCIRU7pV5HPYXKFvdgvltTQ6rscdc9qFglKXts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558558; c=relaxed/simple;
	bh=PgwvOoLAHdeH5x1LPpK/Ic794djJ4NRcQySFzYPO0Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxdAcJIdp8u4N+zFA1f7CVhCE1YdzGv4RR3cT6gZ/hgnEKDW6m9msfaUjptXoLTXQrk6kpdHYaJMQGtWjON68nHNX38hxpqiL1qp8O2to8lcQRuIlw6KcxUVAszMtcZNxFAt5CqnH8hL+2OUmVq84Zid7Re+x6MdIOjHuxF3wQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKUd9qq7; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKUd9qq7"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2020421077so222864066b.3
        for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 11:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786558555; cv=none;
        d=google.com; s=arc-20260327;
        b=ow0HxqIK2ZkAfHUK5yGFz0fOcj1pa0TJmMdZBnCsoHDIeLcCg1wf8c6pJOC1M7jYXi
         8AWJOFlqhpo5kUdpN5mnzc9mcvOB+suDZ09+TFRTc5niotQN6YUlGruX8N5E/Omerphc
         +gj8z4YRsKpg8O5x0NTxx7z8TsuvPtr8j+xOZgVm7aoH+uxW9/p2+qnF5yyqTDgRi1tU
         xKoDFGMZoJSLzMw36Hq/2BtLhNeMDAjs5uaZyAU9keGNp7MF33Lasxl7w0a8gYg2viIo
         yeovnE5bCHilLi2eh2pPFAnefPLEOG9o0cjykyWIHc4FtYgE5mSjz/5Pt81QmCuJv3SS
         z9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PgwvOoLAHdeH5x1LPpK/Ic794djJ4NRcQySFzYPO0Xs=;
        fh=keEAylDvs1MPlXuLgJ0FpI+26jimoLMfWysOW9bEImA=;
        b=pX5ZqPkcFtXwdKTqC2276BkIx2tI+JfMgEDaR1N6Oa5oXrCOrJeFp9z4eM3jQKi6Wt
         CPUpGRPghVEw2BZdFauPx+20rw2SedU9ghqb2zuIr14dajpdEKbEmv7v/BTJWLrjZFJ/
         YnK7RtNuvEBqr0olxeTclohfZuLOtYSl6FE99xaWRaAJ7sAXF9mPN5orQwSkKXKcRkec
         BSEpVILdIVD7qBAuJjI3vgsU+5edaIntZqnud7ZpBu8UghxDtia1HSvvnuo01OxpAIy4
         nX3oNjJY/VkUoJaLgY53kOqOJBtGB++JdCfcuxuTQ23k01AFfTQIALzAu4MGUpaGBcW/
         VbLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786558555; x=1787163355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PgwvOoLAHdeH5x1LPpK/Ic794djJ4NRcQySFzYPO0Xs=;
        b=kKUd9qq7t3DV08lJ0M3+rLTN9C1Sd/lu2RrJhhbAc2Y/tZex6Fh9foZj9c94A9M8Hj
         gXtqm9VelNoJQpgTNB9ppgV3mQf8yIGFIj8ki3pQhYrrmFar66iX/m+RgA8UZ4HeyR/L
         hPnZmByQ3kIwsF6Ku62czgYpSV0jIVY53QDyhfWG+IfKqKKnRbRnbXThBAMScydbTiBe
         DRBzFsYxu7z6spP0vimuAWuoZ4GgZ78MrfEoOuQd4sccS6YqpgRnrCp0J2/0ucB3zApf
         CBJrOpdpa8iCGbgHtpJaiNd14Viw3szG4b+vBsBenGwuXpL7fGIrJeKAGcKDJMdIGlTQ
         sg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786558555; x=1787163355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PgwvOoLAHdeH5x1LPpK/Ic794djJ4NRcQySFzYPO0Xs=;
        b=Q9K7hDAHVY3pcaa3o1nBpoXKHe3H4v+K21qDuojNmuErd96bgtO/PtXcaM7nUggpBx
         gwOpqoEien4W7rnO5vk06IqYSwU3WAXraI24sGK6nDn2YLCiUSymF4z4QRFiKPgrBlKP
         gdYoQ3zlB3BeK9gwmw0RNcRrkFEas5UyWr09w0bx5Pvio1SN58sRDblSt3G8CXrTgfo7
         BP+10xYLltVUerJ95LR/s+72G+qXmgI8U1Tc/MO4Yo/nFDjPPxa37qwG/58JA0wqL5py
         nsGinjCW07B7wClTjSiPPgYX5a7H0so2YslEH7yGMLrxErMtyd/DVSmL9J1cYZMk/aiP
         xlbA==
X-Forwarded-Encrypted: i=1; AHgh+RrbnHpsnIy1xNm4Z69QD266ZgPWFO8Q1Zri/5qfRIWlr1XyuQ+yq/d2wmqB5oEMsNzDlVr5x95Md9DbiruJypk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9hujN+2L61GI/bS8Agm+2lWtHqVAILKVZMRvMorcP9xyaShv
	TesnyoHW2rSzwkUFqg0LWSDDPk6K5YL5y5Sxeg5U/s+/xGOrAbbqdqozLFrK5podBA1vMK1FwV6
	YOtLJC3amIMxD3i5u3QZb5IscaBG5+kg=
X-Gm-Gg: AR+sD12gVZ+gCxuGmm87C0oXf/4pySrgI7ztVMnhPwvlzFfwn0x7qcjLxg+y1ESdoVe
	sgSfAKruWpZzJ27WtF/MNzE0Y/l6WmMQE3y9ulTY3X+43qo1XYGkkE5N/78HKJ4rqW5yQcnnLv9
	eDQA/xkhFHSR/AVKXtRC9zs2WR3DjGGPrLr1wa6fQ1Yw2Z1A41Oai+D09j9yTa+unoAanYatrVE
	EcrtnvEnTjqOkQpRJe3CK1RC/EPwg3Gi4xRvWH/HNmv0UC8YdSk/gTJnLgels4Y1u8jsYuMCQBx
	j/MQVQ+3jpmcHhJ5omZbFLqAZ9AzpL2/yvhIMS2sRDYARp/CkfcuR/j8rFpUoSQwB04lloa+sWd
	OkaH2pXKdktXauCBItusbmNc1lBXrL3Jfx1cLS14m+VB5u7ohAl+vw0C5UbuwH6GS9L4zUshgN7
	9z2JN84JlBKfi9qFYjIVqHqH/5nx83H+2sMk4eiGC+DeOTYpvQcwKZ2sI=
X-Received: by 2002:a17:907:c0d:b0:c20:899:b8bc with SMTP id
 a640c23a62f3a-c2108ee3cf0mr7867166b.6.1786558554870; Wed, 12 Aug 2026
 11:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304041400.7236-1-rosenp@gmail.com> <djjg6jwpuu6l5wcc7zbxfi7j4n5hircmhivxohdtgufzrp6rlb@l6eyfdyfrxix>
In-Reply-To: <djjg6jwpuu6l5wcc7zbxfi7j4n5hircmhivxohdtgufzrp6rlb@l6eyfdyfrxix>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 12 Aug 2026 11:15:43 -0700
X-Gm-Features: AUfX_mxqbIvZ73kcSiSnSMXY77gQTI6q5M4UWPSGxgp8t1CwI1GTwLlXmGpI4Co
Message-ID: <CAKxU2N_VYNgYKhS11Frzio4fbg_ZnDsvCfEypvxSiw3-JV0_QQ@mail.gmail.com>
Subject: Re: [PATCH] phy: mediatek: tphy: simplify main allocation
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-phy@lists.infradead.org, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"moderated list:ARM/Mediatek USB3 PHY DRIVER" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek USB3 PHY DRIVER" <linux-mediatek@lists.infradead.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 6:32=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Tue, Mar 03, 2026 at 08:14:00PM -0800, Rosen Penev wrote:
> > Use a flexible array member to replace kzalloc + kcalloc with a single
> > kzalloc.
> >
> > Shuffled some code around as __counted_by requires the counting variabl=
e
> > to be assigned first.
> >
> > Removed NULL check from of_get_match_data as it's never NULL per the
> > device table.
> >
>
> Please do not combine multiple fixes in a single patch. Also, the NULL ch=
eck can
> be kept for the case of sanity as it wouldn't hurt.
hmm? There are no fixes here. Just a FAM conversion.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
