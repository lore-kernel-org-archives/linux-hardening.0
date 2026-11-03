Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736355;
	b=kyXnBNG/F8dGRsStEC8KielVOlFoU4jCTPPkGlE2Tt6CL5KB7actmrejHiF5nl8woASO
	 kiC90yAmSqy4Br6VhUasVpewQ3GG9qXDgQwyGMWpVguefib4nkPTeRTzt6CNOFV9kBdsn
	 RM+ui9zLF6PwJxia9EIbTzccK1Jf61FN9NayY9m5hB5XPrVPhOQeYfFYUGdus8Q70Ke8T
	 PtFV1uRoYtaLMI638Fjji1AoYv3mn/zSBd8V++g4srZ/2/8glJa0hM5Cz9beoJuZ/t4ou
	 +a0LB/kMffN3aJ9eNeense/JqhOFcaH4BKyqyCCFItTAat+exmUguoSAlHxSE5+/zHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736355;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=;
	b=FAA3Ai4tGNPw72OimJV9Zx2wzqtqIJCpvU7Ig4E1Hc+Mgx+kxOntyCtMYTSstY0Ym0P8
	 J5BjVl+HAU95Y4GxaD/y9QfV29KLwE9xsRZnJBw2hlimP9jDwnAQXFjvfiPrTDf8S3N5h
	 o38oVHDle3YP5MuUzLeKYoRLfKwIQnc1HnanxuFozMs4yGH6ngTwUXS0KO2ClOJW6Hsif
	 U8QWVwRDvK1VlCWeZkrs0iB5C6NVBD6VPYdRvU/gQM50mjYK2tUhAHtkOGbaqg0YoackS
	 Zy3W+MYUR9t7UWSqe0WRPEla2EPLmuUPCJxWr1oe5hk/qFQ9+HFh27wbOqsETZKzVtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OrdkKGXM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="A8iYZke/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295A606D803
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 20:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D295A606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OrdkKGXM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A8iYZke/
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3Ip3eY121806
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 20:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=; b=OrdkKGXMIYie7ZBw
	gX1jlhQeGe0W6e+SD2J+U938n/FIjb6t/MrnoJrjkj9ngAeb3GyWdxwYhUMijSz4
	c3MESy5kh9H1mf14YhEvsnc9EaKlIp1CnNSmOtUSa1tnBYWGFSqMV5ru+0SCfMyk
	wzcaZ+gwn4ZTlGBFp4Q1bLIHntDHo4XbHS8uKEWRIuvtNDR+IqmjNaUSm5I7U7OL
	TYg/LWQZ7thcXer47bFvIdxhgoVaeJgDwuP9+ryUvJJE1fkf5NfROFm+5+Ov/qaP
	hEgb0CNvqMcydckZ8VngxuvfEki4uNsQX7ujeWJ/FRwUK3mE5jG+4kWryOGCHAeW
	QfEXWw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8mr92b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 20:05:53 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97e8be2221eso745798241.2
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793736353; x=1794341153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=;
        b=A8iYZke/o8wtpJunv+zXr0VhcPeHQyuBbFbYkQwcpmlVicQx65rhK+ksKl8jrhCHc/
         70Sb0Wz7JCgpGTyAGauaFMNmAsHPcVxOtl2CbTEL18SNcCs7mxPZ+WOiRvuWzkyZGagB
         d5CEEdKlu/+Nn1YSPB8wD3Q2bGppdm7fSBUkNZ2EtqpJIz4z7fsOMvdhKHSbTWSUelDD
         BWNeUUcJVWO5OFI3ikqaSbSV/eB89elGVox13SWGI5GJ50HJXQQOaH/6QKKXYxWsilJK
         ogi6n3BpTax+g5xwRotoMus0iyTVO/SwYasf9Y+hP52EmgvpFLC1q3fRmkY/6pPS3G4E
         8g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736353; x=1794341153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=;
        b=mLH8JpRyMTj1Ex+Cv7C/w0H9HCCIg2qRvKxm5yA0SBkfnWXyWkAJ3e8SjOdZDnSBku
         RQuOYPosaapKWOJFZcXd+k7NWyeFH94pGkW1ufGJaStFhpZpcyaOPNpwd9M9nMS/bAXe
         43Nu5YKdZXBzZ/C5keYrXSbci8P612J97dVmzpGYqF5IEnI4Evn8D4GDXp8x421ibtaV
         tTj7RNE/e57v4cLmZ97H5Qu4MgXa8I0RRD7WfGRbFOqxynX/QzlAbHKsn876+cX5ThNF
         90i2dxZHJM0LGDzE7/56PR1yzFHRzvZpl2MihJxD7E//iwQi8/tB5VwjxT38kueUMeq/
         frtA==
X-Forwarded-Encrypted: i=1; AKwUvBzS0jfFhiuh1CCww9+jtxqSd7ZepMzpuj0AeMIiWUTCki77uGZ7oJzIEMnSGMkuooMhC9dQT9qBSE0Z8SaHWx4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JyVM0oQCSYZeSEAay6lCn7qZLTzWrDNI+SYuY02RZ2C9CxNAZ
	GG1PGWW5Ge5D3GnDD0t2vY09cN+09Hn0zmEQLKx7fg004BjbLgXdaHvdvbOO5HDVvGs7+xPKD86
	fUlbOs0CmoWFeJgUpOa07WnSdWnUNl/7byVQo//PyZ23uSJ3bkGwwS3LOp7JpanqmmNPScew=
X-Gm-Gg: AYBFou1mK7tHPrTNZ5/MwgfhWBP7Dp6ERpkrmnAPprudKmCbEkUa4Kq5ubKs7FN0K13
	L9/cYX03KBWdHp3+8XFY5ceTi+EKOFNZmWSM8RfSwYTrxfsnT66efcIvZD4fUKyZ+L4xB9HDt/G
	szTQYzHbEc3XD+w66UDvRZiIPT2RrGmhvrziOdBt+EEyuXl61NzGul94Hznq899sdPGQ30H+Ae3
	81QC4TKk5m5YdV0NBikmnvJyvF2HpnPajZ3SScGryDot+JAITvFPM/ad7GNOv84xsshX9KnTWv3
	2gu0U/SVojBFN+n82jpiZxQy3ByK/Ag/Y7hHq6psA1oQu9gbW61BSu5BOveF0RJkD6g/d/hOjFC
	UOk7fsY/6FaPSyc10uH5qEs7YSh9VRrFjKxWBUtXy3V3uC9Jv54Wsl1eMkZloCPgy/AQAZuJTO1
	voK6fgInGZyFxwp/cRe6FA6IJ+u4K3FSeem5C/xJGFnUrmseSA1g3hRZ5lWQQUj/fKFS+hqFo4+
	TMgkN3JaWOmOFVi/lFrofebluee
X-Received: by 2002:a05:6102:5811:b0:7c3:9a36:bbda with SMTP id ada2fe7eead31-7d0727ad784mr5651423137.5.1793736352894;
        Tue, 03 Nov 2026 12:05:52 -0800 (PST)
X-Received: by 2002:a05:6102:5811:b0:7c3:9a36:bbda with SMTP id ada2fe7eead31-7d0727ad784mr5651401137.5.1793736352383;
        Tue, 03 Nov 2026 12:05:52 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcd03d01dsm358875f8f.44.2026.11.03.12.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:05:51 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 21:05:45 +0100
Subject: [PATCH v13 1/9] media: qcom: camss: Add V4L2 meta format for CAMSS
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
Message-Id: <20261103-camss-isp-ope-v13-1-c2cbf15a39b1@oss.qualcomm.com>
References: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
In-Reply-To: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
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
X-Proofpoint-GUID: bkhSAFASJ9KGCzV5uW3RLXI-Dkr3xmCU
X-Proofpoint-ORIG-GUID: bkhSAFASJ9KGCzV5uW3RLXI-Dkr3xmCU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX7ASa9UI+W+v/
 8LP0Xq+JDhwqcKvwJv7ok22YXUJrSOB2ELbNFab1FIUoQwOGQQN/4En1wOhUsqmmuUzuTGhYnPO
 dHI1/40dtgdnmA8YZJVvaN7VtdHRMf4ND5tKUOjuuy0bPLpEv5ic9rZE6Wz+Be0HZNelGDcdFyH
 BD0AizbuM9VdxryrrCrNSQpLNzu2ZOM/re+HNaVYR02MLu/8Gjf/w/4Gu3zcJX230rlYKTc3cex
 +aueWUl3e2Wg9XEcL9cHuBDwAW3D/3VR1w2FKDliscMWH6r3qjRrtCUFr4mPOaTI67MeLl/nTHQ
 sZytwAJg/XHn+myiYmepzFNtoZ55KU3WZ2tWkV6cecUceXrGQTC6NxbXLR+jFxbxv2JGJnXKRvO
 9hVK7zmGQoydfpeGiYh7MVaMzOOHXKXoe1IOJhhdJpr5Rt58wpOT+wJ/SdK85oqEyuUi0myvH4Y
 W9V6JrfcmteYCruU4Jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX2nAack3nVNAE
 5I+z4VMxCEmtScpquCP0OmU6COChBlSvy1ZUbNS7ts3KFJ2g8OOgphsuAn819aEepA8gEhe2vh7
 32RSmL8ACqEMRq8lDzBHkDGYmbh4+P4=
X-Authority-Analysis: v=2.4 cv=HbWB3SE8 c=1 sm=1 tr=0 ts=6aea3ea1 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=mDm0RygAtmZY0osY0NEA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030080

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

