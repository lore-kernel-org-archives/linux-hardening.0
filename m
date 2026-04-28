Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476B3B19D0
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375798; cv=pass; b=Bj4/asP1543R2dldExcXK0xaoXGAKv/RBfwQOaCC1SlwMVygqEQEHOEbEo0hEJt78P8hwYOTBWVeVZJJOlseXzJ1NmhtTGXJTgJON9P5kDY+ga3mnTxugLe2ksYpnaXo3EL4Tu5sQIJBSthKjMBZTJE3WPr6Abry92Dsfruf1Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375798; c=relaxed/simple;
	bh=gAOBAXwoIZgNjfV46XOLVfiLxyQWHRJZDpDieg00AOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPUz0uC225Djw2r5MF4l2xNDtw3Q6dZNDkSFPNrggrtUnbQEZSMa3vA6kNl3aOdeVfKtO/ptStOXqzk1M8lawgTBICi3pt+kjzO8irMGgr1U+inHRz1CUbRX9LY9WhLUXBPXWnjfUjtCfi3skQlp5mkD1OzP9lUG1vSnOvJsCPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nidgTwLw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kON0cKc3; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nidgTwLw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kON0cKc3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5prcu1625116
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 11:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0hbXvdArmq7BM5rLKvOa8BUlGtAkO648SmKUpum84i0=; b=nidgTwLwOByEgLG1
	y9Txngz3OgjJ0joyQ5rcFFtKfd3GKGy+sITAj1oc8zv7FmS4Ru/PnACzKjMUpnNu
	w3HaqUHSmchzsNTpfll5aHGujziIkX0sbJ6I5bwMNsOc12b0tppaHztpb5Igfhii
	xAA9zFE2pea+weLDGr3rI+uroTC4Dh9Fizbsd76/mGcvjz3+RYa2WRnzxqwSZlY4
	wf2glIzspayJhRBZZWtbHJeIp66dqEe9MU9B6LUzJN3AwDj+W+n0SzfvXo5ru/X+
	lVP14UoBzpQcKNEJF7+U0oDAI/cgprHR4XaUQYazI9KUVFK/AvcwL6EoQhv/aGIz
	XOgnGw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgmsappx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 11:29:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50da31af14cso299607221cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 04:29:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777375795; cv=none;
        d=google.com; s=arc-20240605;
        b=LwXgkgT8iHkRUcGPM5MP9paO1DlEnLU2Voyl20Bas8NGAZfDNFlhIfAIobBYX28eb7
         N5d3unqnlnn4uE2cXJn9fnCKCHIN50wLcCNadMWFqI84VotybdibblNM7dO2yE+wz+F5
         uc+hmJCRfICbOH2x8gyxj6NoIrgQvHs9N2zz7HXHz+Okaa6hxjHjkdqCRHbnGHJLVZxk
         ewjj8bmkmgucoaH/uiVczWk5Imp7tUYULDAHpK7fT83BhsXIb5IarbH67j0yLqSQ6nGn
         vmfEHG+42vhATLp8MbJ0rX874hVTW5FeriQ0h8OyLgUqtdZYGsWvxLf+RV2xmWRssay0
         yWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0hbXvdArmq7BM5rLKvOa8BUlGtAkO648SmKUpum84i0=;
        fh=pX1Q+yQ1hN83dPUjoqztzBJZU6KxSxF3AJgGqDVKEIQ=;
        b=APRXGbrKoB9XC4Y1gqEI7jN1yDxj9u5myPXImuwQHB9GA1n1mg9+Rgu8BAz96SC4sj
         7bqSid+N0Y49uIDXx3NvMm5xbz4qxtJQAVAPGnKnFxd/EL9/411WJ1JwCDSfktqMPelv
         yonSo4CNgBvaLo5OZAWlChJhaWPjh/DDCbOHyyVtrEk+sFGh/gszsHLjGNa/c4Y1SyVy
         O8EGglSwXcNnjHCfHeeimRR0OvpJR0gVJwDHzHvIBsSsS5o+B3gR4K5nA+7Dnvdj4jV2
         Y19/m/qWB1xMuvJJvDVf8XtTPoKl09TtouBMOk9L8Gdd2iucWXTHfkIUByVkEjDzRYqV
         yl3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777375795; x=1777980595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hbXvdArmq7BM5rLKvOa8BUlGtAkO648SmKUpum84i0=;
        b=kON0cKc346i3f/W7/9eZUusBzMR5MIc1pDqusZmRkHAy/K+eb2XbLpWqXtjEZFHaT7
         1oX7GMqrWFWyOMtq0eDKxLc0/V3FB/1DaTp/tM44XEaKAUHuzi5tefVRj6xYk+utZHAB
         fGAjmaW1wP7aKEAXRZefCIQlPi6g7H/aV7Pif49cyOwTiOQYCaldSz8qnoTm3TXeU51F
         SC27CzMzG3pZ1mL1d2JNJHipLZoqP5OiqrCjXA5MnZ/DbFDXX4WUaxsXLRAOBcTqLOqq
         kQWYfmLybkXP4nGj3X4nS6qBQHsOI3C+yMQUDjfBxVTcmOAExNid9HeGPNBbtenno55s
         A4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375795; x=1777980595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0hbXvdArmq7BM5rLKvOa8BUlGtAkO648SmKUpum84i0=;
        b=nQKgHw2Bx/3s9eR2LbDj0cVDA9NZEi1Cmhp+g0yzYujrSYxw1ZQMi4bBC7o25UKcOQ
         djA4Ia+cMikh1fV2mxgeguH4nP1AHgzz54w9qOR1fXcMRroOOURHV1y77oR56JS93We8
         JES9/2RQT1E2p3UBv+p2Y2KmvbllDInxsHQ7xAqVYydtECGRag0YJi9HEF/OOXzSeDz8
         avYiFs9JZSIG9zNuujSNlHgqyLIfibbHLDtuH3si8DbLTm/RRz0eJqFtnJ6C7/n4uE0M
         yP7vAudib4cPaqOklPJNrSKD0TBAnQo8/PUbGXlr0hQXHo2/c1S2e2ZhZ6ZL+gyGTmkF
         +PMg==
X-Forwarded-Encrypted: i=1; AFNElJ/fzagSzLQRmCxg+iorVZgBPxV5Ge4dnN1jtZoSaXKLTJ5DKYvo2YgmuTll1RCSGnmIbNeOR89v0kCiG5yIJ5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkLZt0L2LT7zgp9k+FToeZF55PPJmj7XRqUe45QH1QooVDBK46
	75P3ABSOVPAMpsqI8zV9KtI5CsJf7ka8MglFbYbNzxwIXCUoVwl0+McyIBE+VPpU1J/zk0pIVhz
	b4+D2yhAUkepakBIX8wDRY83lEEUtBBIscbrQgMaMe5ygBFqJjGUlzmE/58vgth+eOJ48cM+hiM
	WAnEU4l3hyNz/5dRzfHgkdFarbYriDBNpUUWv8fDtj86IsTA==
X-Gm-Gg: AeBDieu5hR75zkaBEDviHD/GiU868VqjONSf3wtaeMqMwlSAPcv1qiIuB5oTt9NMjEf
	jSC6IgC8nvflW3nzS7Vi4Mmr8qayNdXakqL8WfVhRhO03lGt2vts3BaT5TifhfEh8m/tuHWZuOt
	DdIQtNiIYbf9kwtinsPWbVvNfV9KOiC2ja+N/1VLMerGAwqMflWlxb0si05BsXsr3RrsAHlkF4J
	3jiflDtPSr5Q1tcRQF/jDi6qg0WIY4C7rShoNydBmacPlPtbA==
X-Received: by 2002:ac8:7e8a:0:b0:50f:135e:d68 with SMTP id d75a77b69052e-5100e1fdbebmr31893161cf.58.1777375794686;
        Tue, 28 Apr 2026 04:29:54 -0700 (PDT)
X-Received: by 2002:ac8:7e8a:0:b0:50f:135e:d68 with SMTP id
 d75a77b69052e-5100e1fdbebmr31892841cf.58.1777375794214; Tue, 28 Apr 2026
 04:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <Ptwba7JmobZufdkgayhAhPOOjZhv-yUkZSIMcQYJbKrrBFOdsdG_QI2uUof0EibbexBxSGC4drfA8J1zV2zDRQ==@protonmail.internalid>
 <20260427-camss-isp-ope-v2-5-f430e7485009@oss.qualcomm.com> <d4f786a9-3cd0-40ec-b499-8185e867af44@kernel.org>
In-Reply-To: <d4f786a9-3cd0-40ec-b499-8185e867af44@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:29:42 +0200
X-Gm-Features: AVHnY4IR6P3xmdEgm4g7wjJg0q93e62a-0qdxzDCaWk2GqaeMpyePeTLoKno4rQ
Message-ID: <CAFEp6-2RxaL4QgdBk4jrX3iC8mE8u6PvP89CD34x+Y4oAcwFdg@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] media: qcom: camss: Add camss-isp-bufq helper
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: LTiLPPqkWl2RkrLz7TyZeUXLVoFJIbjO
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f09a33 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=XvfFUYa5IQhs_SHw49QA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwMyBTYWx0ZWRfX7KsIXNVT8Lom
 nqhLeHsPCZIu1xRp8dpSxx9lkqEJCzeVWAao2RqKANDH+Pw2QJa2Sv+VzTNzigIkZnmF1jZUpjK
 kqyovvD2HVtPdce56cgFO2J7c7SkekzHimNnVFWEL7RuI0JrcfepTT7f4WywxaMD3ZcCPFyjj5K
 tHeD+JSWc3EuDsv10jPQgGRAjoZKbSRM9dhaaRsQ95RTHtklg7LkreVuDhgZ+J8MVxkNFJ0SOTn
 Ow8dvQLjjXzKvv4dMEHXUDFSbHg0Y/9aaheAgDH6JU+76Yvi9OHvs2MnEbvqvwlI9Q5Knddf1iy
 rB+bfSUU6xARAiZv1J6sBqihZfi1ylgFh+XWQslKhS8+0062O6W/Z9whC+InSBeYscI2DNmLfNX
 TSEfnlBZN4/u3pPrgn+90aiefOJWDMQxK4Zg/hTM8A0Xdo6li5SXBboWDNqaCGEV55xQ66Co1YE
 rI0wSCU/lj2M25jAldg==
X-Proofpoint-ORIG-GUID: LTiLPPqkWl2RkrLz7TyZeUXLVoFJIbjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280103

On Tue, Apr 28, 2026 at 8:56=E2=80=AFAM Bryan O'Donoghue <bod@kernel.org> w=
rote:
>
> On 27/04/2026 13:43, Loic Poulain wrote:
> > Add a per-queue ready-buffer FIFO helper for CAMSS offline ISP drivers.
> > camss_isp_bufq provides N spinlock-protected FIFO lists of ready vb2
> > buffers, one per queue index. This can help multi-queues management
> > and synchronization in ISP context.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >   drivers/media/platform/qcom/camss/Kconfig          |  14 +++
> >   drivers/media/platform/qcom/camss/Makefile         |   5 +
> >   drivers/media/platform/qcom/camss/camss-isp-bufq.c | 101 ++++++++++++=
+++++++++
> >   drivers/media/platform/qcom/camss/camss-isp-bufq.h |  85 ++++++++++++=
+++++
> What is the purpose of this and the next three patches - why not just do
> it inside the OPE ?

The goal is to improve reusability and avoid an complicated/large OPE
driver by moving non=E2=80=91OPE=E2=80=91specific logic out of the driver. =
This would
allow it to serve as a common framework for both offline and inline
CAMSS processing engines. Looking further ahead, some parts could be
further generalized or refined to fit within the v4l2=E2=80=91isp framework=
,
although that is a longer=E2=80=91term discussion.

For now, since OPE is the only consumer, and to keep related logic
localized within its respective files, should these components
initially be built as part of the OPE module? They can then be moved
out later if and when additional users appear.

Regards,
Loic
