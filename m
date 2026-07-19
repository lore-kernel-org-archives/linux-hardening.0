Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D572621
	for <linux-hardening@vger.kernel.org>; Sun, 19 Jul 2026 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784420118; cv=none; b=Qy7V4d3VnHqLOSFua9gYrHZo+RfObdvpTL16Vk0+YWb1Mijt0Mh79XzVQjZf2ZUa3NBgtGsk4Ii1eSRUNK1htp5sQhRYzXU8Ls8J0ikP0Mdm8hKXPkmJSqFeTBxgKA7tBySdCtcIicbokZLM9WROM8sKlvKUGWvW/4mT/4eTnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784420118; c=relaxed/simple;
	bh=u1fp1alkBNst/d1DzrEnNRW68x049gphSMGWlVawCIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyP1qlZgsnfNkqVuI9PD7Q60l4c8TEY95L6sblvxBsmgqHPCEpl94wcuPO8NoryImRlz7M08HpAUVf63VY5uU/T7Z28jFAxGSxg9AUlY7jIlVLUjevMhydMhaV4hWvAo2vkMtcMUNfgEX6/HMn6hh1CVWos0ziQhAa+QXParJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RUCLgyIR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M3egmu6u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RUCLgyIR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M3egmu6u"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN36YF1991280
	for <linux-hardening@vger.kernel.org>; Sun, 19 Jul 2026 00:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jVtBejOk/fS9XQZvzarHu+foBgQblzV41Qics6xtFZ4=; b=RUCLgyIRYVts9/2s
	6+y7DuyqiVzp5l33JMD9gJqSwGPG7bHiCuiHZjgRPIPWzkOTf6ajAA4RJvvihwxl
	3V91JAmPf+SRgPdoZJYk43iIHaVuBgzrB1TTK8MDCv6igWSxhIurQjK6tLiibFBY
	zKEGYPVVN5wtSIBl89y4jf/vXkSkqzsJcQyomvkI5rvADW+/eJ2UosjX5C5qjvsW
	WmZR/+A9euUPR/oCJRPG54xCRZ/j/yx0zrQSlEq2UuthZsdBZbU1xeMEuKlSbFGG
	7+5LJCsI2V5nJwELHJcMpbskCC1yZQx3+SrGHyLrwtMzqiFLs943HQCwu0bR06M0
	QdJgTw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc1tnx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sun, 19 Jul 2026 00:15:15 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84885a4fcabso6608659b3a.3
        for <linux-hardening@vger.kernel.org>; Sat, 18 Jul 2026 17:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784420114; x=1785024914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jVtBejOk/fS9XQZvzarHu+foBgQblzV41Qics6xtFZ4=;
        b=M3egmu6uR/v4t7VVo0x6s3uFM2hUuzGlDyu24kqAAJgo0eSGFxXrDSChjIq46P8O04
         hBZIxq4zWc299PtJvfUVvzBIrYUckCuOZrEVAPCPXYc7h7iq5+GevmpcG6toUMPEzyyr
         1Mvp/46Q+sVhaT/+a/FOeMgnisjFpn+e6iLgAiEfLpbBpS/G6+4eQDBuokvy3FemSavF
         2DoB55JmwCkcJfQ5ncUQGW+/qIrgbd9UuncPy6REZVOOH9alqXCFRMhIiaNEdiG1aC1A
         7W9ADVeHKTZNY5y4CyvW/GC7ys50lYkw6IUv0OJrGEvjl1zxSrAZi+TLbxeF2g2v7eJu
         trIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784420114; x=1785024914;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jVtBejOk/fS9XQZvzarHu+foBgQblzV41Qics6xtFZ4=;
        b=DoLK+mtPKo8GCUvihESfLVhBq4r0qhX+nCDf5sMxMUYE+P2aGZu7kMXvZbTFdyspPv
         KMwR00yFm7Xea+WsMch3zghNnZ4M917IyJeMZnUfZaorQki1NnPOKGn1khQCvxSf7EX4
         hKni+LweNYdLHhCjAWdLDZRBTMHQO9C2VKDd3shhRLqVNEH6L5e06gz1xtlsPc/gTTpN
         NfmZrVcRFySj6nql0F9+582a2C9omIZ3OG9uerPA3X+gib+hyfWyJDKOq91nueZpfPE7
         sEUGyyy6AIE6yAA4779v/u0P4xFJ6qFoIR33fFakTccLiRuANefj4d332GeS6UAFnw9u
         KpFA==
X-Forwarded-Encrypted: i=1; AHgh+RrmKIxoLnxzVSTxmfo/K6pFG8LWBMwVocVtbQUTqRptvo87S/3NDJRJL8UY2z9biTxQpLy6DjIG9fbkCbqxzEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxijy/YW90CXfnAG7X0mmjvTC5woX503SscEGyRWRLoj9jeptkr
	CkcHezTAp5/JbSqs2SPpA5cmvfi7y2Eo5oFLNt5L2X0G6GKqvOp2s7We9DY350vtbonlAoXgVVM
	VSB1VNXzpMsJmJmJkffq4yS6YXZBbQBqIu+Uc/BhqMK0gzVM1Va31j7fal8UpSGQIN0J7l2Y=
X-Gm-Gg: AfdE7cnWFD4c/1SWv48jnX7Mxa3rZto6w8zgCN17Az5HuvugYAxihO3edzsjCeR2h1f
	z48n9822D+VWk41n7G2fcE3tgvv8Ps6oJzWYSTEg/UYxLYEx/5cCFN1M1XyASelKX8qXRmXeDRG
	jeZQ9zFXCbEdknJ3SMsKiBhgMA/mcCRgs2LrGrpGPOPIpZv7FG8AudONqsarAkphLm6JtMjTj+p
	ip6WvXPHQNlXmhuhn1QLbzkde/dre9xCioVrJqGToONArMcQuJLuW5WZv5DkjoGiMO8tuUho94k
	bPA6zySLlcO37xdTlxIhkK4FwVddw6c7opNC2PJjeyyUiKwZUrjytWf1oxHBtnmkvRXXO4/ok3h
	lc77nE3KrnO9xg804
X-Received: by 2002:a05:6a00:9283:b0:848:2f74:1d5f with SMTP id d2e1a72fcca58-84c29568665mr7946955b3a.69.1784420114217;
        Sat, 18 Jul 2026 17:15:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:9283:b0:848:2f74:1d5f with SMTP id d2e1a72fcca58-84c29568665mr7946915b3a.69.1784420113746;
        Sat, 18 Jul 2026 17:15:13 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad89d0csm3466351b3a.6.2026.07.18.17.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 17:15:13 -0700 (PDT)
Date: Sun, 19 Jul 2026 01:15:07 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org,
        Maxwell Doose <m32285159@gmail.com>,
        Joshua Crofts
 <joshua.crofts1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v8 0/8] New features for the AD5686 IIO driver
Message-ID: <20260719011454.10239afd@jic23-huawei>
In-Reply-To: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAwMCBTYWx0ZWRfX6+WkN44SRNDl
 tYGMGiojNIByxshZApzd4JsGMLLcGBNVUfHPK8wfLtlvqkyv3P/k6u7QTLnYyn8y2eWB69JZKOu
 Ho3atk+g306+l+Lmk4H7Csf9KjiktOs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAwMCBTYWx0ZWRfX+16fhdVQ+7qJ
 IHhJGpgncnkH9O/WYzCOGfNlhe1ztE1pzxXyd4LdJh+kHjzsJy/pjocedjLkChOuBW+yGmGFvaL
 pUcnsm/5kPB0Pms1eo/MkXPAYcwUav8ZZgLD/EoUaVHWW3vMcdUyqJ51XoU+JT0HdlmtgPUJKC2
 VCENE30Z7e4IL9glwjARUzS0/tqEAl6OCmvNbtZSbHMXbBPsBAlEaQPENdzIljAzw7SsGdg0NZ7
 fX6KCgVp5rR2+qNZyg+fzVGHeYamflnstRfcM+4Pf+8AWvjuCfDDZqGs1S3SOyoAeJTYO8pNIl0
 XL1B0J7p8u0MjwmiR08og/3677O6YIPx4cdXIT3VoLGT52HynOrXvjIYT+al7M/uqpbagE2GS3c
 fAasEYeYnmsKOR/EnpcrGjVUnFV3SIL9blubAadEYhqwhoJPClse/Ce/VAkpEl6YzbJncUkgt04
 1A5+CHIId2S7qaUioUg==
X-Proofpoint-ORIG-GUID: 53vN3p2IZmQ_A6XddTWFuSYNYJ4qHCPA
X-Proofpoint-GUID: 53vN3p2IZmQ_A6XddTWFuSYNYJ4qHCPA
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5c1713 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=evLihkQWVGAqolPEgxMA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190000

On Thu, 16 Jul 2026 13:14:16 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This is the second series of three on updating the AD5686 driver.
> 
> Initially, a big patch series was sent:
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> Then, the first patch series added fixes and cleanups:
> https://lore.kernel.org/linux-iio/20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com/
> 
> This one is introducing new features:
> - Consume optional reset and correct power supplies;
> - LDAC GPIO handling (active-low, held low when unused);
> - SPI bus sync() implementation for batching multiple transfers;
> - Triggered buffer support, leveraging LDAC and sync() to flush
>   all channel writes atomically;
> - Gain control support through the scale property.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Applied 2-8 but with tweaks as called out.  Pushed out as testing, please
check I didn't mess it up.

For 1, hopefully I'll get some time this week to put out a set adding
the defensive check in the i2c layer.  That API is just too weird
today for my liking.

Jonathan

> ---
> Changes in v8:
> - Add nul-check for chip_info match data.
> - Update comments/commit text and other minor changes.
> - Link to v7: https://lore.kernel.org/r/20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com
> 
> Changes in v7:
> - Fix return value check of i2c_transfer().
> - Amend refactoring of command/data macros.
> - Link to v6: https://lore.kernel.org/r/20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com
> 
> Changes in v6:
> - Refactor command/data macros in favor of FIELD_PREP()
> - Link to v5: https://lore.kernel.org/r/20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com
> 
> Changes in v5:
> - Create auxiliary handler for the triggered buffer.
> - Do not allow modification of double_scale in case gain_gpio is not set.
> - Link to v4: https://lore.kernel.org/r/20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com
> 
> Changes in v4:
> - Replace anyof+const for enum in dt-bindings. 
> - Address some sashiko's comments.
> - Use guard(mutex)() in trigger handler and other misc changes.
> - Link to v3: https://lore.kernel.org/r/20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com
> 
> Changes in v3:
> - Add range-double property.
> - Acquire reset control after power-up delay.
> - Include cleanup.h and use guard(mutex)() in read_raw().
> - Link to v2: https://lore.kernel.org/r/20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com
> 
> Changes in v2:
> - Get reset control deasserted.
> - Update entire spi_transfer struct rather than individual fields.
> - Replace udelay() for fsleep() in probe().
> - Minor changes addressing further feedback.
> - Link to v1: https://lore.kernel.org/r/20260602-ad5686-new-features-v1-0-691e01883d27@analog.com
> 
> ---
> Rodrigo Alencar (8):
>       iio: dac: ad5696: properly check i2c_transfer() return value
>       iio: dac: ad5686: missing NULL check on match data
>       iio: dac: ad5686: refactor command/data macros
>       iio: dac: ad5686: introduce sync operation
>       iio: dac: ad5686: implement new sync() op for the spi bus
>       iio: dac: ad5686: read_raw/write_raw: use guard(mutex)()
>       iio: dac: ad5686: add triggered buffer support
>       iio: dac: ad5686: add gain control support
> 
>  drivers/iio/dac/Kconfig      |   2 +
>  drivers/iio/dac/ad5686-spi.c | 142 +++++++++++++++++++++-------
>  drivers/iio/dac/ad5686.c     | 217 +++++++++++++++++++++++++++++++++++++++----
>  drivers/iio/dac/ad5686.h     |  52 ++++++++---
>  drivers/iio/dac/ad5696-i2c.c |  18 ++--
>  5 files changed, 355 insertions(+), 76 deletions(-)
> ---
> base-commit: 4c0ecdbdc0d87570f74e656e21d56bae1ab6a8f1
> change-id: 20260602-ad5686-new-features-e116c04bddb9
> 
> Best regards,

