Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B82F547F
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322045; cv=pass; b=mjcmh0O4GEHb+CmaHRSYILrGe/E9ZwL0ph7B7Rs73CCv0mhsGXYJLYv3jeFMTm10pjRFkA2VCfn5Dnul6AU08Grjc/d2CQX6vHsCxsnhhKGqns6TpKC4ZlBrvs4ORB3r+m1TRZB9d1BWrX8GbSJhDVqzW3vZu0fafV5N8Etork4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322045; c=relaxed/simple;
	bh=5dFf4SUBMP66al9PPeN37zfbBUVyl6Hn9p/qcpwkv2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlSPKOuBhiQg/HQcKv0E/M4XwM8X5S0JDCZuegp1/BSb3Ivni3Zxpc38aVBznZxsv5rtmNW0loZtH0yZ3EQKjjMTQ5u2qvOhXSPdyqrNkSLOwQ2RY5R4hu8tw37opNrK6T2tL4LR+Iqm/gEOYMJBIarPZxfHC3v1rLw3B/zGzzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=flLk6J9/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UdTOCkXl; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="flLk6J9/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UdTOCkXl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RFLPkv440983
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 20:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gzkPIKk9u96O6H7P1bdKNoMSV2AVIfh5b7spc/gNPMM=; b=flLk6J9/5KJGIGro
	3UckxDn6KkOsQ5xfqbYUZRKjIlrKEn0WITFWx7wYwnZK9Nue2Qs3umRUEJ8VVa7m
	n2HIVM25BX2K2lcGvFESq7JthJ+8fbE6VBrcBiU+i1NqP9dpZTBmymG/FJ0MD/LV
	bQoYSkqo81Pit0iLqYUCf9DJWStajsGjiN5igoJB0aU8EiouHHLmKKzcc+n9mACT
	qYdsna7negCmXiRdLh/4MrGhM+7DJSEIBC3hlQ5+fEW6ND6mMRzMuDdxvQhmWUhV
	Rc3Fl2+dS7jv/KV2LinTwpegk6Zj60HAvjQ+Np2gV92KdlmeFiNSO0Z2WLVo2DVQ
	6hRC1w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac415pa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 20:34:03 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acb0aa51c6so153028486d6.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 13:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777322042; cv=none;
        d=google.com; s=arc-20240605;
        b=Ti69AUWyOgKZ13v6isVAjcK7uhvzAgwfqN6zMCK9lq2GUP/kC7ss5QysutWy+1Hbd7
         ApyvPzML+lGy8V7EntIMfE0BfCIzzSUc5fn3UYlu2jcnDEi8s9O1g8EFkSPbZkHP1/uJ
         tUAyCluyqwbSEPoX4QJMcWwt4mPJGCfpws3GeYFYK77Pce3MOkuxRLwqX1edyYaF8j8c
         NURHNuL+7AvGhTWLAWdL+JS7Bpsyes0JyL0rLfp8yNj69hlsKdFSVFxud/cWswtjNif4
         O0r1ZJYMysSAyQSBlrwZ4IP06uyPwHTDAgh4FHImBAE5O7Pc/A8nL3D5ikfQ2P0XvGyI
         ULUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gzkPIKk9u96O6H7P1bdKNoMSV2AVIfh5b7spc/gNPMM=;
        fh=dJRPJqnijg0yqYJR9KkyoEE0O2SSIyEf78sxOyI/NmA=;
        b=IxYrPdNXh8wyYSQXghWYPiPr/OgQ351+XpIzvEW1CxOQ0AMYNwi4/gocph4hfohI8/
         IW7gG3dgXEXYbhGBiwmO/7DU91I2BcabI+tLFGAGw7NuLgx9KdZr5nOLeBB9xGW05rbA
         nUyPEKbtB8nkfrJTrAy5+rcTHr2YLe7WRtm/64Jzh3LuSrYGrGz12I/WVV6+VG2oltzM
         GonrqYQtCueh8j2DGyo6GyjnY99C+0HIqiPJMzO59H60gC2HEkZ9V3M7RV14OSiOh3px
         8LhioobyL81M7uRKCyW/kNNxk3xZnrCJEt3WaAGNMItkSayjQOuG3ONYBdu2vT+S1YkA
         oEsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777322042; x=1777926842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzkPIKk9u96O6H7P1bdKNoMSV2AVIfh5b7spc/gNPMM=;
        b=UdTOCkXlWJSMgHKj200eRfHIMhm87R5i6AVeKir1zzkOir6l3Md8ZHiH4KTQ/e6Ojh
         v9fxYYFHbFSg/zVdjDtLqxCqH7x+jg79ougpgmYK8TPzp0lAQr9JIaC7bswYB3sjj+XU
         T6LT1jL9eSf425ux55G9PSeA9U0wwMNjAxcPXahuPxjHFQ8xoKKXbYBHI72PV4eZH+uq
         v5txlCUW72U440SENhBArS9k7u1zwNLGM3/3qbHXxlYQbhc9Tuo1P8hg7A1kHT7kNvWB
         chneS0bnjrTRJ/8Tvo26MATPVTXEfInBugDLSsg95bLPmb0L67oT+3kbetn2Bp8aPb0j
         sRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777322042; x=1777926842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzkPIKk9u96O6H7P1bdKNoMSV2AVIfh5b7spc/gNPMM=;
        b=H6M+Vz3/87eDUAWIFMUJYo+thE77AImo55E4SV8qkDV5pFNS298GwuWubqQWtYdJix
         yNIyPUq428XDXORBHyzjJ/94W9f+83DFgnGG5YjpJPq7Ov1PyYde/LryjirmOSPOJMcd
         BA1vfb3bGxST0w3O5B34mFm3ywvNkT5a1Epr+XEgXchOO10azF9GqPQWoXVRvK779pUS
         1BI7q7YNlt1krEhPBtejZCJ69/QPnvFqDiT71ofu0T3g1y6teIf2DLnMsydgs3bhwXAn
         o7MrQsxKK4tmgnmWKnLm6NF3deq+ZhR5bTagmQbMwT5zJNbLwiC7iev6bEPMB96PnqwL
         awfg==
X-Forwarded-Encrypted: i=1; AFNElJ8QDm+5/J88ciyeXJ3QjAizC3lPGn9dL1kP799hky6g3qZ9uNs205iWWavOI7OJ3LmdfriCSNvn74JtxeYfopQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDxu/Gux3Wi9s/hIgqOziL2m7uWanTVnRZ3w8Bf/XmoQoA9rX
	yPfy79ICbznBdMjoqxTfXjufwnKfmHQK9ycRSK2jVdX2y1eN/BLxI7F0f13h+gCJCcpDVu1KVLU
	IcVb5e3aF2lSRn2CC795ZowxmOsSYwSFfqsgOlpdIwtbQ1/RRtuWB0WDCbLkllsygsRSCrHhiB9
	rCyxRxhDGbsG9tz8/9np6R2ezYvzKuN5M4gNKOgIr8Zfh0Jg==
X-Gm-Gg: AeBDiesDyyHmcmXlqV6h4TVB3acTPB52X1D2moET/XOktnJIAe2eAioKyFWSVu7ovdz
	H4IOBgyBpBvkOZ6/c01tINNOdbXlarLqkdBEbPFArA+SlQ/8N9o85PqCGWuYyukas3DYIaR3WPR
	IBoPcHdjBfpSTsA4GRs1zB+LCTcuAoh7dq1cWwvic/pxCQp6ftHzki4Rf/Ql3ERrqVrPU20YHyq
	SXIADEkIgZhK0JOs8sahlaBn5g/Un6HDjgOt3ScDZ+Iu7wBRRJyxRWPkv2U+0WohjtAsVrhjAhD
	r1I=
X-Received: by 2002:ad4:5f09:0:b0:8ac:b0d8:65f2 with SMTP id 6a1803df08f44-8b3e39240fcmr3249856d6.19.1777322042269;
        Mon, 27 Apr 2026 13:34:02 -0700 (PDT)
X-Received: by 2002:ad4:5f09:0:b0:8ac:b0d8:65f2 with SMTP id
 6a1803df08f44-8b3e39240fcmr3249106d6.19.1777322041639; Mon, 27 Apr 2026
 13:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-10-f430e7485009@oss.qualcomm.com> <aead10a8-45be-4f7a-ac6c-35a99a716b3c@oss.qualcomm.com>
In-Reply-To: <aead10a8-45be-4f7a-ac6c-35a99a716b3c@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 22:33:48 +0200
X-Gm-Features: AVHnY4KDLficlBbaC6G7fd9Wou7Y6yvKL42b-mOiAZ8QDOmheuQtn6aM17Lt5So
Message-ID: <CAFEp6-38=hcUOvW1yd+hRZ2nHV8sLxiLeB18uu-au=LgA2bQTw@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
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
X-Proofpoint-GUID: -aim8B6SN_wLKbzMTvQa6fsIlxy-LJ4U
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69efc83b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=n6yBxzqcbVTERbX9KwMA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: -aim8B6SN_wLKbzMTvQa6fsIlxy-LJ4U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIxOCBTYWx0ZWRfX2FT2XpcZ7aME
 hOCaApp3yjagfJ4QeMtLEBcxVqKTN+XFkdBCQnQ+bAdoVe0npAuBR9nmVQXZhxQOwqW8fAdAIpX
 B/F+maKrt6KRlwutTT5tMtZEPSyWavs1DQ6e3ecRUiF5qN5Pjvjqd2lRByUNDxXLLl+fVUYTc/c
 1rEPvliVSLLYy9GuX1/dqMGtWCqCXaR5JLMwB83894XuUUzBCCtjd0euljmu2tUMBkscX7pn5Cr
 RmqQ5YuaP31TZ98vX/U7Dn3iAPMyHY2r4GZ+CoctiIzLnKlWpNGb5bJpxyem3bznHUoidbVdj3P
 x5M95LFaGaIYqvRifGgcx068pTFcEHVbS76zKUmiZFmnGWCUR/QtUCGT2fsaQFfmUbBV8+9cTCH
 HL1UprKSbJKVxh+7hLEHEK3+YTQjKuUy1zekZs85Nd/D2ytUSMLBpSOKSW4H+mh1PkIAtDzRcTc
 qe3oe/DLHzP6NREtSNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270218

On Mon, Apr 27, 2026 at 4:22=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 4/27/26 2:43 PM, Loic Poulain wrote:
> > Add Devicetree binding documentation for the Qualcomm Camera Subsystem
> > Offline Processing Engine (OPE) found on platforms such as Agatti.
> > The OPE is a memory-to-memory image processing block which operates
> > on frames read from and written back to system memory.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
>
> [...]
>
> > +        clocks =3D <&gcc GCC_CAMSS_OPE_CLK>,
> > +                 <&gcc GCC_CAMSS_OPE_AHB_CLK>,
> > +                 <&gcc GCC_CAMSS_NRT_AXI_CLK>;
>
> Should the two AXI clocks be aggregated by camss-top instead?
>
> Otherwise we run the risk of the OPE driver setting a rate of A
> and another sub-device setting a rate of B

On qcm2290, OPE appears to be the only consumer of the NRT AXI clock,
while the capture path (VFE/TFE) relies on the RT AXI clock. That
said, this may not always be the case and these clocks (AXI / NRT=E2=80=91A=
XI
/ RT=E2=80=91AXI) seem like they could reasonably be managed at the
camss-bus/top level.

The open question is how the NRT AXI clock should be enabled when
required? enabling them unconditionally (similar to other camss PM
clocks), introducing a dedicated CAMSS top=E2=80=91level interface for voti=
ng,
or leveraging an existing framework to handle this?

Regards,
Loic
