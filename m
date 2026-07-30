Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F642981C
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414874; cv=pass; b=bdfepb3qWOWcGX9acl0TXNIyT7KsxBNdbdC14N/DnfySuuQBfEm3shCQP7ol7QQidLoUdMveSBOsp7eu0ExNYGiA6bY99H2Fkm6eKrSpSLqz42UnK9x0xdFM7hMIP2mWLKs89dYIZaWuFDl+4XweZjzM7aoGk3dLUac0O+GRkKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414874; c=relaxed/simple;
	bh=NxWEunGjGB86A7F89AhMOE8cJDXgKJh1EGHFuiKVhl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQfvVEEMAlHdrPcasezz3vITDK4XuHjhizdTTr6c59kOwzj/HZ0EoSyLnFWv/hVKa8f9z09uP7MMVTlHqztDCkdkEfk0rMY0EvmBIqsivNz6eWezauccF62k00+bXsbZprtOJZucMLEeyrr6LPf4kuUqyr8r0HaN4/o/8nbQ84A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X2NXF71a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HuzOIkT8; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X2NXF71a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HuzOIkT8"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2USB735221
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 12:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v0BeCVwbfS2EedV2zVMsiVjAyyRHPtS6bc9+ZZ4vpvA=; b=X2NXF71aPsY6oyRK
	kpXT1OTMuzTzpetDZa/SgPtRNGCr2anNPQiBNRyyHucvvNxO+rrCpfqg63C8e3AV
	jkj7Ah1nEElTgWEMDyOAfYuYPptOvFs0Ha1HuQR6HQP92ChR7LsYDCg0cOLkcrjt
	DoFWV2PWfx2oW5CWlKU40WKSssB+SXacd92oJ411MlhXz4mxoPHmXhipcpuPdAI1
	n3s00XzCIP10ZCT83954Sb4CbOyUAX570SatOTUvHaJNWQ7L9IyHL19FGGWW/PMP
	83w0l/7ypMeaHdJ1A7ckAjYrhwEoh94C038E33wvqcFRDP7qTya5YV37s3q93Iyi
	jDh7TQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr4a2gnpw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 12:34:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e63df032bso69808585a.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 05:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785414871; cv=none;
        d=google.com; s=arc-20260327;
        b=XcGAohfWghuqqWNylNb5BUWrRc9f5LcXZqpQ0HjFm3U9BT+KIXA24MZcWZE43uuDjT
         2OZQqR87cv34YTP45D3F08JgCGjVs8wiKamlNkWQffrdPLk7YcVcO28r8aAsf42BlfzK
         yVaKOSYMDUvwTupyNvzRh0tuSyluKjZK3NvrjFlE6zOKT6iKIv4kFmd6abrVx2H6g78D
         ssYfrhFPjvSkwMV1n/MuAQA4zvwiIhq5BPfUnmYWNa2D40pJXVE3+7ucjXYbhWTn4Ifh
         JjYfhSADoo4UcRCpK2O4sSFitHmWmeuovkHXZDx6aeg5b046O4etc2zep52QG3/SFpUP
         DULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v0BeCVwbfS2EedV2zVMsiVjAyyRHPtS6bc9+ZZ4vpvA=;
        fh=kGhn8EXYV+i1Ny3sbkTwmyMOhzzCYrajH+MEawcDU8A=;
        b=iOby0Bnxg8F8Sy8I/L3IpgDxmsXle31g1tvjpY9q5f0ZjpxpHgIZCDlLdMB/Stx2DG
         2/S0FKn49/V0GO8pTos8VeJPC/2xWqu22NJDwtPXKYbs3Blm+P4MnINeMLqpn9YEqWGU
         rr0LuBpG3po3/XePlWXE4ujDMxibxJk9cA/l7oviCU0eCkln3BdiWncOAkZtyt/fY3RK
         CKXOEYhyOpluPQ4qnQTrp+zsZbpaVcCF9ImSDnWaFHko9/U+fRo6GKcvqf0um942Dkxf
         y7Dd8nqnYdpeBNuE8NKaC2Ijscl+O6681vL6FmuUtSc23GWvgmw7dyR2hvjmFDDQ+kFB
         ScwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785414871; x=1786019671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v0BeCVwbfS2EedV2zVMsiVjAyyRHPtS6bc9+ZZ4vpvA=;
        b=HuzOIkT8NStdLIeLc81HFUOsBNfU2kgN5lRnEVsWv1L09dTvdbAVjA/DLkrnl5613V
         Mg3DORpJHsBKK5LaM5SMy/U0/Voaz8YFAkgID9Xl7gdnE+8NgUFeiEx9OZtKuGCuURvx
         kf4hqveEudWMu2MiWu05+wmC3ZmPa9Bf4hbYwG6azFbHbUjBgOtCNIWrEm6GO0fTpxMp
         rHrkBYL2iyQk0umVyAWuQBAGtGcPIFZCS0DZ47quRjm/TawlRu2IaGBkD+t/WuClaJOv
         6ZH9Tsp03SSIt9gSae7uzG5tbzrWkWRTilqe6frgu9AxylgPOQjUEvgCnMAJAEK17OZ7
         MgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785414871; x=1786019671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0BeCVwbfS2EedV2zVMsiVjAyyRHPtS6bc9+ZZ4vpvA=;
        b=DXMFwkaKQha8Q5ds4la6TSZqKpf4eEmTJ1oS5ts41BLxXG41ozFb67OVrEBskbqtJm
         nA0X+V535jl5VKO8Or2upaMGx9qg7YXxZP40IF9hzF5VmQajvLsq8VA27Bdf6fS2Dj8/
         zS5GGTAmYm81g/oIYQ1TSteMFg6hPY0n1S/A/ZVr+b/hQGsqPE3vsp2Cu6qmbarS5SWK
         Gl3o6/Pr6E7q4hICe4VgeQfFDUY0WbzZFTdi+Tg6fe6jdB5ckwO7M05WhAMYzofMHXQm
         wluKIT+4/TgnGohFZ2lx8fl99tb/+NH23foMkGNABHaHhQ0rWGfOp4nho98EOxC2dl2d
         KoCg==
X-Forwarded-Encrypted: i=1; AHgh+RoOmSpuC3/fgQ2uaJjPSdzIDUxqrSEOpvZ+3nBtXtC3zxhzzFUW4XKj7xvZy8yP86PtNfNruvFPI+P/p2aFuDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRZhJSRkwKST3SnYzQDSty8uOPTu//TOaTczIcGzRe5lj8RP3
	o+q7T/G5dDNKwTRDPTgq+28Ag0qwL9B0V+Vbi11T5T14CYvCaDkIPq3FZ3ZMjNJyE5tSQFcwx9G
	wmi4kWJWfoG314HsKI/HA5fSgS/hwNaydrsTY2lTztPD6zi02rDIcKlBtvmAvd5nDbPuR4BO+Je
	kXQoYM1ZFKByNvuBTj2tp0TREqrVHuZnIq2uTZuuVogSYrKA==
X-Gm-Gg: AR+sD10pdTfoHkar1dGaztR5tEjGPS83+IYFVPImoPmbW0gkRKVw93aheOaaXEgB22I
	wJjr1SxZxgNJJGBNu/z8NSf8Q4NtPFZ5OkdnnoKNmlB9F6xVWDv2dnyAu9zYLmaaDkaqGTuWH1v
	IP96he6viSv0xgBG77Gnc8yTXDYMApXWIaeeSosD8e2sO08pGH7tia69/uHhgYkTcr56DOCJTU0
	/bdkeZoodWF9KUy6r9Kl9SgpHiNJguC7uL00RidyrcdwPf0l+gnkF8+KgruIoBOA6/mUjoOaIc=
X-Received: by 2002:a05:6214:2388:b0:8f1:ed00:7fd8 with SMTP id 6a1803df08f44-9083a3ed266mr2312466d6.3.1785414870379;
        Thu, 30 Jul 2026 05:34:30 -0700 (PDT)
X-Received: by 2002:a05:6214:2388:b0:8f1:ed00:7fd8 with SMTP id
 6a1803df08f44-9083a3ed266mr2311916d6.3.1785414869813; Thu, 30 Jul 2026
 05:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-camss-isp-ope-v5-0-e70ad4fa39ce@oss.qualcomm.com>
 <20260724-camss-isp-ope-v5-1-e70ad4fa39ce@oss.qualcomm.com>
 <e50e3859-0343-4795-a564-757ac58f6cbe@oss.qualcomm.com> <CAFEp6-157JZogPG6vHLUjYiAJ-fwWcVX_xSMTUY=1R6+kat25w@mail.gmail.com>
 <31a77684-221e-452e-85a5-873b0cbbc118@kernel.org>
In-Reply-To: <31a77684-221e-452e-85a5-873b0cbbc118@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 14:34:18 +0200
X-Gm-Features: AUfX_mwG_XLqff8We1-VjUFCpEv_zMOLloZt58qLvXWmamPVEeHzeVGoLatBSdc
Message-ID: <CAFEp6-1jt_q2YZv17mxWTwKbxipNoh3F0RPqhLwhdH-ffcCcvg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] media: qcom: camss: Add V4L2 meta format for CAMSS
 ISP parameters
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: "Gjorgji Rosikopulos (Consultant)" <gjorgji.rosikopulos@oss.qualcomm.com>,
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
X-Proofpoint-GUID: b5xViiWf4gM5Re5ec-FkVxSdPENspso_
X-Proofpoint-ORIG-GUID: b5xViiWf4gM5Re5ec-FkVxSdPENspso_
X-Authority-Analysis: v=2.4 cv=IoIutr/g c=1 sm=1 tr=0 ts=6a6b44d7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=wb1n7jFByJHGHbbB-X0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NCBTYWx0ZWRfX8/gTnYDGUgCM
 VSetBzdP8N3Zq5LGP1IDe1G3SE9/Rmhd7c02GbeJpT5rz/SfkJMr46qChIrGIXn4e4BsxnH8Y4i
 E8csaOKToqTMDDjouU1CY480cwAb0ZQNfgWh4l5ctvBeQXu596hco5k4FUHNJE1Zxk9yBakQK3o
 RL3QhkHTaYMAp+hbdZpUS6lclaIFPWaS5QeL+AOkiFQj3p5IGvj3VyH174vp88nzIvdLTljrrD/
 ee3TdmLVqLdQYc9RFAJBtYo1vt+aKfanZI3zix3IwEBZfN8ffLWPAZYmpnAK2MAcr5LT/JsKVy4
 UgxsE8zPgXMxi+iwFwTTCZXL/ElWO/nOd9/9RyzTeIJ9eyd49KOFrlobwegF1Ck2TqXiPFeYc8r
 HxPmOcfJqydbQCv2dZqPEjFBm11LQzwzuFQUbc7D/TQvcRYwq7K9q8BVLQIVHpdggKesEZidjmG
 +rhINQzduGIWPl1aADw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NCBTYWx0ZWRfX+Nm9KxpdHcnR
 yUy/0Pgz0CdT0q4JO8XKZIIoOJA0fKSN9GOiZRGE6sPoOpUkx7+54JxUSZyi3QwJraqyD40jbCo
 QkprpKUdP7fmtAqGqvbt4hcqRnYnIas=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300094

On Thu, Jul 30, 2026 at 1:57=E2=80=AFPM Bryan O'Donoghue <bod@kernel.org> w=
rote:
>
> On 30/07/2026 12:44, Loic Poulain wrote:
> > On Wed, Jul 29, 2026 at 8:28=E2=80=AFPM Gjorgji Rosikopulos (Consultant=
)
> > <gjorgji.rosikopulos@oss.qualcomm.com> wrote:
> >>
> >> Hi Loic,
> >>
> >> On 7/24/2026 3:42 PM, Loic Poulain wrote:
> >>> Add a V4L2 meta format code (V4L2_META_FMT_QCOM_ISP_PARAMS) for the
> >>> Qualcomm CAMSS ISP parameter buffer. This format is used by the param=
s
> >>> video node exposed by CAMSS offline ISP drivers (e.g. OPE) to carry
> >>> ISP tuning data such as white balance, color correction and chroma
> >>> enhancement settings.
> >>>
> >>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >>> ---
> >>>   drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
> >>>   include/uapi/linux/videodev2.h       | 3 +++
> >>>   2 files changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l=
2-core/v4l2-ioctl.c
> >>> index 98512ea4cc5b9d725e1851af2ed38df85bb4fa8c..7b6e9a9a514f037190d55=
d59409dd6cc97522943 100644
> >>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> >>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> >>> @@ -1471,6 +1471,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdes=
c *fmt)
> >>>        case V4L2_META_FMT_C3ISP_STATS:         descr =3D "Amlogic C3 =
ISP Statistics"; break;
> >>>        case V4L2_META_FMT_MALI_C55_PARAMS:     descr =3D "ARM Mali-C5=
5 ISP Parameters"; break;
> >>>        case V4L2_META_FMT_MALI_C55_STATS:      descr =3D "ARM Mali-C5=
5 ISP 3A Statistics"; break;
> >>> +     case V4L2_META_FMT_QCOM_ISP_PARAMS:     descr =3D "Qualcomm CAM=
SS ISP Parameters"; break;
> >>>        case V4L2_PIX_FMT_NV12_8L128:   descr =3D "NV12 (8x128 Linear)=
"; break;
> >>>        case V4L2_PIX_FMT_NV12M_8L128:  descr =3D "NV12M (8x128 Linear=
)"; break;
> >>>        case V4L2_PIX_FMT_NV12_10BE_8L128:      descr =3D "10-bit NV12=
 (8x128 Linear, BE)"; break;
> >>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/vide=
odev2.h
> >>> index add08188f06890182a5c399a223c1ab0a546cae1..011026194a20cde22a374=
e6fb2570cbc6bced230 100644
> >>> --- a/include/uapi/linux/videodev2.h
> >>> +++ b/include/uapi/linux/videodev2.h
> >>> @@ -888,6 +888,9 @@ struct v4l2_pix_format {
> >>>   #define V4L2_META_FMT_MALI_C55_PARAMS        v4l2_fourcc('C', '5', =
'5', 'P') /* ARM Mali-C55 Parameters */
> >>>   #define V4L2_META_FMT_MALI_C55_STATS v4l2_fourcc('C', '5', '5', 'S'=
) /* ARM Mali-C55 3A Statistics */
> >>>
> >>> +/* Vendor specific - used for Qualcomm CAMSS offline ISP */
> >>
> >> It seems that this is generic format for ISP parameters, can we update=
 the comment and remove offline. The proposal:
> >> /* Vendor specific - used for Qualcomm CAMSS ISP */
> >
> > Sure.
> > Loic
>
> Since these are not the full list and as I understand them not the full
> structures for OPE - qcom restricting the full formats ? - I'd request
> to move these to an OPE specific header.

Yes, I think the params struct can be OPE-specific and defined in an
OPE-specific header. However, could we keep the enum in a generic
header so that we only have a single enum definition? We could then
extend it later with OPE-specific or non-OPE-specific parameters as
needed.

Regards,
Loic
