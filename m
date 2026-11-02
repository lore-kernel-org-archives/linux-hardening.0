Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634808;
	b=SNWwELhvIJyjsivrPemAZsni6qW6p+bqvpq7QY0OJjkwdkZ3dQNAUA6xkz8vrjeZNbnw
	 IlqwrDN7Xr6J9LlI409kpn0uj3AYcAaavLLEsCZO3jT1YWUm8nxt9q989aK2eK7UMSjXl
	 MSnkoev8eP6UouWdZYZ7Yb/z2EoXevvKRXWzpejSb2rjnzCQsx9zdaqV7s4kOwlDJ88IK
	 evx/xhYza3En46t+au0ShTWuEDEks+U87QdB3t51z4VM3FiOl3QFVqBwu/lSeOzjzJQL4
	 P0V//gpZGWVfl60quDU2oqG80hbz7YkjzADnkfdV+/6oHaYXaEZ/RMROWFtq8GRkyeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634808;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=;
	b=RV4rq5IzD3f0GdUSsbz/pynUt2vpcFQJlUzEyI33YuIJmji6CEJJ6LmJ4K2tuzyVwTEQ
	 82PxZ7KBq3Rg86sdtNApJgQtLWm6aiyIpi5tFYMdvU43gOeWnw4dfJt2sbZsyHTTgXUb1
	 2m4lL9xY1VlIuSPrYa6GrvGEupGzibUzeI8RnfKTt1l8OgZi56h6qRJht1VphdhDliKXN
	 qFBE6Qw9A+NJhqotHbIu2PIgENsw/A6hhE0OkVxWp0j8FtdLQZZ52hbPFVnt03ZhlbrgR
	 eocnXEzhSjZVrxkG2iyHM3Gj7m4TVglj+d1DA3bDJ81A+Oye7sghtNedbmZ6FLAsRIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kM374WtA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="bb6GR6/1";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A31607A891
	for <linux-hardening@vger.kernel.org>; Mon,  2 Nov 2026 15:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73A31607A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kM374WtA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bb6GR6/1
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpHIK2991812
	for <linux-hardening@vger.kernel.org>; Mon, 2 Nov 2026 15:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=; b=kM374WtAawYrgcPU
	3m0FBrc4GZOrBLrImookpjbxtv6IW/CVCZfSvubGAeEEx5c0RvbQj6/Ch6zBkfmm
	1+/iJawSkOr9GkebN9c7u4o5mibgNUmQvKEjxzg0y7SyK14FPlaTYcP4bH8pOutL
	nKq6bIPKP66gtmF5g/5lnfRZu4tODup2wQNYVsnefLaG6KA7N4o3Xk941EuJNnc1
	RAxdBCGzc2G0op+wLlHVva1bXpS5VEm4mOQyIFsVhYPYU/aDxl9z/GtKNmhcDMBZ
	9ElhGvpqOeGKkRgck0xZGMtYHqHWtdNlyg9a48yFPlzBIwtUvg018qpxpJuluTgl
	SYqSIw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavh6k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 15:53:21 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7cc01d48a1bso3699598137.1
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 07:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793634801; x=1794239601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=;
        b=bb6GR6/1vt9QyyYzVNEwvjLJ/w25kNwfdChTLC/JVA/VawBfUXoK+oTbly7UscdgSJ
         7RAp0uKZZkz/cJjF+wjELVWu8AxnRZ0nyaIAzc7U+FFtDc1ka17z17ot5fcwa+42Kq4Z
         dJ0uGJrHZUq/lepbdCUnfuTgeNfzaXUw8VLmNK4decaVVqh3xj+nIzogUwRmFup04YzX
         lGz4nqIi+rVYZ1hYrqqYDBookm5yIQEhGoEjPdtAbwRqCn94J5mvK3dmV0xCp9g2zS5I
         L/+kBSnBuA+2oW+MXoKXxS4/Md+r2YHb0hrqN+01PgZStpV7edV2oqjRxHxw8tR/jAZN
         0s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634801; x=1794239601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TgR5F+iBiHqDbSrZbID4DhVkgUbDwbnclx1Ow0233B4=;
        b=m21P49g/aMMVOYKuwaDhC8Pr81i0ZhgR4oGMT2SL40tkS8obIbte61rWR+a04MOGGz
         22mX6+MQi+ldsVA9gOQpxmbKnEBF0DJMBtYOU1XYPxNfMZeFhzpzVLtP5vOnteuC3yvr
         7n/Ga0/0IaeuMvEREEkQEbEPAkfmKAIYQKK+hqZ366vFdbZnQqy0lJhuCqnNjDEnswr4
         1IXlsBTuMKV3HPTil/8kBGRrVlukNXNUSXaaCx1gWXEEQKKGQ5n4OLCfrhwwhDO25PAU
         P/JthpDNrMu//jU+DZ+pQlq73PYzYfVMcD+ccrwuDSB0L3X6ixShx8cGSl2gsVulOGYb
         472A==
X-Forwarded-Encrypted: i=1; AKwUvBxrOKA+v8OSjDiZwPHnXDgwCXr2MHLFq+WQ5mp4nfehLrloEfhaEKcSb33r3xyaUxyW3VG8e04/gg6421/ttAo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PdQhqdYO2kkU4rf1QYAEh9zxNqC9ofULSWWa9kvgkIEV51OFS
	zngndS5EhYDNivY/5S6RDyL/Wj+7JBsr2u/UyadIQoaOqpN2lCd6KtVZaBOnUakZD2IVHXGw+z7
	UaCpqbyfevWmFsIubIGmWrxU52QhBgVcNA8Gyj1itjGa2rcnKOGmqd6xEvrKnN8gFRGEKwTc=
X-Gm-Gg: AYBFou2JKwIVXkpXPdfCAxTcKXXsFOkbHFnktXRcmofRPVskr6qskr8oRndyhO9g7iH
	w79hLLUz/uggcNaqRjPp9K48amRPNIDNBVSvmAxI+weERvJsQgqjqKjzhlhQ1lQTQbGQFJAz5Qb
	fcTOcanlIeLDHSKu89b0mIJe9wDx552qLZ1NCu+XSA//tPLdL2ENNrAgwM5R2+AK2W+6k//77NN
	/baXyIGVepW/5B/w5YRF/JVLLHzQITkswF0WRSqWor8qtZzXgOmN0uHpoAaMEhxVmXXpUGiPu3a
	HppPl+63j/4gnp4ne5IrkThSAT4/GnclSMjOXb64/sAFea0S1g+GWdiTXEUMBw459fNPsBO7xvO
	n362R7ljGUnl46lZGxOu4FHjCOlhqI/hDv+qdvVmiD/c1faMY9qVFDDh/sc89VkwPjOum0HDylj
	jht5wP2OJZfydqE22VlkOVOR/auKzg0pVjFh2F5AFf/yRNUZ1KagxZVqizUMHDcSiqXsUCW7VW5
	vXF+AxWJUb07oiUP0aOJGRU88Eg
X-Received: by 2002:a05:6102:4490:b0:7b3:5b2f:7030 with SMTP id ada2fe7eead31-7d053f25b2dmr4101181137.4.1793634800685;
        Mon, 02 Nov 2026 07:53:20 -0800 (PST)
X-Received: by 2002:a05:6102:4490:b0:7b3:5b2f:7030 with SMTP id ada2fe7eead31-7d053f25b2dmr4101170137.4.1793634800239;
        Mon, 02 Nov 2026 07:53:20 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a7d1sm20700323f8f.38.2026.11.02.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:53:19 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 16:47:32 +0100
Subject: [PATCH v12 1/9] media: qcom: camss: Add V4L2 meta format for CAMSS
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
Message-Id: <20261102-camss-isp-ope-v12-1-702254689feb@oss.qualcomm.com>
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
        Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX9PIsSL3PWCXT
 PiX29cHjVSGFIxR9VYiffDDNE/n9IhH578SWrf8aIAEW41S78BZb6k+Dk5vyAQCN3U5fIJejsMc
 vUIfsNHLdIuIpA2WbX383jEmvNbfiDO2bezuHaMeq7gU4sma80mvshD8qHHaZnNtq+plbREgDR6
 9Og62dlO+f+KvxR/ou2FuQd/aWimxKmGMnJ5JpMVvBNcgtHIMdygeT+vneImlKg3gO1Mk+Abfg7
 XcPhWYAZaSHupj3SrUqRcXsuqjOtFNEvrJYCWyYmQa4C/1hCzznvmV4BXbW9fYhGoEz2bl0DNQz
 WgbwcDsPVPd23YDqHoh5o9r3yusKm4sIp5+FdCnWWaVsR8dCBBgtQixiU2rH867vPDzvWH/PYPk
 d0SBlENfg6AYXxBAP+B7cmphM6oiE/bLSNo6coSK0jjm+kfo4c0AlcaJYfol5P2byn+yXc9BqQV
 Idq43k1a6sxFeX8yu5g==
X-Proofpoint-GUID: w_5rqnmaNScQ6dNqqbEXZHkUJNJrOc0h
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae8b1f1 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=mDm0RygAtmZY0osY0NEA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfXxNIA/o/EA8SM
 ydRpNBfw3Ifx0KPTl4KVrIQdPaoSky0qk3U97CvBNUEnQitcc/bSo8dgbClMSHIamTVUC4PS/cu
 zsNPAuIfjYj81WUy+nGYFOUixpksW+k=
X-Proofpoint-ORIG-GUID: w_5rqnmaNScQ6dNqqbEXZHkUJNJrOc0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020063

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

