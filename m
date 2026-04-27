Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D92D3733
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320555; cv=pass; b=ju7Y+fyTRjrTlub5MuxKvzgBHJDiX/QIpilY+InJLf55asycTMMy55dowXBtXxKVkyGp3+df/GAZOpeDlYiAepmnh8Msc5yacEUZllG9z8ILB9+yNoyuolHc86Bi8hYD2KW+JXksugDormNHTCs4eYyjmH18rG9LFpxEmVsdiZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320555; c=relaxed/simple;
	bh=zJf6itPcif0oS4I2opQ1ZeZHwhSjUSFKoJJMf+zZal4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNXNBWyvMDdvMpmS4IN5BuuFOY3LcbyjC/GFLEa7WoIr8hIRJb9wpPcIUlU5fm1zmp9XVVeSR0+UIWqvJSc88Bzi8yV9yhO7xoIsNkSSc4M36V0zxvAtx3Z1eey3tBiW0muLjChsxQFd+N+yzTzRyf0M5zC9na3drN0wQ8+DIis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NUwUd2Ck; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h6oetvM+; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NUwUd2Ck";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h6oetvM+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RIevv62006206
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 20:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K2HnqUmhHcbUyD58GB7XPc0QpK+OT1yUlEKIPYYo7QQ=; b=NUwUd2Ckcp6eQcr3
	wjTRb6FPXg5tcMtTN2yu8UL2bS2zGf/Em6YqtiyEnlJj6Yk2dGodyuNgS9UGpG+B
	LjWJugW+aBMwe0xaBWSIDK6tmE0menmih1aGaTk+sUHYEEcyXsM2ffIFPaB1koEx
	sc9eBnL1YYESQltWqWn7PK/SQB/4eRg1JKVUtTplcjikjZ+YUCOpmWV6ts618dpZ
	vwG5Woiwp46nGW5yd9HXXNrYo4pRalp3n9DrMpGse+s6MHswQJ3PhfqvlZqaZ2lF
	SvaDPXUGfjXZ4GTZtAU1C4LYoH+6bSkSIctobnRf3MyrG/MXXBT6/BO3hJy//ZQg
	TcMBxA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7gkhurh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 20:09:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8a16036c90eso266816596d6.2
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 13:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777320551; cv=none;
        d=google.com; s=arc-20240605;
        b=aNM35O4unOx1YyASSd+d7hF6DZf9OWWCKP10CtTFHll6I1DIVFArHFuBy6sZ0elRdc
         1e7BMEcdUtMB6465PZHvf8uRXqyAr3h7lsV6ktopbFxfXAzYP/ZFDdAvPZEigHPYK0Ws
         OusK54u8Pd/0vY+ORyJwc6BzHXHZ8+Z4BqyVC5BoE/q0Fxl4RnmB53N7YkrIwvnEG1VV
         +ERL4dKWSz71Q8BIfzU2rxuv6wSQ9SBDP7ZCCGdOt4atbUwSk440V2+4dW0xgoxvCUwu
         urU5BJ856Dk3MLtUFndEaJvzivFU+JjIcgfSvvX3naJLJu9bLy3bi5jtAcuwxG9TRnUL
         9niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K2HnqUmhHcbUyD58GB7XPc0QpK+OT1yUlEKIPYYo7QQ=;
        fh=ZL+X1rI2QUE9uqDjg7xJZxY0FoY8MxQ0IlLqGyaDgSM=;
        b=aw6oJRqN62HdHLoVqT+B5x/1mynC6d2qjDBbiq+Zus3MMv9qRgLP6kjcQX2K+sApgI
         Ej1jUnF7kAMq5BZqx7vXHBc+cHVAmLih103/BWVLFeRpbB1IqGsKUgKOBsq96byNUwPq
         +N/6Uhq1jYOwGiJxkJsiIPK3i+8EIscQNatz+c5ZMSB4zoYsbUO9fC1QgEpvpdtnVfj2
         S6cV1IUg0wtLN1ZTBgbVZZ1M+0A1rLFpQtBRfzqNhTtogHP4ImcA/tnpWRK1XwlEuREJ
         bf0zOkQYP2XgENssqFp771SOQL0Y1H/PddSKcPDySj4EDU5vnK8LjEKaE8BCuSzKmlr3
         DpeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777320551; x=1777925351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2HnqUmhHcbUyD58GB7XPc0QpK+OT1yUlEKIPYYo7QQ=;
        b=h6oetvM+pp9+S/xwnBzKR1jBNK7mGsrYc6Q0nhBAptd80K68zcVo9VLIjf06ZSjQxk
         QsozJwDRg3jB2M6AHbPU7+BIRnyPaUwH2KISec4BIbHY4eMRGOiQUFtmLCSoV9/8ktzn
         4IKrwBP5LxnWtI3pXHwVsuniSqBoD0X05odQBUFVJNUns4Ksk/ICyJFpZJ2oqAbvVkwS
         bVdFUGAyz6wpp/fhWen2He7Fw1n8HiRrb1wDWIXHZKXZrS2iyNmsH1xea4JtJq/dZyz+
         PRRp8DhXFUzIhRxWKQX3/bf25scYX4587NolzEKHuzO71ehHdIpWrORUb8G6T7hP8Ho7
         fOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777320551; x=1777925351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2HnqUmhHcbUyD58GB7XPc0QpK+OT1yUlEKIPYYo7QQ=;
        b=KNbVuLvHe3qaK4aBvAQHFO+ZTCjBZR+OYC8bhwujcHodE4ORoA+S9BppbsWFO9b2c6
         qEmAbI0xYUkaaXZuM5It9s9omYJGUIWzOf2qiwEYJKdEJW/LC/oetxcZbYj4kh0BTDG0
         nDWnhroLDKMANbhBas7xbHvdK3TFVFRDU0sPjSnvcR9xBdWX2ExijAsGOCy/8/MsWiMX
         V8iQS1XwCG7266yT64lVhYkYrpTANz/Cx1lxaQmoOg8tP33Y7r0mpnN05N17dgwt+GTA
         r5betgxuaFf8/FykKn8sfd+0EJu/BhsedJ3nV+AXgbKH6jObKSeea9LFJQj4oOAywnOP
         zM1g==
X-Forwarded-Encrypted: i=1; AFNElJ+gbvaeRfar0V8WxFixML/+QpZE9QhfsMtgRhUVneIqnVStT8/C6PkVDshgGgPO2lJCRksXhIGT8snQFk71NPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtYly6HIFX8ltY/QiKq8GWfU95PQqv6TvblF7jwfg+R7LGday
	vhlsjmUjSe+hYKeuOwPZQIMz++qmGXQv6F20LluDf2I+qeVEREGOvMJRQEdmeC0AmStnWCdXZyF
	jyQcKHKdYhWX/Fd2Z7cCWOTeBs1vDsPdXMlYlvp7C03aEM6Ew+xgzE1DgPolFVqRkRTrEm2b2Gj
	i+70zENyByouK8qO8LpSeHtsojbXL/gruwGKv7rtdwmBIzVA==
X-Gm-Gg: AeBDiesPEOaWT6+tK9BaZ3YEbzsllGHS3JJhcxzB1HAWzlt27pkvgo74/OIYD/8IdjA
	IMrJeTax00GaRlovnFov/cY742S4bGBwOW8YSTYP/qZUHE9aPY9BTI59X9co6RzlsBy5pTxnoVf
	JHTKxMzFH9cDZmNzoVst1BvjuyIg1bX7khl9thiGCLVeICkj+3kFVJF4vW0QAftuqlw9wQQMivo
	Wx5EyfiyuGePA7wEv/25GbTM8jDgEcqwaofRYmsnDlps6mWX/0=
X-Received: by 2002:ad4:5e8b:0:b0:8ac:b619:5ec3 with SMTP id 6a1803df08f44-8b3e31fca48mr5278026d6.50.1777320551075;
        Mon, 27 Apr 2026 13:09:11 -0700 (PDT)
X-Received: by 2002:ad4:5e8b:0:b0:8ac:b619:5ec3 with SMTP id
 6a1803df08f44-8b3e31fca48mr5277336d6.50.1777320550568; Mon, 27 Apr 2026
 13:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-12-f430e7485009@oss.qualcomm.com> <3e72d17c-e46c-42d3-9b17-54627f6e5e28@oss.qualcomm.com>
In-Reply-To: <3e72d17c-e46c-42d3-9b17-54627f6e5e28@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 22:08:59 +0200
X-Gm-Features: AVHnY4KEu3qZJsaEgSW3oDVV1djoe7ePu-gt-mc0PBpeJhQ4prv1LHNjDVdgtGI
Message-ID: <CAFEp6-20MzQh55iJzyhn=htFZxN1yq9o+EJJAX0CWG3O6_KSyA@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] media: uapi: Add CAMSS ISP configuration definition
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
X-Proofpoint-GUID: I1c6FyDQsNcg0dJCqcQig6N1i56R9Jpm
X-Proofpoint-ORIG-GUID: I1c6FyDQsNcg0dJCqcQig6N1i56R9Jpm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIxNCBTYWx0ZWRfXxI07ltf3lLX/
 Xy2rSSwS+2IuxFvwgW7spS/dlKj8WyjipqgWdNGMShuw1U6TNHjRb5000hp5PPKGB/JrByPk7La
 fLevB5sq8kvyIog3pzGpdBTZPJQ8TwuPkMG2qZppbZwAvwUXUbcA0wHnB0phcnJacXyh06S4sRh
 hJUMS1zUR2M2kFXiPJUS4iCWRDXX0Ce16FuzyoG9pnTts0L9WzaxomnCQUkWApqHVf0x4IdwksX
 pk5jsw6NU0TSSpzqjZQrDP5QiGue6I581VRCEMvO+DeYeElPwNhC8/yBfaFi32lpddk1SSjM3DE
 TKcVjmgIzJ2nl2JAmGj/YdAGECFnzJOqFNHcehVB2pjGObaHI3ds3Lg8RKCGOlFK3omzsuD30rU
 Q6yYRRgCmhs5vbV3ccoPhipQnncvoV97iKNWLERf4FN1SfIw9KkL/IS+wotfDDVSAdVTTgfIdA4
 r6BJLNqmn4lvdqYvT0A==
X-Authority-Analysis: v=2.4 cv=bJsm5v+Z c=1 sm=1 tr=0 ts=69efc267 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=NNFLuuOXt9NZh06aAH4A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270214

On Mon, Apr 27, 2026 at 2:56=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 4/27/26 2:43 PM, Loic Poulain wrote:
> > Add the uapi header camss-config.h defining the ISP parameter
> > structures used by the CAMSS Offline Processing Engine (OPE) driver.
> > This includes structures for white balance, chroma enhancement and
> > color correction configuration.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
>
> [...]
>
>
> > +/**
> > + * struct camss_params_wb_gain - White Balance gains
> > + *
> > + * @header:   generic block header; @header.type =3D CAMSS_PARAMS_WB_G=
AIN
> > + * @g_gain:   green channel gain (15uQ10)
> > + * @b_gain:   blue channel gain (15uQ10)
> > + * @r_gain:   red channel gain (15uQ10)
> > + */
> > +struct camss_params_wb_gain {
> > +     struct v4l2_isp_params_block_header header;
> > +     __u16 g_gain;
> > +     __u16 b_gain;
> > +     __u16 r_gain;
> > +     __u16 _pad;
> > +} __attribute__((aligned(8)));
>
> Should this be __le for all of the related types?

At the moment, this is purely a UAPI, the values are not dumped
directly to hardware as-is. Instead, each field is translated into one
or more register writes, with the appropriate math, masking and
shifting applied. Adding explicit endianness in the definition would
therefore require special handling on both user and kernel side
(to_le16, from_le16).

On the other side, there are scenarios, such as platforms that rely on
ICP (firmware-driven processing), where we may want to forward these
structures directly within an HFI packet to the ICP MCU. In that
context, explicitly defining the endianness could make some sense...

Regards,
Loic
