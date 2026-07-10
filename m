Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C940BCA8
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679923; cv=pass; b=jDJ8rLdGGUzEoMB2CFC4porzrdBQH8zjUvCoL1om8BDxfu2F00IFmqvXPaLsObr7t8iPaM1F5qOQrxaZ54rP/tqUN2kMiVj0SLuZ/sxpXe0mh37y+ErIstT3vZEvJzMuXOy9i3jUdoRO1gEg5lh9g1mb0b1TkqnaFVOytMErVko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679923; c=relaxed/simple;
	bh=0KPxLWAyuoPTQ7fPlwfSGd3ACJr7sRxjD2WQTRY+LBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYf/YbUNGXurHXCzbKwWuD9qjLc0KXGkCh/En9c3k8u8AuLhlpBiDFaXz1UaGMSDxmfeHnWrOfkNrSNL7CgLywOE9kEOTin+14Jk9iJlk+hJkh/KWlRnt0gzR5/pQ7i1puMnBlYuwERSy+fmebraoqZ1arBGd/gmsGeOnkU09io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IyqJjgSp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HGNx0H2E; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IyqJjgSp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HGNx0H2E"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dV0x235361
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 10:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hRx0YNaKKEWpX9l5PTuBp8n+5r7hIrtk3Mw3CiVS4eE=; b=IyqJjgSpCCQD+rpY
	f9EzMNXWEyBCQT31mMFOohB/sg9UwLFeR3OnotQs4BasxOiwspWHrZkO88TZAmA+
	w9b7S6ZpSALwOp6qKWInPx2NZK2ChEs6WHrUrCl2OiBZbpfZdPm5SAY/PcMoEzQi
	VVswgcbL0+Wa0/gwifY+lyZX3R9dPDpgKykMuxsBFRQhdqhn/tb1hWTFwxDbwqAi
	w+RKDsaGpl60OhrKxCzpNKOLwxMTFRFz05wF0mvUUxFcA+M7JnvytDNUqPve0LJ8
	IufItzKen8iNKihCZv81YLv4AjpKFbdupiQXZfhHRx6DxNk3N3mS8HoL3OrIQGXR
	h2tgZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3m27s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 10:38:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e61b38eddso133937885a.2
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 03:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783679920; cv=none;
        d=google.com; s=arc-20260327;
        b=g4zjtzt8QDEugg9wxvVC/ZKb+V1R0e7jTe81dlr0zHAQqGebu2fx7M4NkFzsVO9t9x
         cK3LWvtMJ/OyX1EsekxW3gAgi8wR5V+Uv7Qooc8IE8UI18J+hg1AO1JJNqxwt6Tv1lQw
         358NQ01z7vRotfxCjpZIQvtI9kxL0JCuDS7J4dIoyrTvCpdm2Rhc8cki1dpJuvdIpcYk
         hPWhkDmW4IFZNX1HSK8F04VBQXtL/S//3eVUYCgU8+nvFbHFnr32w3OFRr2MDOlJLzb9
         khvuG0mvKX2ftozTmUzotHzNomisqwAnbgnr/ijsGtSCzKm5tBKOimLUg+jpNBef1Mij
         w28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hRx0YNaKKEWpX9l5PTuBp8n+5r7hIrtk3Mw3CiVS4eE=;
        fh=Po1d+uM8DGw7JcgOixLSe+GwGlXdwhtiZUPt1ogCWPk=;
        b=En9/FS1A2pee5xmmAFScmuChWt4YgkX+hpg8hvXIVvKSaAomfkRUwtFyo7J75eJ/PM
         nsP8tmdbC+gvfOgdYskyoz+xtvJqlC9ys6VQiP6NI17VvtcQwO4e7JzDRENX3fBKIlLJ
         07LI8jcFbLS4mWLqtIJgmqPy8qzw1xV28/pIkyfIzyD7nE/PDjLA6+ptyPpiyHZVv6FK
         RIoKE6lMVk01+asMC52lw1YHziMRl/2DaoBrAikYzq+gWjzX/rs/TkuoqsInECwLfuoj
         Y+THrcnawIt1zmguJfJrSAOV4E+ScrFHJLgFByxxT8mPGfKu7ArocNVU/EAS8zMA305/
         igTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783679920; x=1784284720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hRx0YNaKKEWpX9l5PTuBp8n+5r7hIrtk3Mw3CiVS4eE=;
        b=HGNx0H2EiSKRegbSOUN8Aa4Mp0Hb+onknAfKMpGjrvk4nsv8AAuTME5Tx9JkRGK09O
         LaXmA7k1LDZdVzw2fhn5HeYlDDXE4lO5nR8o+x5AvwrCPx4G2a4j5z4ifaJyBOGXqTin
         CIjZ2R4ZVP8AxBroUuqaDv8Hgm6rrgmhEEk8EXwgdSqUc4aXHjDn0iiwFjIyPyiprzVN
         m/RhBewFJQRXP9khTV4vVi6XCE+3IFAd61pVmood6ylBtf2wKv/BN1hxdlO+gC3zCpcG
         dbN59Sqc6XnlkinoZadDnuja3/4ZQHpN7Ern6BFTsTf+ZBTA2A8ahtJssQjotKKzOycz
         +QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679920; x=1784284720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRx0YNaKKEWpX9l5PTuBp8n+5r7hIrtk3Mw3CiVS4eE=;
        b=P6WNh2kiTUvPlSVk5f1XX44fSE8f9Hb6+nfyO38orRFRCyDChGCbpRIsMfvwPgO4+Y
         OGSN54yKDb3bDkTMvUFyPOao1fo6a+rOO9OXmuDRNntWGkEd/cNz8WrjyN9BKxUM7k4E
         aX7zuJwykPP+gc0DnpAwRBfRGR9Cs194w7PPe2tutmyRC4OZa4J65nSWvpNbJ8N1XIqy
         oERDoewpubWXazQToYSTmDnVn5QLI0s8zjT/7qDrhmhJRAE6NlNn2Ihho7NXFIKSw9X5
         S51nqjZE/BRhOh28j2C0eiPZKKAlit798a+hIxMwsqwd/7h/qX2yVoIWAQzRIzwy+zxt
         8bHA==
X-Forwarded-Encrypted: i=1; AHgh+RpuB4yCmg9X7GXdn8pWnxwkV4fglocb4Kca/6U2l54WfMrQrqcbOTw/Ein+qgQMONgAWtk2+VVG4gkuZ2XmPtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQV9LgEg7gDPdX65TzllM0YTSzO5fAUO3e/D0RtIRB6IC/Z483
	OXiXwLyT7OHEVnPcba8RBNLdDvVFJA5oDpKYynodGHNCTgCIQgA6osvcyvCL6kPzn5cNRMpxH4G
	T+2uj2kwKvKoOXkVGE/545k/62dELnGVRZGKtNDP7kXfK1BmHxosGG/j7Vr7njEzxdMouT0s6GL
	3hu+42fMO287iFASlWDdlkiMx6AOyddpa0Pkrfb4Y32YItWg==
X-Gm-Gg: AfdE7ckjkXCzjCZCICjoCCaQMaTTOvJ1fCtLZTQGnrgCzIER3F2cQWimLweMLpbRImA
	wIqDc3YMf1H1m0L1gPVmH6CfUs1DY3SWvOk2316PZqrAuHUoR/Vmv4/DmYu7Av/cEiSZVBD3kip
	joDNbf2VU16RWYcsVJhySem+m54xaYZN1dd5/vfrOU/Od4YKc5SF5dxsMuT+atPOOrbizJyg0Hf
	Q/+XIkr7iSnxbkSKy2qnDmrSZspTClkG11wW2kuRrKHYe2RJRney/vEXnOEG30thYdFJl6RrJqX
	tjBvEVkABlg=
X-Received: by 2002:a05:620a:4495:b0:8bb:ac44:bd3c with SMTP id af79cd13be357-92ecf6aa99bmr1161315585a.52.1783679920214;
        Fri, 10 Jul 2026 03:38:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4495:b0:8bb:ac44:bd3c with SMTP id
 af79cd13be357-92ecf6aa99bmr1161313185a.52.1783679919854; Fri, 10 Jul 2026
 03:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
 <20260710-camss-isp-ope-v4-4-51207a0319d8@oss.qualcomm.com> <d5475ff0-1296-437a-89f4-1d3d6e9ac637@linaro.org>
In-Reply-To: <d5475ff0-1296-437a-89f4-1d3d6e9ac637@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 12:38:28 +0200
X-Gm-Features: AUfX_mxQ19n9pqr7NeXF_LyIWJF_S-APRtcHzPde7YNEtnh7-ASBQu7xsaFIcQs
Message-ID: <CAFEp6-1j=kA=3=wxWOrn_A_=Ugj-kgxRgKzN=a=3UsAef9YiTA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEwNSBTYWx0ZWRfX12jTZ9NC7+Vj
 Mh1hcapLt48lEd1HFaQemOvT3TBkoIBVu3lnnGVB9Fqm30M6lxbFXjrqYv1stbHCcaUYvMO1MPf
 W75ciRrKxyTMdiGsVh3naFcsnQlpMuTGDjZJDZoh23TNhs4DgcLGtpQ1QyDaSezZ/rX4drT5m3i
 DgEZrgFF3xSW9BsF24rMeore71u13kp8lKdu5zGGS1pqIfP1KWZ8roFbpqPJ7V+n31CcDF+HG+H
 n2imeG8ubk0ihFo+PM76e4TcBKqK00EsdqTlYT2y6Ks/fkK6PFvqV6voQ1ZImtU0+dTUVUsws9c
 9mCyMOs8ceF61YDWG7xkqTDQxCKxgj4hntMdMZ582SvVqA1A6Z+RBRIT0Z+nua3V99ZaZuA57zx
 i4HfZDgxtu1fKHy6HfplPhZGeltSS6QYSxf6HB5CBdfcgLkxqhV//YGcHTo50Bc6O+6voaoovgJ
 8XdaPsS0VxOTTy6APOA==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50cbb1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8 a=mfUuqgtbHY_zyTLiPi0A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEwNSBTYWx0ZWRfX+hLjfL9uto8T
 OvnGtlVekvkg5tfoQyGz8+caZBY4oWNjiwDhd97QnXStb64fZw3Z64tIRpLTIFEmOIOlAfofkK8
 dd17VO+O6slnYTPFRQCa6v7GyC0y+P4=
X-Proofpoint-GUID: aBRmcVBLl49FHCwQhyejW_nnz7LuZdCP
X-Proofpoint-ORIG-GUID: aBRmcVBLl49FHCwQhyejW_nnz7LuZdCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100105

On Fri, Jul 10, 2026 at 12:20=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 10/07/2026 10:04, Loic Poulain wrote:
> > +        reg =3D <0x5c42400 0x200>,
> > +              <0x5c42600 0x200>,
> > +              <0x5c42800 0x4400>,
> > +              <0x5c46c00 0x190>,
> > +              <0x5c46d90 0xa00>;
> > +        reg-names =3D "top", "qos", "pipeline",
> > +                    "bus_read", "bus_write";
> > +
>
> Does this register space cover the entire OPE i.e. where are the CDM
> registers ?
>
> We should map those upfront even if they are not included in your first
> drop, we map CDM regs in the IFE even when not used.

My initial thought, especially when we first moved to the CAMSS
subnode model, was that CDM would be represented as a separate node
and referenced from OPE through a phandle. However, CDM may not be
generic enough to justify that level of abstraction/complexity.
Therefore, I'll reintroduce the CDM resources here instead.

Thanks,
Loic

>
> Also, I looks as though you're missing CDM S1 SID entries in your iommu
> definition.
>
> ---
> bod
