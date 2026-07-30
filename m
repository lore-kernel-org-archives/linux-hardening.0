Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40F3203B6
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411854; cv=pass; b=EsqHz/Uoaf5eI9crg30Ey4gktwI5dFK/E2Djd1TQWOqSGXbyCCrPjRudzqm//swG3nADAjXOFETkZXIuQ/3SbJMlJ0zADcIaXkKaHdHzd1a8W9qRzWX07P1wJNx42nXCgLwkKmq9R5sSzyyHUakP5vV6YwRztp2suBo++RjR6tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411854; c=relaxed/simple;
	bh=ev2/weVx6xMlQgDmYd5TevoZcOHWWng3/NPgGYBbmDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjVArh3IUHWxXpMuqfdvLk/ytxtYyeO+e76kmDeYoXC1P+/prDatOYPCJ67iyfVPEhn20ijNpg8Skm9VJDrBjenLoKGGGl+FIgNIXH7o7Idj33I3+MGuF3eOTKJuZd3+GMe50XhsH2PPvMjDZA9QT38lrmVuuIKo2SpAmSV1iLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XITbllBC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LXKs+WF0; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XITbllBC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LXKs+WF0"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2Wdw1664125
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 11:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZFdmZs+lWs/CU3aJZjtaSyzVJfvoHSuYdAqR75AXrhg=; b=XITbllBC/1NxFjvl
	Ty+GQ0YtrzxeN1b2qsd7RLaaJeycUAbGDH4NeE2R6P1ncbHsOonDM5G/5ntIkDC5
	0R5N2HHwYnV0hoq7A869wY5u/btDckkZhVyq2PmelyyVEmi6iJKAn6tpiEAD0GfA
	dP5CVHIE+010lrQ0G6cmq0oPC44pNn0O5bHLk8tjM856SvIUSP3gaKh0AGyYT3lB
	5MM1NAs9g/ZnaIu7bE4uniHazCkYKpup1qESvr0TJPqs0sVO48nm9YJ50q+nhAmH
	EG7VyMELyQRuIdx/qKR2kuLauCVswlPk4douxRuTai3BT4XUb+Fda1+pKJJsRTIF
	iERbLQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3h1rquw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 11:44:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9077b4c35c5so38504436d6.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 04:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785411852; cv=none;
        d=google.com; s=arc-20260327;
        b=pC9z4xBY4vpV+CuyHNZSRS1yxYG+4GjZj/56/vm/HB1AjHqJe2ZxAcNR5Qpv0hraEB
         cQ0txRO2118zbZTdC26kMJJ3ixABhBkbzmvimz5FfKlE3YaaUSL7XdgP46UdgiNlhgxI
         /e0c3oL35ojL8f/2UdP5KbQrXfoHSLDWy0tnvDn6lBqBd/uQaRqW9r3GSZ19JiseSo7E
         yVeHxiGpXA62uRN8N7HCBj5ezql2Rn9GqKcfWuyK/XoINgFILbnzFxVM/j7lukyTUzLC
         goDKLISOufXUCkGCAkP7MOm4l5wq5u97/mFJpE3+jDVQO8yaB+vNhOH9Oc/DYK+WXnsL
         JfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZFdmZs+lWs/CU3aJZjtaSyzVJfvoHSuYdAqR75AXrhg=;
        fh=v+NH8XFnzlbRa80v1Z86cT6sW2esEEo1wISwn9X6YAI=;
        b=WbuSzDIMMfjWygmqnqG67+OQuxmeU7nAzh0aHREgw88I1Naovcen/AwTgs6/ImpD6w
         GtFR1GyiTCPp+Jkan/kJxiLpkf2oi2AT8l6zzQN/y00mCycZ3HYDhSgtDYFzA1hbrl9D
         y8RLqk3ekyJzlJpGrtOAUW/9N6Ew/4kqGmTli2PotO0zN4c5zjnNjnuznQQai/raoqjs
         d6j1w2pSXFdSJvW3xqM70+SePIheBOtlzz2PNHR+ctgKEALzlSNAQ6xENz5Hv5e43aiL
         MndoNS2Y5bmOKhPHy/0+XAAL0VYUQEKwia2MtuOyqhU21FBfWxfiNcDuDYslKe/cNrKw
         UUVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785411852; x=1786016652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZFdmZs+lWs/CU3aJZjtaSyzVJfvoHSuYdAqR75AXrhg=;
        b=LXKs+WF0BAfH8Ok1l7lwvjE5bYWxTqfGh5TPwVhNlRj0msq6hWKjER1ot3XN0TIq+0
         gbX5ZnTR271EeDeL3cmFYKGwGBVftKGXt4aZKbRaP1X2Ncy0yCBAm5qX3xdPnAIrkc0t
         x5RMnUdD4GakG5llXLt0N8d+2PzMPHaMWo/GT+nav9Lpwl/tJwUTsF1FmA9p6oHmpHUI
         tjWmkoWHC+a3iV2eZoCuwPuyxdLedmTt+ABNUxlD45S62IYvHcnA+p71BMxXOwBeoqf1
         rIkfTvJ1DwwsqrpMq47fo0Fqam4mMWoTnxy65MvqJ4VBm2/ETYHFXkQr3einiT1YTQO/
         1zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411852; x=1786016652;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFdmZs+lWs/CU3aJZjtaSyzVJfvoHSuYdAqR75AXrhg=;
        b=BeIjFppIZEYMWMeRg2PbLH3nxHrVJSoYL11eNz3MAHIIHGdB334JOVB7Ykn2bSVgsh
         yFkK4AssqpiGD7myCtSOFWX1lfT5qq1V+MSpIg36uFgYwT8qCLQAgNvxdDkDMnsSGkVu
         i5o193mfZEl9PpGvaA3yESpG9ahk7lQIXP2w5OtrZyI1ZW/ze5d77/ohT4l7elVapffo
         jjW8mJDfOp5F6E3+6Jd1XraMJbtFvxB/TzU16byArODKbdp/Vi7V+DoYv439/aL/Tjjn
         AmffIGuDBelsQnYB6GBAalU3Jw13ZylySCk5wkyIAm5g9GYTeWs9b6LOMOq3AekXeNWI
         BXnA==
X-Forwarded-Encrypted: i=1; AHgh+Rrm11+4IVjvxYMqMZYG2NPjmYuhd/umBblNg0NzHqWQAtD/wkQvG6hxNrbRCnQ+085m73GOBPc09kLcfwRkl7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Dy0qK88+swtrrZtjk/8uTsZwZt4Qs2iRYAsgIg0ZbB0ZCXed
	okkN8Xa34uPqYyYS4zsQShVER2na0a5w48OYujJ5EET+TEqt0VakOjf01X63TvDqKmoGtXZKXBO
	y6c/AA2SKMAl1c7+9LHeVf1oX/etEduL/CeEIcQsgbN7Y5gSJQDADGnIZ2uA7UwGMbMBSbFxGZY
	lt1CQwU7/8Gy/wlKsWHKKhfFemhL/PD0/Dcs+noLGFYD8n3g==
X-Gm-Gg: AR+sD11uXGy3uP+qEpAD0//7HbCz6jN961P9LDx9fMgB09+mhg1vZE8fYPWRSG0IR99
	l0SzTLfgIm+TEQYdSj6CC+wUZ686wdJgYwwjCEbV6el9PrqMNAZLwc1Fjcu1viSddVWKykBigwH
	g3kYDVeg5qz13vHb/Ett+2qRlRdEZGj+sPa2vn6U0Vyg6Wo7LDlB7lJ8LrLxjZxVfMIsNWp6WVH
	UBE5IhQBDCOFmB8VpE/0xxXmkOqY1dww3ND8VyJquRgieeD4KaVovR8i4DICP/HRwvU/B33j0Q=
X-Received: by 2002:ad4:5d6a:0:b0:8ea:184f:c15b with SMTP id 6a1803df08f44-908346f08b9mr18112896d6.14.1785411851690;
        Thu, 30 Jul 2026 04:44:11 -0700 (PDT)
X-Received: by 2002:ad4:5d6a:0:b0:8ea:184f:c15b with SMTP id
 6a1803df08f44-908346f08b9mr18112746d6.14.1785411851237; Thu, 30 Jul 2026
 04:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-camss-isp-ope-v5-0-e70ad4fa39ce@oss.qualcomm.com>
 <20260724-camss-isp-ope-v5-1-e70ad4fa39ce@oss.qualcomm.com> <e50e3859-0343-4795-a564-757ac58f6cbe@oss.qualcomm.com>
In-Reply-To: <e50e3859-0343-4795-a564-757ac58f6cbe@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 13:44:00 +0200
X-Gm-Features: AUfX_mwxQD17-_pwcBQOZzIjdUKawWJPVhjgc8TmItAVXQo-3ebnuMZ032ZLb6Q
Message-ID: <CAFEp6-157JZogPG6vHLUjYiAJ-fwWcVX_xSMTUY=1R6+kat25w@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] media: qcom: camss: Add V4L2 meta format for CAMSS
 ISP parameters
To: "Gjorgji Rosikopulos (Consultant)" <gjorgji.rosikopulos@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: y8qUmADLyDoG81GC0PFlkrPIdzwcinbb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OCBTYWx0ZWRfX4YfaWkUfnQZ9
 Phc48tCtOZ4cGYd+7/dC217OVdxAj0etJpIMa5Jp6uL5ZDMKM6NMdFOQcH38mABmsVvnJDJkCFz
 3w/Jg2mPRXcqoQZzgK8qWHTFhmlcuMX6jnhBgJ7M3aPEOBvH2OoyyD/WEF+zl45YV+npiXQCZmL
 4F9pp3J9c79YjOzPfHn2zRBNt9XfK7mgarRfGRhgCUy1x3X52XncFCjvb4YSXaj3Kb4cjFe5smE
 4tDJOP2fOelJ6HjaI7NbdM1q/ylsYhLM6i+3GR6ymJo/01WhbNDcabZiZxDhSaKDQ52Ihi3brxG
 1R5MMnswxa6138UGK3GavdYig0FJosdeBXbwCw3j4m9gwvnmJ2jk0Tus7ue6Vvn2qIHImhPWQos
 YPLtKfyKN8IKIo7EmpvBwA0KOquBN+RaT9SC8UtSlBpphZTXyjBSavGs9eVRvxwSQLBhGrz07jV
 zRkGAqwOG56au3IGQZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OCBTYWx0ZWRfX8+KhIdi9OCSx
 sWMFaX3JiNQRwhW+Y6Qzhm97R0CKiQ+YLw/HfhnHdSWVU62lk9k4PhuxsjwTmJ/LQ+TlctOL+pD
 JtfcicHE8sO2fv7TZiqBIdGwNUI5YwM=
X-Proofpoint-GUID: y8qUmADLyDoG81GC0PFlkrPIdzwcinbb
X-Authority-Analysis: v=2.4 cv=K/QS2SWI c=1 sm=1 tr=0 ts=6a6b390c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=vIisSAodvos0t_4omlkA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300088

On Wed, Jul 29, 2026 at 8:28=E2=80=AFPM Gjorgji Rosikopulos (Consultant)
<gjorgji.rosikopulos@oss.qualcomm.com> wrote:
>
> Hi Loic,
>
> On 7/24/2026 3:42 PM, Loic Poulain wrote:
> > Add a V4L2 meta format code (V4L2_META_FMT_QCOM_ISP_PARAMS) for the
> > Qualcomm CAMSS ISP parameter buffer. This format is used by the params
> > video node exposed by CAMSS offline ISP drivers (e.g. OPE) to carry
> > ISP tuning data such as white balance, color correction and chroma
> > enhancement settings.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
> >  include/uapi/linux/videodev2.h       | 3 +++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index 98512ea4cc5b9d725e1851af2ed38df85bb4fa8c..7b6e9a9a514f037190d55d5=
9409dd6cc97522943 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1471,6 +1471,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc =
*fmt)
> >       case V4L2_META_FMT_C3ISP_STATS:         descr =3D "Amlogic C3 ISP=
 Statistics"; break;
> >       case V4L2_META_FMT_MALI_C55_PARAMS:     descr =3D "ARM Mali-C55 I=
SP Parameters"; break;
> >       case V4L2_META_FMT_MALI_C55_STATS:      descr =3D "ARM Mali-C55 I=
SP 3A Statistics"; break;
> > +     case V4L2_META_FMT_QCOM_ISP_PARAMS:     descr =3D "Qualcomm CAMSS=
 ISP Parameters"; break;
> >       case V4L2_PIX_FMT_NV12_8L128:   descr =3D "NV12 (8x128 Linear)"; =
break;
> >       case V4L2_PIX_FMT_NV12M_8L128:  descr =3D "NV12M (8x128 Linear)";=
 break;
> >       case V4L2_PIX_FMT_NV12_10BE_8L128:      descr =3D "10-bit NV12 (8=
x128 Linear, BE)"; break;
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index add08188f06890182a5c399a223c1ab0a546cae1..011026194a20cde22a374e6=
fb2570cbc6bced230 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -888,6 +888,9 @@ struct v4l2_pix_format {
> >  #define V4L2_META_FMT_MALI_C55_PARAMS        v4l2_fourcc('C', '5', '5'=
, 'P') /* ARM Mali-C55 Parameters */
> >  #define V4L2_META_FMT_MALI_C55_STATS v4l2_fourcc('C', '5', '5', 'S') /=
* ARM Mali-C55 3A Statistics */
> >
> > +/* Vendor specific - used for Qualcomm CAMSS offline ISP */
>
> It seems that this is generic format for ISP parameters, can we update th=
e comment and remove offline. The proposal:
> /* Vendor specific - used for Qualcomm CAMSS ISP */

Sure.
Loic
