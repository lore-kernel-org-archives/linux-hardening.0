Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDE3BE659
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294013; cv=none; b=AoRNrfu+vH5VMH606dZB9Yj2vzvuDy2NslvEgA9+pUC/h7aOCFXS9yIuBwAg+MExNXSKVCsP/C8J8kehMzjIVCtaR5Jq+l1eykCcfJ7I+ptxo3dXy3jnJFdzvTSWzNlDjv/C3Z4x91NMJAKzojTlOaOm1XAb414VCvq6zaOx4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294013; c=relaxed/simple;
	bh=lPbPNpJ2ajYXcbSU6CUgF1cdOaknw2iS5g76PqOTMJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/yu4evCjbdb+xOPSeZfYPa446T+hehLn/X0y9y898pKNQtlQ7ezNfjQin8ftAs+QEvYfjZPBH7yNjibQE80A3TzCP5PCekvarnt7RFLpBaf/NQzHtZw4A9vqRZ0nTTc3kVue2/cKYnhfDYRKgfMQEK46JqFBljquqOCe1Qmg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kbDvfWxb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iqlwG8O7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kbDvfWxb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iqlwG8O7"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TAYw2793074
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+rZxWV2BVzHNmwNyI4KXBWCRAzv77VAsdiAZYzEAZKc=; b=kbDvfWxbKpo8tYce
	l1OaVfKx2eJfaNCcN3nbhN2Lz1E/0sxlqzqE/RjKegt0WTh9cMYUFgojSREZ4iho
	2G7DoUdE2u87qIdqOfGsDgpSnjO/UeVqeaYIuYoPyPjmcNh269gdn+l1EVtu3ZgH
	+3qRqwo8MA8ftaSrORJj6BJ05Gmb+NUUib8F0+6TEmz3dlVjcszu1YOtB8EGELvs
	Dn9x5RQK9EM3RuD8CMbvwpS4ah+fXLPlfnifaFrHDDDHIDer/qS39P+6RjTWwLA9
	xMFRRJfGWaH9MZsyAroL7IndcN6/4lbKkLRlYs2SO3fbHmVd7LmyHKZPZcA5u1Jh
	BYXN4g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsa4uv6wk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50edf0245b0so35499931cf.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777294010; x=1777898810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rZxWV2BVzHNmwNyI4KXBWCRAzv77VAsdiAZYzEAZKc=;
        b=iqlwG8O75Zg7jCNRHXfk5Vqk7CUxc3cbbc7NSwUjEZ4ftprGERSPIwg82wPaYLTnlJ
         7UKNtS/ToV8pRjmmHd8d8ZklUizB5k5o/+kKc7BBnTC2sNu10y2nlcZSkSdhmQzVwYXF
         VEy020Y0HWNpUpFhaGxBchZcuHkZSppoKPNmCpYnV2fDnzsaxnEWNCAqeoVJYCFC3Pvm
         LEVh4U2TQ0LmyQkw6k1PwmsVD9WNZZKOoqoqjp4JiYjh+SMR6BOdz7YKELwExpKn9OgJ
         IQN/ymehbm/oEzd5nCv8Fow5Zo26lEnApjQKl4tD3crygFuaBMypmg/7mQF05uuNlR4P
         atFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294010; x=1777898810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+rZxWV2BVzHNmwNyI4KXBWCRAzv77VAsdiAZYzEAZKc=;
        b=gFKvu7s/5Syuefje9gzFVt+tbDYr3gcxvIg0qGxaSLDkgZ1T/JO7FWkEA4auXPFprZ
         ZDD0WoAFbV5+rzvoIKD29qp1JAoEs7sa9w3E8YVddZMWu33iwd2wyveqbyMiU2vUluAJ
         q7jXdD9x59586LpE77BYwVq2/CtMyARafiPkquu4aS7gHdCTqD1ty00VFx+czxoTFMN0
         w5Ae/yMdvLkPOt5xu6wtcCy7+2kg0h5J4dM82uL+PEDO9UoUO1Z0HkE6fauHwbFpZBnG
         5XzddO4d951XSWKXz+pMryKIp+fdIr4gortWC+oUdDWjK+zCMW6YNNrlipRuGAMWQ5qV
         VrrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SealAwtVSrbORDv7l8BbEQvXCWyS+UYFflYjHby0kRndlHOgEZpp+rj6DgeipMvS3cTUTfHXCoFcvKZO/XV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjHKpSB/zC+jF4AJfAG2rMhiKIt6yRmRVpo7qKGLBgCTy7l5d
	IjEmeLbQBC7gvfJYEXJT3kssH7xrOmpMrB50Hg2Q+aKuna4njxIlzkSuqjDdJV4aq1AVlCDLW42
	OH9unyqrT7HUPo4wNkdj3iImdT9xlHy/3IG6TfVIIrNqyCVzA6kLh/Fsz5pAaMR57D7YTw8aDqo
	f26ZsuBg==
X-Gm-Gg: AeBDiesurdyAH0N17KElOZ2DepT6jmtQ0FGIY2qczSaA3s+E81/emEjoh+Bt7AGMINb
	iePhdKE+qpWn0OFy7YpijkoQlE3K/AJwc2YIPjhPBaayFl3quR/Nob8tPL7nuIqdjbvT/2fGt1K
	kQyxJvEFYLiNKiF0cohd3Dzulhcz+EA3yO1Y5GoyXJ31HdCZR1r+u7XTa6Zdcru7fh50fHgFoYk
	ZZEHEVkrhcBjRdcie5uayiY1Zjh6kgdxJxPGtnUk848DzNBy3FCxfCi95mpKflWIELKK4VmMssJ
	qPPEyZ89nmT//unpOT9202p7TDa4PMkqF0Q4tbnGNrRfTW002uIq67HgJNaX/AfMOUwQm8krami
	139hdtLF3n+EKwy90SgG+zVKFtmOxj4Xa1uUinaXOlJ3er/IICXd72vn1w+EnUaSJ+JZFeBwUjg
	gsFY9ojH5BRArAhIHVwygU2kxFqo0=
X-Received: by 2002:a05:622a:65c2:b0:50e:5acc:e792 with SMTP id d75a77b69052e-50e5accf287mr351235301cf.14.1777294009731;
        Mon, 27 Apr 2026 05:46:49 -0700 (PDT)
X-Received: by 2002:a05:622a:65c2:b0:50e:5acc:e792 with SMTP id d75a77b69052e-50e5accf287mr351234781cf.14.1777294009301;
        Mon, 27 Apr 2026 05:46:49 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd19sm1091496866b.37.2026.04.27.05.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:46:48 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:43:35 +0200
Subject: [PATCH v2 08/14] media: qcom-camss: Add image formats for Qualcomm
 CAMSS parameters buffer
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-camss-isp-ope-v2-8-f430e7485009@oss.qualcomm.com>
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
In-Reply-To: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 6m_Vrt89T4AC_J583zWV7jhaEXGO8Kx1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzNSBTYWx0ZWRfX1tOaoetppaaC
 jPD0NxZwGIq1cVxxkrS3hkvdM10w1A9BkbVBXNF9Joiei+dl3GnNZRYBrpbUu7aNzQP3L8izfex
 psAk1Y7q9Q4AerLKS4HdAfYMYMDN7+oWwlsXmQryqanEkvxhTyqYdZ5hie1dZm+MtZXNfBOaNQF
 YZKS2iW8RqbLHqC662PqNOv63eYcSAw+rDIfrCsJyV9ZoQVcdoiMIdUc8cGPNYO867/kA1CiM8o
 khmi4ZZEdZw+UGjDZFm9C3xHMAmOAcgfoh53B7qU9LxSpbzl473TO7+jleVoHuv2QBkV45c99WV
 ffTU+Ak9gz//L2mCO0dGiDGvRxnOSIHLbiYpQsZckEPMoput4CXmWIVzw4wvwKxj+DLKvarE3xP
 mN5coBDGCNWyyZ8QmWi9ztYDSPmGAU8vQTuHW6gY/tSMB48bkbzN2Nemyc5UvfH67u4ZxrJaN+u
 jDprdaZLQfErIre0QpA==
X-Proofpoint-ORIG-GUID: 6m_Vrt89T4AC_J583zWV7jhaEXGO8Kx1
X-Authority-Analysis: v=2.4 cv=J/GaKgnS c=1 sm=1 tr=0 ts=69ef5aba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=QedBaXGEmMrZQ1XkLmwA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270135

Add a V4L2 meta format code for the Qualcomm CAMSS ISP parameters.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 include/uapi/linux/videodev2.h       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 98512ea4cc5b9d725e1851af2ed38df85bb4fa8c..7b6e9a9a514f037190d55d59409dd6cc97522943 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1471,6 +1471,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_C3ISP_STATS:		descr = "Amlogic C3 ISP Statistics"; break;
 	case V4L2_META_FMT_MALI_C55_PARAMS:	descr = "ARM Mali-C55 ISP Parameters"; break;
 	case V4L2_META_FMT_MALI_C55_STATS:	descr = "ARM Mali-C55 ISP 3A Statistics"; break;
+	case V4L2_META_FMT_QCOM_ISP_PARAMS:	descr = "Qualcomm CAMSS ISP Parameters"; break;
 	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr = "10-bit NV12 (8x128 Linear, BE)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index add08188f06890182a5c399a223c1ab0a546cae1..f861211ebd7aefbcf4096885388069efed27ddc3 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -888,6 +888,9 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_MALI_C55_PARAMS	v4l2_fourcc('C', '5', '5', 'P') /* ARM Mali-C55 Parameters */
 #define V4L2_META_FMT_MALI_C55_STATS	v4l2_fourcc('C', '5', '5', 'S') /* ARM Mali-C55 3A Statistics */
 
+/* Vendor specific - used for Qualcomm CAMSS offline ISP */
+#define V4L2_META_FMT_QCOM_ISP_PARAMS	v4l2_fourcc('Q', 'C', 'I', 'P') /* Qualcomm CAMSS ISP Parameters */
+
 #ifdef __KERNEL__
 /*
  * Line-based metadata formats. Remember to update v4l_fill_fmtdesc() when

-- 
2.34.1

