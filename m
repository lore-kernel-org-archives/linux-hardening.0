Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634807;
	b=EqK9lJmksDWTnRPxb8htco3NsgoCszGa4uADk5XWl9NjNgnnhg+L/7wzREHXwWgCb6aX
	 Cu2bFyxVQIq62CWiFPKcxBpQhTCCxU7hW0mVLKC4sHNu+CjiM37ALpTnfhfpbEwWe6sTM
	 ywsjEBQmWYfr6T/hlNn9moTyBGYejMoSf++4FdsBia05TeWZKzocli6gDdD54s6c10zSn
	 fdkW6NGPpiYdrVGTU9Wf1f/R1NoNeCDQptCpqq96PXrs4JfBFyubj6UJzv3SApjykFrct
	 xy7kkMYVZePXU8q/Jrp+/3Xvg11S/sfLncQBVb+trW8iOH8s2i3tphcMXzvsNaoEvYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634807;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=;
	b=wUVvQXYdCUS8hH070k3PnFKVzCOHs+JZKJdZQ+P8AdM+qlAlGQ0ZBLyvjWLP5eKrgZpg
	 IWgmOdzvqD5C9taUQgSpK6ObcJItade6y0jqUfbQI9qAlYwKcXQv+RlWJDYCRIlLJApnP
	 Mpm4/C68EoVs7G3paPQoCnvLIUyfm611EHDq61S4laBSpooSv5s7C1vW6OXEOJVsRpg4l
	 WtYErEXWiX2toVj5VZKxLltTz/8FsnV+yRZ9PBOxzBTi1tbdZg3+56D4xUr7/cE7ShgDD
	 c+2JIyotryDVmMv557F2KiUgaTM+WqKDkz0Aa1tLd7AV5ucGhuxFIH5TxHxwLI5EMzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pa4dKkB7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ea8nyh+X;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A660A8C34
	for <linux-hardening@vger.kernel.org>; Mon,  2 Nov 2026 15:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 164A660A8C34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pa4dKkB7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ea8nyh+X
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpRnU477103
	for <linux-hardening@vger.kernel.org>; Mon, 2 Nov 2026 15:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=; b=Pa4dKkB7FS/RPmpr
	4MycTztlI2IEOMbUxMKoE2U1BIwIGcXTEhWZNav9AXAMbgLRbuRh+o/ePhzk7WPV
	a4W0EslWihwIAtEmhhwdd9WdslD+aiWIihz02+FIcEAgQg9GWA/Fyqo68zdpH8wu
	A2Gmx1UG5SkR5lkjYGPMJfCpE+nO+XiihC9unReG17IpHCJUgxLlZ4poWXV1w6i5
	FA2MZCew5ueXmQE6l5YH8bxX3asLSvLvBtz9ce0zRvLCvpu96UvdNrD7ea6fc5rf
	Y9tcrqfL6qSSKGN6nyMTDt3D9y/QFdZG7h7i0Q6mOc/qyLNqKhuh44qcH9bYq0EB
	Ctd9Pg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph19ynf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 15:53:24 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-99081ea787eso2656777241.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 07:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793634804; x=1794239604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=;
        b=Ea8nyh+XA0oeddX0lth30wFRUuW7ZmkKz4W3zjE5qGRXar+E81WnGSphha+OGvCyMt
         jLXmm9ncRWjHDlrK71ILiEiLeer59jxAzVT1IS9tki5RTwzh7PItCMHVtNGtesoCnhDt
         z8ckrzGzIgQUBs2wxo94d0z5tMQqdwpi7NKxV3x7NqAvZI1lJiOhWUVCEiOlW0V6NSzI
         +LOuAJbarJ9HtRrk40B2UEz75iz28kH2W41tufUeENumJPX2prqAYcgI/reF+CeLzTOs
         ocThDgh2Deq+e0px6F72jlRw2jib+mphad1eUacauBNPqwps27Yo2Uol+XexUd6tMJkX
         9Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634804; x=1794239604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=;
        b=t2jhbVxYqIQnsAqn6hkbpI+ReNdbzpPW4ihvRNXZZ9qCJWxpb41eKMCVi5zchX2XNW
         wv0hjDbyyzdBJao9gzllsyg/LN1AmyFQQhslX1cZhMyIHib2DAPhW7rVxs4q5HRifTXk
         AuLmfqkW4vP+Jmdubc4bMqkf/DaP5IArXNWlGsrZyRlMjMZoG53Lvx94LdmExKOanX8f
         j4S2q/qcsCP1MEsXUuiadBa4LBe3+4O5nred/1CcTnU4sSIorip6kR4y0TObGiF+tY1P
         lR+Q4/52Zt38co0H0VGMl0jXSFL0ctuu3niKi1XY8BcTSqHaVqmo34+M4tu6Mt8HIm4J
         ApoA==
X-Forwarded-Encrypted: i=1; AKwUvBx0LZz1DDbvN6r2uSHfuN/edVcLjrWUywGUH9cIxKnaAz/MlIFzs26/L6fgi72kz9p235HigqeriVLk1uUYAYU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZPBHNQep/89i0L+EiF83MoJ7wlfBW6PRYtJw3kvMkwjbu7bXg
	5wvdlYe4rLFkG1EFUX2a4i1wxnrHvzcnFRoxsGXhAmJ1JILFdX2Xti2bPF782XGfYoN+FYUSdT5
	6v7QVmEAnRheStEdSfQuRIE4JMzMLNv6cGhFmhltGkg6MC7GDr3PC6G06Ggh+dZ7rUMJ0fRA=
X-Gm-Gg: AYBFou0GnKHm9eP0ZA8h/5lc94cgm95oLVimgbMiwZ8DVWOucKA42QxnAyK/mraUzDQ
	4KD/1puXLemWr9ZAhykFcsU/ipzoBHYVs9R50akzjukfKZvvu2lt9lx7VexDktI2QXEJbZTV9zv
	zRuLDV2SqlS86V5UXgV+p0OcsdxoBPk0HY+Xq2mUeEtB/+GrHBvsyAxyqSMfx1drDIGn7FPBa6h
	FuURp/YsAULZLTsWHCOCi4cQLB7F9qAmIjqhcEhjt6XNbb87KrarBW6sZnZzsMrtmj/6ID+oY/B
	9L/oDMADF9quO33Qh1sbxFkA7TM0VV3OuDlSuLkEn/MhMwV2W8UoA2mbvskoD/wy8xj2r+F9UgX
	nr9NFK9yYPylXaImavuu1DF9Q7/o2mJVxtVvL+tg0YYO1Boir2OWLmZdtBEzL8LgweWJvkYMXLR
	ailwfw7VraPthb5lPetjV1ya0VEwQuWaUU7dP8DFBOxiPZiEt6AyIKBTR0rf4RnYyY25iiuMw4B
	V+Zdz+0zG8+8HXUQ544GRAiL2BA
X-Received: by 2002:a67:e102:0:b0:7cc:2086:34e0 with SMTP id ada2fe7eead31-7d0728b1cffmr3143642137.4.1793634804326;
        Mon, 02 Nov 2026 07:53:24 -0800 (PST)
X-Received: by 2002:a67:e102:0:b0:7cc:2086:34e0 with SMTP id ada2fe7eead31-7d0728b1cffmr3143636137.4.1793634803840;
        Mon, 02 Nov 2026 07:53:23 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a7d1sm20700323f8f.38.2026.11.02.07.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:53:23 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 16:47:34 +0100
Subject: [PATCH v12 3/9] dt-bindings: media: qcom,qcm2290-camss-ope:
 Document shikra compatible
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
Message-Id: <20261102-camss-isp-ope-v12-3-702254689feb@oss.qualcomm.com>
References: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
In-Reply-To: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
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
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: SOdM7_mfzxXTCUpDhfas1CccV70f-cEN
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae8b1f5 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=yPTVd8cUMD2GasGf7IAA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: SOdM7_mfzxXTCUpDhfas1CccV70f-cEN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX9f7jbSSJaUoh
 LzA1+6W/TQxPkxF8XsL0K+a/qtegmkcwTk4jFZAx5yhVpBO2SBvBO3K526ORQAr7nQvICDlFCN8
 IPkPTuEnwMJGDHvsZK9Zwtc+TJPHkkWIAwUTuhPdVJLNba+AXq/fgTwjR7xnLEHBjH4+jawdPVz
 xtFSwnLQrqthah7iKEJl8QLFf886e7Q8a4ky3Rqcp+Mw/9gZvuBYSm62iyWklTlWPAy9LGQSpXg
 4pp0k1pRXltupM4sudq60bKmQtyWXjLhVtwnNfkFkMbW3AB88ZGHVugEuAkCBCcm5bjulfToUPo
 ipdSBXNmOhOMC2iyK+I4oA0vpEYkPLpPlDaeX8f1Qq8COHszLJ2E33DtMwuPVtY5G3wkMYHv+Vs
 rTu2QgLSosuNw/zCM+14dOUikLQ4DeSdTMnpytebIkDcP8jwpFPReSN5aEuK4GpT+tEJvqVH0kL
 18ZQ2WQcaVhM9ZJ/5sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfXwDr+PcPD0X8S
 QilR5Y1ghiy5kWBwODqMq+OYMcUXVR3ft3ZKrB8VyBnESY5069VXTw0yHNWP7LO+zyS7BUb4wdG
 NipeZPErsfwfax06m9w553mwQGLJ7sA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020063

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Shikra uses the same Offline Processing Engine hardware as QCM2290,
add qcom,shikra-camss-ope compatible string with qcom,qcm2290-camss-ope
as the fallback.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
index f9c31bc88e94b028c241060bbd8e56e0bdc49af5..3359581bfb13e918bb4efb3bc41749e60d772ef4 100644
--- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
@@ -19,7 +19,11 @@ description:
 
 properties:
   compatible:
-    const: qcom,qcm2290-camss-ope
+    oneOf:
+      - items:
+          - const: qcom,shikra-camss-ope
+          - const: qcom,qcm2290-camss-ope
+      - const: qcom,qcm2290-camss-ope
 
   reg:
     maxItems: 6

-- 
2.34.1

