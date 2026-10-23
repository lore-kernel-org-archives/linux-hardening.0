Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768178;
	b=pA5lGDcdm9xzOANy7mBb1/2VAAyOdEEcWF36wbEoXCFUW89eSgN+aXTa86KTGKf7VcK3
	 KHHNJuSpCleoS/sli7lFLefpllxp2krrbHWYrlsTCvlNFqD4Bt8sdqBgzkJeMfsp5dVcP
	 QAD8Kw4/3WYhXmbliAe74bShZdIZzEyLZmw5LwTdqXJPDSNdS9Tw/aR4wHrT03aWR9r/t
	 juw2wFecSJuUHW0YrrlCVtImJf7GFNzozELqzV0zQe8ytUuLjyExEjF75/UX1rQMgeNVv
	 u/IB/7TtNPuVUptFtRklGLzFxh/65QxBs50caGg/B2XuTJRiF4kHaiXyg4ItAPeGdRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768178;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=owC/0Uitd+RPnqSaxCQ8n2UoAK7Gqnd+PP1VG0zdCcc=;
	b=q2JcxzUcV6w9QZ3mDHwYLL5FGY3d6MbJ6iArYcLKUwh5I2mRvJ0l+0nEESbg1lQJ4JdI
	 BAkvK4OZ1rTBFgJbnD/xCIcC08DsXVmWaM71QAT3Tnyzg0pmWNSr4lShzR54M0GyjKAgy
	 PePfwBp/ra4SXWIR8RGuBuImrlpcRVna3j12mj6d5+Luz8V+xlcMexIS3F21qZrhdw0nl
	 S7NWvWJ0G12Iaq6nNDjZA3ve3xLS2WdhXaJlOKFKpTDSwtiGcq+N23WFwiCGxpRAUa6+Q
	 FVBSU47wuZQsc12aAhSICtM0MEMmebvByAGFnISLJt4IV3+MGnDKV13SIXGfcm4wy5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gf+4Ox1p;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rt19+j7Q;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01F606A32C
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB01F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gf+4Ox1p;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rt19+j7Q
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6PdZ3000292
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	owC/0Uitd+RPnqSaxCQ8n2UoAK7Gqnd+PP1VG0zdCcc=; b=gf+4Ox1pI1TJJiqp
	t3lu4fUZWLnoa1a2jMZy5jsyEYxcwmUATjZW4xGitP3AHjJFtnOe/ocLMBvIsO3t
	w0Nwc9goGRkql8MWb67cNqSjA0VuxcaYrADgiaQsLanKdSdiI0r8+LVcJDFU6i1I
	Nnjm9gkymXlnNuml2qcv+3d2Li5PjObCfClZRqf5H04cDuuImGk7S/cFRrEeu+Oe
	0UQcklRe1jOBfoxoV6XA8pxrfSNMBGe7FqOZycLyi8D46ZjUhz/j9ZIpfbMZbnUT
	5TpRb0pZiYVqZsXmIULFRH+E687Nsf71gQBvc9Zisimwvj2xWO4c+bLU+4bzEg/7
	F0e81A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0mp5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844cb60so182130285a.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792768176; x=1793372976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owC/0Uitd+RPnqSaxCQ8n2UoAK7Gqnd+PP1VG0zdCcc=;
        b=Rt19+j7QgadhsvmGbM3BbYhgP3TYDl6s/nsDBcknPsqOSv4E8ZpZrSh7p3rbVnWXs/
         12GrFPLH5Vpx/j4Zh2F3+9Z9XS1eES73BS3pGnYoQ+XeCXx+FaX55BDJDGpOjIteuz5k
         Lwggz9iJnsM6saA7cjC3DYxQO5eASS/IHzw64TJtMCBfLKNw/sqip5oICaGkyM4J12ds
         7kIDP7q4srVfqM3zeZ7w8Y0CuTwt9uovu8z1PzD3JwEdfJyH+UZ9S2L4v14HATXKkGFf
         5qTKdI8mP4YWmW+hZcTFNqqbuzNvKXSfZ1HuyHRmHFJpgZFKQBG1WueHNKyLG50uRNkt
         J44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768176; x=1793372976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owC/0Uitd+RPnqSaxCQ8n2UoAK7Gqnd+PP1VG0zdCcc=;
        b=BlQVrDErcslDOLM+hDwCXRTFK2kE4eNLHh/LqVckeQ3t8t4wl9N+bnNx2WdFJcldeG
         eKR76uCu/DZxH6eMdOJ3o9xm3FeeroY/ycBIdTTFHOD/4tyhh03K+kk0Y8/XDeNd1T82
         HsTNSlYsmy4JDQsoPDNB0IlbV8sP1EpyPG9F01U+0X6hkYLzC9EzSnBt2fkVQ7rRhCjJ
         zO56c4zosNchFf61ZegAOunXJIC1MoqW+IKSQ6zJGV+QXwxyqcAgKZFCEv1zXZaPlYAF
         gGOqbUUeRXJeY0bfASK653Ck2f8JCNzBZ9CBUY8fdELofoBFCJ0d5lNvh4sL/4yGeTq/
         wB3w==
X-Forwarded-Encrypted: i=1; AKwUvBzZU5QTmfRj6q0+q6/YeLJqAcJCicodIoKPaPVcv5nol/6rxctvG7MZSioHczdPdHK9WCqhMNpPwHpR0t8liAs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5vM/8g23l8Jh/JcZ6oX6QdRlXM1wosaMUCDYxVQi7K+l0P+VL
	OFVCfQjeANjoHasvyMxuKoqcZbwyD70hlpXxGvRwmZZ1/y/jcAHwfW6ONXkyaTYD/wjb3RpgCqq
	qy3DfnLy0KPXR/5WoFIIyFtA0tbLFZNatqy2NYNWQOco2pw1hwBzDPgNGwPrJPhZ0eVklW6M=
X-Gm-Gg: AYBFou0+EPmASOrLRAj2eVaceaDv0f4+ugrLSvoNz5WNN64eDlRSdJ5xx1hsYYQ1D3b
	K4yC/0p7Wj/6p4XawAakBPFzrlD2hUzzTgER7U8x717XLia8VI0GYjbvj/ZnY4DqUiQMUpZcDpu
	q7AT+ilrcC2qTmfDJGAEQGty44apPgsZ2cri23TPSlSqUtATuCi1ViTQLcJZ4haQAKXq8YClBbt
	rc4SPVpRMxxIC8bv2SDOA8q8CB+PK4t7sRvYkUoL1NSDXmgo0f42d8e/WOSPZHaaJQBQc7VudnU
	OQUTxn+dc2AmvS37weRJCWQdb/nCZ45n3hjBPGwYW9hTc/Zi7YjReKMe2N75gwrV61QL2h6QQVs
	QHCjhs3PZOTDiHaRySKaFmd+zT73p1outFtjQWhk1TzEjYKALgCZhWXCcilO98MvoZwQosHmk0k
	LjbrP8w8tI4RUyL1sXV4r9+QKDlXqk/cprhOgWM8ijuBh5r1YRegU=
X-Received: by 2002:a05:620a:2b4d:b0:93e:e111:2778 with SMTP id af79cd13be357-93f626db3bdmr945065585a.14.1792768175954;
        Fri, 23 Oct 2026 08:09:35 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4d:b0:93e:e111:2778 with SMTP id af79cd13be357-93f626db3bdmr945056585a.14.1792768175420;
        Fri, 23 Oct 2026 08:09:35 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d0fb:daf1:3106:3697])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4040d3sm323962f8f.27.2026.10.23.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:34 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:09:12 +0200
Subject: [PATCH v11 1/9] media: qcom: camss: Add V4L2 meta format for CAMSS
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
Message-Id: <20261023-camss-isp-ope-v11-1-0c2937195298@oss.qualcomm.com>
References: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
In-Reply-To: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
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
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX/h7Zg2XuWTn3
 QTBbaPF5TLBtFaJCRvL1ZtBwKGEmzR9RDPccEE5tvZV2y/cfc57FwGp7/rXSc5A2R0RhacjPsZQ
 p68fURzBry1/9T9TPFtaQ8OJ6qf+8kPhcb1S2Yavt4J5QqaJSkqWc8UKI9bwZrLVuQGJon0X/zA
 ma6G9FoYhsh0igKqa6xMbI/QqrNGAygEA5w++kYQNCmnjJOsQnLFV8dNdXLaqA6fszSW1VwTMNI
 hifFlvjaRVXY2krHH4o8nb9I5VQQNM4C+AEOJdpUe2TLfzd5FHpBH30Z1sxmma1SJ6tg/A0hXBG
 vPdptHsQHHDbdjGjNMwvygPeCYTP4myTw0Q5gZ5AAcFK6fRTJh0D9aSnSYKqkzNLGkkGRlRGKEU
 up/HWTqBNU3Dn97QIc4zoLqsjHcnpOEvBrMywFPefRL/Q8NnTzQmnAGJKMmZHiL5FcnQI8BJF7m
 fMNRaKc0CXoX04ujdYg==
X-Proofpoint-GUID: fCosUAmUZZw5JQ_2eIay28PdzLQKpnOc
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb78b0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=mDm0RygAtmZY0osY0NEA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: fCosUAmUZZw5JQ_2eIay28PdzLQKpnOc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX0My7zo9sHtGP
 bRq4SmZtK1z7XuVWx6qs6qi2RNfAQ3YpFk4q3w+B5El6C7pqr1aXauqjsa81z9OeGRyjkQqg32Y
 wGHa/5j0OtwrgAjfR+MK4O6duKuSP04=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230059

Add a V4L2 meta format code (V4L2_META_FMT_QCOM_ISP_PARAMS) for the
Qualcomm CAMSS ISP parameter buffer. This format is used by the params
video node exposed by CAMSS offline ISP drivers (e.g. OPE) to carry
ISP tuning data such as white balance, color correction and chroma
enhancement settings.

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

