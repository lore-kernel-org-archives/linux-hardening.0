Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6E366074
	for <linux-hardening@vger.kernel.org>; Sun, 12 Jul 2026 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783821934; cv=none; b=QYJXVzQUP3W7cAEyUi5mCOmMwmwHZ0Ix5gN/9gfe/PVeeAkeK43jYs2+O88UogJ7G8ppJU7fwY6rG6PJNd8BfH6k3GFPaazmrN5EX4Ed+QlBTAuSjBU9BaZ7nVvHB+1F3p0SMwVfcIBJUWDXdsDfu685q5XiU1mAyLjtPKBaOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783821934; c=relaxed/simple;
	bh=n0ynR1YWxdgu15IVsEs6KG6astlI1V+Ync4MSaGMIMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/yNE3lH+8c9yM7c7+SGxQY5uyMNuXxrAtHHHNCuzBJSW6AX2PtSQvUIpEb4VETyvyAZSD/TWDkHGQwc0neukcgrNYnkUKL2mht2GSEDgMJRSQ3YVUgbV3xNx2pW/A0bFp2mj2nhpQ5sXJ+7OfyOc24bTdHOh5YBrdkzQL+aPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fq9Y0rku; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eBBK+yLo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fq9Y0rku";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eBBK+yLo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66C0XRuu1169772
	for <linux-hardening@vger.kernel.org>; Sun, 12 Jul 2026 02:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c4yUicwDd9ZYi3ycSy08Ow/qwfqFoMw6lzLMjdqz6dY=; b=Fq9Y0rkuRYKTYO8/
	UBqIry0LWFM3KslwPJ0w1ok+Thb+HK+SpG75KWCqPaHV5JGKaNu1WDTzvfoyFE6c
	fL9gUdBunyFfvV79S+rtvA5Ensu/7gfUrRWmHQCfslFWaqeriufd1K04sJvZ0lxR
	zwZw+Q/X8hMSb/HfOAzxUSc73ld1ErNxS91AqXQkHnydjiiPqZvtVqePrHiVDWKU
	e1dFdW6g93IVYpVU5w/RbexRxJfHxDIcFibrj/pCsx6qiBZPVw5fa1EtU4cCiIUR
	0/Sn8iOI5BtBMD5KLLq7q627WJq3rwb0BY0qEUJvuRI2Jgw75ov+CeKHw7Fx4FNa
	Bz7biA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9hj11d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sun, 12 Jul 2026 02:05:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc77a6943eso53246015ad.0
        for <linux-hardening@vger.kernel.org>; Sat, 11 Jul 2026 19:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783821931; x=1784426731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=c4yUicwDd9ZYi3ycSy08Ow/qwfqFoMw6lzLMjdqz6dY=;
        b=eBBK+yLoXiMixcs3X8zElYPh7KZ+Ej0eDFWkk+ajLgD5NjAj65S5NBpLf71yD5pkcS
         tE1t6/myGtCxIbQG61mlh809+BZVeo4HR3VhcZDS4RNJc9lOK5DPOCy996JUUBP8gyNu
         zWkU9kf8oz3bs+WVLxp5dHs5JnsLm+yRU/X+blbpIVmxmfBCSxfLC0xMZBgruV3znMHe
         tan5uKIBQLrkfqkrDAr5ZYsKKtvQXCmt7dZbBjzZZfBRTDYc88OGqRJv53ylb1/TCh/B
         ismpEIcOm3jQYb3sp2/4nuXLz8UL4OL/wx/jL1mUjrTdaxNesyycrmei5OI27S4XmA8L
         /zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783821931; x=1784426731;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4yUicwDd9ZYi3ycSy08Ow/qwfqFoMw6lzLMjdqz6dY=;
        b=q1BgNtrB9ruTD495j0Rb3PAC9FiPwyD84J6QcJxRlEIY5k1Jnq4+rWuk2zSWrjOAC4
         hnUuNo9iVw97mmhTktrw+OTQ5hjQPnBWivr1vYLzrEbXN4oYDCrqIT5wi/SGQWnjxHtQ
         fjjtuM+yVDfjZ0wH1nieUitvp9PEJ1xD6OnmjfP53z56XVIk52DrXa9PHzvP9JIltfB/
         uQ8LjwHliWt3G3n4gIfjVRC8Bswf0OtZEbFpAe+XSYdoUETAuAQ2HqgG2egHYROAH33I
         vgbzxHsDIyGcJIg0E02TPtWhjwWutGOKEIAvZHoXnCd2++hy/Q4Wrr4Rq9mYFszDUeCJ
         adPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhtISdgftXj9Xu2bEdr0p1KpBkOeM5DHtiAH+uiWv1417ks9p4CAutZzApCNKZPf+D7dLoH3RxIC7t3Tg12Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBzVniDIoksFlbLwtuG2mEl3tTdo4WkeQ8U5ik4H66P1hRD81
	Cp352gvJjkapE9GVkksoD8/Fl9ez1bQzUpLfqwN8GOO1i4XzZomAN/n3VFJXmNjPTUeK3dgIaOK
	fmxS0rckjVmq3aZlpWXKuA4R6WMRrSjB2YrZxsk3U62sfdUGnWjnZRtYSvFDMq76K4MCJ35w=
X-Gm-Gg: AfdE7clogZV4r1Oc88lvs9tmNH7cZS7O286BgSclQK36vpeS/MSzpgIiscJHXt41En8
	kA+dff7g6nFuFGSOH8yphQIdqa8i+hMU7TqxGt/NpfHush2a5joC/OHx/+yvtC1Zriy+61siNWb
	7jQUnqmYshwBmkig3sPkFGCw8SKjXzvnwSkKFX+0mqbhrRweRKpLKlXHZK2fFlFdTsAOAZrd+nx
	OTyh0GbfxuOG7T3IX3WTw4drmfVL6jXcsT8YyqxtgHc+D/Qlo2lkC889Ii9O3UmbAzYeCPAFpC+
	5LKy02I6HVYjVLhBTuDLNze54Azp5Lwpbgo9inkvIIq/cipRQF8fizm/SoAp6590UqnrK6g8zaE
	f7IInl76JkTFkRazUOCVZDlkcLh4=
X-Received: by 2002:a17:903:198e:b0:2ca:d31e:ac50 with SMTP id d9443c01a7336-2ce9e99f4e8mr49495095ad.17.1783821931108;
        Sat, 11 Jul 2026 19:05:31 -0700 (PDT)
X-Received: by 2002:a17:903:198e:b0:2ca:d31e:ac50 with SMTP id d9443c01a7336-2ce9e99f4e8mr49494705ad.17.1783821930611;
        Sat, 11 Jul 2026 19:05:30 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf92bfsm79846135ad.28.2026.07.11.19.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:05:29 -0700 (PDT)
Date: Sun, 12 Jul 2026 03:05:23 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: David Lechner <dlechner@baylibre.com>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel
 <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org,
        Maxwell Doose
 <m32285159@gmail.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v7 0/7] New features for the AD5686 IIO driver
Message-ID: <20260712030455.424a2ecf@jic23-huawei>
In-Reply-To: <adf66856-1cdc-4722-bc3e-549122a912bc@baylibre.com>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
	<adf66856-1cdc-4722-bc3e-549122a912bc@baylibre.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yjCgYNhuFyhWSSCx7-uSerCWJdf339bE
X-Authority-Analysis: v=2.4 cv=SajHsPRu c=1 sm=1 tr=0 ts=6a52f66c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=bnaZUdZ_d7RInuNZ25oA:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: yjCgYNhuFyhWSSCx7-uSerCWJdf339bE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDAxOCBTYWx0ZWRfX7KTbP0G+9LwN
 XkWVpMNrnLHK+GmtQVTRoDQGdmdQ/JckFXc5p25NCKX3thD3rO1D5oAspIA1SvzJjmFHwZENJMm
 ST5hfq8qCIR/tBGtvmSNeILRrmmOuNjdTb3votJp0mAu9KQGmEflfWJSnzChlMLWFmMKGMpNdHk
 Htf2jG0ezPg/Y1jqhqI1wC0Zxuxn5A7JccLW6qB/8NkmQoUJwJY/K5aSmaWoSFQ088sqMg4q7E5
 OPG3vxc3ysayR2jfE7l8OyS4OY0IrO/UGCQfZS5abGY47S8gMK/J4V2ONnOtLEyLosBsh1oeZ8s
 UdWG6EJR4NcNLSNDI0EnAWC++ZHz0TBdQ8ZAsLN8hj02ZIahLWwqSbhsbAJqQUDhKD8sQlWoBUQ
 ConwQ+A0AkWKTlBy74zUv0bEz7VzPphWiAkKv+6akXA5VIqr9vLpcgINKbGnKbS+MSDxwSTMDA1
 mfvQBpxe8OkVVanHBdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDAxOCBTYWx0ZWRfXwM2UV3DrUYLM
 hb8SzXdN/a/Xs943702u4z/63Q9uX8rOmO8MWefwZsqaUFTBdH5L9pygM6aUk8c0KQzcIAZJL/d
 Z0oweFF6Ua7xNjrg13iCHvO6rOH1e6E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120018

On Sat, 11 Jul 2026 10:23:56 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/10/26 6:20 AM, Rodrigo Alencar via B4 Relay wrote:
> > This is the second series of three on updating the AD5686 driver.
> > 
> > Initially, a big patch series was sent:
> > https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> > 
> > Then, the first patch series added fixes and cleanups:
> > https://lore.kernel.org/linux-iio/20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com/
> > 
> > This one is introducing new features:
> > - Consume optional reset and correct power supplies;
> > - LDAC GPIO handling (active-low, held low when unused);
> > - SPI bus sync() implementation for batching multiple transfers;
> > - Triggered buffer support, leveraging LDAC and sync() to flush
> >   all channel writes atomically;
> > - Gain control support through the scale property.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---  
> 
> I made a few comments, but nothing critical, so...
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> 
I didn't find anything to add, so should be good with a v8
covering the stuff David pointed out.  FWIW sashiko is clean
though it does raise a missing null check if anyone forces
a bind that might be good to fix.

As to the DMA cache line issues, I'd ignore those. If they
are a real problem with any controller (or more likely
the interconnect / caches in front of it) than I think it
is up to the controller driver to bounce the data.

J


J


