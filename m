Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1F43D4E1
	for <linux-hardening@vger.kernel.org>; Wed,  6 May 2026 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071816; cv=pass; b=lQnvLMI9xkpvH8MTH8nNfRc7c6SFGotrgssav5DEkbefx7rXxtGWBfWKrKBAh2C38T0GYWN42Peu9S7TxPOHx/zf3N0Nwni8gH6Pw4O5is40INfJsdP25ikG8qJhAY7GMkHQajFo16E9APkBs3XPdTSyxKkYZwKpH/Hvvt6ueL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071816; c=relaxed/simple;
	bh=mS8r+S9pwmLKoRAaHK8MS4UWAwbGG4zgoB2kyfgCpJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j262B+Q9usj+UFt0C+EU0u/TSN/MHw7K5tIIutlnFM305yuwjpPZlxs5kfq4UPfjT5RQm6KB+r2AYz3VG8jgHi4fn0wO28u2Jrf0ZSuMlNTCKO+olx85PxshPnwz9BTrj8bzSviZdalOxwj0/pnQGp+6ZHr7ikNtOsx6Z8GVZ00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cpasl/dB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iK0OJn8r; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cpasl/dB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iK0OJn8r"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646A4mrC3524374
	for <linux-hardening@vger.kernel.org>; Wed, 6 May 2026 12:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pr1pche33PBNlzUR0xWQRPtHTU8BxUSRKmofmRzZmZw=; b=Cpasl/dB+mNRW3GP
	peHL08s4IXVWZLRtwIT2Ruw9Tn4FICbvHwetrFzDhPd+NtkrFvlaO1CPiw8awhZz
	JnEck7fEUyJzO4xzTVNHkQmwZA+eR15fBJeCbL88qeZxxpkjOGEMCNj8Klc2OfzB
	LuA6RfyRgePGUARUhk8DsumoFtJFfek4l5X77T91mYh7l24DPpU0xx5kV0JX7Ccc
	5ctM8r949dYlO3xqLGsbTEWLaglEEyNSs0HFE1jo4X10pO5SZDCPRYA725dGNH5W
	80dCj+i+dV6wgXvZzvh9mRxYMe8p9KwpdENOqsfb09exq9LDFF99n0qJTrkduEnN
	qXVtDw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jwrgk7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 06 May 2026 12:50:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b1f4478ca7so170470716d6.3
        for <linux-hardening@vger.kernel.org>; Wed, 06 May 2026 05:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778071814; cv=none;
        d=google.com; s=arc-20240605;
        b=G98MBFKKAt4Dy94aCQE31qJ2nyre71BWYIc0RtNGEfjfnd6pzDtWM0/X0dYf48OnbU
         l6Dv5IwYNwabLhQ6A2OvSyYRNFdomx/iBdYRyXkECCy8TMhtcMUH5SYP3G1uOmBotHyX
         lrzGNuYmqzpxqf+oDwhskskMyuuaDnQ6JyzJW4IUcSdGikvd3rkaiT13b/0IycpNKK4j
         NPPiMVwL2ywpRj4kaLBb0CjXpd1h5yQzfkaFdL2WqFSogo1nQzKumf2vrDdxVK7KLGue
         FgfJaABsxsNxzg43TFFepc3E0HonvvoCDFg/cp76sXdBHAfVqUH1Ioz8l2oHzcLQhv4C
         qrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pr1pche33PBNlzUR0xWQRPtHTU8BxUSRKmofmRzZmZw=;
        fh=Xru0lPp8TVcgQR4zWL/1Dpo70XAt9TRtEN2m/cKgfKI=;
        b=dLYZD0SFFobhDHrZgsLfXAeK0kKBeNJfyiLMS1VudsyxCIHNY9frbjELIX43k8te+x
         lASoDq13UB4/hZg75tCLpjGr/SLlkM0KEgGNxk+hAZFhuII6GBnHx3kUkb47X/0e3h7G
         BStzcwI/kVu3+YmYEpj2mvycIlS/w40ZwOmGh+HnbCgb2FTTQTyKGR3/3wJJ7MxSF09o
         xnHF1e0dke/hdySW1XpYlCvbfuR6sUHPibjH7KBLQrftvZz1RGrQrLuYxW61pmmVXX6x
         xhizMvaryVD8PB3ge+u3IvNNKkOQ1GWl1NzpNTYN8twl7kCrc2m1tOh/6/qDHCFk+AY0
         4F1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778071814; x=1778676614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr1pche33PBNlzUR0xWQRPtHTU8BxUSRKmofmRzZmZw=;
        b=iK0OJn8rkdb+no76HC6aUCrBVkvjmG0b7RrlnDKD16txkfQaXCxWADxBZB7GPBdY0o
         mkySpyx7gI4lJA8CjXairPbH+q2QNDZnzv5IUU0hbUSAz1o6FIV6zPexzxJ9GwTnFdCg
         xUawNxz6wnKoUg+j5yRVrrSAC3Tokz30PbYJS0/n+Yo7M53tZXb6vdfxHIXK0B6OwkNo
         bXt91GY2Uh4//7Fm49C6lfUu3Id4juC/e9xw9GzkCqJtvmvBUaTYgQjIqAfNN5GHWhZt
         I1qeuR5gzFQl4GJB2Cl7/JX+eJVULJ8trVg3U6qOCA/Z2NYVwMEsw0t5oyudU4H0pd3J
         /l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071814; x=1778676614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pr1pche33PBNlzUR0xWQRPtHTU8BxUSRKmofmRzZmZw=;
        b=RPJgmhEZD9o9KgeFpBxY/xj9jiAv1mi/xzucmi5DnLJeQpL25d2lRVPnteWGmCvyZI
         rWFM1EXlPRoytag2ghrxKMn4wOOfuAks6BmhnVBMVdMkfSkxMXmP88foF3VEYeKuubhw
         arwvo05/ne2RnHKtPxYxjyr3VeImRDtm8WyOj9aEUFtpVy3bPBmalDB/dbVF769JYvES
         avoPpYP6AXR//4VMTMdt3Dg5gfZg7e2jdFLV8jQfuitX3kng8pM5jvi3LdAFbJ9VsKHi
         /L9bQWV6pgEyuaUvpgvLLSm1g2ZpnxtWI9WdFCBcXKOQR2VOauBMcaVMgnKn8jEsl+YP
         AQwg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ryu1IeWjNalNNuQ47/XrHq+uMHz4qja6l5mSo4Fqx5b2Fi+kDAcf+oy8MYvRYoY08rYmVHzGUUPum/5qgbRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrk8og/9Novsu8XcJxySR5vQCqMighdlWexkmipKtNtzNgno8s
	/xjysIyYn4vOC8ea4Di6OzpSXa+no2NwXiIp3zcUC8D924qvjAollYbNsmLqQkOLJSF42qMxGFd
	tbx60pkRItKtxsvgfxRlTIq15ukLn9rfz6MQH9Hb7yXrocjeEZ/9alOX4vbEDAr7KWHNzhQ12BV
	8o34eQe/xzSdNkLQfU4S49nPu+UCp1URVwFXiYXDIVVYOPUg==
X-Gm-Gg: AeBDievItexgFm0fI6Boi/dDuslT5k9knzojpUth6IKy83zUQxbTI1UJmsyW7BViZ6G
	shT7js1WHOxykITtLc44eTMlfHQ2VoqIdp+pQjJI2VGdvYdcYrPKSc3aOLsk96GhbYFC7Y5EiF8
	UrrQdALm7foij74nguybJr9wSvzmK/TsAdQee60u/OsR3zlrFamBnnNfMKV5FPrdaxUTrzAGllp
	WJujcDquKWY5BthUnEIMhuf2/yRflpB+7IcuqoVp7mR/0xd78E=
X-Received: by 2002:a05:6214:4589:b0:8a5:104b:e385 with SMTP id 6a1803df08f44-8bc45e1f618mr42954206d6.35.1778071813620;
        Wed, 06 May 2026 05:50:13 -0700 (PDT)
X-Received: by 2002:a05:6214:4589:b0:8a5:104b:e385 with SMTP id
 6a1803df08f44-8bc45e1f618mr42953566d6.35.1778071813020; Wed, 06 May 2026
 05:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-2-f430e7485009@oss.qualcomm.com> <c145efc2-9285-4e2f-a9e9-73c4faadf15e@oss.qualcomm.com>
In-Reply-To: <c145efc2-9285-4e2f-a9e9-73c4faadf15e@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 6 May 2026 14:50:01 +0200
X-Gm-Features: AVHnY4KyfxMt2VrjFb0bRHruVPCpaFG41raMk7S3fQl6jlpOP3lRjD4NH7eqmGU
Message-ID: <CAFEp6-2pASEmD1CrOpY6BpUHVLWgtPuGRsMYHFZ-GgUKy9EXaw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] media: qcom: camss: Add PM clock support and
 integrate with runtime PM
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=J4CaKgnS c=1 sm=1 tr=0 ts=69fb3906 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=ZQv5F3SHT4vI6nyy_eUA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEyNSBTYWx0ZWRfX4BkdyL92Du00
 XL6co397/ECpIktZkg0WV9B4e1yemwwM6ZKAY+SjFfXB9sJy2g5V2uQHGVkW+9Y+7N0Ywh9alBQ
 xKJt815nydOK62LhhgZXZULgCwjf0xZP1GRVMbMKX4bL+VvJiZQGX0DrpjDPO8NW1QJqpHZloyT
 SMrtl8p1OIdzFw+Ew+4I2j9B7m6tm9mLr/y5UnTHadRzU9E7JulvNguoFawa7h+M1/FpMoJKVT2
 QpdQt+hGPzhSfypnlxdNdL2BzJ2J8W+rQseGGJgC0obULZqLNyJ4SAMbF89swAdhY7AgIw/a5XC
 5hjBTwaUhDJprSPbxzixAQVMUPxXXI4nOBXmKbK/HBW+Rq4GCU4nzCeJbVtmSuFlIf2ZHSGyfXE
 EH14GXwjG46s6zTvp7r04kcb3pD+KtPzdfxqHJFxQkMhRlJpzOrJvqChAeCkUNVIQ62l31Dz3nU
 gQ+646bnofuAgjqRTkg==
X-Proofpoint-GUID: wnj_m4T3DYL7nLJ8pj08PosEEdETbO18
X-Proofpoint-ORIG-GUID: wnj_m4T3DYL7nLJ8pj08PosEEdETbO18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060125

On Mon, Apr 27, 2026 at 4:04=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 4/27/26 2:43 PM, Loic Poulain wrote:
> > Add optional PM clock support to the CAMSS driver using the PM clock
> > framework. This allows CAMSS clocks to be registered once and
> > automatically managed during runtime suspend and resume.
> >
> > This is especially useful for global CAMSS clocks that are shared acros=
s
> > multiple CAMSS subnodes. Now that CAMSS is modeled as a simple-bus,
> > these clocks are automatically enabled whenever a child node becomes
> > active.
> >
> > This avoids the need for each subdevice to reference and manage the
> > shared clocks individually. A typical example is the set of clocks in
> > the top_group, which may be used by CSID, PHY, CCI, OPE, and other
> > CAMSS blocks.
> >
> > Introduce a small PM clock descriptor table in the CAMSS resources
> > structure to describe clocks and their optional rates. Initialize
> > these clocks at probe time and delegate clock ownership to the PM
> > core.
> >
> > Hook PM clock handling into the runtime PM callbacks to ensure clocks
> > are properly suspended and resumed alongside power domains and ICC
> > paths.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
>
> [...]
>
> > +     for (i =3D 0; i < CAMSS_RES_MAX && camss->res->pm_clks[i].name; i=
++) {
> > +             const struct camss_pm_clk *entry =3D &camss->res->pm_clks=
[i];
> > +             struct clk *clk;
> > +
> > +             clk =3D clk_get(dev, entry->name);
> > +             if (IS_ERR(clk)) {
> > +                     dev_warn(dev, "failed to get pm_clk %s: %pe\n",
> > +                              entry->name, clk);
> > +                     continue;
> > +             }
> > +
> > +             if (entry->rate) {
> > +                     ret =3D clk_set_rate(clk, entry->rate);
> > +                     if (ret)
> > +                             dev_warn(dev, "failed to set rate for pm_=
clk %s: %d\n",
> > +                                      entry->name, ret);
> > +             }
>
> So this makes a couple fragile assumptions:
>
> * there's only one "on/operational" rate
> * no OPP votes
>
> I would imagine that in the camss-is-the-bus model, the top-level
> device would house an OPP table.. but we have two somewhat independent
> clocks that may possibly have separate RPMH requirements for their M/N
> number of rates, which could result in M*N-long opp table

I think we can remove the clock configuration here and handle it
properly in a dedicated place once we have a strong plan.
For now, I guess we can simply rely on assigned-clock-rates in the DTS
to set a sensible default (nominal) frequency.

Regards,
Loic
