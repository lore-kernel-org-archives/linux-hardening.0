Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736368;
	b=gOjcn2vhyye8KriHQN50dtOa32TA25pGIIV5NRaVAboxZuie59HlMriFYj5bdETEYHIK
	 PRKBG251c0CDhlz94fory5XZMc4Ql6Dz6Cekwwrcnskv45wH9/WgiLSvSyo/GbnlCH10l
	 RNbq4+Wm+R3pFUk1hZ9Jqd4G6Ui1Jz1/4ZBuqbMBttwazJ4tczN8wykKhpSC9L1Uo69zh
	 PN/OZNRNXlS3b8nQDsiJdMPL1i26FyTmtm4pN7f3iGfk3uwD4D1b1lSWh5uS15cbGrpts
	 JUtKs15s+e8U+LWf2SDj+D7xDtR2ViKGzFSafNvEnfDIgawwKAXJiPFPSLhpQb3BifQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736368;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FQCnJ4CNRei6l1u7qB7F+y1q86ACcroiAcDcJoVp/GU=;
	b=Sgqdju+VvZqgATi/PNUV+XmvqP8Kucx/5TKbcYsw29SAFTuPVolQi8iKleQtdKH4zdYF
	 g5Pc83HIlrWd8KKLjM0vU+r/lX8B69rAggXzavvdIV9bkhcomOpf0qy5dGbFnxCL5Unpw
	 k2DBVkcb8zz6qUWLWCU5lW2hLWyW1rNH2r7YL78D2U7XydI6hqB1K7VqlUJZSNG33ih5h
	 KLEElWBF5RCnswild97lkm/XfHZdOVOCs67BUwYo0DxWQ1T1UlSuUTlQNQXHb4/L+ZUV0
	 sxE4VMsqoQkN1n+JiBZIT3qclkIAIhznVpplFDkitZ/lO6NGvzmk6hEyck+52L2QE+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dBFK6PR4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Oev7k/iy";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6A606D810
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 20:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0F6A606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dBFK6PR4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oev7k/iy
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IpHaC122302
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 20:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FQCnJ4CNRei6l1u7qB7F+y1q86ACcroiAcDcJoVp/GU=; b=dBFK6PR4CElr6wdP
	K9yjwcnDs3qh91+iaxF2b6AhJtX439vK47QbbEgK2GgAxGTXPY+C0fX+gyRuz1IF
	EGzYSE70cZSiECFVJ01XC0GikdQQ7rgTswroVKr6ONL2QRFIIQJVmyMQUN9Kh6PC
	Lq+/9NoI243AnURaXnVa43o7TsC/XQ/Erhh0zkgbzNTne6mAbv7mS+MpTQ92sj/8
	h0tS1JepSkt6nVLU51QMG5lQeIN9r97oWMkvhhzs+evmjNDB+z327VUg4qBYoqqQ
	HeuUxHUaahDdUcWtB1BiQrumKZnNntEXg8rEvj6Ior3wTgg1G52nGqUyPbr0ZVa7
	W/xBgQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8mr939-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 20:06:01 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98c6374b678so4093344241.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793736361; x=1794341161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQCnJ4CNRei6l1u7qB7F+y1q86ACcroiAcDcJoVp/GU=;
        b=Oev7k/iy+FMuoBy4bZd/rVje1xl4CEZxeOp52LVvKziIu0aSpxuQzNqaps5gjmOoOd
         7K1nEAaGeSU0DusT90fs6BQK+D3Dbwpj0hj9X36vYgSwfQu20JYCUVkGcWzJZapew0m1
         9FGNEuNMB40O4/exqpx7jU578P7EyPEOzCT3pSdK703w+SFOrLQxHam+V6i7I6/QWZjm
         ++4riTp79JAUpMKbuv4JqkMgmgj4q7TsgZJatUqrGACyjSTZIlQyvx2Z9Gbe5QkRiFWy
         RTljPcjoi2dy6QnZrUht76gZyaPjBApIA8rRMB73MJNsoj2OEgMj83C30QqkRgtycDV6
         pKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736361; x=1794341161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQCnJ4CNRei6l1u7qB7F+y1q86ACcroiAcDcJoVp/GU=;
        b=SWQ05kp3G/g1E1RVAuqtHTS/gzCqQlbXYoigFch9RDnvC/TXtBudoUTZrrczzNzNYS
         n21Pw3VMGBlcaxYt9zuHKbYsfQlNy6nFKwRYZniFMcjM6GcT8l52sJDTfM9cgxHHr/tG
         Dy/b/lLxTH8zTJ6vTAKdyS5HddCxFrbColU+dTtE7E3E9cVJh0TP0sk7UdC1tG9HgAko
         NtD/97GP6+YTeuI3CNtfPieivzyz+l1OyXEYiXImyHyy62TrKj4S3//tKMd6sr7NR/t/
         9qxKolTXwX+7N5GeZql//mfWLKPOk7UuYwR7Iq1TCrJh97FW8KuMLO431BrHvvzycFM+
         WnfA==
X-Forwarded-Encrypted: i=1; AKwUvBwRSyylvuXQ9Tvon3vy4pQXBpdOYVGh7mGlW22zABTzdY3vFKw1jfhioPVTEF+gZb0Vs4+oZUg+P/YrQChz+RA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YAPupzMiabJKqRUSNc3r+xwwTRVU6lAlur73pQxLQVaPf19Ku
	F1vBRIU047C1ImYo1Khe0ckrkIUEjNjUDVvOVSxBRG7iGc89X9/S0mDErbC+1+g1/Ju1Y6UOv0P
	mAjr7FMhrhzYGcK69jctcTQiuiuNwOAF/E/F82uROLW1pk/GEARph4jdtht6ZvhAjhEwVf6k=
X-Gm-Gg: AYBFou2paLZfrezgLNI0KB55kW+RLDglms+5UQVOhkYvW/gONX0itnkShykQNIpAG/u
	VWmmzR7IaAPb5mKDGwzch+bpZVPKXi0bXNAnXQ6suPwi0Cxipyt2dJRE2aKHuSJOJmwVRP8865z
	ZDDWQwePNVkn0QQBjb82CmYgu88YN2YdOZJNEt+4O1Sz5okl6fyMbVwZoCyzWAKXc2TZZLCjR8Q
	kihuEHpoYRLja9865JoDTMfPDE3iZX/hYoBwPCMCjFJknBUbANBmol6YjY9knArWpwCE6Ga3fPN
	BCXTwMBu6WcYqCODb5BIFRRUsfWsqorijLkUaakhNYxDjLvJxEiimbuGHEVUFQT6GWLPAzPjtK1
	HBRE7FP3YNNlIa3A5oVhqlGhxX4GJuoITrlp0DOTZ01OSbisXyMahKfr8xaK5WqQOTNbWQ6rJQE
	mgb+1R//OWWMDwl/FsrErxxC25QSZPGVHQ05A+PJbnREFE4IR1+atGK+B6p9L6QRwTYTatd4nf/
	vBNgNMkmEO+aDY8O02AaURgjev+
X-Received: by 2002:a05:6102:149c:b0:7ad:3ad3:997a with SMTP id ada2fe7eead31-7d072247aa7mr6264095137.5.1793736361013;
        Tue, 03 Nov 2026 12:06:01 -0800 (PST)
X-Received: by 2002:a05:6102:149c:b0:7ad:3ad3:997a with SMTP id ada2fe7eead31-7d072247aa7mr6264086137.5.1793736360431;
        Tue, 03 Nov 2026 12:06:00 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcd03d01dsm358875f8f.44.2026.11.03.12.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:05:59 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 21:05:49 +0100
Subject: [PATCH v13 5/9] media: Documentation: uapi: Add qcom-camss ISP
 params documentation
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
Message-Id: <20261103-camss-isp-ope-v13-5-c2cbf15a39b1@oss.qualcomm.com>
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
X-Proofpoint-GUID: L-xWz_mhj30-JharQRfVoCsvDC2DSngT
X-Proofpoint-ORIG-GUID: L-xWz_mhj30-JharQRfVoCsvDC2DSngT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXyRBHmLhSqHth
 +km/qvgQpQ7f03UBP83DFw3if6dqFzU1NA4dF1dwMjPSSL1oxR6ApQuDhPyYn7yxZpkheiUKoOY
 0YFTjZ2fvssOrlzwEoSXkk3iN/O3sowU6Kky2hJt7HGqdOWxSWx9A+nTzs591O+WtClgw3Wt4aa
 MWyVLnIf4wJL0ebpD8Kx8mXc/LiGzI95OPWpUc4aRr505yWWDa14hrnRDd9kX7fuMpHs23dH3Pq
 fx9f19A9ylX86vTPkGoktWG0dX1/MjsDrGxatBEuYWnOjaRHWWSHkSHUootCA7YUMeEX1Auinjx
 lKy6GxU6hx4ajFvf2Eqbiq6GhAgCIFVCjbGN+eDeZWEQzyJeMb9B5/SC0nSXH+Dbr07Ipimhpl0
 OH1Ox85HHyKvA0GhCCyYtk1aMV8o+5m8VehevH+pjzafK9GdUY4vfbQoxZbpaeOQ8AxaARAZYcQ
 UEDKQwDHuSci9LZ2+QA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX3Ewkg9pVxdaZ
 eSlaQpq/uxpBXhH++beljbCBzOZale0ZzDKcER3drruh0XLEDvnTsw56A70sFi5CJyj8HPcdy5Q
 nfaIs7vyvG8AOcrQcd1mtseyX1AXQ/0=
X-Authority-Analysis: v=2.4 cv=HbWB3SE8 c=1 sm=1 tr=0 ts=6aea3ea9 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Nff7jVtaK1xTle8F27sA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030080

Add documentation for the Qualcomm CAMSS ISP parameters metadata format
(V4L2_META_FMT_QCOM_ISP_PARAMS). The format is built on the V4L2
extensible ISP parameters system, with per-block structs defined in the
qcom-camss-config.h uAPI header, and is designed to be shared by any
CAMSS ISP engine exposing a parameters metadata output video node. The
Offline Processing Engine (OPE) ope_params node is the first consumer,
with additional engines expected to add their own parameter blocks in
the future.

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../userspace-api/media/v4l/meta-formats.rst       |   1 +
 .../userspace-api/media/v4l/metafmt-qcom-isp.rst   | 147 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 149 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index b5455229837e707c24e134438d5e2fd12cb3bf37..25b46af4d9f7faab37000076c530e9aad5b4a076 100644
--- a/Documentation/userspace-api/media/v4l/meta-formats.rst
+++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
@@ -20,6 +20,7 @@ These formats are used for the :ref:`metadata` interface only.
     metafmt-intel-ipu3
     metafmt-pisp-be
     metafmt-pisp-fe
+    metafmt-qcom-isp
     metafmt-rkisp1
     metafmt-rppx1
     metafmt-uvc
diff --git a/Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst b/Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
new file mode 100644
index 0000000000000000000000000000000000000000..da0dd9b0884ea8b3c5fba7b5aa2eb1af80418cae
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
@@ -0,0 +1,147 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. c:namespace:: V4L
+
+.. _v4l2-meta-fmt-qcom-isp-params:
+
+**************************************
+V4L2_META_FMT_QCOM_ISP_PARAMS ('QCIP')
+**************************************
+
+Configuration Parameters
+========================
+
+The ``V4L2_META_FMT_QCOM_ISP_PARAMS`` format carries image processing
+configuration for the ISP engines found in the Qualcomm Camera Subsystem
+(CAMSS). It is passed to a metadata output video node using the
+:c:type:`v4l2_meta_format` interface.
+
+Rather than a single struct containing sub-structs for each configurable area
+of the ISP, parameters use the :ref:`v4l2-isp` parameters system, through which
+groups of parameters are defined as distinct structs or "blocks" which may be
+added to the data member of :c:type:`v4l2_isp_buffer`. Userspace is
+responsible for populating the data member with the blocks that need to be
+configured by the driver. Each block-specific struct embeds
+:c:type:`v4l2_isp_block_header` as its first member and userspace must
+populate the type member with a value from :c:type:`camss_params_block_type`.
+Populated blocks must be placed consecutively in the data member, and the
+combined size of all populated blocks must be set in the data_size member of
+:c:type:`v4l2_isp_buffer`.
+
+The set of supported blocks depends on the CAMSS engine consuming the buffer.
+The block definitions themselves are shared across CAMSS ISPs; currently the
+Offline Processing Engine (OPE) is the only engine consuming them, through its
+``ope_params`` metadata output video node. Additional engines and blocks may be
+added to this format in the future.
+
+A block carrying ``V4L2_ISP_PARAMS_FL_BLOCK_DISABLE`` bypasses the
+corresponding hardware module. Any other block updates the module's
+configuration and leaves it enabled. Blocks omitted from a buffer keep their
+previously programmed configuration and enable state; until userspace submits
+a block for a given module, the driver's default configuration applies.
+
+OPE processing pipeline
+=======================
+
+The OPE is a memory-to-memory engine that reads a Bayer RAW frame from its
+``ope_input`` node and writes a YUV frame to its ``ope_disp_output`` node. The
+parameter blocks configure fixed-function hardware modules that the frame data
+passes through, in the following order:
+
+.. code-block:: none
+
+	 Bayer RAW in            RGB domain                      YUV domain      YUV out
+	 (8/10-bit)   +------+   +------+   +------+   +------+   +------+   +------+   (NV12/NV16/
+	  ----------> |  WB  |-->| DEMO |-->|  CC  |-->| GLUT |-->|CHROMA|-->| DSC  |----------->
+	              +------+   +------+   +------+   +------+   |ENHAN |   +------+    NV24/GREY)
+	                                                         +------+
+
+The stages, and the parameter block that configures each one, are:
+
+.. flat-table:: OPE pipeline stages
+    :header-rows: 1
+    :stub-columns: 0
+
+    * - Stage
+      - Module
+      - Parameter block
+      - Function
+    * - WB
+      - CLC_WB
+      - :c:type:`camss_params_wb_gain`
+      - Per-channel white balance gains and black-level / pedestal offsets,
+        applied to the raw Bayer data.
+    * - DEMO
+      - CLC_DEMO
+      - *(none)*
+      - Demosaic: reconstructs a full-resolution RGB image from the Bayer
+        mosaic. Always enabled; not configurable through this format.
+    * - CC
+      - CLC_CC
+      - :c:type:`camss_params_color_correct`
+      - Color correction matrix applied in the RGB domain.
+    * - GLUT
+      - CLC_GLUT
+      - :c:type:`camss_params_gamma`
+      - Per-channel gamma correction curves (256-entry LUTs).
+    * - CHROMA_ENHAN
+      - CLC_CHROMA_ENHAN
+      - :c:type:`camss_params_chroma_enhan`
+      - RGB to YUV color transfer matrix.
+    * - DSC
+      - Downscaler
+      - *(none)*
+      - Chroma (and, when required, luma) downscaling to produce the requested
+        YUV subsampling, e.g. YUV 4:4:4 to 4:2:2 (NV16) or 4:2:0 (NV12).
+
+The input node accepts 8-bit and 10-bit packed Bayer RAW formats (for example
+``V4L2_PIX_FMT_SRGGB8`` and ``V4L2_PIX_FMT_SRGGB10P``). The output node
+produces semi-planar YUV (``V4L2_PIX_FMT_NV12`` / ``NV21`` / ``NV16`` /
+``NV61`` / ``NV24`` / ``NV42``) or luma-only ``V4L2_PIX_FMT_GREY``. A
+configurable stage is bypassed while its block carries
+``V4L2_ISP_PARAMS_FL_BLOCK_DISABLE``.
+
+The following example populates an OPE parameters buffer with a white balance
+and a gamma correction block:
+
+.. code-block:: c
+
+	struct v4l2_isp_buffer *params =
+		(struct v4l2_isp_buffer *)buffer;
+
+	params->version = V4L2_ISP_VERSION_V1;
+	params->data_size = sizeof(struct camss_params_wb_gain) +
+			    sizeof(struct camss_params_gamma);
+
+	__u8 *data = params->data;
+
+	struct camss_params_wb_gain *wb =
+		(struct camss_params_wb_gain *)data;
+
+	memset(wb, 0, sizeof(*wb));
+	wb->header.type = CAMSS_PARAMS_WB_GAIN;
+	wb->header.flags = V4L2_ISP_PARAMS_FL_BLOCK_ENABLE;
+	wb->header.size = sizeof(struct camss_params_wb_gain);
+
+	/* Unity gain on all three channels (15uQ10, 1024 = 1.0) */
+	wb->g_gain = 1024;
+	wb->b_gain = 1024;
+	wb->r_gain = 1024;
+
+	data += sizeof(struct camss_params_wb_gain);
+
+	struct camss_params_gamma *gamma =
+		(struct camss_params_gamma *)data;
+
+	memset(gamma, 0, sizeof(*gamma));
+	gamma->header.type = CAMSS_PARAMS_GAMMA;
+	gamma->header.flags = V4L2_ISP_PARAMS_FL_BLOCK_ENABLE;
+	gamma->header.size = sizeof(struct camss_params_gamma);
+
+	/* Identity curve (pass-through, gamma 1.0) */
+	for (unsigned int i = 0; i < CAMSS_GAMMA_LUT_SIZE; i++)
+		gamma->glut[i] = gamma->blut[i] = gamma->rlut[i] = i;
+
+Qualcomm CAMSS ISP uAPI data types
+==================================
+
+.. kernel-doc:: include/uapi/linux/qcom-camss-config.h
diff --git a/MAINTAINERS b/MAINTAINERS
index e4ca41cdd8729625fe2f731cd443bdd4da527dca..234c4c69dec7e7264763f1970438c22d0cec11a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22908,6 +22908,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/qcom_camss.rst
 F:	Documentation/devicetree/bindings/media/qcom,*camss*
+F:	Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
 F:	drivers/media/platform/qcom/camss/
 
 QUALCOMM CLOCK DRIVERS

-- 
2.34.1

