Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973329;
	b=deD6/cDbNere3hKYfQMvZ29uOpdY6QxwYmw2im2uk3VdpTx0VbfNDbX98KfShj/XZRQq
	 FKtpIATJjpMycoC1Alc/+GaiJ1rBmjUUFvF85l2Sv/TLFRuLkYvFcVUrA98ZCsjDbdd6A
	 DDb5PbP9+/iPk1u7gqjMHXicsojHJAXdz29mp+F1rszGm/2oun8H/miq0y2KgoZ80Vduh
	 5wQ/QYoLMyT/5j1YVvn7+0qeysdcAzQfxtr0MpEardTiIOwH/otPHTfL66J7HOWuS7G0y
	 phvET1V3hT9Uh0PGERARk4e36AiWC64p+Q3wD8QKvL27ULnls3dLDaxLMhBsK+n0nZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973329;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=;
	b=MQKpRpV5oFbrE2H3Dw3KaFxrCcBZyg/GVNkndkJMGYbLyUQcuJQjgJJQzruXW6cDnKbM
	 YS1V2ME1iYdbq856sRLejMJr6cv1kuYcgqmbvzJYVGwsrbpyOYrsOtZ+s5kbGiy5giFNF
	 d4s0Htx3EjXN+gDDqPEKxOsElu3nE1M9Yim35yBQ46c/SbMr9S2t/PpWjyF/4Ku+iP4Lc
	 //AW8Uxvz3fbC5G04VfVjiyryVVddxSinr7iqq+GBx+qJYGyU/GPRC44Da38fvP0TB6Vb
	 sWbqyZIM0sgvxvU7PFFnCGWn/eML1jQoXt1ebGh6h9JV31dSMY9mM99WUfEiBCQloaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bm5Znuev;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=de+Ll0Td;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E03606D83B
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 13:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73E03606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bm5Znuev;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=de+Ll0Td
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DoH0h4147422
	for <linux-hardening@vger.kernel.org>; Fri, 6 Nov 2026 13:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=; b=bm5Znuevrh4SmsgD
	vb6RvI7iPS2Fr56sekLTNlHWe1dwdGAcyEAwWtZRcQMaUMpi2827p8iz5X0w73C6
	gM8gsIdM3YDa6mN1YUYOTNTf0su8wIjuylpKeXBx7lfQ+zVSiB3eEJTtkkMyZde+
	sCMr+9DiT5MeeBEJdblEkKQVe6cUswnuspjc6QZlyLtAnN6rdTqB5TUibrakXBbC
	nKc/9yTZwxiJtJvoPJvxH7Aj6r/NsITdvweOxIE1xXU01WAITbBQLM1QufkfYvzV
	DqfKEGR5ae2YOhA52leR+Zinzd5TjCrFVUhVQ9icA8GFKfzPGVEJZcHad7JvBbs2
	p0HwyQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa32q6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 13:55:27 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7c0f07b4e97so657841137.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 05:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793973327; x=1794578127; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=;
        b=de+Ll0TdO6I3gn28LBdVHqdTL21TYIs3UW/Itx4mJT4H1C70WWUx2q7hh3OWlywq6s
         6AlwHNnzCt81CPbaVb8YHTfiwtEmp5CvLbjajapScwB1/0sMpjtzs59iTMK/Mov55Lli
         6BcGRKxhS2BmX2mOoXkwD/rMRya2x88hBuSb7F/zJ6omKAMWEsK/TNM2KqRPYLgP0Y+t
         gDgrR8g3nvQKwA4AMDY1a+NrYNBG4+mQMz4Dy3IyGWOxgXjhiYM2BrMwA86ylf4mi9ln
         KvHs7Lb7WgBZnoGNLCQ+3e+qTWXnvqiFOeLNn11jFgo1byLE47ZF9lzmaRqp9PwwpchR
         lO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973327; x=1794578127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=;
        b=wPcVh85keaE/JemwqE2bsLySjEjHVdM7XZhKD2XuCdSCFyTi5T4gkQ9y7F8tygd7qn
         a2mjIkbjD8wKPqsnk9EQNbzKZlyVOHVT1NqVIDRwIXaXKPc5dZoFMXJz0upFOdDZT+U1
         TDTjtO5dwiEk1+0ImK8GneXCgZIX45ybuVZ6Iex3xtS7suRTZcK9PWKxH0WBjwhSZd/J
         HxW9wi8mbxjCXZEnXJKqzOD3YzyGNOJcjad2YYn//HJ9Nwkuw3iNSAGTrOuBzVUK5rVL
         3+VV8fVIzx6ALkiJdPMRYivOzMWb5nazcOmz6rOLKEcuEp/U5HtpB7KTBF6fbYcPhppe
         /0iQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXdf2kzKNrRI2WkqDDDpeDOhw2lOhlqPBhO0uAIq0cD6zqDn/jIon8zGH7SGS4jcJPNQb+YDBrpjm9Qib5/L4=@vger.kernel.org
X-Gm-Message-State: APuU4Z92QxUn5TE/ZbV7w5igig7gtpbBeHyAMMQvafe6TVLJQakHjinU
	hdmFz4dd4w5HMNvsCiejIb1CJCuvHDHWs0HGkypuj9aT5Z+V7OG6oSTnK7mW1wTqLIlVik9xoLL
	0IeWTMY8NJS/tTav3tElxURS4eBfJy+iuv0fVMifs1fI9IZL+pnky8MjQpxA9pTRIPKoiEqY=
X-Gm-Gg: AYBFou1JRLNsC+Nd75dFZ3ziRvMYlX5jiGNX2C9cOFkQvBbMMsqFcwgxTkJe63gCS//
	FtALI2r2sG7DffX+MMY2o4c0D2g71+rWexOw9CoGHPm+EPnzdZUICTkM5jG/ySxLKOPgE/DxPUk
	glcUw+JW1V4iS7zLbm2wd7RFo6r53JYw8+mp2j4OPhUH/TKGC1/lOW0y14rcWIefXKuw/8Miq8s
	hI1J69+jXB6gS1jsxTnJDYJgpBaFzHsOUCRzZEMA36OE4nGjzh1dxtFRrBVmSLQVQlm9yPniuUg
	qYmczb6Tqw7CdDtZVbkfqWUsgapW58BX2INarCfeZXaFid9W6s2GTDfNHu3hbw0esPm0Ppa4uNG
	R0n2bK7ZyQ5bALM2724e2Nyyaih3T6iTJmZw4jvQ4kWtbt4kx66wo7vguQyZ8kkAG/Fi+fUzbTu
	MpRLsXH5QIAN1ognphXqLDw/Ro2KayP7/VnHHvg38aGwAOftXRoHYbrtiaujnYcQajxmMf1qit6
	D0jbIAwjc5KeKUhOWaavA25sEHN
X-Received: by 2002:a67:e70c:0:b0:7cc:828b:421b with SMTP id ada2fe7eead31-7d2a15097e6mr1816167137.6.1793973326665;
        Fri, 06 Nov 2026 05:55:26 -0800 (PST)
X-Received: by 2002:a67:e70c:0:b0:7cc:828b:421b with SMTP id ada2fe7eead31-7d2a15097e6mr1816146137.6.1793973326222;
        Fri, 06 Nov 2026 05:55:26 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm3963256f8f.51.2026.11.06.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:55:24 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 14:55:17 +0100
Subject: [PATCH v14 1/9] media: qcom: camss: Add V4L2 meta format for CAMSS
 ISP parameters
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-camss-isp-ope-v14-1-49c426cd2715@oss.qualcomm.com>
References: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
In-Reply-To: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX4Hrh37+eyzc7
 BHnN9tGByTzM8xsKiCTEFjO0d2P/vzJJY2hnF8ZKw+rv/FRwSCSFXFYiCNofGvYh1oNUL9/jomx
 fZ/BUZRlC1KxyeVW71BWBkjse641XG+RuFKAcGANWNmkDVqeQnpmFRDocCtG4TfmFwoqmP6SmDX
 uj2rYSAa1u2Pdpv+KoeCmzyGW0IRxLa+0eUjo1yamMVq2tAi85c+3SKWv6nKMI9OYKJd7O/7uzd
 y37tMm3AvdF9USOKHEjBFlXBYMclOvemlmMOYfMHqo7Lq+cCew1pI6mwu9zXp9NZqDKKZchfJb6
 GCibYvXcKsvf607kRlrJdVaBTZCXPC4WcqY5xBHoi5GQlHzi6mr9i4ze6MQRwP3is2hdEsQlhS9
 UUHR76uMor8mMA2YbhxppKFjObjXFFRYbjxCopRSGQmHjFCJxSbK7q5xUpVT0AVz9+82gxrgCJU
 fHOCllfj1f5jslgdJEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX8iL77bsOlquO
 PHk2jZZM+mlT3zM0B4PcyM3xpmxi45Hq36YYVVTyEPyfETzKm0J+PBKnk/PJbOybnQLIXbkXPyC
 DRk4ZX+HDcTWhh20+0454FDniQycBUg=
X-Proofpoint-ORIG-GUID: zAZeJTXv5xxkHCoC1NllNNC8ZA7bUCIK
X-Authority-Analysis: v=2.4 cv=GpzXaU1C c=1 sm=1 tr=0 ts=6aeddc4f cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=mDm0RygAtmZY0osY0NEA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: zAZeJTXv5xxkHCoC1NllNNC8ZA7bUCIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060055

Add a V4L2 meta format code (V4L2_META_FMT_QCOM_ISP_PARAMS) for the
Qualcomm CAMSS ISP parameter buffer. This format is used by the params
video node exposed by CAMSS offline ISP drivers (e.g. OPE) to carry
ISP tuning data such as white balance, color correction and chroma
enhancement settings.

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 include/uapi/linux/videodev2.h       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 17ba1ae707355a134047de646f61fcc2d1512d4c..cef1593c1835070f7b34a8b8c860738fb77f533a 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1471,6 +1471,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_C3ISP_STATS:		descr = "Amlogic C3 ISP Statistics"; break;
 	case V4L2_META_FMT_MALI_C55_PARAMS:	descr = "ARM Mali-C55 ISP Parameters"; break;
 	case V4L2_META_FMT_MALI_C55_STATS:	descr = "ARM Mali-C55 ISP 3A Statistics"; break;
+	case V4L2_META_FMT_QCOM_ISP_PARAMS:	descr = "Qualcomm CAMSS ISP Parameters"; break;
 	case V4L2_META_FMT_RPPX1_PARAMS:	descr = "Dreamchip RPP-X1 ISP Parameters"; break;
 	case V4L2_META_FMT_RPPX1_STATS:	descr = "Dreamchip RPP-X1 ISP Statistics"; break;
 	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5373dba640fae3d19247ab1c74ba336e05dc0fe0..70208a9443d8ade569f130e2fc3d6beebab6b636 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -893,6 +893,9 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_RPPX1_PARAMS	v4l2_fourcc('D', 'R', '1', 'P') /* Dreamchip RPP-X1 Parameters */
 #define V4L2_META_FMT_RPPX1_STATS	v4l2_fourcc('D', 'R', '1', 'S') /* Dreamchip RPP-X1 Statistics */
 
+/* Vendor specific - used for Qualcomm CAMSS ISP */
+#define V4L2_META_FMT_QCOM_ISP_PARAMS	v4l2_fourcc('Q', 'C', 'I', 'P') /* Qualcomm CAMSS ISP Parameters */
+
 #ifdef __KERNEL__
 /*
  * Line-based metadata formats. Remember to update v4l_fill_fmtdesc() when

-- 
2.34.1

