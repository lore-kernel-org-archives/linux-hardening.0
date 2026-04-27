Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA053A7848
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323695; cv=pass; b=Sd+b9/vrvZj9mmrS47/OOZc4uevQUcgs4ARVg1I9tqbh/W+VoQPabENyCV/O4wPl4UN0WVXrx+TMXfXuDYy51sKF2Cc2nVnx8ZRB6ys+kskKa0OYbTuXVwc7NoLUSaoJfxLKHNEbSHVpnhmDB9fzAanqdXuHYp1SMRsrCa41BmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323695; c=relaxed/simple;
	bh=+C4GOpYhh4aS7P7JVT1CRxfrSUiV6hkVbjF9PaKWQQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSim68S0TTIa5GGndhsn0bkq1O1Dy2SUMEsgeibzqeft5F8PGH0uGgUoA7w1Lu1ge/j9G+EPOgD/cJ0oa2gtRreMpF0Gb9pV7BHfhygQS11rLruLxagALrFpPPZApiNOlZjxeO7X2ONLBqbV8MRc0hzzNwlcQ+JH9vzXXXSWnP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cp/1dL52; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IgUzHqjl; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cp/1dL52";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IgUzHqjl"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RDtjeF241566
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 21:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1JV0342BhDHMDqkE0j+wNHcbkp8N7EQgQZU0YiwIqxU=; b=cp/1dL52K20USnHG
	xbiP+49+kQ33kx6K6NX65lnRHBunBRp6nvDF4IjzIJx/T8bJSXbPJgXh2SKonvI5
	yhXCkl+uOR6RvyIABH1bBk32CkE3iVKN0r2FsgHJ7eycpvuBUFzxeYPmHlrdlvBK
	A+95SBHUAnlqulwA5/pwGrRpjodDriQNbLjGx6wH4H6MoTibeiTZs3zBzFRdIxnh
	6TjGOEMw3XMw7/7NrgE2AXlHQdweqFYd6/JwJ5qqB6/cQXcFVgOp80Et1OT9qQGZ
	HvZYackOvIzvuCvMlkFeOu9Zs2JaEK19uOYS3HxMmtdnAEE299tQQC3rHtltZrpL
	lUMZ6Q==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt946sk56-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 21:01:31 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dce0f50eeeso13921664a34.2
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 14:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777323691; cv=none;
        d=google.com; s=arc-20240605;
        b=f+YCk6F7KiqGfnR3YB5a7fRE0oPATCxghYy4o0yJWt4qCQJz4K6Dxn0d9y9ycreSHZ
         0bU7ilLPwy3DNF835G9i948laS5zekSnH2vYczD++gZ8XlHQKMUb7nBdui4thHp8NG3P
         FeTuCM6RQ9+1iRdM5AJgLI3mxNWucFrync0rdnYaRQbrET3nxoRokQ0Uvpd0Nygdy4jf
         72tweaSn4kZWGkTDqI5mbuY7IWHwixja0n2m10r9OFrxitBDYDtiTj36iPqA9lD7+gz3
         V9Nbmzwnbb20FSYCd6KgXTjF0xJwq7sZHuLuYnMb2aoHQTPwTzdBKpz8qpzu+p70u6WR
         7mpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1JV0342BhDHMDqkE0j+wNHcbkp8N7EQgQZU0YiwIqxU=;
        fh=lFRlAxPzgiPOCzyfEysDvcP0bxEO6Z283JK8RV9L03U=;
        b=I/MA/qnxzrHcEwmgwFlArUMEfaHiRKHX7S6EmG5Po3PakUf4CVBCS5r4GrdyMt8nkn
         Gq9xjHITBo0U8rmbb9DNSyZDYGZpRykAG7HzzIUyue3F2QSI6XL8ZuaXQayIU5J8vjB3
         T0nk+h8Db0T+eyKR47kOjryEUFQMGhSZ8Faz2QnZANR24MEV+FZaqd2xPFzuk/1Eka/Y
         iIMI+Mu4XIJ5ISsk+9oNSYr9xqxyKtU8FsVw0e/+B0iCKcVFvAaDWRPjQ7tWIVh0MMiS
         5NfM+gtWYR0lwdlicy4KpXjKJSV7kWlsr/V2X+LuKklsT+EPD9dYR7qay1poXe5Ueico
         27Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777323691; x=1777928491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JV0342BhDHMDqkE0j+wNHcbkp8N7EQgQZU0YiwIqxU=;
        b=IgUzHqjl77nAzPzB4uDaV3OqaUkMQ+9x92I2fIVFfbOicl+soEK2zaZKwW951BbMm6
         KB5x84nJsKhnI6a05+IGVzovvMneYcCmbjazrBtU3dN8IxMwCCoMTX3b311ioi15f9eA
         4eYe2CM+HhDc5vGreAtLus0LAu9bISU+MgeQA+d0pVTWkzMIdGwdCYcuQtjX/jH90YQs
         Llgu1UXHz6pnADI0wuX+/JSaOHf8I+iKAcVdAtBordDCY33yMvcVWxNn9CseN5Abmxdi
         MJ/SUg40j0+o6hvMcxEKYCnqMny5tI+v/Z7xMQj4L9dyBTZWZetUxQZ9Xg7JgYJMwj4k
         98Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777323691; x=1777928491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1JV0342BhDHMDqkE0j+wNHcbkp8N7EQgQZU0YiwIqxU=;
        b=Yre5mwlBPBe9LLtFsGhyPq/buX0mI/bKr9t2iqVEtvC6+h7oJu9mOrnDH1195RxmHJ
         KR7SSj3koqMhLuPc7DNkxLocBKW/6yLRlMZwB38VSksAb/oONeA1hzyTs8KVS2SHYE5n
         4ZhTjdsnMr18jhKAFMY/whSfFbWRApHHWHhLdyteRexHnhCoMYPiL8atcfigzTXOd1vt
         yOcKed4uIeFF49X8JSpiAxs2YpOYUDxY2keFY6wv04q6QcWE5BWdLEtnQEcKZ2M+rdQ9
         zAmDSPX9qa5UYAXJI2gFnO5b8VvwuYmAdU7XhI/d+d3GfPk/h3/sh452gKzIVo9x565a
         REow==
X-Forwarded-Encrypted: i=1; AFNElJ8I7bZ8JNTy7nuqBA9sWga6jQ3BPfbNgP2I/JPWG/bYaW/aXAqMTlKb/jxTK+J3/Ztn9wHRcBleVJ0sUk3Bzeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXkwAevSiPn79ZKw5QchiwXzwRRf8JTuF2WghuaynV8XT6Wpfl
	7hNKDPGTXuQQdWXDB4rQofmepBJcH7qpB2GHXCk4STdpphclIMyvqWdlazghH8lVNCxfcQVAiTV
	7pkkDxjIlKBgVxsDMKV4OV/ThAbk9L0szHQ+Ya0XSegeqGD19JDDYs/MoriagTGb75+sre/QPcd
	767JnqYOp73VvvTbyn8WCVQtdugjaqwl+Zs8o11mEoN49img==
X-Gm-Gg: AeBDieuLpaEQi8eaom2bNATF7y95VDHtKVBDo925ctyeA9EnGbAlT9Nony9IOCqOXbW
	8gWsys/rpIBGwOEr84YtHEgQPK5LIZBvPvnKhZMdZxFsnp9UslBwOGnNDMiPgHIbpjmw/NKK4b1
	7geRJsQbFVnmNC0M2nknqjO2CJUf4T2IJJDHlcbopAUcLHJCAgKpNwL0ukHXkmfLHNCFfmMrPyH
	RNhCQhRskcjareWRwIIW4MTXmcKE0o8bNYqNNF1QJDQTsRdpDk=
X-Received: by 2002:a05:6830:81ce:b0:7d7:48cc:ccdb with SMTP id 46e09a7af769-7de9a0ea40emr232037a34.19.1777323690801;
        Mon, 27 Apr 2026 14:01:30 -0700 (PDT)
X-Received: by 2002:a05:6830:81ce:b0:7d7:48cc:ccdb with SMTP id
 46e09a7af769-7de9a0ea40emr231987a34.19.1777323690349; Mon, 27 Apr 2026
 14:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-12-f430e7485009@oss.qualcomm.com>
 <3e72d17c-e46c-42d3-9b17-54627f6e5e28@oss.qualcomm.com> <CAFEp6-20MzQh55iJzyhn=htFZxN1yq9o+EJJAX0CWG3O6_KSyA@mail.gmail.com>
 <20260427202523.GE3219146@killaraus.ideasonboard.com>
In-Reply-To: <20260427202523.GE3219146@killaraus.ideasonboard.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 23:01:19 +0200
X-Gm-Features: AVHnY4KhboWBXcHPTL_60SWtSw-AAA7UM_3jLhGlKnmcS9RCmKJpNOXClsRGkmE
Message-ID: <CAFEp6-3yecq5oGRFFbaTCEW5Ag9JaZXjVTAT=Z2FSX20UC41Ow@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] media: uapi: Add CAMSS ISP configuration definition
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
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
        kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=YcWNIQRf c=1 sm=1 tr=0 ts=69efceab cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=P1BnusSwAAAA:8
 a=EUspDBNiAAAA:8 a=By-mYhKeKzH8vs57knYA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=cvBusfyB2V15izCimMoJ:22 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: lt1MYCp6lKJsQ8kuVnIDQBrdgSgoorIX
X-Proofpoint-ORIG-GUID: lt1MYCp6lKJsQ8kuVnIDQBrdgSgoorIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIyMyBTYWx0ZWRfX4HzRmAYeVPfG
 iihfkUWn/G0ATlvXnY1FZ3BR9yp1PO5T/J3JYnjUe+gg/AdfIjDX0MHLypNRVMWWjqROejh0+gy
 G4VrXomMfrJpD6+sNmBxhsI96GvGL9SF4DRUUQymG+vzK8e3lcv3W2bmfpKFWFo4Jg77ydS5RJe
 85Ac6eEhA8M0J5vWlF8dvl9umx0YzZuLJU12G9H3tTfR8wlYQoTbrM3BRWNaW4vlNpt2Pxcxiyy
 X9MVX1KCR/tGWDY1BKRXWeWg1PuU+MrKwBY+GqkruDbAlPAT19+n0iMdQlu0pNRqFFFecGIN90H
 fTnp6/REoALmfzAzsaVjrtwg60KJeRl9QWOO8tuAUrlU0SgY+O+EPGDeUwak3tzM84dc5JaJpHB
 3eHcmh5aFMGGHGOBF6IzzO2ls7C0d/6eWwUckb6rEAa98v8UL4Pao4rP2MpTG3kY2oauH53uAR8
 hRxpHRWpMZ2zP85/V/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270223

On Mon, Apr 27, 2026 at 10:25=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Apr 27, 2026 at 10:08:59PM +0200, Loic Poulain wrote:
> > On Mon, Apr 27, 2026 at 2:56=E2=80=AFPM Konrad Dybcio wrote:
> > > On 4/27/26 2:43 PM, Loic Poulain wrote:
> > > > Add the uapi header camss-config.h defining the ISP parameter
> > > > structures used by the CAMSS Offline Processing Engine (OPE) driver=
.
> > > > This includes structures for white balance, chroma enhancement and
> > > > color correction configuration.
> > > >
> > > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > > ---
> > >
> > > [...]
> > >
> > >
> > > > +/**
> > > > + * struct camss_params_wb_gain - White Balance gains
> > > > + *
> > > > + * @header:   generic block header; @header.type =3D CAMSS_PARAMS_=
WB_GAIN
> > > > + * @g_gain:   green channel gain (15uQ10)
> > > > + * @b_gain:   blue channel gain (15uQ10)
> > > > + * @r_gain:   red channel gain (15uQ10)
> > > > + */
> > > > +struct camss_params_wb_gain {
> > > > +     struct v4l2_isp_params_block_header header;
> > > > +     __u16 g_gain;
> > > > +     __u16 b_gain;
> > > > +     __u16 r_gain;
> > > > +     __u16 _pad;
> > > > +} __attribute__((aligned(8)));
> > >
> > > Should this be __le for all of the related types?
> >
> > At the moment, this is purely a UAPI, the values are not dumped
> > directly to hardware as-is. Instead, each field is translated into one
> > or more register writes, with the appropriate math, masking and
> > shifting applied. Adding explicit endianness in the definition would
> > therefore require special handling on both user and kernel side
> > (to_le16, from_le16).
> >
> > On the other side, there are scenarios, such as platforms that rely on
> > ICP (firmware-driven processing), where we may want to forward these
> > structures directly within an HFI packet to the ICP MCU. In that
> > context, explicitly defining the endianness could make some sense...
>
> Would those be different structures, or do you envision that someone
> could develop an ICP firmware that understands these structures ?

I believe some of these structures could be reused across different
platforms and bus implementations. In particular, a given e.g. wb_gain
parameter struct could potentially be shared between OPE, ICP
(firmware=E2=80=91based), and the inline engine (IFE), with minimal
driver-side adaptation (limited to shifting and masking) or even zero
adaptation. Bryan has sent another RFC [1] defining parameter
structures and layouts that (as far as I understand) mirror the HFI
data layout, so I plan to sync with him to identify opportunities to
leverage common types or structures.

[1] https://lore.kernel.org/all/20260426000418.1158716-1-bryan.odonoghue@li=
naro.org/
