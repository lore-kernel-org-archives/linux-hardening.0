Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644503DB96F
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674303; cv=none; b=lBA9YuLspUEsiIOMcJEpMPGRIE5yE6js2d9tAMARxpYOWFT5cO8hX8fdV7E2grCv1nkFD8JVclI6HxlZDhAzDLMOS0HGbJys8GPLyl0yUJaW5RP761ls02a0ZIWwPYj1IXbw3VM4Yy2AI4TPVqyh/V2eYNlGSGlcYXXXpiOgOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674303; c=relaxed/simple;
	bh=njrkKm3aiN5Zc7CJQtaFlW6IU/Xu6yimySfqW99zRic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYwBO5JYzYPG53RTiJxImYxn5pS5DBdZLt9ej1cUwHahhx+6/zJoGZA0bqPFEC7Zp8emX5hFo3MuvhjN0TW6+TMAs+hhts72d3gQ91ZhZM4o2H2V1BrbLqCzQN90/l55q/ii1ZBOCyq2Y5cttYueLrAZgIBsj5iCruUWCvZqZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cawtc6ER; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lyq80u5K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cawtc6ER";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lyq80u5K"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dMaf182265
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hGScOXxHIxlcFY4BY/Y1OfU858ahh8r8M2ytmxZhzuY=; b=Cawtc6ERus/ZEH6Z
	crkdPCDD7Sf9Inkuuwb+pM/J+Ahd7qgTlt9mv6SPtS+PiIYRjfkJK4DKb85G8Yqj
	DQ5NUQBdBMaZFzBMRZtKy3BUKYbj2y/OcSD3XlqtshVQJgnC3GqeSHMRChw9lIzN
	M3rRaQPM0j7K4tO70Jv3HG1JMCJ4BLVw4KeIrlwOb1QsJD46ithUCnEiCduP9ydM
	kC9pjlJgDQg5J8doFCzJI+HL7SnUsjreGlAjEKj1fhyUI0oL3lcnT3RmjSd+c9JH
	5QOViw6yhoxIwjZpeEDsF5e2FzpDO7DZOL9DuaYdCEhYMWrA6Ykd9VWm+kluXYqd
	/dsbXQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte2ab3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1a97644aso6267241cf.2
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783674300; x=1784279100; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGScOXxHIxlcFY4BY/Y1OfU858ahh8r8M2ytmxZhzuY=;
        b=Lyq80u5KnKFWh6QAVgFsML8rolGPzuivTf0gEqjI3XPf8uBTvE+DskKCs4niKQeSSI
         jMNmnNzw+osWelcYaGVuWETuJ1EUFTrqVhrZCVrTG9NTlJgvLePxITnu52ESDafk/rW2
         YvffJ/ffTeZx0/kOlJjBkqCjyBlhPTIsf6An+hd7rGPSTMUFi3kdnt8712EWt6m17k4m
         XEEm/zvcMInQ3DAfF5Mub2o+A9NXFngGt2GZIfTwOkCztRatJudOuYxkI0wCnQtyVCqq
         8LdmimtoQgFhHWzcwb1XItBCDBpY+hPhXocAGdm7Y2ygmUSJyMHYRxSmLA/8avk3fnzR
         TbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674300; x=1784279100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGScOXxHIxlcFY4BY/Y1OfU858ahh8r8M2ytmxZhzuY=;
        b=hl02fFobjoI5ux6iNo5CH8lzXMDbZKONJt6El1XBqzk3v6oftA6/CsJRgyMfyA1dK/
         g+Pkif5Zy9ozNGDrANJJQmaDIoFqv78Ykkamnw/lM4wCf9M/IODm3PQQ0uTyxNTF2B8x
         RAN8N/NUApmGgXEGm3pr4plAaSCvoGv0kxX9g6NhJLdLvcmK2dz9yTYx/O2/mZJ+vc2i
         p0WkhvzxA091mGWgyZZ2RNJC4f2h/LNQefw/razKlknEK8A1kyH1ddPKUzD+w10igv8q
         gqztHOg2U4arA8chb3ICnc+nTzWvRxKvGCAxFDc6RNaSbsN27JOwYkNLV6b/BD1NS5dj
         MMdg==
X-Forwarded-Encrypted: i=1; AHgh+RoNw57RHXok7K1W3bxbbowQzD4Yv5MHe+ffnDQCQZIih1FzsW9R7n2AJj5ZlbOIjtshc3/0k8yY0ctTSrRX6kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzszfogUvdwyzqneuMvUDEEtOrJf83x0wUrkhzgJyxZHDr94iLD
	6eUuu0glAP+nyMiAPGC/JTysXTtJNrs9hRfXARzsnNNSQHg/h1v77Mco6PTmMUmm6bdWoI0hYIs
	G74CeAleLmewvZuj1JbizWFahmdBJMKAhxb7GFxX0ob575fsXKRaFdGRNSQnmWbMLM9lutXA=
X-Gm-Gg: AfdE7cmWlTpeV6aFKj0UBYo8DOVsBYefQa6oyhl94ZA9j/mz2SK6zMIGuOE2cgubU58
	rfzjI7/uDl3v15baz94FT4muKivZXxKF6HVfIVSWda+0fk7cdxormsTR9FMiI5TsHRAgQvkHkaY
	D6wKnVVoJ3+CXxIJquswhtbAJSgPo4bnT7L7GEuHQGo9Z5fE2s02ikwbiMUj4NoazY1EwDLMrsg
	Bjox4779ji2BUvEGDWo7lMMU2qJUzwffCoJkkNY4g4K6tCPfAg/7GwcY7U3N+4OFC3zsZNo4CZV
	vBaU6xy4Lo/kQ7+lMklUdIb4DITMHzjLZMUE3yaPh+sKxJ/ceaLvlh4J7UlZxxsCuV1w7f6+Y3L
	NHHLilSouZG/CiPih1Exda+BMbdQ6/fQu4wPbMtvI1JnpbpZMKqt6y4epH243SZQRNYBnC3lafz
	qaW+2hVCQA3z9syyVCreB3e2wiRuV+fKGg9QvcGqtcbPmFiKKanHXkmLb0+63JXA==
X-Received: by 2002:ac8:5ccb:0:b0:51a:8d31:9a06 with SMTP id d75a77b69052e-51c8b403b76mr120422731cf.16.1783674299602;
        Fri, 10 Jul 2026 02:04:59 -0700 (PDT)
X-Received: by 2002:ac8:5ccb:0:b0:51a:8d31:9a06 with SMTP id d75a77b69052e-51c8b403b76mr120422501cf.16.1783674299240;
        Fri, 10 Jul 2026 02:04:59 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm259932266b.36.2026.07.10.02.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:04:58 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:04:49 +0200
Subject: [PATCH v4 3/7] media: qcom: camss: Add V4L2 meta format for CAMSS
 ISP parameters
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-camss-isp-ope-v4-3-51207a0319d8@oss.qualcomm.com>
References: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
In-Reply-To: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: KlJOyI0H7tLksaUJiTF2VZtm5OgnY0d7
X-Proofpoint-ORIG-GUID: KlJOyI0H7tLksaUJiTF2VZtm5OgnY0d7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfX8ORHfDEzUqsD
 AgOLJM3XRYKoLGZYhHIuK9snqt4qPkNzjbooPqw4iFRxzxqSfP3pngmuJHvlUsZzaHm4sTXDCyC
 ufcNwNChxEwlo8OSZAHvPjTa+G3CyTn96HL4wrsESA9Yzd25h9dE0YtufZC7Sw6c9s3WgutHHaO
 dYgQogI+Mzfl4muQv8zsX7fuzIRFgR4kAQ8WZCS2uiooSxlsP7cPKYFYYAqT2C92fpHud2+rXNk
 MCCQNNn6Q0hWwbYnslKoI5H5Yu58yxbHGsTRQPQ7TZ/MVtpak1Y1qNjA4xRsuQSz9ALGn6wXc/s
 qinyuFxFYUsXJWceOb+xohYqRgrFj+4L99Hf+WGbgBlYkzoovnsAvz7v2sDrofipoHoJHP/7GUh
 kdZPUQFRjbVr7+xO4FntFeiNEQI1uU8DTigB6qBKlOjZj5bRCmIuSWBdlGewlGUDQ9en4gInk1V
 6hPnIwV0Vt9VVZU1bgg==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a50b5bc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=NHZ7RztTnFrf7oJu4FoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfX0GhJwy8STYog
 Az6k3E0kV9JF6E2cC/GAzpybZ9Qn4m8PprgM1dKUEcO0yPTdYcsE6Tr0JhtpJerGMjktil4QY3A
 Q3fxejZRdmueBNFMuYEzWPk812TB+08=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100088

Add a V4L2 meta format code (V4L2_META_FMT_QCOM_ISP_PARAMS) for the
Qualcomm CAMSS ISP parameter buffer. This format is used by the params
video node exposed by CAMSS offline ISP drivers (e.g. OPE) to carry
per-frame ISP tuning data such as white balance, color correction and
chroma enhancement settings.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 3 +++
 include/uapi/linux/videodev2.h       | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 98512ea4cc5b9d725e1851af2ed38df85bb4fa8c..01593493dff63491a36cfebe404d26df34c95838 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1471,6 +1471,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_C3ISP_STATS:		descr = "Amlogic C3 ISP Statistics"; break;
 	case V4L2_META_FMT_MALI_C55_PARAMS:	descr = "ARM Mali-C55 ISP Parameters"; break;
 	case V4L2_META_FMT_MALI_C55_STATS:	descr = "ARM Mali-C55 ISP 3A Statistics"; break;
+	case V4L2_META_FMT_QCOM_ISP_PARAMS:
+		descr = "Qualcomm CAMSS ISP Parameters";
+		break;
 	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr = "10-bit NV12 (8x128 Linear, BE)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index add08188f06890182a5c399a223c1ab0a546cae1..011026194a20cde22a374e6fb2570cbc6bced230 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -888,6 +888,9 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_MALI_C55_PARAMS	v4l2_fourcc('C', '5', '5', 'P') /* ARM Mali-C55 Parameters */
 #define V4L2_META_FMT_MALI_C55_STATS	v4l2_fourcc('C', '5', '5', 'S') /* ARM Mali-C55 3A Statistics */
 
+/* Vendor specific - used for Qualcomm CAMSS offline ISP */
+#define V4L2_META_FMT_QCOM_ISP_PARAMS	v4l2_fourcc('Q', 'C', 'I', 'P') /* Qualcomm CAMSS ISP */
+
 #ifdef __KERNEL__
 /*
  * Line-based metadata formats. Remember to update v4l_fill_fmtdesc() when

-- 
2.34.1

