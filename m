Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E52F361F
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987026; cv=pass; b=mhL45ELaoNSzE2rB5erxYsriCiIQs2WZRDSigQWsS7786MuFpGX3D4KI38V85epIifFMzJvZ3/gX9Y4sro5RbBkd8ZY64VjmS6Z6GtbaKI2qWIc3qICq7hp0HtLbGNq1OC7R97vP4RW0EYoTJ8fdFrtlLraLTWW9rODYcBe+5Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987026; c=relaxed/simple;
	bh=RINXaIomji3Z5k68WUVEnL93Hz5H4UongOpfpintwjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujF+ON1RNFTiM20kw5xpphLnhDgcgW2jlWR9iFjJ7mOb+gsG5/uvwcLhxgpjzXib7Wjbqbj5SUF1KsuBSeBhC4sWwWBx5bUqJE1UH6LZCniSXty1DVoMJ3T1Ux2AScOS+a1/B4pRyhFfzfGaXqSTncfLi1O1BiLG2i/Q45CGEoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EPFtpj7Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OVKQ+gMa; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EPFtpj7Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OVKQ+gMa"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645D62QM3187614
	for <linux-hardening@vger.kernel.org>; Tue, 5 May 2026 13:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AD798WH8YaKhVfp/Kav0sq2C2jeCeH7HoyLFibDPvLE=; b=EPFtpj7YXNJxCs7X
	HJwZFiVLoYL6T1l5DiF60DoP837ay+JVBPpk9po9f7fDQ4tsGp0eTtCVyAEr/mnm
	CqXSuSleUA/r38a9U+iEwWVIx4DOr7BgOHdTO7H68+6N+wem0sD8vzgq9fiZpckp
	1vWFHhe8HOUaJfEJ7x7pnl2CyodAN9Rd4rzmKEaofo9HThcwAyHL2Sea14I2CdHv
	DIg9nlmSeHY8rZv3cVyJJuWH7pmeiL3P/u3X8ltmyuhtlOSIVNeVC6cUrRRrHDE7
	KiWzC21NKF9EDEGlgV4SOWXqA+zP+3uAsmZDif/ODfvfQh47VftK/nbBu/J0gbbE
	//GMEg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkk9drr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 05 May 2026 13:17:03 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6101726c594so3013079137.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 May 2026 06:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777987023; cv=none;
        d=google.com; s=arc-20240605;
        b=KA5dznOTJiMoDGuISqZEiPhqUdOVv1NMh4MsfAQwFk18vrl5qWVmyH5TzmLUMVZ3lm
         e8h1YPQufQn0oS+RPFLBEeCZo6VDQf5HwOzcayoEXJ8HTt8upvn7f3McZBlSK+sM18PW
         FToRAKo4hJwAbEcGUoFlVC7eVDBmeTbCzc/XhYbKKcm8FBDCyHbrxz4uRWWRGXMMilTi
         0aaJgd6ZXyc4SA0pJBPR2qBJ9+6FmAo8oTLcUPJqDIP50D+9l26xlxfxQPwhw2f6QwsS
         jp9cQ8zanoeM9Uatoqa0MkLjm0GgJV1JxbZ59fXAkaxu8JbThQtT7TnSeFX1N+P17ZmF
         fASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AD798WH8YaKhVfp/Kav0sq2C2jeCeH7HoyLFibDPvLE=;
        fh=Yefws/4tacqE7PvUdF1ccE4ovSkGc2Hd3G+sZfnzEI8=;
        b=Cb7TbQB3FCilrwXbgxqIQQq8NvfVRbnr2NpNuhbxGL+FygrTXgnzeNzA0HOCTM7HQm
         IxRSyvAsv0hDRB6FrXa2DS6YloYENirVXzghcVcHfs5fGb92AA4B0eULfJSBLtYfGBLj
         vgAIiJsNJzPsnKyuIhYdgveA9FQlT29sz/ZwCL1mAJjg4Yf2tW1oSolJEkmcPAv5wyRU
         vqJFbVlv4FmA6HlaYghGbWW17hDFYRypap7dYV8DgnKJPGD7Zm3G/Hl35u/zH996CSdx
         gqZxq+udkwqvb4b0ODS/DC8dHoQqSCQMbgHp3r55qbT3eeGtNrvz2tWn6sQwy4Sv7cjO
         g+EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777987023; x=1778591823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AD798WH8YaKhVfp/Kav0sq2C2jeCeH7HoyLFibDPvLE=;
        b=OVKQ+gMateW+W+JifJeKvOFvIRLK9xJl5Oa1+H75KnEmWvpeVlwqvsSSxaVXdNZ3ke
         G0EmyWm5f4/FkTmY1YChRlbP/JiaPTm+pddUg7YWGdI9PlhJ7Gc0RIo8tveRNt3+ECDd
         bKxEXZCP0V/lNJiTwQ68gAIsouti9Z5iTuOqGycheCYKEeRHgQW4ogMt72ZlgGLRA6yX
         xblRKlnSceiMyNuvRlgGea3W8ZUqkSA0P2CSyRhKgkLkmQ1Jwu1cBpvrTcmh7yDdxkbA
         KZxePQ+M3DnbZmK5rFdmmDBrob/l8QQSPCp546WDhZ+b5YHdW8WZz6O1eBIwwg2giJON
         +p+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987023; x=1778591823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AD798WH8YaKhVfp/Kav0sq2C2jeCeH7HoyLFibDPvLE=;
        b=HgyKudO5eCouwPhyvYWRy4j555DurY1YktKl+oACr+D78jxx9SaKhZNvN3kzORLlxh
         07M7vdzghvloWpaIelzeML1hWzPcOIwjEf0n7TkE6Pu08ui/hc5q/oR46ZqInUVkyJQh
         /L2+mSMs5Vv25V5r6Bo4rhV7zyY/Woqvt7fV+Ru++FGQoGahvyQEa21fwKEb65EMsz2U
         nKnZ+37JdFIsppTiYBRI6LYHz6/oyUoR8mfFB54lV+YXYQIflfKiE+ess4nVKbT1W/DC
         PteLs+wHeN6mzcRnHa7vSjCU7ybfo08zZipVgFJBqSZMkSDLA3v5OtyA47UWpH/9ld4B
         NTvg==
X-Forwarded-Encrypted: i=1; AFNElJ8C3X45Yt8olfOIZv1n5oWgsjGKx0lS9fwbiUEGK1XJXFdUek0I3BIhByNAtKJuhTmG6dJaaodUh2XJYWHlmVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHTDBE347LCN8MK4j0eLv48lBNn9jvtYC2U9+k18qo2yNaLxG
	UUU8N12jMD67P6BbVHvS0s9FxsqykcMTn5N1GDf799XRfDlBaepE/r7SH5vnhnqHwBgehNcCjQd
	14hapvrcakGQJUR96pIlUijdxgU+iH1wySuJ1lyV/svHU1k5/ZzO//ecoeKb8jBzGe1WaM+5F+7
	YvefHmSRiVUxtoafnsfO8lynY8JEGY8L0dTEYYS1m7eMQoGQ==
X-Gm-Gg: AeBDievIRKWkj7fDq7+/yogRdjjMQbfc5ilAdjwGlVRHXqplwRg6kGlfGWxsB5O44WG
	1ffMTCIlNkbuKDkjS9veshUjvBGL0tqApk5vUchCwtzOVxquuSIhJK29rMuKQbvZrjzZuX6foIe
	nFAZj73U+S8DeSvguya8zSVBkFXf3A17uc5CHyDK+ff+b7DAHZwe3OszdgTmiL3wJKwmpiEYEVb
	lMu4LuHnv1BB+B+BNvcWoSRkP33ni0YKlbs4taGPet5eKPBVrGI7Lvtno2viX8uWdn854W6jusG
	mbU=
X-Received: by 2002:a05:6102:5e84:b0:612:7ddc:52ee with SMTP id ada2fe7eead31-62f591e15f8mr1334680137.15.1777987023061;
        Tue, 05 May 2026 06:17:03 -0700 (PDT)
X-Received: by 2002:a05:6102:5e84:b0:612:7ddc:52ee with SMTP id
 ada2fe7eead31-62f591e15f8mr1334635137.15.1777987022558; Tue, 05 May 2026
 06:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-10-f430e7485009@oss.qualcomm.com>
 <aead10a8-45be-4f7a-ac6c-35a99a716b3c@oss.qualcomm.com> <CAFEp6-38=hcUOvW1yd+hRZ2nHV8sLxiLeB18uu-au=LgA2bQTw@mail.gmail.com>
 <0c6c9366-a190-4143-a0fb-2aff38ed8804@oss.qualcomm.com>
In-Reply-To: <0c6c9366-a190-4143-a0fb-2aff38ed8804@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 5 May 2026 15:16:51 +0200
X-Gm-Features: AVHnY4LGEhfsUlkX4TOjzlp790x-TMEYbGtYBxNjEt1Hs1iHIIf3wT5xSTTbtjU
Message-ID: <CAFEp6-1uDO7UzYm+5ejRH0fCtnFZSA3z_Xa+4ibDEbXBh38ueA@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEyNiBTYWx0ZWRfX/hjCfR0WnN1v
 E5km4QJNpACfMKtNNF7VkG21JmWSHlAxQ76M18M1TDMJzEOsnJAiRE7XIIDqwBpTjBTQfBzm3mU
 D5tXVy8Qtd91hk+6iAJ+NQGvmclA/DI7EUwJaBp9riWi+MQyGxECWBbGFyxOCYkxIQMoz9aYzmu
 XEzkGr8rfxcHL183GlAXIARl8v2/78nLTH2FIAVHXNNEqze3NYLCWh4VlIFVzWwJ5dFXLv7dMkE
 kSnh6b9J7+E8IudbwU9RXEjqXWxDMKW+stN/cCDE+NbS4fHdpRRtW7i9vhSYSJC1ZQoBJQqUgsy
 ZhSa44HJH1m/BlniD35nobjA/WlGRam8Z3uoXQ8laUajfHezkr0Mp5rPRkamFHqAZ4pzh9uBGlv
 l4rF1UsfwZsJ5gKX/XOJyTH4wBYf818BNpIIxGybfyg9rjAyoaZ/o2p0g6AN6sPMlRBPpdbdkVG
 J9eb0GJX4bcqNytbhwQ==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69f9edcf cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=_2yBmY5WZcee53Sj_MsA:9
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: 9mpPwf50tBVLVLiEDEwtn5z6NYFfWLS2
X-Proofpoint-ORIG-GUID: 9mpPwf50tBVLVLiEDEwtn5z6NYFfWLS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050126

On Tue, Apr 28, 2026 at 12:16=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 4/27/26 10:33 PM, Loic Poulain wrote:
> > On Mon, Apr 27, 2026 at 4:22=E2=80=AFPM Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
> >>
> >> On 4/27/26 2:43 PM, Loic Poulain wrote:
> >>> Add Devicetree binding documentation for the Qualcomm Camera Subsyste=
m
> >>> Offline Processing Engine (OPE) found on platforms such as Agatti.
> >>> The OPE is a memory-to-memory image processing block which operates
> >>> on frames read from and written back to system memory.
> >>>
> >>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >>> ---
> >>
> >> [...]
> >>
> >>> +        clocks =3D <&gcc GCC_CAMSS_OPE_CLK>,
> >>> +                 <&gcc GCC_CAMSS_OPE_AHB_CLK>,
> >>> +                 <&gcc GCC_CAMSS_NRT_AXI_CLK>;
> >>
> >> Should the two AXI clocks be aggregated by camss-top instead?
> >>
> >> Otherwise we run the risk of the OPE driver setting a rate of A
> >> and another sub-device setting a rate of B
> >
> > On qcm2290, OPE appears to be the only consumer of the NRT AXI clock,
> > while the capture path (VFE/TFE) relies on the RT AXI clock. That
> > said, this may not always be the case and these clocks (AXI / NRT=E2=80=
=91AXI
> > / RT=E2=80=91AXI) seem like they could reasonably be managed at the
> > camss-bus/top level.
> >
> > The open question is how the NRT AXI clock should be enabled when
> > required? enabling them unconditionally (similar to other camss PM
> > clocks), introducing a dedicated CAMSS top=E2=80=91level interface for =
voting,
> > or leveraging an existing framework to handle this?
>
> So, interconnect, or some internal, smaller version of it?

Downstream, there is a CPAS driver that handles these clocks in
conjunction with the internal CAMNOC block. Dmitry also mentioned the
existing icc_clock mechanism, but we likely need to investigate this
further to support proper dynamic scaling of the required clocks.
However, I don=E2=80=99t plan to address this as part of the current series=
,
as it would significantly increase its scope.

I believe the current approach is acceptable for now because:
- This NRT clock is required by this specific sub-block, but not by
all CAMSS sub-blocks (unlike, for example, camss-ahb), so referencing
it makes sense here.
- At the moment, the OPE only enables this clock without setting its
rate (i.e., it uses the default), so this should not conflict with
introducing a more complete scaling framework later.

Does this sound good?

Regards,
Loic
